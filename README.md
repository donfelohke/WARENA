# WARENA — Advanced Reproducible Extensible Networked Artefacts

**Author:** Feloh Warena · [@donfelohke](https://github.com/donfelohke) · [X](https://x.com/donfelohke)  
**Pillar:** GRIT · Freedom is a system  
**Canonical principle:** ONE CORPUS → MANY VIEWS → ONE PRACTICE.

**Purpose:** Build and document maintainable, reproducible, local-first computing systems and infrastructure.

WARENA is the ecosystem's systems and enablement domain. It focuses on GNU/Linux environments, reproducible configurations, networking, recovery, and infrastructure that can be inspected, repaired, and handed over.

## Principles

- **Freedom is a system:** prefer inspectable, modifiable components and document constraints.
- **Reproducibility:** record versions, configuration inputs, build steps, hardware assumptions, and test evidence.
- **Local-first:** do not assume cloud services, telemetry, or permanent external connectivity.
- **Recovery before claims:** a backup plan is not a recovery test; record actual restoration evidence.
- **Least privilege:** minimise permissions, credentials, exposed services, and operational dependencies.
- **Human stewardship:** document how another maintainer can understand, rebuild, operate, and retire a system.

## Scope

- GNU/Linux and GNU Guix/RDE research and configurations.
- Reproducible package environments and deployment profiles.
- Network design, segmentation, local services, and operational runbooks.
- Backup, restoration, migration, and lifecycle planning.
- Hardware inventories, compatibility notes, test plans, and implementation evidence.

## Knowledge base

Start at [docs/knowledge-base-index.md](docs/knowledge-base-index.md). It routes contributors to:
- [Architecture](docs/architecture.md) and [reproducibility plan](docs/reproducibility-plan.md).
- [Host inventory template](docs/host-inventory-template.md).
- [Reproducible environment runbook](docs/reproducible-environment-runbook.md).
- [Network services runbook](docs/network-services-runbook.md).
- [Backup and restore runbook](docs/backup-restore-runbook.md).

These runbooks are proposed procedures until tested against a named target and accompanied by evidence. Each implementation must state its maturity as `LIVE`, `PROTOTYPE`, `RESEARCH`, `CONCEPT`, `HISTORICAL`, `SUPERSEDED`, or `UNKNOWN`.

## Canonical ecosystem

- [FELOH Corpus](https://github.com/donfelohke/feloh-corpus) — shared terminology, governance, architecture, and decision provenance.
- [Public portfolio](https://github.com/donfelohke/donfelohke.github.io) — public presentation.
- [GENJE](https://github.com/donfelohke/Genje) — creative technology and embodied practice.
- [IKAI](https://github.com/donfelohke/Ikai) — reflexive-compute research.
- [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN) — beauty craft and customer-facing business operations.
- [Gallery](https://github.com/donfelohke/Gallery) — curated assets.

Commercial enquiries and service confirmations are handled through NAKEBUSEN's approved customer-facing channels: [WhatsApp 0719 635 415](https://wa.me/254719635415).

## Repository map

- `GOVERNANCE.md` — stewardship and decision principles.
- `CONTRIBUTING.md` — change and verification workflow.
- `SECURITY.md` — responsible reporting and safe handling.
- `docs/architecture.md` — system boundaries and evidence rules.
- `docs/reproducibility-plan.md` — staged implementation plan.
- `docs/knowledge-base-index.md` — runbook and template index.
- `.github/workflows/validate.yml` — lightweight documentation baseline checks.

## Current status

**Status: RESEARCH / INITIAL DOCUMENTATION BASELINE.** No claim is made here that a production machine image, RDE profile, network deployment, backup restoration, branch protection, or security scanning is operational. Those require separate evidence.

---

## Canonical architecture update — 2026-10-26

WARENA is the technical identity of **NAKEBUSEN DIGITAL**; WARENA Systems describes the systems-engineering and infrastructure practice. It is not a competing customer-facing booking brand. **ONLY NAKEBUSEN TRANSACTS.** Route commercial service enquiries through NAKEBUSEN's approved channels.

The shared human-authority principle is **“AI suggests. The human decides.”** Technical direction remains local-first where practical, reproducible, inspectable, recoverable and documented. A listed technology or proposed runbook is not evidence of deployment; distinguish LIVE, PROTOTYPE, RESEARCH, CONCEPT, HISTORICAL, SUPERSEDED and UNKNOWN. IKAI Mirror is a related reflective-computing research project; GENJE ZA WARENA is the cultural identity/motivating idea, not a technical subsystem.

See the [canonical architecture](https://github.com/donfelohke/feloh-corpus/blob/main/docs/canonical-architecture-2026-10-26.md).
