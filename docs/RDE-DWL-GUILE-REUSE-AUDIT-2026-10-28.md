# RDE + DWL-Guile — Upstream Reuse Audit

**Status:** RESEARCH  
**Date:** 2026-10-28  
**Maturity:** Not implemented in WARENA. Not LIVE. No build verified in this pass.

Governing rule: **reuse first, adapt second, implement last.**  
WARENA owns policy, qualification evidence, and recovery — not a fork of upstream compositors by default.

Related: [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) · [STACK-REGISTER.md](./STACK-REGISTER.md) · [CAPABILITY-MAP.md](./CAPABILITY-MAP.md) · [WM-NG-REUSABLE-CORE.md](./WM-NG-REUSABLE-CORE.md) (feature branch; X11 track, separate from this Wayland study).

---

## 1. Repository map

| # | Project | URL | Role |
|---|---------|-----|------|
| 1 | **RDE** | https://github.com/abcdw/rde | Scheme feature framework over Guix System + Guix Home |
| 2 | **dwl-guile** | https://github.com/engstrand-config/dwl-guile | dwl-based Wayland compositor + Guile config/REPL |
| 3 | **home-service-dwl-guile** | https://github.com/engstrand-config/home-service-dwl-guile | Guix Home service + Guix channel packaging dwl-guile |
| 4 | **guix-dotfiles** (Engstrand) | https://github.com/engstrand-config/guix-dotfiles | Reference composition of RDE features + Home service |

Upstream states that **home-service-dwl-guile is a work in progress**. Treat integration as experimental until WARENA qualification gates pass.

---

## 2. What to inspect (source study checklist)

| Repository | Inspect first | Question |
|------------|---------------|----------|
| RDE | `src/rde/features.scm` (`feature`, `rde-config`); `examples/src/rde-configs/` | How does WARENA compose reusable system/user features? |
| dwl-guile | `guix.scm`, `dwl.c`, `config.mk`, `share/`, `dscm/` | Dependencies, Guile bindings, runtime eval surface |
| home-service | `dwl-guile/`, `README.org`, `.guix-channel` | Can lifecycle be reused without forking? |
| Engstrand dotfiles | `engstrand/features/wayland.scm`, reconfigure/channels patterns | How are RDE + service + host joined? |

---

## 3. Findings by repository

### 3.1 RDE (`abcdw/rde`)

**Verified from public source structure (not a local build):**

- Core abstraction: **`feature`** records with optional home- and system-services getters; **`rde-config`** folds features into operating-system / home-environment.
- Public API surface includes `rde-config-features`, `rde-config-home-environment`, `rde-config-operating-system`, `merge-features`, value helpers (`get-value`, `require-value`).
- Examples: `examples/src/rde-configs/configs.scm` builds named configs (`ixy-config`, `live-config`) by **appending feature lists** and projecting OS/HE.
- Layout pattern: hosts / users / shared feature modules — **host and user configuration stay separable**.

**Reuse for WARENA:** Prefer defining WARENA policy as **RDE features** (or plain Guix Home/System services) rather than inventing a parallel feature system inside `donfelohke/WARENA`.

**Gap:** `donfelohke/WARENA` on `main` has **no** RDE modules, channels, or manifests — documentation only.

### 3.2 dwl-guile (`engstrand-config/dwl-guile`)

**From upstream README (2026-10-28 research read):**

- Based on **dwl v0.4** and **wlroots 0.16.x**; continuously rebased claim — **must re-verify pins before any build**.
- Guile: startup config file + **runtime** `-e` evaluation + optional **REPL** (`dwl:start-repl-server`).
- Package entry: in-tree **`guix.scm`**.
- Goal: Guix-native, Scheme-integrated compositor (not a general X11 WM).

**Reuse:** Study binding style (`dwl:` prefix) and config language as **pattern** for programmable policy.

**Do not:** Treat as drop-in for WM-NG (WM-NG is **X11** research). Keep tracks separate per DESKTOP-ARCHITECTURE.

### 3.3 home-service-dwl-guile

**From upstream README:**

| Capability | Detail |
|------------|--------|
| Install | Packages dwl-guile via Home service |
| Lifecycle | Shepherd: `herd start/stop/restart dwl-guile` |
| Autostart | Optional first-TTY login |
| Env | Wayland-related environment variables; QT optional |
| Config | Guile alist/`setq`-style config field; reload-on-change option |
| Runtime | `dwl-guile -e "(…)"`; REPL explicit opt-in |
| Extension | **`simple-service`** on `home-dwl-guile-service-type` (RDE-friendly) |
| Channel | Dedicated Guix channel + introduction commit/fingerprint in README |
| Status | **Explicit WIP** |

**Reuse:** Prefer **channel + service-type extension** over vendoring the compositor. Example pattern: Engstrand `wayland.scm` extends keys via `simple-service`.

**Security boundary:** Arbitrary Scheme evaluation and REPL are development powers — production profiles must define exposure (disable REPL, restrict who can invoke `-e`).

### 3.4 Engstrand guix-dotfiles

**Role:** Practical composition reference — RDE features + host/user split + Home service extension.

**Reuse:** Copy **structure** (feature modules, channel pins, reconfigure flow), not wholesale personal host config.

---

## 4. Compatibility and risk matrix

| Topic | Evidence status | WARENA implication |
|-------|-----------------|--------------------|
| RDE feature model | Documented in upstream source | Compose features; do not reimplement |
| home-dwl-guile-service-type | Documented; WIP | Candidate integration; qualify before LIVE |
| dwl 0.4 / wlroots 0.16 | Stated upstream | Pin and test; newer Guix may not match |
| Guile version in dwl-guile build | Not fully verified this pass | Record exact Guile when building |
| Runtime eval / REPL | Documented features | Policy + security review required |
| WARENA in-repo Guix modules | **Absent** on main | No local package scaffold until need proven |
| Build/deploy on WARENA host | **UNKNOWN** | No LIVE claim |

---

## 5. Apply to WARENA layering

```text
WARENA policy
  hardware profiles · security · qualification · recovery

GNU Guix + RDE (upstream)
  pinned channels · features · System / Home

Sway          → baseline Wayland candidate (qualify first)
dwl-guile     → RESEARCH Scheme-native compositor (via Home service channel)
WM-NG (X11)   → separate track (Gershwin / WMaker / native core study)
```

**Commercial boundary unchanged:** experimental desktop stacks are not NAKEBUSEN product SKUs until capacity and evidence exist (see CAPABILITY-MAP).

---

## 6. Decisions (research)

| Decision | Rationale |
|----------|-----------|
| Do **not** auto-create `wm-ng.scm` / full channel tree in WARENA | Repo is docs-first; no buildable core yet |
| Prefer **upstream channel** for dwl-guile Home service | Avoid fork maintenance |
| Extend via **RDE features / simple-service** | Established pattern in Engstrand + service README |
| Qualify **Sway** before promoting dwl-guile | Fallback path required |
| Keep **WM-NG off this track** | Wayland vs X11 separation |
| Runtime Guile eval = **security decision** | Not default-on in any production profile |

---

## 7. Study sequence (before new Guix files in WARENA)

1. Map RDE `feature` / `rde-config` and example host/user split.  
2. Trace dwl-guile `guix.scm` + dependency pins (wlroots, Guile).  
3. Read Home service Shepherd unit behaviour and reload path.  
4. Diff channel introduction and Engstrand `wayland.scm` extension.  
5. Only then: minimal isolated `guix shell` / Home eval of **pinned** revisions.  
6. Verify return path to Sway (or other baseline) if experimental session fails.

---

## 8. Licensing note (orientation only)

Upstream projects use various free licenses (e.g. GPL-family for home-service README claim; dwl-guile carries multiple LICENSE files). **Any WARENA packaging must record exact licenses of pinned revisions before redistribution.** Not a legal clearance.

---

## 9. Status line

**RESEARCH only.** Upstream RDE and Engstrand dwl-guile stack are the correct reuse targets for a Guix/Scheme Wayland research profile. This document does not authorize channel commits in WARENA, host reconfiguration, or LIVE maturity. No builds or deployments were performed for this audit.

### Suggested follow-ups

- Pin exact git SHAs of the four repos after a successful local `guix pull` / build experiment.  
- Cross-link stack-register rows for Sway and dwl-guile with Guix evidence when available.  
- Keep X11 WM-NG work on its own proposal branch.
