# Evidence status vocabulary (WARENA)

**Status:** GOVERNANCE STANDARD · 2026-10-30  
Use these labels consistently in architecture documents, stack records, runbooks, issues and release notes.

| Label | Meaning | Minimum evidence |
|---|---|---|
| CONCEPT | Idea or design only | Description and assumptions |
| RESEARCH | Investigation or source study | Sources, date and open questions |
| PROPOSED | Recommended but not approved/implemented | Scope, owner and review state |
| PROTOTYPE | Limited implementation | Named target, revision and limitations |
| IMPLEMENTED | Code/configuration exists | Repository path and immutable revision |
| TESTED | Defined tests executed | Target, commands, results and date |
| DEPLOYED | Installed in a named environment | Deployment record, owner and revision |
| LIVE | Current operation observed | Named host/service, observation date, monitoring and recovery evidence |
| HISTORICAL | Retained record, not current assertion | Date and historical context |
| SUPERSEDED | Replaced by a named decision or revision | Replacement link |
| UNKNOWN | Evidence is insufficient | Explicit missing evidence |

## Rules

- Upstream release exists ≠ package available in the selected Guix channels.
- Package available ≠ installed.
- Installed ≠ service operational.
- Configuration exists ≠ configuration evaluates.
- Build succeeds ≠ runtime works.
- Runtime works ≠ recovery works.
- CI green ≠ deployment.
- Documentation ≠ implementation evidence.
- A source commit is a provenance pin, not a host observation.

A claim may have different maturity at different layers. Record technology lifecycle, implementation state and document status separately.

**Forbidden inference:** CONCEPT / RESEARCH / PROPOSED → LIVE without target-specific evidence.

See [STACK-REGISTER.md](./STACK-REGISTER.md), [WSAS-01](./WSAS-01.md) and [VALIDATION.md](./VALIDATION.md).
