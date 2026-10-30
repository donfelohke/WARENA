# WSAS-01 — WARENA Systems Architecture Specification

**Status:** PROPOSED ARCHITECTURE BASELINE  
**Revision:** 1.0 · 2026-10-30  
**Owner:** WARENA · NAKEBUSEN DIGITAL  
**Authority:** Human review required; this document does not authorize deployment.

## 1. Mandate

WARENA defines, integrates, verifies and operates maintainable computational systems and infrastructure. Its engineering priorities are sovereignty, modularity, reproducibility, local-first operation where useful, security, recoverability and human authority.

The architecture is documentation-first until implementation evidence is recorded against a named target.

## 2. Boundaries

- **NAKEBUSEN:** enterprise and sole transacting customer-facing entity.
- **NAKEBUSEN DIGITAL:** commercial technology-services path powered by WARENA.
- **WARENA Systems:** engineering architecture, infrastructure, integration, operations and technical standards.
- **IKAI Mirror:** distinct reflective-computing product/research identity. It may consume WARENA capabilities but does not become a WARENA subsystem or product by implication.
- **GENJE:** distinct cultural and creative practice.
- **FELOH / @donfelohke:** human author and accountable decision-maker.

## 3. Functional subsystems

| Subsystem | Responsibility | Minimum acceptance evidence |
|---|---|---|
| Platform | GNU/Linux, Guix, host and environment definitions | Evaluated configuration and reproducible build evidence |
| Software | Guile applications, libraries, services and automation | Source review and functional tests |
| Data | Canonical files, metadata, indexes, backup and recovery | Integrity checks and successful restore evidence |
| Networking | LAN/WAN, routing, DNS, firewall and service connectivity | Documented topology and connectivity/security tests |
| Security | Identity, access, isolation, provenance and patching | Threat review and verified controls |
| Operations | Provisioning, upgrades, rollback, maintenance and retirement | Runbooks and operator handover |
| Observability | Logs, metrics and diagnostics | Useful, privacy-respecting telemetry and incident evidence |

## 4. Architectural constraints

1. Prefer inspectable, source-first and reproducible components.
2. Pin source inputs and record provenance; do not confuse a branch name with an immutable revision.
3. Keep secrets and machine-specific state outside public source control.
4. Separate upstream source, WARENA-owned adapters and local configuration.
5. Prefer minimal upstream divergence and explicit interfaces.
6. Make backup, restoration and rollback independently testable.
7. Avoid mandatory cloud, telemetry or proprietary services without a documented need and explicit approval.
8. Preserve user and operator control over consequential actions.

## 5. Human authority

Automation and AI may assist with research, analysis, classification, recommendation and execution preparation. They do not independently authorize consequential actions involving identity, ownership, money, personal data, irreversible changes or production deployment. Require a named human decision-maker and an auditable approval record.

## 6. Technology governance

Use these classifications consistently:

- **ADOPTED:** approved engineering standard for an identified scope.
- **PREFERRED:** recommended default, subject to target requirements.
- **EXPERIMENTAL:** under evaluation; not a production promise.
- **REJECTED:** excluded for a recorded reason; reconsider only through a new decision.

Technology lifecycle is separate from implementation evidence. An ADOPTED tool can still be UNKNOWN on a particular host.

## 7. Upstream integration

For every upstream component, record canonical source, mirror status, branch/tag, full commit, commit date, channel introduction and signing identity where applicable, licence, dependencies, WARENA treatment, tests, known limitations and update strategy.

Choose one treatment: **REUSE UNCHANGED**, **ADAPT**, **REJECT**, or **TEST FIRST**. Do not infer compatibility from adjacent projects or successful documentation checks.

## 8. Build, verification and release

The lifecycle is:

`SOURCE → PINNED INPUTS → EVALUATION → BUILD → STATIC CHECKS → TESTS → SECURITY REVIEW → HUMAN APPROVAL → DEPLOYMENT → OPERATIONS`

A release candidate requires immutable inputs, build logs, test results, licence/provenance review, upgrade and rollback instructions, known limitations and explicit human approval. A successful build is not production readiness.

## 9. Quality gates

| Gate | Requirement |
|---|---|
| G0 Definition | Scope, owner, target and problem |
| G1 Architecture | Interfaces, dependencies and threat boundaries |
| G2 Provenance | Source revisions, channel introductions and licences |
| G3 Reproducibility | Repeatable evaluation/build |
| G4 Functionality | Defined tests pass on named target |
| G5 Security | Threat and access review |
| G6 Operations | Backup, restore, monitoring and rollback evidence |
| G7 Release | Human acceptance and release record |

A project may remain experimental. No automatic promotion is implied.

## 10. Documentation and change control

Use Architecture Decision Records (ADRs) for consequential choices. Every operational claim must identify its target, revision, date, procedure, observed result and evidence. Mark unknowns as UNKNOWN. Substantive changes use focused branches and pull requests; no document authorizes merging, branch deletion or deployment by itself.

## 11. Governing distinction

**Specification is not implementation. Implementation is not verification. Verification is not deployment.**

## Related records

- [WSAS-02 — Repository and Upstream Integration Register](WSAS-02.md)
- [Upstream Source Register](UPSTREAM-SOURCE-REGISTER.md)
- [Architecture Decision Records](decisions/README.md)
- [Stack Register](STACK-REGISTER.md)
- [Evidence Status](EVIDENCE-STATUS.md)
- [Desktop Architecture](DESKTOP-ARCHITECTURE.md)
