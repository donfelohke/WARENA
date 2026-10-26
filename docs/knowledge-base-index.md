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
| Architecture | [architecture.md](architecture.md) | Boundaries, layers, evidence rules |
| Reproducibility | [reproducibility-plan.md](reproducibility-plan.md) | Staged environment/deployment plan |
| Host inventory | [host-inventory-template.md](host-inventory-template.md) | Hardware, firmware, OS, interfaces |
| Reproducible environments | [reproducible-environment-runbook.md](reproducible-environment-runbook.md) | Pinning, evaluation, build evidence |
| Network services | [network-services-runbook.md](network-services-runbook.md) | Topology, access, service checks |
| Backup and restore | [backup-restore-runbook.md](backup-restore-runbook.md) | Integrity and recovery tests |
| Master technology register and implementation handbook | [FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md](FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md) | Consolidated technology inventory, WARENA implementation guidance, governance, security, recovery and acceptance controls |

## Status vocabulary

- `LIVE` — current operation evidenced with owner and review date.
- `PROTOTYPE` — experimentally implemented; limitations stated.
- `RESEARCH` — investigation/evidence gathering.
- `CONCEPT` — design not implemented.
- `HISTORICAL` — retained record, not asserted current.
- `SUPERSEDED` — replaced by a named revision or decision.
- `UNKNOWN` — status cannot currently be established.

A document is not implementation evidence. A syntax check is not a deployment test; deployment is not a recovery test.

## Ecosystem interfaces

- [FELOH Corpus](https://github.com/donfelohke/feloh-corpus): shared definitions, governance, decision provenance.
- [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN): customer-facing services and business operations. Do not copy private customer data here.
- [IKAI](https://github.com/donfelohke/Ikai): reflective-compute research and privacy boundaries.
- [GENJE](https://github.com/donfelohke/Genje): creative computation and performance environments.

## Minimum evidence for an operational claim

Record repository commit, target hardware/software, configuration inputs, commands, expected and observed results, test date, operator, limitations, and recovery path. Redact secrets and personal data. If evidence is missing, use `UNKNOWN` or `NOT VERIFIED`.
