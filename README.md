# Prism Node

[![Validate](https://github.com/prismnetwork-tech/prism-node/actions/workflows/validate.yml/badge.svg)](https://github.com/prismnetwork-tech/prism-node/actions/workflows/validate.yml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/prismnetwork-tech/prism-node/badge)](https://securityscorecards.dev/viewer/?uri=github.com/prismnetwork-tech/prism-node)
[![License](https://img.shields.io/badge/license-Apache--2.0-ccff00)](LICENSE)

`prismd` is the supplier-side daemon for Prism Network. It enrolls a GPU host,
publishes signed inventory and telemetry, receives lease commands and creates
isolated Kata workloads with exclusive VFIO device assignment.

## Status

This project is pre-production. Its unit tests and simulated image checks run
in public CI, but public CI does not exercise a physical NVIDIA GPU, IOMMU,
VFIO, Kata Containers or the production control plane. A passing build is not
evidence that a host is safe for paid workloads.

## Capabilities

- Host preflight for Ubuntu, NVIDIA, containerd, Kata, IOMMU, VFIO and
  nftables prerequisites.
- Ed25519 device identity, signed enrollment and sequenced telemetry.
- Short-lived mutual-TLS node certificates.
- Outbound-only SSH and Jupyter tunnel registration.
- Signed command polling and idempotent command reporting.
- Public OCI image validation and digest pinning.
- Exclusive VFIO reservation, Kata launch plans, egress policy and teardown.
- Encrypted ephemeral workspace setup and crash-recovery state.

## Requirements

The initial hardware target is Ubuntu 24.04 on x86-64 with an NVIDIA GPU in a
complete, isolated IOMMU group. A production host also needs:

- NVIDIA drivers and NVIDIA Container Toolkit.
- containerd, `nerdctl` and a configured Kata runtime.
- IOMMU and `vfio-pci`.
- nftables.
- Swap disabled.

Read [the hardware contract](docs/HARDWARE.md) before changing a host. VFIO
binding can remove its display adapter from the host and a bad IOMMU topology
cannot be corrected in software.

## Build

The repository pins its Rust toolchain and protocol release.

```sh
cargo build --release --locked
./target/release/prismd preflight
```

Install the binary and systemd units by following
[`deploy/systemd/README.md`](deploy/systemd/README.md). Enrollment and funded
network participation require external Prism Network services and credentials;
they are not bundled here.

## Development

```sh
./scripts/validate.sh
```

The validation gate formats, lints, tests, documents, audits and builds a
release binary. Hardware integration is a separate release gate documented in
[`docs/VALIDATION.md`](docs/VALIDATION.md).

## Security

Running `prismd` grants a small, security-critical component control over VFIO,
containerd and host firewall rules. Do not run arbitrary forks on a supplier
host. Read [`SECURITY.md`](SECURITY.md) before installing or contributing.

## License

Code and documentation are licensed under the
[Apache License 2.0](LICENSE). The Prism Network name and visual identity are
governed separately.
