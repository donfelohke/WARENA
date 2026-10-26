# Evidence status vocabulary (WARENA)

Aligned with FELOH Corpus maturity labels and the stack-register contract.

| Label | Use when |
|-------|----------|
| LIVE | Host + config + observation + recovery |
| PROTOTYPE | Controlled run only |
| RESEARCH | Experiment / study / architecture doc |
| CONCEPT | Spec without implementation evidence |
| UNKNOWN | Missing evidence |

**Forbidden inference:** concept → LIVE; CI green → deployed; upstream release → installed on a WARENA host.

See [STACK-REGISTER.md](./STACK-REGISTER.md).
