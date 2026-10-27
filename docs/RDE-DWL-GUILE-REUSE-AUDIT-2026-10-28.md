# RDE + DWL-Guile reuse audit

**Status:** RESEARCH / INTEGRATION PLAN  
**Review date:** 2026-10-28  
**Repository:** `donfelohke/WARENA`  
**Scope:** Public upstream source review and proposed integration path. This document does not claim a successful build, installation, hardware test, or deployment.

## Executive decision

Reuse upstream projects and patterns before implementing new WARENA-specific machinery:

1. **RDE** — investigate as the reusable Guix-oriented configuration framework.
2. **GNU Guix / Guix Home** — own package inputs, declarative environment composition, build provenance, and user-level service configuration.
3. **DWL-Guile** — keep as the experimental Scheme-native Wayland compositor profile.
4. **DWL-Guile Home service** — inspect and reuse where its package and lifecycle assumptions match the pinned Guix environment.
5. **Engstrand configuration** — use as an implementation reference, not as a configuration to copy wholesale.
6. **WARENA** — own hardware profiles, policy, evidence records, qualification tests, fallback, and recovery.

Sway remains the preferred baseline candidate for the first Wayland qualification. DWL-Guile remains RESEARCH until build, runtime, failure-handling, and recovery evidence exists.

## Repositories

| Project | Upstream | Intended use | Caution |
|---|---|---|---|
| RDE | https://github.com/abcdw/rde | Reusable Guix-oriented environment framework | API is under active development; pin and inspect the actual channel source |
| DWL-Guile | https://github.com/engstrand-config/dwl-guile | Scheme-configurable Wayland compositor | Confirm current base, wlroots/Wayland dependencies, patches, and runtime-control behaviour |
| DWL-Guile Home service | https://github.com/engstrand-config/home-service-dwl-guile | User-level package/service integration | Upstream describes work in progress; do not infer production readiness |
| Engstrand Guix dotfiles | https://github.com/engstrand-config/guix-dotfiles | Real-world RDE, Guix System, Guix Home, host/user separation, and Wayland example | Personal settings, host-specific configuration, and secrets-management choices are not WARENA defaults |
| GNU Guix | https://guix.gnu.org/ | Package management, system and home environment | Pin channels and record provenance; package availability does not prove installation or operation |

Useful upstream reading:
- RDE project overview: https://github.com/abcdw/rde
- Engstrand configuration overview: https://github.com/engstrand-config/guix-dotfiles
- WARENA desktop policy: ./DESKTOP-ARCHITECTURE.md
- WARENA evidence contract: ./STACK-REGISTER.md
- WARENA reproducibility stages: ./reproducibility-plan.md

## Architecture boundary

```text
WARENA policy
  ├── hardware and user profiles
  ├── profile selection and fallback
  ├── qualification evidence
  └── recovery and operational constraints
        |
GNU Guix + RDE
  ├── pinned channels and package sources
  ├── reusable environment modules
  ├── system configuration
  └── Guix Home configuration
        |
Wayland profile candidates
  ├── Sway       — baseline candidate
  └── DWL-Guile  — experimental Scheme-native candidate
        |
Emacs + Geiser — development workflow, where applicable
```

Do not create a generic compositor abstraction merely to make Sway and DWL-Guile look identical. Share WARENA policy only at real boundaries such as profile selection, application launch, input/display expectations, logging, fallback, and recovery.

## Reuse and adaptation rules

- Inspect the upstream module and service APIs before writing replacements.
- Reuse the DWL-Guile Home service if its current source is compatible with the chosen Guix channel and lifecycle requirements.
- Cherry-pick small, understood patterns from the Engstrand configuration; do not import its complete host or user configuration.
- Keep WARENA-specific hardware assumptions outside generic upstream modules.
- Record source URL, exact revision, license, patch origin, and any local modifications.
- Do not add credentials, private host details, customer data, or secret material to the repository.

## Qualification risks

### 1. Reproducibility and channel provenance
Record the Guix revision, channel URLs and introductions, exact source revisions, package definitions, patches, build commands, and outcomes. A floating branch name is not a reproducibility pin.

### 2. Dependency compatibility
Confirm the selected DWL-Guile source against the pinned Guix package set, Guile, wlroots, Wayland libraries, and compositor build dependencies. Do not rely on an older README version statement as proof of current compatibility.

### 3. Runtime evaluation and access
Determine how runtime Scheme evaluation and any REPL endpoint are enabled, exposed, restricted, and disabled. Test malformed expressions, evaluation errors, blocked evaluation, and recovery from a bad configuration.

### 4. Session recovery
Test startup failure, compositor crash, display reconnection, input availability, configuration reload, and return to the baseline Sway session. Keep a recoverable configuration and a documented procedure before using the experimental profile as a daily driver.

### 5. Hardware validation
Record the actual target host and relevant graphics, display, input, storage, and firmware details. No hardware compatibility is implied by upstream repository existence.

## Staged work plan

| Stage | Work | Acceptance evidence |
|---|---|---|
| P0 — source audit | Inspect current source trees, licenses, module boundaries, service lifecycle, patches, and channel declarations | Source/revision matrix with unresolved questions |
| P1 — pin inputs | Choose compatible revisions and document channel provenance | Exact commit IDs and channel introduction data |
| P2 — evaluate/build | Create a minimal isolated configuration and evaluate/build it | Recorded commands, exit status, logs, and build result |
| P3 — runtime test | Start the compositor in a disposable or recoverable environment | Startup, display/input, launch, reload, and failure-case results |
| P4 — fallback test | Return to Sway after an intentionally failed experimental configuration | Demonstrated recovery and documented procedure |
| P5 — evidence update | Update the WARENA stack register | Status remains RESEARCH until the relevant gate is actually passed |

## Promotion rule

DWL-Guile must remain **RESEARCH** until evidence supports a higher maturity level. Promote to PROTOTYPE only after a controlled build and runtime test; promote to LIVE only with named-host evidence, resolved configuration, dated operational observation, and a recovery path. Upstream existence, a package definition, or a written plan alone is not deployment evidence.

## Current limitations

This document records a research decision and qualification plan. It does not assert that a WARENA Guix configuration, RDE integration, DWL-Guile build, or desktop deployment currently exists. The public WARENA tree previously lacked a verified channel lock, executable system/Home configuration, build log, and named-host test record; re-check those artifacts before making future status claims.

## P0 source audit — 2026-10-28

### WARENA repository inspection

The current WARENA `docs/STACK-REGISTER.md`, `docs/DESKTOP-ARCHITECTURE.md`, `docs/reproducibility-plan.md`, and `docs/VALIDATION.md` were read. They define the evidence vocabulary and qualification plan, but the reviewed documents do not provide a resolved channel lock, an executable Guix System/Home entry point, a successful build log, or a named-host validation record. GitHub code-search queries for `channels.scm`, `manifest.scm`, `guix.scm`, and `system.scm` returned no indexed matches; because code-search indexing is not a complete repository-tree proof, this is recorded as **not found by this search**, not a definitive assertion that no such file exists anywhere in the repository.

The available execution environment was checked on 2026-10-28: `git` is present, but `guix` is not installed or on PATH. Therefore a Guix evaluation/build cannot be run in this environment. No build was attempted or represented as successful.

### Upstream revision snapshot

The following exact commits were returned by GitHub's commit search for each upstream repository as the most recent observed commit in the returned results on 2026-10-28. These are **research snapshot pins**, not yet a mutually compatible channel set; verify the channel heads and source provenance again before adopting them in a configuration.

| Source | Observed commit | Commit date (UTC) | Evidence |
|---|---|---|---|
| RDE mirror | `24955da51caf1aaad9a5f0e6c9c9845a504eff64` | 2026-05-04 | https://github.com/abcdw/rde/commit/24955da51caf1aaad9a5f0e6c9c9845a504eff64 |
| DWL-Guile | `3b9eb86637777a8f82211114a9c38d1c1ede03f7` | 2024-01-12 | https://github.com/engstrand-config/dwl-guile/commit/3b9eb86637777a8f82211114a9c38d1c1ede03f7 |
| DWL-Guile Home service | `09045a658a17a914d1bda4d23c04d99c40a1d63b` | 2023-10-20 | https://github.com/engstrand-config/home-service-dwl-guile/commit/09045a658a17a914d1bda4d23c04d99c40a1d63b |
| Engstrand Guix dotfiles | `06ecbc501932141ba0cfc24703d44a8c7a407a0a` | 2024-01-16 | https://github.com/engstrand-config/guix-dotfiles/commit/06ecbc501932141ba0cfc24703d44a8c7a407a0a |

The RDE README documents its channel introduction as commit `257cebd587b66e4d865b3537a9a88cccd7107c95`, fingerprint `2841 9AC6 5038 7440 C7E9 2FFA 2208 D209 58C1 DEB0`. The Engstrand Home service README documents its channel introduction as commit `314453a87634d67e914cfdf51d357638902dd9fe`, fingerprint `C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C`. The Engstrand dotfiles channel file shows GNU Guix's introduction `9edb3f66fd807b096b48283debdcddccfea34bad` and the Engstrand channel introduction `005c42a980c895e0853b821494534d67c7b85e91` with the same Engstrand fingerprint. These introduction records authenticate channel history; they are not the current source revision pins.

### Source-level findings

- **DWL-Guile package definition:** its current `guix.scm` defines `dwl-guile-devel` version `2.0.3` and explicitly overrides several graphics-stack dependencies, including wlroots `0.16.0`, Wayland `1.21.0`, Wayland protocols `1.27`, and Xwayland `22.1.5`. Treat these as compatibility-sensitive legacy pins; do not assume they compose with an arbitrary current Guix channel.
- **Home service lifecycle:** the README provides a real `home-dwl-guile-service-type`, configurable auto-start, config reload on change, Shepherd control, and logs. It also labels the project work in progress.
- **Runtime control:** the README says arbitrary Guile expressions can be evaluated at runtime, and a REPL server can be explicitly started by calling `(dwl:start-repl-server)`. The REPL should not be enabled in a production profile without an explicit access-control and threat-model decision. Error and recovery behaviour remains untested here.
- **Engstrand integration seam:** `engstrand/features/wayland.scm` imports both RDE feature modules and `(dwl-guile home-service)`, then uses `simple-service` extensions on `home-dwl-guile-service-type` for compositor keybindings. `engstrand/reconfigure.scm` composes user features and host-specific features into an RDE config, then derives both Home and System configurations. This is the strongest concrete reuse pattern found: adapt the feature/service composition boundary, not the entire configuration tree. Source: https://github.com/engstrand-config/guix-dotfiles/blob/main/engstrand/features/wayland.scm and https://github.com/engstrand-config/guix-dotfiles/blob/main/engstrand/reconfigure.scm.
- **Source age mismatch:** the observed RDE commit is from May 2026, while the observed DWL-Guile, Home service, and Engstrand dotfiles commits are from January 2024, October 2023, and January 2024 respectively. Treat this as a material compatibility risk; do not infer the old service works with the newer RDE/Guix channel without evaluation.
- **Engstrand channel pattern:** `engstrand/channels.scm` demonstrates channel declarations and introductions, and the README documents separate host and user configuration. Reuse the pattern selectively; do not import their personal host configuration wholesale.
- **RDE:** its README describes the project as usable but actively developed, with APIs subject to change. The upstream documentation also warns against blindly copying example configurations.

### P0 outcome and next gate

P0 is **partially complete**: source entry points, service lifecycle, channel introductions, observed commit IDs, and a key dependency-compatibility risk are recorded. The local Guix build gate is **blocked by tool availability**, not passed. Before creating configuration files, P1 must choose one coherent, authenticated channel set and verify that the older DWL-Guile/Home-service package definitions evaluate against it. Prefer an isolated disposable Guix environment or a suitable Guix host; do not manufacture a lock file from incompatible snapshots. Keep Sway as the baseline and do not promote DWL-Guile above RESEARCH without build, runtime, and fallback evidence.
