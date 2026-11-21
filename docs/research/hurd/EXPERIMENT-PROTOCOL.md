# WARENA GNU Hurd experiment protocol

**Status:** RESEARCH / NOT EXECUTED · 2026-11-20

## Purpose

Create reproducible evidence for Guix/Hurd without changing the WARENA production host or conflating upstream progress with local validation.

## Environment boundary

- Host: GNU/Linux + Guix.
- Virtualization: QEMU/KVM.
- First target: Guix ChildHurd, preferably `hurd64-qcow2`.
- No bare-metal installation in the initial phase.
- No production service migration.
- No changes to existing WARENA host configuration without a separate explicit decision.

## Required experiment record

| Field | Record |
|---|---|
| Experiment ID | HRD-YYYYMMDD-NN |
| Date | UTC timestamp |
| Host | OS, kernel, Guix version and architecture |
| Guix source | channel/repository commit and branch |
| Hurd target | `i586-gnu` or `x86_64-gnu` |
| Image | URL, checksum, build identifier |
| VM | QEMU version, machine type, CPU, RAM, disk, firmware |
| Configuration | version-controlled Scheme file and hash |
| Procedure | exact commands and steps |
| Result | PASS / FAIL / PARTIAL / NOT RUN |
| Logs | paths or redacted evidence references |
| Recovery | reset, rollback and data-loss expectations |
| Limitations | known incompatibilities and unresolved issues |

## Package qualification states

Do not collapse these into one "supported" column:

1. Package definition exists.
2. Dependency closure resolves for target.
3. Build completes.
4. Tests complete (or documented test exclusions).
5. Package executes on Hurd.
6. Relevant WARENA workflow works.
7. Recovery and repeatability demonstrated.

## Initial test matrix

| Package / subsystem | Why test it | Status |
|---|---|---|
| GNU Mach / Hurd boot | Kernel and server startup | NOT RUN |
| MIG / glibc | Target toolchain and ABI | NOT RUN |
| Guile 3 | WARENA Scheme foundation | NOT RUN |
| Shepherd | Service lifecycle | NOT RUN |
| coreutils / findutils | Base userland | NOT RUN |
| OpenSSH | Remote administration | NOT RUN |
| Git | Source workflow | NOT RUN |
| SQLite | Local persistence | NOT RUN |
| GNUstep / X.Org | Desktop feasibility | NOT RUN |

## Completion criteria for first milestone

- Reproducibly boot a 64-bit Guix/Hurd image under QEMU.
- Start and stop a ChildHurd through Shepherd.
- Demonstrate console access and SSH access.
- Record exact Guix revision and image provenance.
- Publish package-availability measurements for both target architectures.
- Preserve logs and recovery steps.

No experiment has been run merely because this protocol exists.
