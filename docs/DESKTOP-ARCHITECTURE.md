> **Spatial/XR/AI extension — 2026-11-20:** Spatial computing and immersive XR are separate optional layers, not replacements for the conventional desktop. GNU/MAVERIK and DEVA3 are historical architecture references; OpenXR is the native XR API candidate and Monado the Linux runtime candidate. AI is disabled by default and requires explicit per-service and per-task authorization. See [Spatial Computing, XR & Opt-in Intelligence Architecture](SPATIAL-COMPUTING-XR-AI-ARCHITECTURE-2026-11-20.md). This extension does not alter the X11-first desktop policy or imply implementation/deployment.

> **Current precedence — 2026-11-20:** WARENA's desktop direction is **X11-first**. X.Org is the initial compatibility baseline; XLibre is a compatibility experiment; Gershwin is the X11 desktop case study; Guile-WM / WM-NG are the window-management research tracks. Wayland is secondary/experimental; dwl-guile is experimental; Sway is a comparison/recovery baseline. Earlier Sway-first, Niri/Noctalia-first and Wayland-first recommendations below are retained as dated research history only. See the [F3L0H Sovereign Master Corpus](https://github.com/donfelohke/feloh-corpus/blob/main/docs/FELOH-SOVEREIGN-MASTER-CORPUS-2026-11-20.md) and [Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md).

---

# WARENA desktop architecture

**Status:** RESEARCH / POLICY · 2026-10-26 · updated 2026-11-09  
**Scope:** Display stack candidates for WARENA (Guix-oriented). Not a claim that every stack is LIVE on hardware.

## Two separate comparisons

1. **Gershwin vs Window Maker** — GNUstep / NeXT-inspired **X11** track  
2. **Sway vs dwl-guile** — **Wayland** compositor track  

Do not force X11 and Wayland into one compositor abstraction. Share higher-level WARENA policy (input, profiles, recovery) only where interfaces genuinely overlap.

---

## 1. X11 track: Gershwin vs Window Maker

| Criterion | Gershwin | Window Maker |
|-----------|----------|--------------|
| Scope | Full desktop environment | Window manager |
| Display | X11 | X11 |
| GNUstep | Central | Optional / complementary |
| Workflow | More integrated components | Assemble your own |
| Engineering question | Reproducible packaging & maintenance? | Does a minimal X11 session suffice? |

**Verdict:** Not equivalents.  
- **Gershwin** — candidate for a cohesive NeXT-inspired desktop study  
- **Window Maker** — compact mature X11 baseline / fallback  

GNUstep is a **framework**, not a DE or WM by itself.

**WARENA policy:** Investigate Gershwin as a **separate X11 desktop profile**. Keep Window Maker as the simpler X11 comparator. Neither dictates the OS architecture.

---

## 2. Wayland track: Sway vs dwl-guile

| Criterion | Sway | dwl-guile |
|-----------|------|-----------|
| Protocol | Wayland | Wayland |
| Config | i3-style text | GNU Guile / Scheme |
| Runtime | Config + IPC | Guile eval + optional REPL |
| Integration risk | Lower baseline | Higher (fork, wlroots pin) |
| Guix/Scheme fit | External config language | Strong Scheme alignment |
| Operational risk | Lower starting point | Needs safeguards & tests |
| WARENA role | **Stable daily profile** | **Research / differentiating profile** |

### Critical distinction

- **Sway** = established configuration interface  
- **dwl-guile** = programmable compositor (Scheme at runtime)

Programmability is valuable only if these are answered before LIVE promotion:

1. What happens when a Scheme expression fails or blocks?  
2. How is runtime state reconciled with declarative config?  
3. Can the stack rebuild from pinned sources?  
4. Can REPL / runtime control be disabled in a production profile?  
5. Can the session recover after a bad change or crash?

`dwl-guile` Home service documentation describes WIP behaviour — qualify carefully; do not reject solely for ambition.

### WARENA maintenance layer (2026-11-09)

Compositor research is maintained through independent forks, not by depending solely on mutable upstream:

| Component | WARENA repository |
|-----------|-------------------|
| Compositor | [donfelohke/dwl-guile](https://github.com/donfelohke/dwl-guile) (fork of engstrand-config/dwl-guile) |
| Guix Home service | [donfelohke/home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile) |
| Configuration policy | **This repository (WARENA)** — sole configuration home |

There is no separate `warena-rde` repository. See [FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](./FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md).

**Upstream references (verify current revisions independently):**  
- https://github.com/swaywm/sway  
- https://github.com/engstrand-config/dwl-guile  
- https://github.com/engstrand-config/home-service-dwl-guile  
- https://github.com/donfelohke/dwl-guile  
- https://github.com/donfelohke/home-service-dwl-guile  
- https://github.com/gershwin-desktop/gershwin-desktop  
- https://www.windowmaker.org/

---

## 3. Recommended WARENA layering

```text
WARENA desktop policy  (this repository)
  · user intent · keyboard · display profiles · launch · recovery

Stable Wayland profile  →  Sway
Practical candidate     →  Niri + Noctalia v5
Research Wayland profile →  dwl-guile (WARENA forks)

X11 study track          →  Gershwin (DE) · Window Maker (WM baseline)

Guix System + Guix Home + RDE (upstream pin)
  · pinned inputs · declarative config · rebuild · rollback tests
```

---

## 4. Decision matrix (provisional)

| Requirement | Starting point |
|-------------|----------------|
| Dependable Wayland daily driver | **Sway** |
| Practical modern Wayland evaluation | **Niri + Noctalia v5** |
| Scheme-native graphical infrastructure | **dwl-guile** (forks) |
| Integrated NeXT-inspired GNUstep desktop | **Gershwin** |
| Minimal NeXT-inspired X11 session | **Window Maker** |
| Lowest custom-maintenance burden | Sway or Window Maker (by stack) |
| Distinctive research direction | dwl-guile + Guix |
| Reproducibility | **Must be demonstrated per pinned stack** |

---

## 5. Qualification gate (before LIVE)

For each candidate:

- [ ] Current upstream / fork revision recorded  
- [ ] Build dependencies known  
- [ ] Guix package / Home service path exists or is explicitly WIP  
- [ ] Hardware behaviour on target machine documented  
- [ ] Offline rebuild attempted  
- [ ] Rollback / recovery procedure written  

Upstream docs support architectural comparison. They do **not** by themselves prove WARENA qualification.

## Related

- [ORIENTATION.md](./ORIENTATION.md)  
- [FOUNDATIONS.md](./FOUNDATIONS.md)  
- [PRACTICE.md](./PRACTICE.md)  
- [VALIDATION.md](./VALIDATION.md)  
- [FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](./FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md)  
- [STACK-REGISTER.md](./STACK-REGISTER.md)  
- [GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md](./GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md)

## 6. Current desktop-stack decision — 2026-11

This document's Sway/dwl-guile comparison remains useful as the Wayland baseline, but it is no longer the complete candidate map. The current decision adds **Niri + Noctalia v5** as the leading practical candidate, **Nix/NixOS** as a declarative comparator, **DankMaterialShell** as a shell comparator, and **Flatpak/Fedora Silverblue** as adjacent application-delivery/system comparators. Guix + RDE remains the preferred WARENA foundation; no migration or host deployment is approved.

See [Desktop Stack Decision — Nix, Niri, Noctalia and Alternatives](desktop-stack-decision-2026-11.md) for current packaging notes, upstream references, test matrix and decision gates. This addendum supersedes no historical experiment result; it extends the candidate set.


## Current technology-policy precedence — 2026-11-17

This document must be read subject to the current [WARENA Technology Constitution](https://github.com/donfelohke/WARENA/blob/main/docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md) and [FELOH Corpus technology policy](https://github.com/donfelohke/feloh-corpus/blob/main/docs/technology-policy-2026-11-17.md). JavaScript is prohibited as a language, runtime, framework or dependency; web technologies are excluded as WARENA/IKAI application and runtime architecture. Prefer native, libre, local-first and user-controlled interfaces. Candidate tools listed in this document do not become approved dependencies merely by appearing here. Historical descriptions remain historical; apply this policy to current and future decisions.


## Current architecture direction — 2026-11-17

This dated direction supersedes older candidate summaries in this document where they conflict:

- WARENA desktop research is **X11-first**.
- X.Org is the initial compatibility baseline; XLibre is a drop-in compatibility experiment.
- Default selectable sessions: **Guile-WM** (Scheme-native programmable session) and **Gershwin** (GNUstep/OpenStep-inspired desktop). Both are intended as default sessions under one WARENA identity; this is not a deployment claim.
- Wayland is secondary/experimental: dwl-guile + RDE is the research path; Sway is a recovery/comparison baseline.
- Niri/Noctalia is retained as a historical research candidate, not the current default direction.
- Native-first policy excludes JavaScript and web technologies as WARENA/IKAI application/runtime architecture. See [Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md).

This is a research/architecture direction, not authorization to install, migrate, deploy or modify a host.


## Current desktop decision — 2026-11-18 (supersedes earlier candidate ordering)

The older Niri + Noctalia evaluation below is retained as a historical comparator, not the current WARENA default direction. Apply the [Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md) and the [Guile-WM / WM-NG session audit](GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md).

**Current policy:**
- **X11-first** desktop research.
- **X.Org** is the initial compatibility baseline.
- **XLibre** is a separately qualified compatibility experiment; do not mix server and DDX modules across ABIs without explicit validation.
- **Gershwin** is the intended native GNUstep/Objective-C desktop session candidate.
- **Guile-WM / WM-NG** is the intended Scheme-policy window-management track, with native XCB ownership for WM-NG.
- **Sway** remains a recovery/comparison baseline, not the WARENA default.
- **dwl-guile / Wayland** remains secondary and experimental.
- **Niri + Noctalia** remains a historical practical-candidate study, not the current leading WARENA desktop direction.
- GNU Guix + RDE remains the preferred system/configuration research foundation. No migration or host deployment is implied.

This is a policy and research decision. It does not establish a Guix package, successful build, display-manager integration, hardware validation or deployed session.
