# WARENA systems and infrastructure update — 2026-11-22

**Domain:** CAPABILITY. **Motto:** Freedom Is a System. **Status:** Research and engineering direction; no new host deployment is asserted.

## Architecture boundaries

WARENA remains the systems/configuration home. Do not create a parallel RDE repository. NAKEBUSEN alone transacts. IKAI owns the reflective participant experience and optical research; GENJE owns authored creative and embodied practice; WARENA supplies infrastructure and integration capability.

## Current technical direction

- Libre-first, local-first, native-first, inspectable and reproducible; GNU is foundational but not an ecosystem exclusion rule.
- Guix + RDE remains the configuration home.
- Desktop research remains X11-first: X.Org baseline, XLibre compatibility experiment; Wayland/dwl-guile remains secondary and experimental.
- Preserve upstream lineage and licences for `dwl-guile` and `home-service-dwl-guile`; these are WARENA-maintained forks, not original inventions.
- REFLECTION± infrastructure research covers device interfaces, optical acquisition, display output, timing/synchronisation, local compute, storage, power, recovery and human-authorised I/O.
- GNU Hurd / ChildHurd remains experimental research, distinct from the practical GNU/Linux baseline.

## Engineering method

For each candidate, record upstream URL and creator, licence, exact revision, Guix package/channel state, host state, build log, test procedure, result, limitations and recovery path. Do not conflate upstream availability with packaging, a successful build, installation or operation.

Before inventing, evaluate existing standards, protocols, scholarly work, hardware, open-source projects and interoperable components. Prefer reuse and adaptation with attribution.

## Immediate validation

1. Reconcile REFLECTION± I/O requirements with IKAI's M1 validation plan.
2. Define a timestamped, measurable bidirectional I/O test matrix: direction, payload, clock, latency, jitter, loss, synchronisation, permission and fail-safe behaviour.
3. Audit fork deltas and upstream changes before code changes.
4. Reproduce the Guix workstation baseline and backup/restore only on a named test host.
5. Keep X11 and Wayland qualification records separate.

**Evidence boundary:** this document records direction and tests to perform; it does not claim a build, hardware integration, live service or deployment.


## Omarchy / Omaxian and reproducible desktop research — 2026-11-22

The [comparative architecture study](OMARCHY-OMAXIAN-GUIX-DESKTOP-ARCHITECTURE-RESEARCH-2026-11-22.md) examines Omarchy Quattro's desktop integration, Omaxian's X11/XLibre portability work, Quickshell/QML's policy boundary, Guix generations/provenance and a proposed modular native WARENA architecture. It does not change the current X11-first decision or promote dwl-guile beyond secondary/experimental status. **RESEARCH / ARCHITECTURE ANALYSIS; no implementation, build, hardware validation or deployment claimed.**
