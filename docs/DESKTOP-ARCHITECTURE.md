# WARENA desktop architecture

**Status:** RESEARCH / POLICY · 2026-10-30  
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
| WARENA role | **Reference candidate** | **Research / differentiating profile** |

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

**References (upstream — verify current revisions independently):**  
- https://github.com/swaywm/sway  
- https://github.com/engstrand-config/dwl-guile  
- https://github.com/engstrand-config/home-service-dwl-guile  
- https://github.com/gershwin-desktop/gershwin-desktop  
- https://www.windowmaker.org/

---

## 3. Recommended WARENA layering

```text
WARENA desktop policy
  · user intent · keyboard · display profiles · launch · recovery

Stable Wayland profile  →  Sway
Research Wayland profile →  dwl-guile

X11 study track          →  Gershwin (DE) · Window Maker (WM baseline)

Guix System + Guix Home
  · pinned inputs · declarative config · rebuild · rollback tests
```

---

## 4. Decision matrix (provisional)

| Requirement | Starting point |
|-------------|----------------|
| Dependable Wayland daily driver | **Sway** |
| Scheme-native graphical infrastructure | **dwl-guile** |
| Integrated NeXT-inspired GNUstep desktop | **Gershwin** |
| Minimal NeXT-inspired X11 session | **Window Maker** |
| Lowest custom-maintenance burden | Sway or Window Maker (by stack) |
| Distinctive research direction | dwl-guile + Guix |
| Reproducibility | **Must be demonstrated per pinned stack** |

---

## 5. Qualification gate (before LIVE)

For each candidate:

- [ ] Current upstream revision recorded  
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


## 6. Upstream alignment — 2026-10-30

Exact source snapshots, channel introductions and licence notes are maintained in [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md).

| Candidate | Observed upstream revision | Current WARENA treatment |
|---|---|---|
| RDE | `24955da51caf1aaad9a5f0e6c9c9845a504eff64` (GitHub mirror; 2026-05-04) | Selective reuse; pin and test with chosen Guix channels |
| dwl-guile | `3b9eb86637777a8f82211114a9c38d1c1ede03f7` (2024-01-12) | Experimental; README describes dwl v0.4 / wlroots 0.16.x |
| dwl-guile Home service | `09045a658a17a914d1bda4d23c04d99c40a1d63b` (2023-10-20) | Experimental; upstream labels project work in progress |
| Sway | `1652c54b73f67df17b7b4ab0b0f7048204aa8104` (2026-09-21) | Reference candidate; target-specific Guix and hardware qualification required |

The dwl-guile and Home service snapshots are substantially older than the RDE and Sway snapshots. Do not infer compatibility. Establish a single authenticated Guix channel set, evaluate each package and service, then build and test candidates in an isolated/recoverable environment.

Sway is a comparative reference, not a claim of an installed or production-qualified WARENA desktop. The phrase “stable daily profile” in earlier planning is aspirational and must not be read as a verified WARENA deployment.

Runtime Guile evaluation and optional REPL access increase the compositor's control surface. Keep the REPL disabled unless an isolated development use case explicitly requires it; document access boundaries and failure recovery before any wider use.

**Current status:** source revisions observed; compatible channel lock, Guix package evaluation, builds, runtime, hardware and recovery remain NOT VERIFIED.
