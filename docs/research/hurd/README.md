# GNU Hurd research — WARENA

**Status:** RESEARCH · evidence snapshot 2026-11-20  
**Owner:** WARENA systems research  
**Primary integration focus:** GNU Guix / Guix System / ChildHurd  
**Production boundary:** GNU/Linux + Guix remains the production baseline. GNU/Hurd is an experimental portability and architecture track.

This directory records upstream activity and WARENA feasibility. It is not a fork, deployment claim, or commitment to replace the current host platform.

## Research objectives

1. Track GNU Hurd and GNU Mach upstream development, including translators, IPC, device support, SMP, architecture ports and userland.
2. Track GNU Guix support for `i586-gnu` and `x86_64-gnu`, including bootstrap, cross-compilation, package availability, system images, installer, Shepherd services and ChildHurd.
3. Separate changes merged to Guix `master` from work visible only on topic branches or in patch review.
4. Evaluate practical reproducibility on a GNU/Linux + Guix host using QEMU/KVM and ChildHurd before considering bare-metal work.
5. Extract architecture lessons for WARENA without prematurely creating a custom kernel, filesystem, IPC protocol or service framework.

## Current position

| Area | Evidence-backed position at 2026-11-20 | WARENA status |
|---|---|---|
| GNU Hurd | Upstream development continues; recent changes include libports lifecycle/error handling and libnetfs directory lookup work | RESEARCH |
| GNU Mach | Separate microkernel workstream; track independently from Hurd userland | RESEARCH |
| Guix/Hurd | Integrated support exists; 32-bit and 64-bit target paths are documented | RESEARCH |
| x86_64-gnu | Guix 1.5.0 includes 64-bit Hurd support; master has continuing target-specific fixes | RESEARCH |
| ChildHurd | Guix provides a Shepherd-managed Hurd VM service on GNU/Linux | PRIMARY EXPERIMENT |
| Package coverage | Published snapshot reports approximately 1.7% for i586-gnu and 0.9% for x86_64-gnu; these are historical figures, not a fresh measurement | NEEDS REFRESH |
| Desktop / X.Org | Do not assume the GNU/Hurd package set can provide WARENA's desktop target; Hurd running guide notes X.Org is unavailable in its Guix/Hurd snapshot | BLOCKED / INVESTIGATE |
| Hardware | QEMU first; physical hardware compatibility is a separate qualification gate | NOT TESTED |

## Documentation map

- [Guix/Hurd integration and feasibility](./GUIX-INTEGRATION.md)
- [Upstream activity log](./ACTIVITY-LOG.md)
- [WARENA experiment and evidence protocol](./EXPERIMENT-PROTOCOL.md)

## Upstream sources to monitor

- [GNU Hurd project](https://www.gnu.org/software/hurd/)
- [GNU Hurd commit notifications](https://www.mail-archive.com/commit-hurd@gnu.org/)
- [GNU Mach repository](https://git.savannah.gnu.org/cgit/hurd/gnumach.git/)
- [GNU Mach commit notifications](https://www.mail-archive.com/commit-hurd@gnu.org/) (shared commit-hurd archive; filter for GNU Mach subject lines)
- [GNU Guix repository](https://git.savannah.gnu.org/cgit/guix.git/)
- [Guix commit notifications](https://www.mail-archive.com/guix-commits@gnu.org/)
- [Guix/Hurd running guide](https://hurd.ion.nu/hurd/running/Guix.html)
- [Guix manual: virtualization services](https://guix.gnu.org/manual/en/html_node/Virtualization-Services.html)
- [Guix 1.5.0 release](https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/)
- [The 64-bit Hurd in Guix](https://guix.gnu.org/en/blog/2026/the-64-bit-hurd/)

## Evidence rules

- Record commit hash, upstream branch, author/date, merge state, affected subsystem and practical consequence.
- Label Guix `master`, topic branches, patch submissions and downstream forks separately.
- A commit notification is evidence of a repository change, not proof that a target system boots or a package builds.
- Package definition availability is not a successful build; successful build is not runtime validation; runtime validation is not deployment.
- Refresh package coverage with `guix weather --system=i586-gnu` and `guix weather --system=x86_64-gnu` on a current Guix checkout. Record date, channel commit and output.
- Do not promote any WARENA component to PROTOTYPE or LIVE without reproducible test evidence and recovery notes.

## Immediate next steps

1. Refresh `guix weather` for both GNU/Hurd systems on current Guix master.
2. Build and boot the official 64-bit Guix/Hurd QEMU image in a disposable GNU/Linux + Guix environment.
3. Evaluate a ChildHurd service from a version-controlled `operating-system` definition; verify Shepherd lifecycle, VNC console, SSH access and ephemeral-state behaviour.
4. Run a small package matrix: Guile, Shepherd, coreutils, grep, sed, findutils, tar, gzip, openssh, git, SQLite and selected WARENA dependencies. Mark unsupported packages explicitly.
5. Track GNU Mach SMP and device support separately; do not infer hardware readiness from QEMU success.

---

**Last reviewed:** 2026-11-20  
**Maturity:** RESEARCH. No WARENA host, package set, image or ChildHurd deployment is claimed.
