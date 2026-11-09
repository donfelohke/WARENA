# HP EliteBook 835 G8 — Sovereign Emacs / Guix RDE / Agent Workstation

**Document ID:** WARENA-ELITEBOOK-835G8-2026-11  
**Date:** 2026-11-09  
**Status:** RESEARCH / SETUP SPECIFICATION — NOT DEPLOYED  
**Target:** HP EliteBook 835 G8, AMD Ryzen 5 PRO 5650U  
**Owner:** WARENA Systems  
**Governing rule:** specification ≠ configuration ≠ build ≠ host verification ≠ deployment.

## 1. Purpose

Define a staged, local-first workstation for systems engineering and coordinated agent-assisted development. The human operator remains in control through GNU Emacs. GNU Guix and RDE provide the declarative environment; Guile owns the proposed agent coordination and permission boundary; Wayland is a separately qualified desktop layer.

This document does not claim that the target laptop has been inspected, upgraded, installed with Guix, or tested. The installed operating system, RAM population, SSD model/health, firmware version, Secure Boot state, battery condition and display configuration are currently **UNKNOWN**.

## 2. Hardware profile and capacity plan

### Known target model

| Item | Target / design implication |
|---|---|
| CPU | AMD Ryzen 5 PRO 5650U; 6 cores / 12 threads |
| Graphics | Integrated AMD Radeon; suitable for ordinary Wayland compositing, not a substitute for a dedicated LLM accelerator |
| Memory | DDR4-3200 SODIMM platform; inspect the actual module population and firmware-reported capacity |
| Storage | M.2 NVMe; inspect exact device, health, capacity and encryption state |
| Display | 13.3-inch FHD class; consider an external monitor for dense Emacs layouts |
| Network | Wi-Fi 6 class and wired networking through a suitable adapter/dock |

Do not treat reseller listings as a complete hardware inventory. Confirm the exact product number and machine-specific maintenance documentation. Verify the number of populated memory sockets, supported module density, current memory, SSD form factor and battery condition before purchasing parts.

### Recommended capacity targets

| Resource | Minimum workable start | Preferred workstation target | Rationale |
|---|---:|---:|---|
| RAM | 16 GB | 32 GB (2 × 16 GB if supported) | Emacs, build tools, local services and one modest inference workload |
| RAM for heavier experiments | — | 64 GB only after model/VM requirements justify it | Check HP limits, BIOS and module compatibility first |
| NVMe | 512 GB | 1 TB; 2 TB for retained model files/build caches | Guix store, source trees, caches, backups staging and datasets |
| Local inference | One model on demand | One primary model; logical agents share it | Avoid memory contention and thermal saturation |

Eight gigabytes is not a suitable target for the complete multi-agent development environment. Sixteen gigabytes can support the editor and development foundation, but local inference and concurrent builds will be constrained. Thirty-two gigabytes is the recommended balance; it does not make this CPU a high-throughput inference system.

Before upgrades, confirm the exact SKU and module configuration. Do not infer that every refurbished or Ex-UK unit has the same RAM, SSD, screen, WWAN, NFC or battery options.

## 3. Architecture

```text
Human operator
  GNU Emacs
  Org · Magit · Dired · Eglot · Geiser · TRAMP
          |
          v
Conversation / task interface
  gptel (LLM client; not the agent runtime)
          |
          v
WARENA agent control plane (proposed; Guile)
  task coordinator · policy broker · task state · audit events
          |
          +-- Architect       -> plans / acceptance criteria
          +-- Researcher      -> source-grounded findings
          +-- Implementer     -> isolated Git worktree / patch
          +-- Tester          -> approved tests / benchmarks
          +-- Reviewer        -> independent diff review
          +-- Provenance      -> source, licence and attribution audit
          |
          v
Constrained execution boundary
  approved tools · command allowlist · isolated worktrees
  explicit network access · redacted logs · human approvals
          |
          v
GNU Guix + RDE + Guix Home
  pinned channels · declared packages · user services
          |
          v
Linux host / Wayland session
  Sway reference fallback · Niri evaluation · dwl-guile research
```

### Responsibility boundaries

- **Emacs** is the operator's workbench, not an autonomous authority.
- **gptel** supplies an Emacs interface to model backends and tool integrations. It does not, by itself, provide the full WARENA multi-agent policy engine.
- **Guile** is the proposed orchestration language and policy implementation environment. The coordinator is a design proposal; no coordinator service is claimed to exist.
- **Agents** are role-scoped workers. Multiple logical agents may share one model backend; do not assume one heavyweight model process per role.
- **Guix/RDE** owns reproducible package and user-environment declarations. Do not mix mutable host state or secrets into declarative source.
- **Desktop compositor** is replaceable. Do not make the experimental compositor a prerequisite for the editor or agent system.

## 4. Emacs baseline

Proposed editor components:

| Component | Responsibility |
|---|---|
| Org mode | Research notebook, task records, decision logs and runbooks |
| Magit | Git history, worktrees, diffs and review |
| Dired | File navigation and controlled project inspection |
| Eglot | Language Server Protocol integration |
| Geiser | Guile/Scheme REPL and development |
| TRAMP | Explicit remote file and process access |
| gptel | Model conversations and approved tool workflows |

Start with a small, pinned Emacs package set. Add packages only when a concrete workflow requires them. Native compilation is optional and must be evaluated against the Guix Emacs build features and the target host; do not assume it is enabled.

### Agent interface rule

Keep transcripts and task records inspectable. The user must be able to see the active model/backend, the current project/worktree, tools available to the agent, and the approval boundary before a consequential action.

## 5. Multi-agent permission model

The control plane must enforce policy outside the model prompt. Prompt instructions alone are not a security boundary.

| Operation | Default policy |
|---|---|
| Read explicitly approved project files | Allow |
| Search local manuals and declared source trees | Allow |
| Draft plans, patches and tests | Allow |
| Edit a dedicated temporary Git worktree | Allow within project scope |
| Run read-only inspection and approved test commands | Allow |
| Access network, fetch dependencies or call remote models | Require explicit task-level approval |
| Read credentials, SSH keys, browser profiles or private customer data | Deny by default |
| Change boot, disk, encryption, firewall, Guix System or host services | Human approval required |
| Install packages or reconfigure the live host | Human approval required |
| Push to protected branches, merge, release or deploy | Human approval required |

Required controls:

1. Per-project filesystem scope; no ambient home-directory access.
2. Separate Git worktree per implementation task.
3. Command allowlist and bounded execution time/output.
4. No implicit shell interpolation of model-generated strings.
5. Network egress disabled by default for workers; explicit approval for named destinations or tasks.
6. Credentials supplied only through a separately designed secret mechanism; never put them in prompts, transcripts or logs.
7. Append-only task/action records with actor, tool, scope, approval, timestamp and result.
8. Human review of generated diffs, licences, source provenance and test output.
9. A kill switch and a recoverable state if the coordinator or model fails.
10. No autonomous merge, release, payment, account change or host reconfiguration.

A multi-agent system is considered coordinated only when tasks, permissions, handoffs and outcomes are recorded. Unbounded parallel model calls are not the objective.

## 6. Guix and RDE strategy

**Preferred deployment path:** staged.

1. Preserve the existing operating system and a known-good boot path.
2. Audit the host and backups.
3. Establish a pinned Guix development environment in an isolated or recoverable context.
4. Build the Guix Home/RDE profile first.
5. Add Emacs and developer tools.
6. Add local inference and the Guile coordinator only after the editor baseline works.
7. Qualify the compositor independently.
8. Consider full Guix System only through a separate migration decision and recovery plan.

### Channel and package policy

- Record the Guix version and every channel URL, branch, commit and introduction fingerprint.
- Check in a channel declaration only after authentication and compatibility review.
- Record the exact RDE source commit and its channel/package relationship.
- Distinguish upstream existence, package definition, successful evaluation, successful build, host installation and operational service.
- Do not create a plausible-looking lock file from unrelated snapshots.
- Keep model weights, caches, credentials and mutable user data outside the source repository.
- Prefer source and binary substitutes only where their provenance and trust model are understood; document offline closure requirements.

### Current upstream observation snapshot

Observed from upstream GitHub repository metadata and default-branch commits on 2026-11-09. These are source observations, **not a compatible channel lock or tested dependency set**.

| Component | Canonical source / mirror | Observed commit | Commit date | Licence observation | Disposition |
|---|---|---|---|---|---|
| RDE | [abcdw/rde](https://github.com/abcdw/rde), GitHub mirror of SourceHut project | `24955da51caf1aaad9a5f0e6c9c9845a504eff64` | 2026-05-04 | GPL-3.0 | Keep upstream; consume as pinned dependency after channel audit |
| dwl-guile | [engstrand-config/dwl-guile](https://github.com/engstrand-config/dwl-guile) | `3b9eb86637777a8f82211114a9c38d1c1ede03f7` | 2024-01-12 | GitHub API reports NOASSERTION; repository licence text references GPL-3.0-or-later and component-specific licence files | Fork candidate only after complete per-file/component licence audit |
| Home service | [engstrand-config/home-service-dwl-guile](https://github.com/engstrand-config/home-service-dwl-guile) | `09045a658a17a914d1bda4d23c04d99c40a1d63b` | 2023-10-20 | GPL-3.0 | Fork candidate; upstream describes work in progress |
| gptel | [karthink/gptel](https://github.com/karthink/gptel) | `e161ababf0cb19654ec9097f06c09c95d4561721` | 2026-11-05 | GPL-3.0 | Keep upstream; pin through selected Emacs package source |

The dwl-guile licence must not be simplified to a repository-wide GPL assertion without checking its referenced component notices (including `LICENSE.tinywl`, `LICENSE.dwm` and `LICENSE.sway`). Preserve all notices and upstream history in any lawful fork. Never rewrite or transform source to disguise origin or licence.

The observed age gap between the RDE snapshot and the dwl-guile/Home-service snapshots is a compatibility risk. The old compositor package definition has been associated with a dwl v0.4 / wlroots 0.16.x dependency baseline. Re-evaluate the current source and dependency graph before packaging; do not assume it builds with a current Guix channel.

## 7. Fork and repository plan

Proposed WARENA-owned repositories:

- `donfelohke/dwl-guile` — compatibility maintenance and WARENA-specific patches, preserving upstream history and notices.
- `donfelohke/home-service-dwl-guile` — service lifecycle and Guix/RDE integration maintenance.
- `donfelohke/warena-rde` — original host-independent configuration, machine profiles, policy, tests and setup documentation; not a fork of RDE.

Keep `abcdw/rde` and `karthink/gptel` upstream unless a documented technical or governance reason justifies a fork. Treat `engstrand-config/guix-dotfiles` as a reference implementation, not a configuration to copy wholesale.

**Repository action status:** the proposed forks and `warena-rde` repository are not confirmed created by this change. GitHub fork creation was not available through the connected GitHub actions during this task. No substitute repository has been fabricated.

## 8. Desktop qualification

The editor and agent control plane must work independently of the experimental compositor.

- Keep the existing working session until its identity and recovery path are recorded.
- Use Sway as a conservative Wayland fallback/reference if it is available and tested on the host.
- Evaluate Niri + Noctalia as a separate practical desktop candidate under the existing WARENA desktop decision.
- Keep dwl-guile in a separate research profile until pinned source, package evaluation, build, runtime, REPL access control and recovery have passed.
- Do not expose a dwl-guile REPL on an untrusted network or enable it by default in a production session.

Desktop acceptance checks include login/logout, keyboard/input, display hot-plug, scaling, audio, portals, notifications, lock/idle, suspend/resume, compositor crash recovery, TTY access and fallback-session recovery.

## 9. Staged implementation and acceptance gates

| Gate | Work | Acceptance evidence |
|---|---|---|
| H0 — inventory | Record exact SKU, CPU, RAM modules, SSD, firmware, battery and current OS | Completed host inventory with source/command evidence |
| H1 — recovery | Verify backup, recovery media, boot path and data restore | Recovery procedure and observed test result |
| G0 — source | Review channel introductions, immutable commits, licences and package dependency graph | Authenticated source/revision/licence register |
| G1 — environment | Evaluate and build minimal Guix/RDE environment away from the live host | Exact inputs, commands, logs and exit status |
| E0 — editor | Start Emacs; validate Org, Magit, Geiser and language tooling | Recorded interactive checks |
| A0 — agent policy | Implement role/task schema, worktree boundary and approval broker | Unit tests for allow/deny cases and audit events |
| A1 — model | Benchmark one local backend on actual hardware | Model identity/quantisation, memory, latency, thermals and power observations |
| D0 — desktop | Test compositor and session lifecycle separately | Hardware test matrix and demonstrated fallback |
| R0 — recovery | Rebuild or restore from documented source and backup | Independent repeat and recovery evidence |

Do not mark a gate PASS before running it. A documentation PR, configuration file or successful syntax check is not proof of a built or deployed workstation.

## 10. Safe initial host inventory

Only run commands appropriate to the currently installed operating system. These Linux commands are read-only examples; they do not install or reconfigure anything:

```sh
uname -a
lscpu
free -h
lsblk -o NAME,MODEL,SIZE,TYPE,FSTYPE,MOUNTPOINTS
lspci -nn
lsusb
```

For firmware, battery, NVMe health, RAM population and BIOS settings, use the platform's available read-only tools and HP machine-specific documentation. Redact serial numbers, UUIDs, MAC addresses, usernames and private network details before sharing output.

If GNU Guix is already installed, capture its current channel description with:

```sh
guix describe --format=channels
```

Do not run `guix home reconfigure`, `guix system reconfigure`, partitioning, firmware flashing or bootloader changes as part of inventory.

## 11. Decisions still required before executable setup

- Current installed operating system and version.
- Actual RAM population and whether an upgrade is needed.
- NVMe capacity, health and encryption/recovery state.
- Whether the target should remain dual-boot or preserve the existing OS.
- Preferred initial compositor/session and available fallback.
- Whether local inference must be strictly offline or may use explicitly approved remote backends.

Until those facts are recorded, the repository should contain a setup specification and checklists, not pretend-ready machine-specific `home.scm`, `system.scm` or channel lock files.

## 12. Related WARENA documentation

- [Desktop stack decision](desktop-stack-decision-2026-11.md)
- [Desktop architecture](DESKTOP-ARCHITECTURE.md)
- [Stack register](STACK-REGISTER.md)
- [Reproducibility plan](reproducibility-plan.md)
- [Reproducible environment runbook](reproducible-environment-runbook.md)
- [Host inventory template](host-inventory-template.md)
- [Backup and restore runbook](backup-restore-runbook.md)
- [Validation discipline](VALIDATION.md)

## 13. Primary source references

- HP EliteBook 835 G8 media specification: https://www.hp.com/content/dam/sites/garage-press/press/press-kits/2021/ces-2021/hp_elitebook_835_g8_media_spec_sheet.pdf
- RDE upstream/mirror: https://github.com/abcdw/rde
- RDE canonical SourceHut project: https://sr.ht/~abcdw/rde/
- dwl-guile: https://github.com/engstrand-config/dwl-guile
- dwl-guile Home service: https://github.com/engstrand-config/home-service-dwl-guile
- Engstrand Guix dotfiles (reference only): https://github.com/engstrand-config/guix-dotfiles
- gptel: https://github.com/karthink/gptel
- GNU Guix manual: https://guix.gnu.org/manual/
- RDE manual: https://abcdw.github.io/rde/
- GNU Emacs manual: https://www.gnu.org/software/emacs/manual/
- gptel documentation: https://gptel.org/

Re-check upstream source, channel, package and licence state immediately before implementation. Links and snapshot commits are evidence pointers; they are not a substitute for a verified, mutually compatible lock.
