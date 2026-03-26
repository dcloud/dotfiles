#!/usr/bin/env zsh

# Tests for the randname script
# Run with: ./test_randname.zsh

set -eu

THIS_PATH="${0:A:h}"
SCRIPT="$THIS_PATH/../bin/randname"

assert() {
    local desc="$1"
    local expected="$2"
    local actual="$3"

    if [[ "$expected" == "$actual" ]]; then
        print "✅ PASS: $desc"
    else
        print "❌ FAIL: $desc"
        print "  Expected: $expected"
        print "  Actual  : $actual"
        return 1
    fi
}

assert_matches() {
    local desc="$1"
    local pattern="$2"
    local actual="$3"

    if [[ $actual =~ $pattern ]]; then
        print "✅ PASS: $desc"
    else
        print "❌ FAIL: $desc"
        print "  Pattern: $pattern"
        print "  Actual : $actual"
        return 1
    fi
}

# Capture stderr only (stdout goes to /dev/null)
stderr_of() { "$@" 2>&1 >/dev/null || true; }

# Get exit code of a command (stdout/stderr suppressed)
# Uses || to avoid triggering set -e on expected failures
get_exit_code() { local code=0; "$@" >/dev/null 2>&1 || code=$?; print $code; }

test_output_format() {
    local out
    out=$($SCRIPT)
    assert_matches "default output is 3 hyphen-separated words" \
        '^[a-z]+-[a-z]+-[a-z]+$' "$out"
}

test_word_count() {
    local out

    out=$($SCRIPT 2)
    assert_matches "N=2 produces 2 words" '^[a-z]+-[a-z]+$' "$out"

    out=$($SCRIPT 5)
    assert_matches "N=5 produces 5 words" '^[a-z]+-[a-z]+-[a-z]+-[a-z]+-[a-z]+$' "$out"
}

test_n_before_and_after_theme() {
    local out

    out=$($SCRIPT 2 --theme default)
    assert_matches "N before --theme: 2 words" '^[a-z]+-[a-z]+$' "$out"

    out=$($SCRIPT --theme default 2)
    assert_matches "N after --theme: 2 words" '^[a-z]+-[a-z]+$' "$out"
}

test_help() {
    local out
    out=$($SCRIPT -h)
    assert_matches "-h prints usage to stdout" 'Usage:' "$out"
    assert "exit code is 0: -h" "0" "$(get_exit_code $SCRIPT -h)"

    out=$($SCRIPT --help)
    assert_matches "--help prints usage to stdout" 'Usage:' "$out"
    assert "exit code is 0: --help" "0" "$(get_exit_code $SCRIPT --help)"
}

test_list() {
    local out
    out=$($SCRIPT --list)
    assert_matches "--list output contains 'default'" 'default' "$out"
    assert "exit code is 0: --list" "0" "$(get_exit_code $SCRIPT --list)"

    out=$($SCRIPT -l)
    assert_matches "-l output contains 'default'" 'default' "$out"
    assert "exit code is 0: -l" "0" "$(get_exit_code $SCRIPT -l)"
}

test_error_n_not_integer() {
    local err
    err=$(stderr_of $SCRIPT foo)
    assert_matches "non-integer N error message" 'N must be a positive integer' "$err"
    assert "exit code is 1: non-integer N" "1" "$(get_exit_code $SCRIPT foo)"

    # Note: -3 starts with '-' so it is caught by the unknown-option handler, not the N check
    err=$(stderr_of $SCRIPT -3)
    assert_matches "flag-like non-integer N treated as unknown option" 'unknown option: -3' "$err"
    assert "exit code is 1: -3" "1" "$(get_exit_code $SCRIPT -3)"
}

test_error_n_too_small() {
    local err
    err=$(stderr_of $SCRIPT 1)
    assert_matches "N=1 error message" 'N must be at least 2' "$err"
    assert "exit code is 1: N=1" "1" "$(get_exit_code $SCRIPT 1)"

    err=$(stderr_of $SCRIPT 0)
    assert_matches "N=0 error message" 'N must be at least 2' "$err"
    assert "exit code is 1: N=0" "1" "$(get_exit_code $SCRIPT 0)"
}

test_error_unknown_option() {
    local err
    err=$(stderr_of $SCRIPT -z)
    assert_matches "unknown option error" 'unknown option: -z' "$err"
    assert "exit code is 1: unknown option" "1" "$(get_exit_code $SCRIPT -z)"
}

test_error_unknown_theme() {
    local err
    err=$(stderr_of $SCRIPT --theme ghost)
    assert_matches "unknown theme error" 'unknown theme: ghost' "$err"
    assert "exit code is 1: unknown theme" "1" "$(get_exit_code $SCRIPT --theme ghost)"
}

test_error_invalid_theme_name() {
    local err
    err=$(stderr_of $SCRIPT --theme 'bad name')
    assert_matches "invalid theme name error" 'invalid theme name' "$err"
    assert "exit code is 1: invalid theme name" "1" "$(get_exit_code $SCRIPT --theme 'bad name')"
}

test_error_invalid_weight() {
    local err

    err=$(stderr_of $SCRIPT --theme default:0)
    assert_matches "weight=0 error" 'invalid weight' "$err"
    assert "exit code is 1: weight=0" "1" "$(get_exit_code $SCRIPT --theme default:0)"

    err=$(stderr_of $SCRIPT --theme 'default:')
    assert_matches "empty weight error" 'invalid weight' "$err"
    assert "exit code is 1: empty weight" "1" "$(get_exit_code $SCRIPT --theme 'default:')"
}

test_weight_leading_zero() {
    # Spec: leading zeros accepted (tech:01 = weight 1)
    local out
    out=$($SCRIPT --theme default:01)
    assert_matches "leading-zero weight is valid" '^[a-z]+-[a-z]+-[a-z]+$' "$out"
    assert "exit code is 0: leading-zero weight" "0" "$(get_exit_code $SCRIPT --theme default:01)"
}

test_duplicate_theme() {
    local out
    out=$($SCRIPT --theme default,default)
    assert_matches "duplicate theme is valid" '^[a-z]+-[a-z]+-[a-z]+$' "$out"
}

test_empty_segment() {
    local out
    out=$($SCRIPT --theme ',default')
    assert_matches "leading comma segment skipped" '^[a-z]+-[a-z]+-[a-z]+$' "$out"
}

test_error_unreadable_theme() {
    local tmpdir err exit_code
    tmpdir=$(mktemp -d)
    print '[adjectives]\nbold\n[nouns]\nriver' > "$tmpdir/secret.txt"
    chmod 000 "$tmpdir/secret.txt"
    err=$(RANDNAME_THEME_DIR="$tmpdir" stderr_of $SCRIPT --theme secret)
    exit_code=$(RANDNAME_THEME_DIR="$tmpdir" get_exit_code $SCRIPT --theme secret)
    chmod 644 "$tmpdir/secret.txt"
    rm -rf "$tmpdir"
    assert_matches "unreadable theme file error" 'cannot read theme file' "$err"
    assert "exit code is 1: unreadable theme" "1" "$exit_code"
}

test_error_pool_too_small() {
    local tmpdir err exit_code

    # Theme with only 1 adjective: requesting N=3 needs 2 adjectives
    tmpdir=$(mktemp -d)
    print '[adjectives]\nbold\n[nouns]\nriver\nstone' > "$tmpdir/tiny.txt"
    err=$(RANDNAME_THEME_DIR="$tmpdir" stderr_of $SCRIPT --theme tiny 3)
    exit_code=$(RANDNAME_THEME_DIR="$tmpdir" get_exit_code $SCRIPT --theme tiny 3)
    rm -rf "$tmpdir"
    assert_matches "adjective pool too small error" 'adjective pool too small' "$err"
    assert "exit code is 1: adj pool too small" "1" "$exit_code"

    # Theme with nouns only: adj pool is empty
    tmpdir=$(mktemp -d)
    print '[nouns]\nriver\nstone' > "$tmpdir/nounonly.txt"
    err=$(RANDNAME_THEME_DIR="$tmpdir" stderr_of $SCRIPT --theme nounonly 3)
    exit_code=$(RANDNAME_THEME_DIR="$tmpdir" get_exit_code $SCRIPT --theme nounonly 3)
    rm -rf "$tmpdir"
    assert_matches "empty adjective pool error" 'adjective pool too small' "$err"
    assert "exit code is 1: empty adj pool" "1" "$exit_code"

    # Theme with adjs only: noun pool is empty
    tmpdir=$(mktemp -d)
    print '[adjectives]\nbold\ncrispy\nancient' > "$tmpdir/adjonly.txt"
    err=$(RANDNAME_THEME_DIR="$tmpdir" stderr_of $SCRIPT --theme adjonly 2)
    exit_code=$(RANDNAME_THEME_DIR="$tmpdir" get_exit_code $SCRIPT --theme adjonly 2)
    rm -rf "$tmpdir"
    assert_matches "noun pool is empty error" 'noun pool is empty' "$err"
    assert "exit code is 1: noun pool empty" "1" "$exit_code"
}

test_dash_dash() {
    local out

    out=$($SCRIPT -- 2)
    assert_matches "-- passes N=2" '^[a-z]+-[a-z]+$' "$out"
    assert "exit code is 0: -- 2" "0" "$(get_exit_code $SCRIPT -- 2)"

    out=$($SCRIPT 3 -- 4)
    assert_matches "N already set before --; 4 ignored, 3 words" '^[a-z]+-[a-z]+-[a-z]+$' "$out"
    assert "exit code is 0: 3 -- 4" "0" "$(get_exit_code $SCRIPT 3 -- 4)"
}

run_tests() {
    print "Running randname tests..."
    test_output_format
    test_word_count
    test_n_before_and_after_theme
    test_help
    test_list
    test_error_n_not_integer
    test_error_n_too_small
    test_error_unknown_option
    test_error_unknown_theme
    test_error_invalid_theme_name
    test_error_invalid_weight
    test_weight_leading_zero
    test_duplicate_theme
    test_empty_segment
    test_error_unreadable_theme
    test_error_pool_too_small
    test_dash_dash
    print "All tests completed!"
}

run_tests
