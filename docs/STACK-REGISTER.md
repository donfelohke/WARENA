# WARENA stack register

**Status:** RESEARCH / REGISTER CONTRACT · 2026-10-26 · reviewed 2026-11-18  
**Rule:** A version that exists upstream is **not** evidence of deployment.

Public GitHub under @donfelohke documents architecture and intent. It does **not**, by itself, prove a production fleet.

Related: [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) · [GNU Guile ecosystem audit](./GNU-GUILE-ECOSYSTEM-AUDIT-2026-10-30.md) · [Technology Constitution](./TECHNOLOGY-CONSTITUTION-2026-11-17.md) · [Guile-WM / WM-NG audit](./GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md) · [FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](./FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md) · [VALIDATION.md](./VALIDATION.md) · [feloh-corpus source register](https://github.com/donfelohke/feloh-corpus/blob/main/docs/source-register.md)

---

## Evidence vocabulary

| Maturity | Meaning |
|----------|--------|
| **LIVE** | Named host + resolved config + date + operational observation + recovery path |
| **PROTOTYPE** | Built/run in a controlled environment; not production |
| **RESEARCH** | Documented experiment or study |
| **CONCEPT** | Specified only |
| **UNKNOWN** | Insufficient evidence |

| Field | Required meaning |
|-------|------------------|
| Component | Exact software or service name |
| Claimed version | Version asserted by inventory |
| Upstream evidence | Official release/tag + verification date |
| Guix evidence | Package, channel revision, availability result — or UNKNOWN |
| Host evidence | Named host or **UNKNOWN** |
| Configuration evidence | Manifest / system.scm / lock file ref — or UNKNOWN |
| Maturity | LIVE · PROTOTYPE · RESEARCH · CONCEPT · UNKNOWN |
| Verification | Observation, date, outcome — or UNKNOWN |
| Recovery | Backup/restore or rollback note — or UNKNOWN |
| Evidence link | Commit, release URL, or redacted deploy record |

**Guix package available ≠ installed. Installed ≠ service operational.**

Do **not** use a single ambiguous **CANON** label to mean “production-deployed.”

---

## Configuration ownership (2026-11-09)

`donfelohke/WARENA` is the sole configuration home for RDE notes, Guix Home policy, architecture and maintenance. There is no separate `warena-rde` repository.

| Component | Role | Ownership | Maturity |
|-----------|------|-----------|----------|
| WARENA repository | Configuration home, stack policy | donfelohke/WARENA | DOCUMENTATION / RESEARCH |
| dwl-guile | Guile-configurable Wayland compositor | Fork: [donfelohke/dwl-guile](https://github.com/donfelohke/dwl-guile) (from engstrand-config/dwl-guile) | RESEARCH |
| home-service-dwl-guile | Guix Home integration | Fork: [donfelohke/home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile) | RESEARCH |
| RDE (abcdw/rde) | Declarative environment | Upstream pin | RESEARCH (dependency) |
| gptel | Emacs LLM interface | Upstream package | RESEARCH (dependency) |
| engstrand-config/guix-dotfiles | Reference study only | Upstream reference | REFERENCE ONLY |

Forking preserves history and licence (GPL-3.0). It does not imply installation or a LIVE session.

---

## Upstream existence checks (selected pins)

Verified as *version exists upstream* on 2026-10-26 unless noted. Deployment remains **UNKNOWN** unless host evidence is added later.

| Component | Claimed | Upstream | Guix | Host | Config | Maturity | Verification | Recovery | Evidence link |
|-----------|---------|----------|------|------|--------|----------|--------------|----------|---------------|
| GNU Guix | 1.5.0 | Exists (released 2026-01-23) | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/ |
| GNU Shepherd | 1.0.9 | Exists (released 2025-12-03) | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only; release record checked 2026-11-21 | UNKNOWN | https://lists.gnu.org/archive/html/info-gnu/2025-12/msg00003.html |
| GNU Guile | 3.0.11 | Exists (released 2025-12-01; current stable 3.0 series on 2026-11-21) | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only; current stable series checked 2026-11-21 | UNKNOWN | https://lists.gnu.org/archive/html/info-gnu/2025-12/msg00002.html |
| dwl-guile | v2.0.2 observed | engstrand-config/dwl-guile (dwl v0.4 / wlroots 0.16.x base) | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | Fork exists 2026-11-09 | UNKNOWN | https://github.com/donfelohke/dwl-guile |
| home-service-dwl-guile | upstream main | engstrand-config/home-service-dwl-guile | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | Fork exists 2026-11-09 | UNKNOWN | https://github.com/donfelohke/home-service-dwl-guile |
| restic | 0.19.1 | Exists (2026-07-05) | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://github.com/restic/restic/releases/tag/v0.19.1 |
| Yggdrasil | 0.5.13 | Exists (2026-02-24); 0.5.14/0.5.15 also exist | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://github.com/yggdrasil-network/yggdrasil-go/releases/tag/v0.5.13 |
| linux (nonguix) | 6.18 LTS claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| SQLite | 3.47.x claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| nftables | (unpinned) | Generic component | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| nginx | 1.30.5 claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| Cage | 0.3.0 claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| OpenSSH | 9.x claim | Generic series | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| MagicMirror² | 2.37.0 claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| ungoogled-chromium | (unpinned) | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| Emacs | 29.x / WMOL claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| WARENA Pay Core | v1.0 | No public deploy evidence in @donfelohke GitHub | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| M-Pesa Daraja | 3.0 | External API; integration not evidenced here | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| KRA eTIMS | — | External; integration not evidenced here | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| H68K (RK3568) | hardware | Hardware claim; no host log in public repos | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| “32 Mashakura apps” | inventory claim | Not evidenced as public repos/releases | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |

---

## Profile stack (desktop — architecture only; current direction 2026-11-17)

| Component | Role | Maturity (docs) |
|-----------|------|-----------------|
| X.Org | Initial X11 compatibility baseline | RESEARCH |
| Guile-WM | Default WARENA Scheme-native window-manager session | RESEARCH / architecture direction |
| Gershwin | Default WARENA GNUstep/OpenStep-inspired desktop session | RESEARCH / architecture direction |
| XLibre | X.Org-compatible alternative under evaluation | RESEARCH |
| dwl-guile + RDE | Secondary / experimental Wayland research session | RESEARCH |
| Sway | Wayland recovery and comparison baseline | RESEARCH |

The intended default selectable sessions are Guile-WM and Gershwin under one WARENA identity. This is not a claim that either session is installed or deployed. Niri + Noctalia v5 is retained as historical candidate research, not the current default direction.

See [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) and [desktop-stack-decision-2026-11.md](./desktop-stack-decision-2026-11.md). Not LIVE unless qualification gate is completed.

---

## How to promote a row to LIVE

1. Named host (or equivalent durable identity)  
2. Resolved configuration (manifest / system config / channel lock)  
3. Verification date and outcome   
4. Recovery procedure tested or documented   
5. Evidence link retained in-repo or securely referenced  

Until then: keep **UNKNOWN** or **RESEARCH** / **CONCEPT**.

---

## Stewardship

- Prefer updating this register over inventing parallel “CANON lists” in chat.  
- Cross-link FELOH Corpus claim/source registers when claims enter the corpus.  
- Never commit secrets, customer payment data, or private host credentials.  


## Current technology-policy precedence — 2026-11-17

This document must be read subject to the current [WARENA Technology Constitution](https://github.com/donfelohke/WARENA/blob/main/docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md) and [FELOH Corpus technology policy](https://github.com/donfelohke/feloh-corpus/blob/main/docs/technology-policy-2026-11-17.md). JavaScript is prohibited as a language, runtime, framework or dependency; web technologies are excluded as WARENA/IKAI application and runtime architecture. Prefer native, libre, local-first and user-controlled interfaces. Candidate tools listed in this document do not become approved dependencies merely by appearing here. Historical descriptions remain historical; apply this policy to current and future decisions.


## Current desktop decision precedence — 2026-11-18

Read all desktop rows subject to the [WARENA Technology Constitution](./TECHNOLOGY-CONSTITUTION-2026-11-17.md) and the current [X11-first desktop architecture decision](./DESKTOP-ARCHITECTURE.md). The intended session tracks are Gershwin (native GNUstep/Objective-C) and Guile-WM / WM-NG (Guile policy; native XCB ownership for WM-NG). X.Org is the initial compatibility baseline; XLibre is a separate compatibility experiment. Sway is a comparison/recovery baseline; dwl-guile/Wayland is secondary and experimental. This records policy and research direction only: Guix package availability, build, session integration, host installation and recovery remain separate evidence gates.
