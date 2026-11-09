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

## 6. Current desktop-stack decision — 2026-11

This document's Sway/dwl-guile comparison remains useful as the Wayland baseline, but it is no longer the complete candidate map. The current decision adds **Niri + Noctalia v5** as the leading practical candidate, **Nix/NixOS** as a declarative comparator, **DankMaterialShell** as a shell comparator, and **Flatpak/Fedora Silverblue** as adjacent application-delivery/system comparators. Guix + RDE remains the preferred WARENA foundation; no migration or host deployment is approved.

See [Desktop Stack Decision — Nix, Niri, Noctalia and Alternatives](desktop-stack-decision-2026-11.md) for current packaging notes, upstream references, test matrix and decision gates. This addendum supersedes no historical experiment result; it extends the candidate set.
