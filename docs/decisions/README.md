# WARENA Architecture Decision Records

**Status:** DECISION REGISTER · 2026-10-30

ADRs record decisions and their consequences. A proposed ADR is not an implementation instruction or deployment authorization.

| ID | Decision topic | Initial disposition |
|---|---|---|
| ADR-001 | GNU/Linux and GNU Guix platform foundation | Adopt the platform direction; pin and qualify per target |
| ADR-002 | RDE integration | Selective reuse; avoid importing an entire personal configuration |
| ADR-003 | Wayland compositor strategy | Sway reference candidate; dwl-guile experimental |
| ADR-004 | Source and channel reproducibility | Full immutable revisions plus authenticated channel introductions |
| ADR-005 | Runtime Scheme and REPL security | Disabled by default outside isolated development; threat review required |
| ADR-006 | Data integrity algorithms | Decide per workload after interoperability and recovery tests |
| ADR-007 | Repository and branch governance | Preserve unique research; reconcile before deleting |
| ADR-008 | Human authorization boundary | Human approval for consequential actions |

## ADR template

Create one file per decision as `ADR-NNN-short-title.md` with:

- **Status:** PROPOSED / ACCEPTED / SUPERSEDED
- **Date and owner**
- **Context and constraints**
- **Decision**
- **Alternatives considered**
- **Evidence and source revisions**
- **Security, licence and operational consequences**
- **Verification required**
- **Review trigger**

Do not mark an ADR ACCEPTED until the decision-maker has explicitly accepted it. The initial dispositions above are proposals for review.
