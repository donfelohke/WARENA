# WARENA Architecture

**Status:** PROPOSED ARCHITECTURE SUMMARY · 2026-10-30  
**Canonical specification:** [WSAS-01](./WSAS-01.md)

## Role and boundaries

WARENA defines systems engineering and infrastructure: reproducible environments, platform configuration, software, data, networking, security, operations, recovery and evidence.

NAKEBUSEN is the sole transacting enterprise; NAKEBUSEN DIGITAL is the commercial technology-services path powered by WARENA. IKAI Mirror remains a distinct reflective-computing identity and may consume WARENA capabilities without becoming a WARENA product. GENJE remains a distinct creative practice.

## Functional subsystems

1. Platform engineering.
2. Software engineering.
3. Data engineering and recovery.
4. Networking and service integration.
5. Security and provenance.
6. Operations and maintenance.
7. Observability and diagnostics.

See [WSAS-01](./WSAS-01.md) for responsibilities and acceptance evidence.

## Design constraints

- Prefer source-first, local-first and reproducible components.
- Record immutable source revisions, channel introductions, dependencies, hardware assumptions and expected outputs.
- Separate declarative configuration from secrets and machine-specific state.
- Keep backup and restoration independently testable.
- Avoid mandatory telemetry or remote services unless justified and documented.
- Preserve human authority for consequential changes.

## Upstream integration

Reuse unchanged, adapt minimally, reject with rationale, or test first. Do not combine RDE and dwl-guile as if they were a prevalidated stack. Source and licence details are maintained in [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md).

## Evidence discipline

The presence of a configuration file does not prove it evaluates. A successful build does not prove runtime safety. A successful deployment does not prove recovery. Record each level separately using [EVIDENCE-STATUS.md](./EVIDENCE-STATUS.md).
