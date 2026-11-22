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
| GNU Guile ecosystem | [GNU-GUILE-ECOSYSTEM-AUDIT-2026-10-30.md](GNU-GUILE-ECOSYSTEM-AUDIT-2026-10-30.md) | Curated project survey, WARENA dispositions, source-audit and qualification gates |
| RDE / DWL-Guile integration | [RDE-DWL-GUILE-REUSE-AUDIT-2026-10-28.md](RDE-DWL-GUILE-REUSE-AUDIT-2026-10-28.md) | Upstream age, dependency pins, Home service lifecycle, REPL risks and qualification gates; X11-first policy remains authoritative |
| Host inventory | [host-inventory-template.md](host-inventory-template.md) | Hardware, firmware, OS, interfaces |
| Reproducible environments | [reproducible-environment-runbook.md](reproducible-environment-runbook.md) | Pinning, evaluation, build evidence |
| Network services | [network-services-runbook.md](network-services-runbook.md) | Topology, access, service checks |
| Network and federation architecture | [NETWORK-FEDERATION-AND-PAYMENT-ARCHITECTURE-2026-11-20.md](NETWORK-FEDERATION-AND-PAYMENT-ARCHITECTURE-2026-11-20.md) | GNUnet, Reticulum, libp2p, Yggdrasil, ActivityPub, Pubstrate, Goblins/OCapN, Taler, Kenyan mobile-money integration, security and Guix/Shepherd boundaries |
| Distributed storage and AFS | [DISTRIBUTED-STORAGE-AFS-COMPARISON-2026-11-20.md](DISTRIBUTED-STORAGE-AFS-COMPARISON-2026-11-20.md) | OpenAFS cells/volumes/callbacks and comparison with NFS, SMB, Ceph, GlusterFS, Syncthing, Tahoe-LAFS, IPFS and backup |
| Backup and restore | [backup-restore-runbook.md](backup-restore-runbook.md) | Integrity and recovery tests |
| Desktop candidate study | [desktop-stack-decision-2026-11.md](desktop-stack-decision-2026-11.md) | Historical Nix/Niri/Noctalia comparator; current priority is X11-first |
| Desktop architecture | [DESKTOP-ARCHITECTURE.md](DESKTOP-ARCHITECTURE.md) | Current X11-first policy: X.Org baseline, separate XLibre qualification, Gershwin and Guile-WM/WM-NG session tracks |
| Omarchy / Omaxian comparative study | [OMARCHY-OMAXIAN-GUIX-DESKTOP-ARCHITECTURE-RESEARCH-2026-11-22.md](OMARCHY-OMAXIAN-GUIX-DESKTOP-ARCHITECTURE-RESEARCH-2026-11-22.md) | Product integration, Quattro shell consolidation, X11 portability, Guix reproducibility and a proposed modular native WARENA architecture; RESEARCH only |
| Fork and configuration ownership | [FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md) | WARENA as config home; dwl-guile forks; no warena-rde |
| Stack register | [STACK-REGISTER.md](STACK-REGISTER.md) | Upstream vs Guix vs host evidence |
| GNU Hurd + Nix research | [research/gnu-hurd-nix-compatibility-and-cross-build-2026-11.md](research/gnu-hurd-nix-compatibility-and-cross-build-2026-11.md) | Hurd/Guix status including 64-bit Guix 1.5.0 milestone, Nix feasibility, Childhurd experiment gates |
| GNU Hurd / Guix tracker | [research/hurd/README.md](research/hurd/README.md) | Upstream Hurd/Mach/Guix activity, ChildHurd integration, package-coverage refresh and reproducible experiment protocol |
| Master technology register | [FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md](FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md) | Consolidated technology inventory and implementation guidance |
| Computer science foundations | [FOUNDATIONAL-CS-LEARNING-AND-SYSTEMS-REFERENCES-2026-11.md](FOUNDATIONAL-CS-LEARNING-AND-SYSTEMS-REFERENCES-2026-11.md) | Nine-subject syllabus scaffold, language study and reproducible learning evidence |
| Sovereign workstation setup | [ELITEBOOK-835-G8-SOVEREIGN-WORKSTATION.md](ELITEBOOK-835-G8-SOVEREIGN-WORKSTATION.md) | HP EliteBook 835 G8 target, Emacs, Guix/RDE, human-governed agent architecture, host inventory and staged qualification gates |
| Workstation setup workspace | [../setup/README.md](../setup/README.md) | Planned staging tree only; no executable host configuration or deployment |
| LinkStar-H68K network appliance | [research/linkstar-h68k-network-appliance-2026-11.md](research/linkstar-h68k-network-appliance-2026-11.md) | Article-reported hardware, unknowns, candidate roles and qualification gates |
| Distributed filesystems and networked storage | [research/DISTRIBUTED-FILESYSTEMS-AND-NETWORKED-STORAGE-2026-11-20.md](research/DISTRIBUTED-FILESYSTEMS-AND-NETWORKED-STORAGE-2026-11-20.md) | OpenAFS/AFS and alternatives; architecture, security, Guix/Shepherd feasibility, performance and recovery gates |
| GNUstep–Guile / GOOPS compatibility | [GNUstep Guile GOOPS compatibility audit](GNUSTEP-GUILE-GOOPS-COMPATIBILITY-AUDIT-2026-11-18.md) | Historical bridge limits, GOOPS distinction and modern compatibility gates |
| Identity and Sheng context | [WARENA-NAME-NOTE.md](WARENA-NAME-NOTE.md) | Owner-confirmed technical expansion, Kenyan Sheng resonance and source qualifications |
| IKAI wearable integration | [IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md](IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md) | WARENA infrastructure boundary, Guix/Scheme services, media, IPC, OpenXR and operational qualification |

| Sovereign Movement Systems | [research/SOVEREIGN-MOVEMENT-SYSTEMS-RESEARCH-2026-11-21.md](research/SOVEREIGN-MOVEMENT-SYSTEMS-RESEARCH-2026-11-21.md) | EV software, embedded systems, CAN, charging, nduthi/matatu use cases, off-grid energy, portable storage and Kenyan policy; research only |

## Status vocabulary

- `LIVE` — current operation evidenced with owner and review date.
- `PROTOTYPE` — experimentally implemented; limitations stated.
- `RESEARCH` — investigation/evidence gathering.
- `CONCEPT` — design not implemented.
- `HISTORICAL` — retained record, not asserted current.
- `SUPERSEDED` — replaced by a named revision or decision.
- `UNKNOWN` — status cannot currently be established.

A document is not implementation evidence. A syntax check is not a deployment test; deployment is not a recovery test.

## Historical portfolio alignment

- [WARENA Portfolio Alignment (2026-10-31)](portfolio-alignment-2026-10-31.md) — historical NAKEBUSEN-parent framing; superseded for current domain relationships by the [F3L0H Sovereign Master Corpus](https://github.com/donfelohke/feloh-corpus/blob/main/docs/FELOH-SOVEREIGN-MASTER-CORPUS-2026-11-20.md).

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

## African histories and sovereign technological futures

- [Black Hinterland — Technology, Infrastructure and Sovereign Futures (2026-11-22)](BLACK-HINTERLAND-TECHNOLOGY-AND-SOVEREIGN-FUTURES-2026-11-22.md) — WARENA's bounded study of historical technologies, infrastructure, institutions and contemporary technological sovereignty.
- Shared history, chronology, source register and evidence standards: [FELOH Corpus master dossier](https://github.com/donfelohke/feloh-corpus/blob/main/docs/BLACK-HINTERLAND-BEFORE-AFRICA-MASTER-DOSSIER-2026-11-22.md).

## Current systems research alignment — 2026-11-22

See [WARENA systems and infrastructure update](ECOSYSTEM-UPDATE-2026-11-22.md) for REFLECTION± infrastructure responsibilities, real-time bidirectional I/O validation priorities, upstream/fork provenance and the current X11-first desktop boundary.

## Real-time I/O and display pipelines

- [Real-Time Bidirectional I/O and Display Pipelines](REALTIME-BIDIRECTIONAL-IO-AND-DISPLAY-PIPELINES-2026-11-22.md) — candidate native interfaces and measurement contract for camera/display/compute systems.

## Omarchy / Omaxian comparative desktop research — 2026-11-22

- [Omarchy, Omaxian and the Reproducible Desktop](OMARCHY-OMAXIAN-GUIX-DESKTOP-ARCHITECTURE-RESEARCH-2026-11-22.md) — Omarchy Quattro product and shell integration, Omaxian X11 portability case study, Quickshell/QML policy boundary, Guix generations/provenance, proposed modular native architecture, extension threat model and validation gates. **RESEARCH / ARCHITECTURE ANALYSIS; no WARENA implementation or deployment claimed.**
