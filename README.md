# WARENA

**Systems engineering · reproducibility · infrastructure**  
**Public commercial face:** [NAKEBUSEN Digital](https://donfelohke.github.io/)  
**Author:** [@donfelohke](https://github.com/donfelohke) · Felix Lwova · #HisGenjeness

> **Freedom Is a System.**

**ONE CORPUS → MANY VIEWS → ONE PRACTICE.**

WARENA is the systems-engineering layer powering NAKEBUSEN Digital. It is not a separate consumer checkout brand. Customer-facing enquiries and commercial agreements remain through **NAKEBUSEN**, the sole transacting enterprise.

Use NAKEBUSEN **customer-facing channels** (website, WhatsApp, email) for service enquiries. An enquiry is not an accepted project. Scope, price, support and access are agreed before work begins.

**Public-facing description:** *Sovereign systems that work when the internet does not.* WARENA helps people and organisations plan, understand, maintain and recover computing systems, emphasising local-first operation, reproducibility and clear handover.

This is positioning, not proof of completed client deployments. Publish a service, price, compatibility claim or delivery promise only when scope and evidence are current.

## Why WARENA exists

Prefer systems people can install, understand, maintain and recover, including where power and connectivity are unreliable.

1. Comprehensibility.
2. Maintainability.
3. Local-first where it helps.
4. Honest maturity and evidence.
5. Human authorship: tools assist; the operator decides.

## Public capability map

| Domain | Typical work | Maturity |
|---|---|---|
| GNU/Linux | Installation, administration, troubleshooting | Offered via NAKEBUSEN Digital |
| Workstations | Diagnostics, recovery, maintenance | Offered |
| Networks | Wi-Fi, LAN, router setup | Offered |
| Small infrastructure | Servers and shared services | By engagement |
| Learning spaces | Laboratory, classroom, cybercafé | By engagement |
| Local-first / offline | Weak-WAN environments | By engagement |
| Reproducible tooling | Documented environments | Practice / evolving |
| RDE / Guix / desktop research | Sovereign workstation experiments | RESEARCH; not a product claim |

## Architecture and evidence

| Document | Role |
|---|---|
| [WSAS-01](docs/WSAS-01.md) | Canonical proposed systems architecture |
| [WSAS-02](docs/WSAS-02.md) | Repository and integration register |
| [Upstream Source Register](docs/UPSTREAM-SOURCE-REGISTER.md) | Source revisions, channel introductions, licences and compatibility caveats |
| [Architecture Decision Records](docs/decisions/README.md) | Decision register and ADR process |
| [Stack Register](docs/STACK-REGISTER.md) | Upstream vs Guix vs host; source availability is not deployment |
| [Evidence Status](docs/EVIDENCE-STATUS.md) | Common maturity and evidence vocabulary |
| [Desktop Architecture](docs/DESKTOP-ARCHITECTURE.md) | Sway reference candidate; dwl-guile research; separate X11 track |
| [Knowledge Base](docs/knowledge-base-index.md) | Operational runbooks and research navigation |
| [Capability Map](docs/CAPABILITY-MAP.md) | Offerings versus experiments |

This repository is documentation-first. Markdown, upstream releases and green documentation CI are not proof of a named production host.

## Upstream policy

WARENA records canonical upstream source, mirror status, immutable commit, channel introduction and fingerprint where relevant, licence, dependencies, integration treatment and verification evidence. Branch names alone are not reproducible pins. See the [Upstream Source Register](docs/UPSTREAM-SOURCE-REGISTER.md).

Current research posture: RDE is selectively reusable; dwl-guile and its Home service require compatibility and security testing; Sway is the Wayland reference candidate. No compatible Guix channel lock or successful WARENA desktop build is claimed.

## Ecosystem boundaries

| Name | Relationship |
|---|---|
| **NAKEBUSEN** | Sole transacting enterprise; Digital path is WARENA-powered |
| **IKAI** | Distinct reflective-computing research/product identity |
| **GENJE** | Distinct cultural and creative practice |
| **FELOH / @donfelohke** | Human author |
| **feloh-corpus** | Shared terminology and evidence standards |

Cross-domain relationships: [canonical architecture](https://github.com/donfelohke/feloh-corpus/blob/main/docs/canonical-architecture-2026-10-26.md).

## Contact

[donfelohke.github.io](https://donfelohke.github.io/) · WhatsApp **+254 719 635 415** · `mela9ine@proton.me`

## License

See [LICENSE](LICENSE).
