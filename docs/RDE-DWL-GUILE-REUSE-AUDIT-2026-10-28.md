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
