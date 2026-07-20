#!/usr/bin/env bash
set -euo pipefail

if grep -RInE \
  --exclude-dir=.git \
  --exclude-dir=target \
  --exclude=check-repository.sh \
  '(/Users/[^/$]+/|/home/[^/$]+/|BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY|gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{50,}|Co-Authored-By:|Generated with (Claude|Codex))' \
  .; then
  echo "prohibited credential, path or attribution detected" >&2
  exit 1
fi

git diff --check
