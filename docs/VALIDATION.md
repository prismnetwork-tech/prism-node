# Validation

## Public CI

Public CI verifies repository hygiene, formatting, linting, unit tests,
documentation, dependency advisories and a release build. Runtime tests use
generated plans and a non-GPU test image.

Public CI does not claim to validate NVIDIA hardware, IOMMU grouping, VFIO
passthrough, Kata isolation, CUDA readiness or production networking.

## Hardware canary

Before a release is eligible for paid workloads, run the following on a clean
copy of the supported Ubuntu host image:

1. Record firmware, kernel, NVIDIA, containerd and Kata versions.
2. Verify the complete IOMMU group and bind it to `vfio-pci`.
3. Run `prismd preflight` and archive the signed result.
4. Resolve a public OCI image to an immutable digest.
5. Launch it through Kata with exclusive GPU assignment.
6. Confirm CUDA readiness, SSH and Jupyter access through the outbound tunnel.
7. Confirm blocked metadata, private-network and SMTP destinations.
8. Terminate the lease and verify device release, firewall cleanup, key
   destruction and workspace removal.
9. Repeat launch and teardown after daemon and gateway restarts.
10. Complete a capped end-to-end settlement on the staging network.

The canary evidence must identify the source revision and protocol tag without
including hostnames, wallet secrets, access tokens or personal paths.
