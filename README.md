# WARENA

**Systems engineering · reproducibility · infrastructure**  
**Public commercial face:** [NAKEBUSEN Digital](https://donfelohke.github.io/)  
**Author:** [@donfelohke](https://github.com/donfelohke) · Felix Lwova · #HisGenjeness

> **Freedom Is a System.**

**ONE CORPUS → MANY VIEWS → ONE PRACTICE.**

WARENA powers **NAKEBUSEN Digital**. It is not a separate consumer checkout brand. Customer-facing channels for service enquiries and commercial agreements remain through **NAKEBUSEN**.

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

## Current portfolio alignment

NAKEBUSEN's current umbrella proposition is **Beautiful Roots. Sovereign Systems.** WARENA remains the systems-engineering identity powering DIGITAL; GENJE ZA WARENA is a distinct cultural and creative identity, not a WARENA product or checkout brand. See [portfolio alignment (2026-10-31)](docs/portfolio-alignment-2026-10-31.md).

## Evidence and stack truth

| Document | Role |
|----------|------|
| [docs/STACK-REGISTER.md](docs/STACK-REGISTER.md) | Upstream versus Guix versus host — **CANON ≠ deployed** |
| [docs/EVIDENCE-STATUS.md](docs/EVIDENCE-STATUS.md) | LIVE / PROTOTYPE / RESEARCH / CONCEPT / UNKNOWN |
| [docs/REPOSITORY-EVIDENCE-AUDIT-2026-10-26.md](docs/REPOSITORY-EVIDENCE-AUDIT-2026-10-26.md) | Audit of what public GitHub actually contains |
| [docs/DESKTOP-ARCHITECTURE.md](docs/DESKTOP-ARCHITECTURE.md) | Sway baseline · dwl-guile research · X11 track |
| [docs/GERSHWIN-GUIX-PACKAGING-PLAN-2026-11.md](docs/GERSHWIN-GUIX-PACKAGING-PLAN-2026-11.md) | Gershwin upstream GitHub map, GNUstep dependency chain, Guix packaging and X11 session qualification |
| [docs/GERSHWIN-UPSTREAM-SOURCE-AUDIT-2026-11.md](docs/GERSHWIN-UPSTREAM-SOURCE-AUDIT-2026-11.md) | Gershwin upstream checkout/build graph, resolved source pins, component snapshots, license reconnaissance and Guix 1.5.0 release boundary |
| [docs/GERSHWIN-UPSTREAM-DELTA-2026-11-18.md](docs/GERSHWIN-UPSTREAM-DELTA-2026-11-18.md) | Latest Gershwin upstream checkout and window-manager changes; XLibre migration status and revised Guix qualification gates |
| [docs/GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md](docs/GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md) | Legacy Guile-WM versus WARENA WM-NG, Guile 2.2/3 compatibility, XCB/ICCCM/EWMH dependencies, Guix package plan and Xephyr session gates |
| [docs/desktop-stack-decision-2026-11.md](docs/desktop-stack-decision-2026-11.md) | Historical Niri / Noctalia / Nix comparator; superseded by X11-first policy |
| [docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md](docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md) | Fork layer and configuration ownership |
| [docs/CAPABILITY-MAP.md](docs/CAPABILITY-MAP.md) | Offerings versus experiments |
| [docs/IKAI-MIRROR-COMPUTE-ARCHITECTURE-2026-11-14.md](docs/IKAI-MIRROR-COMPUTE-ARCHITECTURE-2026-11-14.md) | IKAI MIRROR+ compute, runtime, hardware and recovery research |
| [docs/IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md](docs/IKAI-WEARABLE-PLATFORM-INTEGRATION-2026-11-18.md) | IKAI voice/AR wearable integration: Guile, Shepherd, IPC, media services, OpenXR qualification and operational gates |
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

Cross-domain relationships are documented in the [canonical architecture](https://github.com/donfelohke/feloh-corpus/blob/main/docs/canonical-architecture-2026-10-26.md).

## License

See [LICENSE](LICENSE).

---

## Portfolio alignment — 2026-10

WARENA remains the systems-engineering layer: reproducible builds, GNU/Linux, local-first infrastructure and network services. **Freedom Is a System.** NAKEBUSEN is the public commercial interface; route customer enquiries there. Do not imply that research concepts are shipped products without implementation evidence.

---

## Before Africa — knowledge systems research

Research note on African technologies, ecological infrastructure, information systems, trade networks and political organisation. Contemporary WARENA principles are used only as analytical questions, not projected backwards as historical equivalences. [Read the research note](docs/BEFORE-AFRICA-KNOWLEDGE-SYSTEMS-2026-11-07.md).

## Desktop stack research — 2026-11

Current policy: **GNU Guix + RDE** remains the preferred foundation; desktop research is **X11-first**, with X.Org as the initial compatibility baseline and XLibre as a separate compatibility experiment. **Gershwin** and **Guile-WM / WM-NG** are the intended selectable session tracks; **Sway** is a comparison/recovery baseline; **dwl-guile / Wayland** is secondary and experimental. Niri + Noctalia and Nix/NixOS remain historical comparators, not the current default direction. See [Desktop Architecture](docs/DESKTOP-ARCHITECTURE.md), [Desktop Candidate Study](docs/desktop-stack-decision-2026-11.md), and [Fork Architecture](docs/FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md). Research only; no host deployment is implied.

## Canonical identity and technology constitution — 2026-11-17

**WARENA = Warena Architecture Re Network/ed Artefact.** Preserve the deliberate “Network/ed” form. **Freedom Is a System.**

The name also has a documented resonance with Kenyan Sheng *warena*, recorded with senses including fire and formidable energy. This is a cultural association, not the historical derivation or translation of WARENA's technical expansion. See [WARENA Name Note](docs/WARENA-NAME-NOTE.md) for source qualifications.

The governing technical policy is native-first, libre-first, local-first and user-controlled. **JavaScript is prohibited** as a language, runtime, framework or dependency; web technologies are excluded as WARENA application/runtime architecture. Prefer GNU/Linux, Guix, Guile/Scheme/GOOPS, native interfaces and inspectable local persistence. OpenXR is a native API candidate and is distinct from WebXR.

See [Technology Constitution (2026-11-17)](docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md). This dated policy supersedes conflicting older proposals; historical records remain preserved. Current desktop decisions must be read with the latest X11-first / dual-session architecture records, not inferred from older Wayland candidate summaries.
