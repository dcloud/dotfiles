#!/usr/bin/env zsh

# Unit tests for phonetic script
# Run with: ./test_phonetic.zsh

set -eu

# Path to the phonetic script
SCRIPT="../bin/phonetic"

# Test helper function
assert() {
  local desc="$1"
  local expected="$2"
  local actual="$3"

  if [[ "$expected" == "$actual" ]]; then
    echo "✅ PASS: $desc"
  else
    echo "❌ FAIL: $desc"
    echo "  Expected: $expected"
    echo "  Actual  : $actual"
    return 1
  fi
}

# Test basic functionality
test_basic() {
  local result=$(echo "ABC" | $SCRIPT --no-color)
  local expected=$'Alfa\nBravo\nCharlie'
  assert "Basic alphabet conversion" "$expected" "$result"
}

# Test different alphabets
test_alphabets() {
  # Test NATO alphabet (default)
  local nato=$(echo "XYZ" | $SCRIPT --no-color)
  local expected_nato=$'X-ray\nYankee\nZulu'
  assert "NATO alphabet" "$expected_nato" "$nato"

  # Test Western Union
  local wu=$(echo "XYZ" | $SCRIPT --alphabet=wu --no-color)
  local expected_wu=$'X-ray\nYoung\nZero'
  assert "Western Union alphabet" "$expected_wu" "$wu"
}

# Test command line input
test_cmdline_input() {
  local result=$($SCRIPT --no-color "Hello")
  local expected=$'Hotel\nEcho\nLima\nLima\nOscar'
  assert "Command line input" "$expected" "$result"
}

# Test piped input
test_piped_input() {
  local result=$(echo "Test" | $SCRIPT --no-color)
  local expected=$'Tango\nEcho\nSierra\nTango'
  assert "Piped input" "$expected" "$result"
}

# Test color output
test_color_output() {
  # Get output with color
  local color_output=$(echo "A" | $SCRIPT)

  # Check if color output contains ANSI color codes
  local has_color=0
  if [[ $color_output == *$'\033['*'m'* ]]; then
    has_color=1
  fi

  assert "Color output enabled by default" "1" "$has_color"

  # Get output with --no-color
  local plain_output=$(echo "A" | $SCRIPT --no-color)

  # Check if plain output contains ANSI color codes
  local has_no_color=1
  if [[ $plain_output == *$'\033['*'m'* ]]; then
    has_no_color=0
  fi

  assert "Color output disabled with --no-color" "1" "$has_no_color"
}

# Test non-letter handling
test_non_letters() {
  local result=$(echo "A 1" | $SCRIPT --no-color)
  local expected=$'Alfa\n\n1'
  assert "Non-letter handling" "$expected" "$result"
}

# Run all tests
run_tests() {
  echo "Running phonetic script tests..."
  test_basic
  test_alphabets
  test_cmdline_input
  test_piped_input
  test_color_output
  test_non_letters
  echo "All tests completed!"
}

run_tests

