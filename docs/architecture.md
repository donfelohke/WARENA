# WARENA Architecture

## Role

WARENA is responsible for computing systems and infrastructure: reproducible environments, system configuration, networking, local services, recovery, and operational documentation.

## Design constraints

- Prefer source-first, local-first and reproducible components.
- Record the source revision, configuration inputs, dependencies, hardware assumptions, and expected outputs.
- Separate declarative configuration from secrets and machine-specific state.
- Keep backup and restoration procedures independently testable.
- Avoid mandatory telemetry or remote services unless explicitly justified and documented.

## Initial implementation layers

1. **Host inventory:** hardware, firmware, storage, interfaces, and constraints.
2. **Environment definition:** distribution, channels, manifests, package versions, and configuration.
3. **Service and network configuration:** topology, access boundaries, firewall policy, and service dependencies.
4. **Validation:** syntax checks, isolated build tests, service tests, and failure-mode checks.
5. **Operations:** deployment, update, rollback, backup, restore, monitoring, and retirement.
6. **Evidence:** commit, commands, logs with secrets redacted, observations, and remaining limitations.

## Ecosystem interfaces

- FELOH Corpus: shared terminology, governance and decision provenance.
- GENJE: reproducible creative computing environments and performance infrastructure.
- IKAI: local computation and privacy-preserving prototype infrastructure, subject to IKAI's own research boundaries.
- NAKEBUSEN: business systems and customer-facing operations. Sensitive customer records must not be copied into this repository.

## Status discipline

The presence of a configuration file is not proof it builds. A successful build is not proof it is safe to deploy. A successful deployment is not proof that recovery works. Record each level separately.
