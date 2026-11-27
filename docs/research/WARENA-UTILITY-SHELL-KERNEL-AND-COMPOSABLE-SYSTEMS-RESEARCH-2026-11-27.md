# WARENA Research — Utility Shell, Kernel Boundaries and Composable Systems

**Date:** 2026-11-27  
**Status:** ARCHITECTURAL RESEARCH / OPEN QUESTIONS  
**Authority:** WARENA for systems engineering; FELOH Corpus for cross-domain synthesis.

## 1. Purpose

This research track examines how command-oriented interaction, operating-system services, resource composition and real-time input/output can be made modular, inspectable and replaceable.

**Utility Shell Kernel** is a working research phrase, not the name of an implemented kernel, released operating system or completed product. The phrase must not blur the distinction between a command shell, service supervisor, user-space server, microkernel and monolithic kernel.

The governing engineering rule is **Do Not Recreate Wheels**: identify mature systems, standards and implementations before proposing a new subsystem.

## 2. Define the boundaries first

| Layer | Responsibility | Existing-system questions |
|---|---|---|
| Kernel | Scheduling, memory, process isolation, device and interrupt mechanisms | Which functions are already supplied by Linux or another kernel? |
| IPC and capabilities | Communication, naming, authority and resource access | Which existing IPC and permission models are suitable? |
| Service/process supervision | Start, stop, dependency, health and recovery | Can Shepherd or another mature supervisor meet the need? |
| Shell and command language | Human command entry, composition, scripting and pipelines | Can POSIX shells, Guile or existing command tools be composed? |
| Utility services | Files, network, media, identity, storage and device operations | Which standard interfaces and user-space services already exist? |
| Event and I/O fabric | Bidirectional events, buffers, clocks, streaming and backpressure | Can PipeWire, D-Bus, sockets, V4L2 and established media APIs be reused? |
| Policy and authority | User consent, capability grants, audit and revocation | How are least privilege and human approval enforced? |
| Desktop/session | Display, input, window management and user session | Which existing compositor and desktop components can be integrated? |

A shell is not a kernel. A service supervisor is not a kernel. A microkernel architecture is not created merely by moving command utilities into separate processes.

## 3. Existing work to evaluate

The following are research candidates, not a preselected stack:

- **GNU/Linux:** practical baseline for current workstation and device support.
- **GNU Hurd:** distinct microkernel architecture with user-space servers and translators; evaluate actual hardware, driver, ABI and application constraints rather than assume Linux parity.
- **GNU Guix:** declarative system and package management, generations and reproducible environment practices.
- **Shepherd:** service supervision and dependency management within the Guix ecosystem.
- **Guile/Scheme:** programmable composition and user-level automation where it provides a bounded, maintainable responsibility.
- **FUSE:** user-space filesystem interface; evaluate its performance and security boundaries.
- **Genode:** component-oriented operating-system framework and capability architecture.
- **NetBSD rump kernels:** research into using kernel components in user-space contexts.
- **PipeWire:** graph-based audio/video routing and real-time media infrastructure.
- **D-Bus, Unix sockets and established IPC:** use fit-for-purpose interfaces rather than invent a universal message bus.

The candidate list is a starting point for evidence collection, not a claim that all components are compatible or should be combined.

## 4. Composability criteria

A component should be evaluated for:

1. **Explicit contract:** documented inputs, outputs, errors, versioning and state transitions.
2. **Replaceability:** alternative implementations can satisfy the same interface.
3. **Authority boundaries:** least privilege, capability scoping and revocation.
4. **Failure containment:** component failure does not silently compromise unrelated services.
5. **Observability:** logs, metrics, tracing and diagnostic state without unnecessary personal-data collection.
6. **Recovery:** restart, rollback, persistence and degraded-mode behaviour.
7. **Reproducibility:** versioned source, configuration, build inputs and test fixtures.
8. **Interoperability:** stable formats and protocols with documented transformations.
9. **Performance:** latency, jitter, throughput, resource use and backpressure measured against real workloads.
10. **Human control:** consequential operations require visible authority and explicit approval.

## 5. Real-time bidirectional I/O connection

The shell/service architecture must account for continuous data paths, not only request/response commands.

Relevant pipeline stages include:

**Capture → transport → buffer ownership → processing → synchronisation → rendering/output → feedback/control.**

For cameras, displays, audio and interactive systems, investigate established interfaces including V4L2, DMA-BUF, DRM/KMS, PipeWire, USB, PCIe, networking and conditional OpenXR. Record the exact hardware, kernel, driver and userspace versions.

Measure end-to-end latency, jitter, frame loss, timestamp accuracy, buffer contention, recovery and privacy behaviour. Throughput alone is not an adequate metric.

See the [WARENA real-time bidirectional I/O reference update](REALTIME-BIDIRECTIONAL-IO-REFERENCE-UPDATE-2026-11-27.md) and [camera/display/I/O at scale research](../CAMERA-DISPLAY-REALTIME-IO-SCALE-RESEARCH-2026-11-24.md).

## 6. Candidate architecture experiments

Do not begin by writing a new kernel. Run bounded comparative experiments:

- **Experiment A — Shell composition:** compose existing commands and Guile procedures with explicit structured data and predictable error handling.
- **Experiment B — Service lifecycle:** model a small Shepherd-managed service graph, dependency failures, restart policy and shutdown.
- **Experiment C — Resource boundary:** expose one existing resource through an established interface such as FUSE or a documented socket API; measure isolation and overhead.
- **Experiment D — Media path:** build a minimal V4L2-to-PipeWire/DRM path using existing components and measure timing.
- **Experiment E — Capability boundary:** demonstrate scoped read/write/device permissions and revocation for one service.
- **Experiment F — Reproducibility:** rebuild the same experiment from pinned inputs and compare artefact hashes and environmental differences.

Each experiment must include a baseline, hypothesis, source revisions, test environment, exact commands, logs, metrics, failure cases and limitations.

## 7. Decision gates

A new component or kernel-level mechanism is justified only if comparative evidence shows that mature existing systems cannot meet a clearly stated requirement.

Before implementation, answer:

- What specific user or engineering problem is unmet?
- Which mature projects and standards were evaluated?
- What measurable requirement do they fail?
- Is the gap architectural, operational, licensing-related or merely unfamiliarity?
- Can an adapter, service or configuration solve it without a fork?
- What is the maintenance, security and compatibility cost?
- Who will own long-term support and recovery?

## 8. Non-claims

This document does not announce a new operating system, kernel, shell implementation, microkernel, service framework or product. No performance, compatibility or production-readiness claim is made. All candidate technologies require upstream and platform-specific verification.

## 9. Ecosystem routing

- **WARENA:** operating-system, service, I/O and reproducible-systems research.
- **IKAI:** reflective environment and participant-directed interface research.
- **GENJE:** real-time creative interaction, livecoding and movement systems.
- **FELOH Corpus:** cross-domain architecture, evidence and provenance.
- **NAKEBUSEN:** sole commercial transaction interface; no proposed system becomes a live offer by appearing in this research.

**Freedom Is a System.**
