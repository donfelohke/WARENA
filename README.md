# WARENA — Advanced Reproducible Extensible Networked Artefacts

**Purpose:** Build and document maintainable, reproducible, local-first computing systems and infrastructure.

WARENA is the ecosystem's systems and enablement domain. It focuses on GNU/Linux environments, reproducible configurations, networking, recovery, and infrastructure that can be inspected, repaired, and handed over.

## Principles

- **Freedom is a system:** prefer source-available, inspectable, modifiable components and document unavoidable constraints.
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

This repository is a project baseline, not evidence that any system has already been deployed. Each implementation must state its maturity as `LIVE`, `PROTOTYPE`, `RESEARCH`, `CONCEPT`, `HISTORICAL`, `SUPERSEDED`, or `UNKNOWN`.

## Canonical ecosystem

- [FELOH Corpus](https://github.com/donfelohke/feloh-corpus) — shared terminology, governance, architecture, and decision provenance.
- [Public portfolio](https://github.com/donfelohke/donfelohke.github.io) — public presentation.
- [GENJE](https://github.com/donfelohke/Genje) — creative technology and embodied practice.
- [IKAI](https://github.com/donfelohke/Ikai) — reflexive-compute research.
- [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN) — beauty craft and the transaction boundary.

**Transaction boundary: ONLY NAKEBUSEN TRANSACTS.**

## Repository map

- `GOVERNANCE.md` — stewardship and decision principles.
- `CONTRIBUTING.md` — proposed change and verification workflow.
- `SECURITY.md` — responsible reporting and safe handling.
- `docs/architecture.md` — system boundaries and evidence rules.
- `docs/reproducibility-plan.md` — staged implementation plan.
- `.github/workflows/validate.yml` — lightweight documentation baseline checks.

## Current status

**Status: RESEARCH / INITIAL DOCUMENTATION BASELINE.** No claim is made here that a production machine image, RDE profile, network deployment, backup restoration, branch protection, or security scanning is operational. Those require separate evidence.
