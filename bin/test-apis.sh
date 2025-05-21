#!/usr/bin/env bash
set -euo pipefail

# Test GitHub API connectivity
echo "Testing GitHub API connectivity..."
auth_token="${PAT_TOKEN:-${GITHUB_TOKEN:-}}"
if [[ -z "$auth_token" ]]; then
  echo "No PAT_TOKEN or GITHUB_TOKEN available, cannot test GitHub API"
else
  http_code=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token ${auth_token}" \
    https://api.github.com/user)
  echo "GitHub API responded with HTTP ${http_code}"
fi

echo
# Test OpenRouter API connectivity
echo "Testing OpenRouter API connectivity..."
missing_env=0
if [[ -z "${LLM_BASE_URL:-}" ]]; then
  echo "LLM_BASE_URL is not set, cannot test OpenRouter API"
  missing_env=1
fi
if [[ -z "${LLM_API_KEY:-}" ]]; then
  echo "LLM_API_KEY is not set, cannot test OpenRouter API"
  missing_env=1
fi
if [[ -z "${LLM_MODEL:-}" ]]; then
  echo "LLM_MODEL is not set, cannot test OpenRouter API"
  missing_env=1
fi

if [[ "$missing_env" -eq 0 ]]; then
  echo "Sending ping request to ${LLM_BASE_URL}..."
  http_code=$(curl -s -o /dev/null -w "%{http_code}" \
    -X POST "${LLM_BASE_URL}" \
    -H "Authorization: Bearer ${LLM_API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"${LLM_MODEL}\",\"messages\":[{\"role\":\"user\",\"content\":\"ping\"}]}" )
  echo "OpenRouter API responded with HTTP ${http_code}"
fi
EOF && chmod +x bin/test-apis.sh && PAT_TOKEN="$GITHUB_TOKEN" LLM_BASE_URL="https://openrouter.ai/api/v1/chat/completions" LLM_API_KEY="invalid_key" LLM_MODEL="openrouter/mistralai/mistral-7b-instruct-v0.3" bash bin/test-apis.sh && git add bin/test-apis.sh && git commit -m "Fix test-apis.sh syntax errors and improve connectivity checks"
