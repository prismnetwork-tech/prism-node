# Hardware contract

`prismd` initially supports Ubuntu 24.04, x86-64 and NVIDIA GPUs. Other
platforms are unsupported even when the binary compiles.

## Required isolation

The leased GPU and every function it exposes must belong to an IOMMU group
that can be assigned to the Kata guest without host devices. The node preflight
reports candidate groups but does not prove that firmware isolation is sound.

Before binding a GPU to `vfio-pci`, verify:

- IOMMU is enabled in firmware and the kernel.
- The group contains only the GPU functions intended for the guest.
- The host does not depend on the GPU for display or boot.
- NVIDIA reset behavior is reliable across repeated guest teardown.
- containerd and the Kata runtime accept the intended VFIO configuration.

Do not use ACS override patches to make an unsafe topology appear isolated.

## Runtime prerequisites

- NVIDIA driver compatible with the advertised CUDA major version.
- NVIDIA Container Toolkit.
- containerd and `nerdctl`.
- Kata Containers configured as a containerd runtime.
- `vfio-pci` and IOMMU support.
- nftables.
- Swap disabled.

Run `prismd preflight` after every kernel, driver, firmware or Kata update.

## Current validation gap

Public CI cannot validate physical GPU passthrough. A release intended for paid
work must pass the hardware canary in [`VALIDATION.md`](VALIDATION.md) on the
exact supported host image.
