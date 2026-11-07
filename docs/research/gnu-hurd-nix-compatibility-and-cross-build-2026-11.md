# GNU Hurd + Nix: Compatibility, Cross-Building and WARENA Research Plan

**Document ID:** WARENA-RSCH-HURD-NIX-01  
**Revision:** 2026-11-07  
**Status:** RESEARCH / NOT IMPLEMENTED  
**Scope:** GNU Hurd, GNU Mach, Nix, Nixpkgs, NixOS, GNU Guix/Hurd  
**Decision boundary:** This document authorizes research and isolated experiments only. It does not authorize a native port, production deployment, hardware purchase, or replacement of the current GNU/Linux baseline.

> **Executive finding:** Hurd + Nix is not a single compatibility proposition. A historical Nix-based GNU/Hurd cross-built image exists in GNU Hurd documentation, but it is explicitly distinguished from NixOS. The most credible present-day research path is to investigate Nix as a Linux-hosted cross-build/artefact-provenance tool for Hurd targets, while treating native Nix-on-Hurd and NixOS-on-Hurd as separate, unproven engineering projects.

## 1. The three questions that must not be conflated

| Question | Current assessment | Evidence status |
|---|---|---|
| Can Nix be used on a Linux host to cross-build GNU/Hurd components or images? | Historical proof-of-concept is documented; current reproducibility and maintenance need verification. | Historical evidence; current build unverified |
| Can the Nix package manager run natively on GNU Hurd? | No current supported native Hurd host target was established by this research. Requires porting and runtime validation. | Unknown / research |
| Can NixOS run on GNU Hurd? | No. NixOS is a Linux distribution with Linux-specific system integration; a historic Hurd image was explicitly not equivalent to NixOS. | Not supported by evidence |

A successful cross-build does not prove that the package manager runs on the target. A working package manager does not prove that NixOS service, boot, activation, and rollback machinery works on that kernel.

## 2. Historical precedent: Nix-based GNU/Hurd image

The GNU Hurd project's Nix page documents a Hurd system image cross-built using Nix, with packages installed in per-package directories under `/nix/store`. The same page explicitly says the image was not comparable to NixOS because it lacked whole-system configuration (including services) and whole-system transactional update and rollback.

The page also preserves a 2013 discussion in which the Hurd image's Hydra jobset was reported broken. This is useful historical evidence, not proof of a maintained or currently reproducible pipeline.

**Research conclusion:** Nix has been used in the Hurd ecosystem as a build tool. Do not describe this as “NixOS on Hurd”, and do not assume the historical jobset or image still builds.

## 3. Why NixOS is a different problem

Nix is a package manager and build system. NixOS is an operating-system distribution and configuration framework built around Nix.

A Hurd port of NixOS would need substantially more than Nix expressions that compile Hurd-compatible binaries. It would need a supported Hurd kernel/system target and replacements or ports for Linux-dependent components and assumptions, including:

- Kernel and boot integration.
- Service supervision and system activation.
- Device management and hardware discovery.
- Filesystem and mount orchestration.
- Networking and firewall integration.
- User/session and desktop integration.
- System generation switching, rollback and recovery semantics.
- Build/test infrastructure and supported binary substitutes.

NixOS's existing architecture is Linux-oriented. The Nixpkgs issue discussing non-Linux kernels is a design discussion, not evidence of a supported NixOS/Hurd implementation.

## 4. GNU Hurd readiness constraints

GNU Hurd is a multi-server operating-system architecture running Hurd servers in user space on GNU Mach. Its architecture is a legitimate research alternative, but hardware and software support remain much narrower than contemporary Linux.

Relevant official Hurd material and status reports indicate:

- GNU Mach is the microkernel foundation.
- x86_64 Hurd progress is substantial, but this does not imply parity with Linux hardware support.
- Hurd documentation describes limitations in device support; recent guidance still reports very limited USB support and recommends QEMU for experimentation.
- Guix has integrated GNU/Hurd support, but the Hurd Guix page reports a small runnable package fraction (approximately 1.7% at the time of that page; use `guix weather --system=x86_64-gnu` or the currently documented system triplet to refresh).
- Package percentages are time-sensitive and must be re-measured before any decision.

Do not extrapolate old Hurd documentation about SMP or hardware directly into a current support claim. Record the date and exact source of every compatibility assertion.

## 5. Nix versus Guix as a Hurd research tool

| Dimension | Nix | GNU Guix |
|---|---|---|
| Hurd integration | Historical Nix-built Hurd image documented; present state unclear | Hurd support integrated in Guix; still experimental and package coverage limited |
| Best current research role | Cross-build orchestration, derivation experiments, artefact provenance | Native Hurd package/system integration research |
| System configuration on Hurd | No NixOS/Hurd implementation established | Guix System/Hurd experimental configuration documented |
| Package definitions | Nix expressions / Nixpkgs | Guile package definitions / channels |
| Binary distribution | Nix store paths and substituters | Guix store items and substitutes |
| Main unknown | Current target-platform and build graph support | Current package coverage, service and hardware gaps |
| WARENA posture | Comparator and possible cross-build tool | Primary Hurd integration research path |

This is not a contest to select one package manager for every system. The tools may serve different roles: Guix as the native GNU/Hurd integration path and Nix as a comparative build-graph / cross-build experiment hosted on Linux.

## 6. Proposed experiment ladder

All experiments are bounded, virtualised and reversible. No bare-metal Hurd deployment is required for the initial stages.

### HN-00 — Source and status audit

- Record current Nix version, Nixpkgs revision, Guix revision and Hurd source revisions.
- Inspect the historical GNU Hurd Nix page and determine whether its Hydra references still resolve.
- Identify whether any current Nixpkgs platform definitions mention `*-gnu` / Hurd.
- Inspect actual build/test jobs rather than relying on target-triplet strings alone.
- Deliverable: dated evidence table with URLs, revisions and confidence.

**Acceptance:** Every claim is classified as current verified, historical, proposed, or unknown.

### HN-01 — Linux-hosted cross-build feasibility

- Use a disposable x86_64 GNU/Linux build host or VM.
- Reproduce a minimal Hurd-related build using a pinned Nixpkgs revision.
- Determine whether the build is a genuine Hurd-target cross-build or merely builds host-side tooling.
- Capture derivations, source hashes, build logs, target triplets and outputs.
- Do not claim success unless the produced binary is confirmed to target GNU/Hurd.

**Acceptance:** A minimal, independently inspectable Hurd-target artefact builds from pinned inputs, or a precise blocker report is produced.

### HN-02 — Guix/Hurd baseline in QEMU

- Obtain the documented Guix/Hurd QEMU image or build it using the documented workflow.
- Record exact image provenance, architecture, Guix revision and Hurd revision.
- Boot, inspect package availability, run a small package build, and test network/device assumptions.
- Run `guix weather` for the correct Hurd system triplet and save the output with timestamp.

**Acceptance:** Repeatable boot and package test with logs; no production claim.

### HN-03 — Nix and Guix artefact comparison

- Compare store layout, closure transfer, dependency metadata, source retention and offline operation.
- Test exporting/importing a minimal package closure in each ecosystem where supported.
- Record whether artefacts can be rebuilt, merely transferred, or only consumed on their original host platform.
- Do not assume Nix and Guix stores are interchangeable.

**Acceptance:** A written compatibility matrix; no cross-store equivalence claim without an actual verified test.

### HN-04 — Native Nix-on-Hurd feasibility spike

Only proceed if HN-00 identifies a credible maintainer path and HN-01 establishes a useful cross-build baseline.

Investigate:
- Nix daemon and client assumptions.
- Linux-specific syscalls, namespaces, cgroups, mount and process APIs.
- Filesystem, sandbox and build-isolation mechanisms.
- Hurd/glibc integration and available primitives.
- Whether an unsandboxed or reduced-sandbox mode is technically possible and safe.
- Required changes upstream versus a downstream fork.

**Acceptance:** Written porting estimate, dependency map, upstream engagement plan and explicit security limitations. No claim of native support until tested on Hurd.

### HN-05 — NixOS/Hurd feasibility review

Treat as a separate architectural project. Map Linux dependencies in NixOS activation, systemd, boot, device management and networking. Do not begin a port merely because Nix can evaluate expressions or cross-compile packages.

**Acceptance:** A documented go/no-go decision. Current default is NO-GO for implementation; research-only.

## 7. WARENA architecture recommendation

**Near term**
- Keep GNU/Linux as the operational baseline.
- Keep Guix + RDE as the primary reproducible system and user-environment research path.
- Maintain Sway as the known transitional desktop baseline; evaluate Niri separately.
- Keep dwl-guile and dtao-guile as bounded Guile-native research, not assumed production components.
- Use QEMU for Hurd experimentation.

**Research track**
- GNU Hurd + Guix: primary native Hurd research.
- Nix + GNU Hurd: cross-build and provenance comparator.
- Native Nix on Hurd: exploratory porting question.
- NixOS on Hurd: no implementation commitment.

**Long-term principle:** Do not make the future of Hurd depend on a NixOS port, and do not make the current WARENA platform depend on Hurd maturity.

## 8. Risks and devil's-advocate review

| Risk | Consequence | Control |
|---|---|---|
| Historical Nix Hurd image mistaken for current support | False compatibility claims | Label historical; reproduce before citing as current |
| Cross-build confused with native execution | Wrong architecture or unusable binaries | Verify ELF target, ABI and runtime on Hurd |
| NixOS confused with Nix | Scope explosion | Keep package manager, package set and OS distinct |
| Hurd hardware limitations | VM-only results fail on target hardware | QEMU-first; separate hardware qualification |
| Package count treated as stable | Misleading availability claims | Timestamp `guix weather` results |
| Custom fork becomes unmaintainable | Long-term security and upgrade burden | Prefer upstreamable patches and named maintainers |
| Store closure mistaken for full OS image | Incomplete recovery | Retain boot, kernel, configuration, services and recovery artefacts |
| Offline cache mistaken for source reproducibility | Cannot rebuild later | Preserve source, revisions, signatures and build inputs |

## 9. Decision register

| Decision | Current value |
|---|---|
| GNU/Linux operational baseline | RETAIN |
| Guix/RDE primary configuration research | RETAIN |
| GNU Hurd research | APPROVE — QEMU / non-production |
| Guix/Hurd investigation | APPROVE — experimental |
| Nix cross-build investigation | APPROVE — research only |
| Native Nix on Hurd | DEFER — feasibility evidence required |
| NixOS on Hurd | NO-GO for implementation; monitor research |
| Bare-metal Hurd deployment | NOT APPROVED |
| Production migration | NOT APPROVED |

## 10. Evidence sources

1. GNU Hurd, “Nix-based GNU/Hurd System”: https://www.gnu.org/software/hurd/hurd/running/nix.html  
   Historical Nix-built Hurd image; explicitly distinguishes it from NixOS.
2. GNU Hurd, “Guix”: https://www.gnu.org/software/hurd/hurd/running/Guix.html  
   Guix/Hurd integration, QEMU image and package-availability guidance.
3. GNU Hurd, “GNU Mach”: https://www.gnu.org/software/gnumach/  
   Microkernel role and architecture.
4. GNU Hurd, “Doing a GNU/Hurd System Port”: https://www.gnu.org/software/hurd/faq/system_port.html  
   Components involved in a system/architecture port and AArch64 experimental port context.
5. GNU Hurd, “FAQ”: https://www.gnu.org/software/hurd/faq_inlined.html  
   Hardware and software support notes; consult dated sections.
6. NixOS Wiki, “NixOS”: https://wiki.nixos.org/wiki/NixOS  
   NixOS as a Linux distribution and supported architecture context.
7. Nixpkgs Reference Manual: https://nixos.org/manual/nixpkgs/stable/  
   Package-set and platform documentation.
8. Nixpkgs issue #26850, “Support non-Linux kernels in NixOS”: https://github.com/NixOS/nixpkgs/issues/26850  
   Historical discussion; not evidence of implementation.

## 11. Review checklist

- [ ] Confirm historical Nix/Hurd Hydra job status.
- [ ] Inspect current Nixpkgs target-platform definitions and build jobs.
- [ ] Reproduce a minimal Hurd-target cross-build, or document exact blocker.
- [ ] Boot current Guix/Hurd QEMU image and record revisions.
- [ ] Capture current Guix/Hurd package weather output.
- [ ] Compare offline closure export/import in Nix and Guix.
- [ ] Review Nix native port requirements before any implementation.
- [ ] Keep NixOS/Hurd out of implementation scope unless new evidence changes the decision.

**Final operating rule:** A historical proof of concept is a research lead, not a supported platform. Nix can be investigated as a build instrument for Hurd without claiming NixOS compatibility. Guix remains the more direct native Hurd research path.
