#!/usr/bin/env zsh

# Tests for the nn script
# Run with: ./test_nn.zsh

set -eu

THIS_PATH="${0:A:h}"
SCRIPT="$THIS_PATH/../bin/nn"

assert() {
    local desc="$1"
    local expected="$2"
    local actual="$3"

    if [[ "$expected" == "$actual" ]]; then
        print "✅ PASS: $desc"
    else
        print "❌ FAIL: $desc"
        print "  Expected: '$expected'"
        print "  Actual  : '$actual'"
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
        print "  Actual : '$actual'"
        return 1
    fi
}

stderr_of() { "$@" 2>&1 >/dev/null || true; }
get_exit_code() { local code=0; "$@" >/dev/null 2>&1 || code=$?; print $code; }

test_basic_transformations() {
    assert "spaces become hyphens" \
        "hello-world" "$($SCRIPT 'hello world')"

    assert "periods in stem (not final extension) become hyphens" \
        "hello-world.txt" "$($SCRIPT 'hello.world.txt')"

    assert "uppercase letters are lowercased" \
        "hello-world" "$($SCRIPT 'Hello World')"
}

test_extension_handling() {
    assert "file extension is preserved" \
        "hello-world.txt" "$($SCRIPT 'hello world.txt')"

    assert "extension is lowercased" \
        "hello.pdf" "$($SCRIPT 'Hello.PDF')"

    # Regression: `:e` captures ' Jiger' (leading space) for "vs. Jiger".
    # A space-prefixed "extension" means the dot was mid-sentence, not a file-extension
    # separator — fold it back into the stem so the dot becomes a hyphen.
    assert "period-space mid-sentence: dot becomes hyphen, not extension separator" \
        "gamera-vs-jiger" "$($SCRIPT 'Gamera vs. Jiger')"
}

test_no_lowercase() {
    assert "-L preserves case" \
        "Hello-World.TXT" "$($SCRIPT -L 'Hello World.TXT')"

    assert "--no-lowercase preserves case" \
        "Hello-World.TXT" "$($SCRIPT --no-lowercase 'Hello World.TXT')"
}

test_replace_short() {
    assert "-r replaces in stem" \
        "gamera-versus-jiger.mkv" "$($SCRIPT -r vs/versus 'gamera vs jiger.mkv')"

    assert "-r replace affects stem only, not extension" \
        "gamera-versus-jiger.txt" "$($SCRIPT -r vs/versus 'gamera vs jiger.txt')"
}

test_replace_long() {
    assert "--replace=SEARCH/REP replaces in stem" \
        "gamera-versus-jiger.mkv" "$($SCRIPT --replace=vs/versus 'gamera vs jiger.mkv')"
}

test_help() {
    local out

    out=$(stderr_of $SCRIPT -h)
    assert_matches "-h prints usage to stderr" 'Usage:' "$out"
    assert "exit code is 0: -h" "0" "$(get_exit_code $SCRIPT -h)"

    out=$(stderr_of $SCRIPT --help)
    assert_matches "--help prints usage to stderr" 'Usage:' "$out"
    assert "exit code is 0: --help" "0" "$(get_exit_code $SCRIPT --help)"
}

test_errors() {
    local err

    err=$(stderr_of $SCRIPT)
    assert_matches "no args: error message" 'filename' "$err"
    assert "no args: exit code 1" "1" "$(get_exit_code $SCRIPT)"

    err=$(stderr_of $SCRIPT -z)
    assert_matches "unknown short option: error message" 'Invalid option' "$err"
    assert "unknown short option: exit code 1" "1" "$(get_exit_code $SCRIPT -z)"

    err=$(stderr_of $SCRIPT --bogus)
    assert_matches "unknown long option: error message" 'Unknown long option' "$err"
    assert "unknown long option: exit code 1" "1" "$(get_exit_code $SCRIPT --bogus)"
}

run_tests() {
    print "Running nn tests..."
    test_basic_transformations
    test_extension_handling
    test_no_lowercase
    test_replace_short
    test_replace_long
    test_help
    test_errors
    print "All tests completed!"
}

run_tests
