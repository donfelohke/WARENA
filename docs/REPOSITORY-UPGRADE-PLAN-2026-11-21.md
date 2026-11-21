# Repository upgrade plan — 2026-11-21

**Repository:** `WARENA`  
**Primary role:** CAPABILITY — systems engineering, infrastructure, reproducibility and technical enablement.  
**Motto:** Freedom Is a System.

## Architecture and policy

- WARENA remains the configuration and systems architecture home; do not create a parallel `warena-rde` repository.
- Libre-first, local-first, inspectable and reproducible; GNU is foundational but WARENA is not GNU-exclusive.
- Native-first application architecture. JavaScript/web stacks are not acceptable WARENA/IKAI runtime or application dependencies.
- X11-first desktop research: X.Org initial baseline, XLibre compatibility experiment; Wayland/dwl-guile remains secondary and experimental.
- NAKEBUSEN remains the only commercial transaction interface. Research is not a product or deployment claim.

## Upgrade workstreams

1. **Stack register:** pin upstream source, Guix package/channel version, host state and test evidence separately. Never conflate upstream existence with a built package or installed service.
2. **Reproducibility:** define clean-environment build procedures, input hashes, source revisions, build logs, binary comparison limits and rollback.
3. **Security model:** document trust boundaries, least privilege, human-controlled agent authority, secrets handling, update provenance and recovery.
4. **Infrastructure:** compare local-first networking, federation, storage, backup, identity and payment components against operational constraints; reuse and credit existing work.
5. **Desktop:** keep X11 and Wayland tracks explicitly separated; qualify display server, WM, shell, compositor, session, input/output and recovery independently.
6. **Hurd/Guix:** distinguish upstream development, cross-build feasibility, package availability, emulation and physical deployment; label each maturity level.
7. **XR / IKAI support:** WARENA supplies compute, IO and integration infrastructure; IKAI owns reflective participant experience; GENJE owns embodied creative practice.
8. **Documentation CI:** check links, Markdown, Scheme formatting and declared evidence references without claiming build success where no build ran.

## Engineering acceptance gates

Every implementation record should include purpose, upstream attribution, licence, pinned revisions, threat model, test method, observed results, limitations, recovery path and maintenance owner. No release claim without reproducible evidence.

## Immediate sequence

1. Reconcile eight open WARENA PRs and identify unique work.
2. Audit current stack claims against upstream and Guix state.
3. Prioritise reproducible workstation baseline and backup/recovery.
4. Turn high-value research into testable, bounded prototypes only where evidence supports the gap.
5. Publish a release/compatibility matrix with explicit UNKNOWN values.