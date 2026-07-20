# Security policy

## Supported versions

The node is pre-production. Security fixes apply to the current `main` branch.
No release currently receives long-term support.

## Reporting a vulnerability

Do not open a public issue.

Use GitHub private vulnerability reporting for this repository. If that
channel is unavailable, email `security@prismnetwork.tech` with the affected
version, reproduction steps, impact and required prerequisites.

## Privilege boundary

The command supervisor runs with host privileges because VFIO assignment,
nftables policy and containerd control cannot be delegated to an ordinary
process. The tunnel runs as an unprivileged user.

The daemon does not make a permissionless supplier trustworthy and does not
provide confidential computing. It must not be used for confidential or
sensitive renter workloads. Operators remain responsible for:

- Dedicated GPU IOMMU groups and correct `vfio-pci` binding.
- Host patching, secure boot policy and physical access control.
- Protecting the device identity and mutual-TLS private key.
- Keeping the control-plane and gateway trust roots current.
- Reviewing launch plans before enabling real execution.

Never include device identities, private keys, access credentials, renter
environment values or workload contents in issues or logs.
