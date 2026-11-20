# WARENA

**CAPABILITY domain · systems engineering · reproducibility · infrastructure**  
**Commercial interface:** [NAKEBUSEN](https://donfelohke.github.io/) only  
**Author:** [@donfelohke](https://github.com/donfelohke) · Felix Lwova · #HisGenjeness

> **Freedom Is a System.**

**ONE CORPUS → MANY VIEWS → ONE PRACTICE.**

WARENA is the **CAPABILITY** domain within the F3L0H practice. It provides systems engineering, infrastructure and technical enablement. It is not a separate commercial checkout brand; any customer-facing service engagement is offered and transacted through **NAKEBUSEN**, the ROOT domain and only live commercial practice.

**Public-facing description:** *Sovereign systems that work when the internet does not.* WARENA helps people and organisations plan, understand, maintain and recover computing systems, with emphasis on local-first operation, reproducibility and clear handover documentation.

**Audience:** small organisations, learning spaces, community infrastructure and independent operators who require understandable systems and practical operational support. This is positioning, not proof of completed client deployments. Publish a specific service, price, compatibility claim or delivery promise only when current scope and evidence are documented.

**An enquiry is not an accepted project.** Scope, price and support are agreed before work begins.

---

## Why WARENA exists

Prefer stacks that people can install, understand, maintain and recover—including in environments where power and connectivity are unreliable.

1. **Comprehensibility**  
2. **Maintainability**  
3. **Local-first where it helps**  
4. **Honesty of status** — LIVE versus RESEARCH versus PROPOSAL  
5. **Human authorship** — tools assist; the operator decides  

Pillar: **GRIT** (within GRACE · GRIT · GLORY).

---

## Capability map (public)

| Domain | Typical work | Maturity |
|--------|--------------|----------|
| GNU/Linux | Install, administration, troubleshooting | Offered via NAKEBUSEN Digital |
| Workstations | Diagnostics, recovery, maintenance | Offered |
| Networks | Wi-Fi, LAN, router setup | Offered |
| Small infrastructure | Servers, shared services | By engagement |
| Learning spaces | Laboratory, classroom, cybercafé | By engagement |
| Local-first / offline | Weak-WAN environments | By engagement |
| Reproducible tooling | Documented environments | Practice / evolving |
| RDE / Guix / desktop research | Sovereign workstation experiments | **RESEARCH** — not a product claim |

---

## Configuration ownership

**This repository is the WARENA configuration home.** RDE notes, Guix Home integration policy, system architecture, stack register, desktop decisions and maintenance policy live here. There is no separate `warena-rde` repository.

Guile-native compositor research uses independent forks (not upstream mutation):

| Repository | Role |
|------------|------|
| [donfelohke/dwl-guile](https://github.com/donfelohke/dwl-guile) | Fork of engstrand-config/dwl-guile |
| [donfelohke/home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile) | Fork of engstrand-config/home-service-dwl-guile |

RDE (`abcdw/rde`) and `gptel` remain pinned upstream dependencies. See [Fork and Configuration Architecture](docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md).

---

## Current constitutional alignment — 2026-11-20

WARENA is the **CAPABILITY** domain in the four-domain F3L0H architecture: NAKEBUSEN / ROOT, IKAI / MIRROR, GENJE / EXPRESSION, WARENA / CAPABILITY. F3L0H is the overarching human authorship identity, not a fifth domain. GENJE NODE is a WARENA manifestation. **ONLY NAKEBUSEN TRANSACTS.** See the [F3L0H Sovereign Master Corpus](https://github.com/donfelohke/feloh-corpus/blob/main/docs/FELOH-SOVEREIGN-MASTER-CORPUS-2026-11-20.md).

## Evidence and stack truth

| Document | Role |
|----------|------|
| [docs/STACK-REGISTER.md](docs/STACK-REGISTER.md) | Upstream versus Guix versus host — **CANON ≠ deployed** |
| [docs/EVIDENCE-STATUS.md](docs/EVIDENCE-STATUS.md) | LIVE / PROTOTYPE / RESEARCH / CONCEPT / UNKNOWN |
| [docs/REPOSITORY-EVIDENCE-AUDIT-2026-10-26.md](docs/REPOSITORY-EVIDENCE-AUDIT-2026-10-26.md) | Audit of what public GitHub actually contains |
| [docs/DESKTOP-ARCHITECTURE.md](docs/DESKTOP-ARCHITECTURE.md) | X11-first · X.Org baseline · XLibre experiment · Wayland secondary/experimental |
| [docs/GERSHWIN-GUIX-PACKAGING-PLAN-2026-11.md](docs/GERSHWIN-GUIX-PACKAGING-PLAN-2026-11.md) | Gershwin upstream GitHub map, GNUstep dependency chain, Guix packaging and X11 session qualification |
| [docs/GERSHWIN-UPSTREAM-SOURCE-AUDIT-2026-11.md](docs/GERSHWIN-UPSTREAM-SOURCE-AUDIT-2026-11.md) | Gershwin upstream checkout/build graph, resolved source pins, component snapshots, license reconnaissance and Guix 1.5.0 release boundary |
| [docs/GERSHWIN-UPSTREAM-DELTA-2026-11-18.md](docs/GERSHWIN-UPSTREAM-DELTA-2026-11-18.md) | Latest Gershwin upstream checkout and window-manager changes; XLibre migration status and revised Guix qualification gates |
| [docs/GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md](docs/GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md) | Legacy Guile-WM versus WARENA WM-NG, Guile 2.2/3 compatibility, XCB/ICCCM/EWMH dependencies, Guix package plan and Xephyr session gates |
| [docs/desktop-stack-decision-2026-11.md](docs/desktop-stack-decision-2026-11.md) | Historical Niri / Noctalia / Nix comparator; superseded by X11-first policy |
| [docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md) | Fork layer and configuration ownership |
| [docs/CAPABILITY-MAP.md](docs/CAPABILITY-MAP.md) | Offerings versus experiments |
| [docs/IKAI-MIRROR-COMPUTE-ARCHITECTURE-2026-11-14.md](docs/IKAI-MIRROR-COMPUTE-ARCHITECTURE-2026-11-14.md) | IKAI MIRROR+ compute, runtime, hardware and recovery research |
| [IKAI Mirror M1 Engineering Validation](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-MIRROR-M1-ENGINEERING-VALIDATION-2026-11-18.md) | IKAI-owned optical/display validation gates; WARENA infrastructure evidence remains a separate responsibility |
| [docs/IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md](docs/IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md) | IKAI voice/AR wearable integration: Guile, Shepherd, IPC, media services, OpenXR qualification and operational gates |
| [docs/SPATIAL-COMPUTING-XR-AI-ARCHITECTURE-2026-11-20.md](docs/SPATIAL-COMPUTING-XR-AI-ARCHITECTURE-2026-11-20.md) | GNU/MAVERIK and DEVA3 foundations; spatial services, OpenXR/Monado, graphics, Guix/Shepherd and disabled-by-default opt-in AI |
| [docs/IKAI-XR-PLATFORM-COMPATIBILITY-MATRIX-2026-11-18.md](docs/IKAI-XR-PLATFORM-COMPATIBILITY-MATRIX-2026-11-18.md) | Native OpenXR, Monado, Android XR and platform qualification research; no deployment claimed |
| [docs/RDE-PREINSTALL-POSTINSTALL-RUNBOOK.md](docs/RDE-PREINSTALL-POSTINSTALL-RUNBOOK.md) | RDE live ISO pre-install evaluation, Guix System installation planning, post-install validation and recovery |
| [docs/GITHUB-POSTINSTALL-SETUP.md](docs/GITHUB-POSTINSTALL-SETUP.md) | Git identity, SSH authentication, GitHub CLI, canonical WARENA checkout, safe sync and contribution workflow; rebase deferred |
| [docs/WARENA-NAME-NOTE.md](docs/WARENA-NAME-NOTE.md) | Exact technical expansion and distinction from Kenyan Sheng usage |

This repository is **documentation-first** on public GitHub. Markdown is not proof of a named production host.

---

## Contact

[donfelohke.github.io](https://donfelohke.github.io/) · WhatsApp **+254 719 635 415** · `mela9ine@proton.me`

---

## Ecosystem

| Name | Relationship |
|------|----------------|
| **NAKEBUSEN** | Sole transacting enterprise; Digital path is WARENA-powered |
| **IKAI** | Reflective-compute research — not a WARENA product |
| **GENJE** | Cultural / creative practice |
| **FELOH / @donfelohke** | Human author |
| **feloh-corpus** | Shared terms and evidence standards |
| **dwl-guile / home-service-dwl-guile** | WARENA-maintained forks for Guile compositor research |

Cross-domain relationships are governed by the [F3L0H Sovereign Master Corpus](https://github.com/donfelohke/feloh-corpus/blob/main/docs/FELOH-SOVEREIGN-MASTER-CORPUS-2026-11-20.md).

## License

See [LICENSE](LICENSE).

---

## Portfolio alignment — 2026-10

WARENA remains the systems-engineering layer: reproducible builds, GNU/Linux, local-first infrastructure and network services. **Freedom Is a System.** NAKEBUSEN is the public commercial interface; route customer enquiries there. Do not imply that research concepts are shipped products without implementation evidence.

---

## Before Africa — knowledge systems research

Research note on African technologies, ecological infrastructure, information systems, trade networks and political organisation. Contemporary WARENA principles are used only as analytical questions, not projected backwards as historical equivalences. [Read the research note](docs/BEFORE-AFRICA-KNOWLEDGE-SYSTEMS-2026-11-07.md).

## Network, federation and payment architecture — 2026-11-20

[Network, Federation and Payment Architecture](docs/NETWORK-FEDERATION-AND-PAYMENT-ARCHITECTURE-2026-11-20.md) documents GNUnet and its alternatives, Reticulum, Pubstrate/ActivityPub, Goblins/OCapN, GNU Taler, Kenyan mobile-money integration, security boundaries, and Guix/Shepherd feasibility. Research only; no payment automation or production network deployment is implied.

[Distributed Storage and AFS Comparison](docs/DISTRIBUTED-STORAGE-AFS-COMPARISON-2026-11-20.md) compares OpenAFS, NFS, SMB, Ceph, GlusterFS, Syncthing, Tahoe-LAFS, IPFS and local backup strategies.

## Desktop stack research — 2026-11

Current policy: **GNU Guix + RDE** remains the preferred foundation; desktop research is **X11-first**, with X.Org as the initial compatibility baseline and XLibre as a separate compatibility experiment. **Gershwin** and **Guile-WM / WM-NG** are the intended selectable session tracks; **Sway** is a comparison/recovery baseline; **dwl-guile / Wayland** is secondary and experimental. Niri + Noctalia and Nix/NixOS remain historical comparators, not the current default direction. See [Desktop Architecture](docs/DESKTOP-ARCHITECTURE.md), [Desktop Candidate Study](docs/desktop-stack-decision-2026-11.md), and [Fork Architecture](docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md). Research only; no host deployment is implied.

## Canonical identity and technology constitution — 2026-11-17

**WARENA = Warena Architecture Re Network/ed Artefact.** Preserve the deliberate “Network/ed” form. **Freedom Is a System.**

The name also has a documented resonance with Kenyan Sheng *warena*, recorded with senses including fire and formidable energy. This is a cultural association, not the historical derivation or translation of WARENA's technical expansion. See [WARENA Name Note](docs/WARENA-NAME-NOTE.md) for source qualifications.

The governing technical policy is native-first, libre-first, local-first and user-controlled. **JavaScript is prohibited** as a language, runtime, framework or dependency; web technologies are excluded as WARENA application/runtime architecture. Prefer GNU/Linux, Guix, Guile/Scheme/GOOPS, native interfaces and inspectable local persistence. OpenXR is a native API candidate and is distinct from WebXR.

See [Technology Constitution (2026-11-17)](docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md). This dated policy supersedes conflicting older proposals; historical records remain preserved. Current desktop decisions must be read with the latest X11-first / dual-session architecture records, not inferred from older Wayland candidate summaries.

## IKAI Mirror infrastructure relationship — 2026-11-18

WARENA's role is limited to enabling-infrastructure research: local compute, native interfaces, reproducible configuration, storage, operations and recovery. IKAI owns the participant-facing mirror experience and its optical/M1 research. See [WARENA's IKAI MIRROR+ compute architecture](docs/IKAI-MIRROR-COMPUTE-ARCHITECTURE-2026-11-14.md), [IKAI's mirror technology research](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-MIRROR-TECHNOLOGY-AND-SCHOLARLY-RESEARCH-2026-11-18.md), and the [corpus cross-project alignment](https://github.com/donfelohke/feloh-corpus/blob/main/docs/IKAI-MIRROR-CROSS-PROJECT-ALIGNMENT-2026-11-18.md). All remain RESEARCH; no hardware procurement, implementation or deployment is implied.


## Knowledge, inquiry and the Sage archetype — 2026-11-20

WARENA uses **Sage** as a contemporary design archetype for inquiry, reflection, evidence and understanding within the Sovereign × Creator × Sage conceptual triad. This is distinct from Henry Odera Oruka's historical African Sage Philosophy and philosophic sagacity. WARENA does not claim to implement Oruka's method or to inherit its scholarly authority. The FELOH Corpus owns the historical research record: [Oruka Sage Philosophy & Philosophic Sagacity](https://github.com/donfelohke/feloh-corpus/blob/main/docs/ORUKA-SAGE-PHILOSOPHY-AND-PHILOSOPHIC-SAGACITY-2026-11-20.md). **RESEARCH / conceptual boundary only; no product or implementation claim.**
