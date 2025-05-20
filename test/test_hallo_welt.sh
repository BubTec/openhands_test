#!/usr/bin/env bash
set -euo pipefail
output=$(bash bin/hallo-welt.sh)
if [[ "$output" != "Hallo Welt!" ]]; then
  echo "Expected 'Hallo Welt!', got '$output'"
  exit 1
fi
echo "Test passed."
