#!/usr/bin/env bash
set -euo pipefail

./scripts/check-repository.sh
cargo fmt --check
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo test --all-features --locked
RUSTDOCFLAGS="-D warnings" cargo doc --all-features --no-deps --locked
cargo build --release --locked

if command -v cargo-audit >/dev/null 2>&1; then
  cargo audit
fi
