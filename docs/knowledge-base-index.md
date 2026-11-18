# WARENA Technical Knowledge Base

**Status: PROPOSAL / DOCUMENTATION BASELINE.** This index organises operational knowledge; it does not assert that any host, network, Guix/RDE profile, backup, or deployment has been built or tested.

## Reading path

1. Identify the domain and target system.
2. Record the current baseline before changing anything.
3. Read the applicable runbook and state prerequisites, risks, rollback, and acceptance tests.
4. Prefer read-only or isolated tests before disruptive changes.
5. Record exact commands, revisions, observed results, and limitations.
6. Change status only when evidence supports it.

## Domain map

| Area | Document | Purpose |
|---|---|---|
| Service UX and handover | [digital-service-ux-sop.md](digital-service-ux-sop.md) | Discovery, scope, acceptance tests, evidence, handover and service feedback |
| Architecture | [architecture.md](architecture.md) | Boundaries, layers, evidence rules |
| Reproducibility | [reproducibility-plan.md](reproducibility-plan.md) | Staged environment/deployment plan |
| Host inventory | [host-inventory-template.md](host-inventory-template.md) | Hardware, firmware, OS, interfaces |
| Reproducible environments | [reproducible-environment-runbook.md](reproducible-environment-runbook.md) | Pinning, evaluation, build evidence |
| Network services | [network-services-runbook.md](network-services-runbook.md) | Topology, access, service checks |
| Backup and restore | [backup-restore-runbook.md](backup-restore-runbook.md) | Integrity and recovery tests |
| Desktop candidate study | [desktop-stack-decision-2026-11.md](desktop-stack-decision-2026-11.md) | Historical Nix/Niri/Noctalia comparator; current priority is X11-first |
| Desktop architecture | [DESKTOP-ARCHITECTURE.md](DESKTOP-ARCHITECTURE.md) | Current X11-first policy: X.Org baseline, separate XLibre qualification, Gershwin and Guile-WM/WM-NG session tracks |
| Fork and configuration ownership | [FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md) | WARENA as config home; dwl-guile forks; no warena-rde |
| Stack register | [STACK-REGISTER.md](STACK-REGISTER.md) | Upstream vs Guix vs host evidence |
| GNU Hurd + Nix research | [research/gnu-hurd-nix-compatibility-and-cross-build-2026-11.md](research/gnu-hurd-nix-compatibility-and-cross-build-2026-11.md) | Hurd/Guix status, Nix feasibility, experiment gates |
| Master technology register | [FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md](FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md) | Consolidated technology inventory and implementation guidance |
| Computer science foundations | [FOUNDATIONAL-CS-LEARNING-AND-SYSTEMS-REFERENCES-2026-11.md](FOUNDATIONAL-CS-LEARNING-AND-SYSTEMS-REFERENCES-2026-11.md) | Nine-subject syllabus scaffold, language study and reproducible learning evidence |
| LinkStar-H68K network appliance | [research/linkstar-h68k-network-appliance-2026-11.md](research/linkstar-h68k-network-appliance-2026-11.md) | Article-reported hardware, unknowns, candidate roles and qualification gates |
| GNUstep–Guile / GOOPS compatibility | [GNUstep Guile GOOPS compatibility audit](GNUSTEP-GUILE-GOOPS-COMPATIBILITY-AUDIT-2026-11-18.md) | Historical bridge limits, GOOPS distinction and modern compatibility gates |
| Identity and Sheng context | [WARENA-NAME-NOTE.md](WARENA-NAME-NOTE.md) | Owner-confirmed technical expansion, Kenyan Sheng resonance and source qualifications |
| IKAI wearable integration | [IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md](IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md) | WARENA infrastructure boundary, Guix/Scheme services, media, IPC, OpenXR and operational qualification |

## Status vocabulary

- `LIVE` — current operation evidenced with owner and review date.
- `PROTOTYPE` — experimentally implemented; limitations stated.
- `RESEARCH` — investigation/evidence gathering.
- `CONCEPT` — design not implemented.
- `HISTORICAL` — retained record, not asserted current.
- `SUPERSEDED` — replaced by a named revision or decision.
- `UNKNOWN` — status cannot currently be established.

A document is not implementation evidence. A syntax check is not a deployment test; deployment is not a recovery test.

## Current portfolio alignment

- [WARENA Portfolio Alignment (2026-10-31)](portfolio-alignment-2026-10-31.md) — current relationship to NAKEBUSEN DIGITAL and distinction from GENJE ZA WARENA.

## Ecosystem interfaces

- [FELOH Corpus](https://github.com/donfelohke/feloh-corpus): shared definitions, governance, decision provenance.
- [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN): customer-facing services and business operations. Do not copy private customer data here.
- [IKAI](https://github.com/donfelohke/Ikai): reflective-compute research and privacy boundaries.
- [GENJE](https://github.com/donfelohke/Genje): creative computation and performance environments.
- [dwl-guile](https://github.com/donfelohke/dwl-guile): WARENA-maintained compositor fork (research).
- [home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile): WARENA-maintained Guix Home service fork (research).

## Minimum evidence for an operational claim

Record repository commit, target hardware/software, configuration inputs, commands, expected and observed results, test date, operator, limitations, and recovery path. Redact secrets and personal data. If evidence is missing, use `UNKNOWN` or `NOT VERIFIED`.

## Canonical policy — 2026-11-17

- [Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md) — WARENA identity, native-first / libre-first / local-first policy, JavaScript prohibition, Stallman reference and IKAI boundary.
- Current desktop direction: X11-first; X.Org baseline; XLibre compatibility experiment; Guile-WM and Gershwin as intended default selectable sessions. Wayland/dwl-guile is secondary/experimental; Sway is recovery/comparison baseline.
