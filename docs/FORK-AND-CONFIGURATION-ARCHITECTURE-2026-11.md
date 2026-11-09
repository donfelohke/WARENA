# WARENA Fork and Configuration Architecture

**Document ID:** WARENA-FORK-ARCH-2026-11  
**Date:** 2026-11-09  
**Status:** RESEARCH / ARCHITECTURE DECISION  
**Owner:** WARENA Systems  
**Governing rule:** specification ≠ implementation ≠ verification ≠ deployment.

## 1. Decision summary

`donfelohke/WARENA` is the WARENA-owned configuration repository. It is the home for RDE configuration notes, Guix Home integration policy, system architecture, stack register, desktop decisions and maintenance policy.

There is **no** separate `warena-rde` repository.

Two independent forks provide controlled maintenance of the Guile-native compositor stack:

| Repository | Role |
|------------|------|
| [donfelohke/dwl-guile](https://github.com/donfelohke/dwl-guile) | Fork of `engstrand-config/dwl-guile` — Guile-configurable Wayland compositor |
| [donfelohke/home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile) | Fork of `engstrand-config/home-service-dwl-guile` — Guix Home integration |

WARENA documents and coordinates integration of these forks. The forks preserve upstream history and remain independent so compositor and Home-service history can diverge under controlled, licence-compliant maintenance.

## 2. Repository map

| Repository | Purpose | Action |
|------------|---------|--------|
| **donfelohke/WARENA** | Configuration home: RDE, Guix Home policy, architecture, stack register, runbooks | Existing — authoritative |
| **donfelohke/dwl-guile** | Fork of upstream compositor | Fork created 2026-11-09 |
| **donfelohke/home-service-dwl-guile** | Fork of Guix Home service | Fork created 2026-11-09 |
| **abcdw/rde** | Declarative RDE environment | Keep upstream; pin as dependency |
| **gptel** | Emacs LLM interface | Keep upstream; install via package channel |
| **engstrand-config/guix-dotfiles** | Reference architecture study only | Reference only — do not inherit whole system |

## 3. Ownership and maintenance policy

1. **WARENA owns policy.** Channel pins, integration decisions, host inventory templates, recovery procedures and evidence status live in this repository.
2. **Forks own code history.** Local changes to the compositor or Home service stay on clearly named branches in the respective fork. Prefer rebase or documented merge from upstream when possible.
3. **Upstream remains the source of truth for unpatched behaviour.** Record the upstream revision that was tested. Forking does not mean immediate modification or installation.
4. **Licences.** Both upstream projects are GPL-3.0. Retain licence files and provenance. Do not relicense.
5. **No silent LIVE claims.** Presence of a fork is not evidence of a working session on any host.

## 4. Upstream provenance (research notes)

### dwl-guile

- Upstream: https://github.com/engstrand-config/dwl-guile  
- Based on dwl v0.4 and wlroots 0.16.x (per upstream README).  
- Latest observed release tag in research: v2.0.2.  
- Goal: minimal dwm-like Wayland compositor with Guile configuration and optional REPL.  
- Compatibility risk is high relative to current Guix/wlroots; treat as experimental until qualification gates pass.

### home-service-dwl-guile

- Upstream: https://github.com/engstrand-config/home-service-dwl-guile  
- Provides Guix Home service and channel introduction for dwl-guile.  
- Must track the compositor fork when local patches are applied.

### RDE (abcdw/rde)

- Prefer as a **pinned upstream dependency**.  
- Do not fork solely for configuration ownership; configuration belongs in WARENA.

## 5. Desktop-stack relationship

This architecture supports the Guile-native research track described in:

- [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md)  
- [desktop-stack-decision-2026-11.md](./desktop-stack-decision-2026-11.md)  

Current research preference remains:

- **Foundation:** GNU Guix + RDE  
- **Practical Wayland candidate:** Niri + Noctalia v5  
- **Fallback baseline:** Sway  
- **Guile-native research:** dwl-guile (via the forks above)  
- **Comparator only:** Nix/NixOS  

No host deployment is authorised by this document.

## 6. Implementation sequence (research)

1. Record channel and commit pins in STACK-REGISTER and a future channel-lock note.  
2. Build dwl-guile from the fork in a disposable Guix environment.  
3. Test home-service-dwl-guile against the forked compositor.  
4. Run session lifecycle, display, input and recovery checks on identified hardware.  
5. Promote maturity only when host evidence exists (see STACK-REGISTER promotion rules).

## 7. Non-goals

- No production migration to a forked compositor as default session.  
- No claim that dwl-guile or its Home service is installed on any WARENA host.  
- No inheritance of engstrand-config/guix-dotfiles as a whole system configuration.  
- No separate warena-rde repository.

## 8. Related documents

- [STACK-REGISTER.md](./STACK-REGISTER.md)  
- [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md)  
- [desktop-stack-decision-2026-11.md](./desktop-stack-decision-2026-11.md)  
- [EVIDENCE-STATUS.md](./EVIDENCE-STATUS.md)  
- [reproducibility-plan.md](./reproducibility-plan.md)  
