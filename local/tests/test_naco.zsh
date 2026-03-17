#!/usr/bin/env zsh

# Unit tests for naco script
# Run with: ./test_naco.zsh

set -eu

THIS_PATH="${0:A:h}"
SCRIPT="$THIS_PATH/../bin/naco"

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

test_to_snake_case() {
  assert "camelCase to snake_case" \
    "camel_case" "$($SCRIPT -t s camelCase)"

  assert "PascalCase to snake_case" \
    "pascal_case" "$($SCRIPT -t snake_case PascalCase)"

  assert "camelCase to snake_case (long option)" \
    "camel_case" "$($SCRIPT --to=snake_case camelCase)"
}

test_to_camel_case() {
  assert "snake_case to camelCase" \
    "snakeCase" "$($SCRIPT -t c snake_case)"

  assert "PascalCase to camelCase" \
    "pascalCase" "$($SCRIPT -t camelCase PascalCase)"
}

test_to_pascal_case() {
  assert "snake_case to PascalCase" \
    "SnakeCase" "$($SCRIPT -t p snake_case)"

  assert "camelCase to PascalCase" \
    "CamelCase" "$($SCRIPT -t PascalCase camelCase)"
}

test_autodetect() {
  # camelCase → auto-selects snake_case
  assert "Auto-detect camelCase → snake_case" \
    "camel_case" "$($SCRIPT camelCase)"

  # snake_case → auto-selects camelCase
  assert "Auto-detect snake_case → camelCase" \
    "snakeCase" "$($SCRIPT snake_case)"
}

test_spaces() {
  assert "Spaces treated as separators" \
    "helloWorld" "$($SCRIPT -t c 'hello world')"
}

run_tests() {
  echo "Running naco script tests..."
  test_to_snake_case
  test_to_camel_case
  test_to_pascal_case
  test_autodetect
  test_spaces
  echo "All tests completed!"
}

run_tests
