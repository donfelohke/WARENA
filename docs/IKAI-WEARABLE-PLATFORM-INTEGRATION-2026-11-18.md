# WARENA — IKAI Wearable Platform Integration

**Date:** 18 November 2026  
**Status:** RESEARCH / SYSTEMS INTEGRATION PLAN  
**Owner:** WARENA owns infrastructure and operational integration; IKAI owns reflective-computing interaction and privacy requirements.

## Purpose

Define the WARENA responsibilities required to support IKAI's proposed voice-only and visual-AR wearable research without turning WARENA into an IKAI product owner or claiming an operational platform.

**IKAI decisions:** both voice and visual wearables; hybrid local/remote intelligence; central first-class display philosophy. **WARENA remains the configuration and systems home.**

## Responsibility boundary

| Layer | Owner | WARENA contribution |
|---|---|---|
| Participant experience and reflective interaction | IKAI | Implementable service contracts only |
| Consent, purpose and memory semantics | IKAI, with Corpus governance | Enforceable local policy primitives |
| GNU/Linux host, Guix and RDE | WARENA | Reproducible host and service configuration |
| Service lifecycle | WARENA | Shepherd supervision and recovery |
| Native IPC and device adapters | WARENA integration | Unix sockets; D-Bus only where useful |
| Audio/media plumbing | WARENA integration | PipeWire and GStreamer qualification |
| XR runtime and graphics | Shared research | OpenXR/native API qualification |
| Local inference | WARENA platform / IKAI policy | Resource scheduling; no authority to bypass IKAI permissions |
| Remote inference | Optional external boundary | Egress control, credentials and documented retention |
| GENJE movement / creative practice | GENJE | Not a WARENA subsystem or commercial product |

## Reference node architecture

1. **Wearable endpoint:** voice or display device with documented interfaces and observable capture state.
2. **Companion:** pairing, transport, status, fallback controls and device-specific adapters.
3. **IKAI core:** Guile-governed session and permission policy.
4. **WARENA host:** Guix/RDE environment, Shepherd services, local media and optional local inference.
5. **Remote gateway:** disabled by default; explicit per-task routing only.

The WARENA host must not silently become the owner of participant records. IKAI defines the data contract and participant controls; WARENA provides secure storage primitives and operational evidence.

## Candidate infrastructure stack

| Concern | Candidate | Qualification |
|---|---|---|
| System and configuration | GNU Guix + RDE | Pin channels and source revisions; confirm package availability |
| Service supervision | Shepherd | Start/stop, restart limits, logs and dependency ordering |
| Policy orchestration | GNU Guile | Session state, permission checks, routing decisions |
| Local persistence | SQLite | Schema, export/delete and backup/restore tests |
| IPC | Unix sockets; D-Bus selectively | Authentication, message schema, peer identity and lifecycle |
| Audio graph | PipeWire | Device routing, mute state, latency and disconnect recovery |
| Media pipeline | GStreamer | Codec, camera/audio source, buffering and memory ownership |
| Native UI | GNUstep / Objective-C | Companion/desktop integration research |
| Spatial runtime | OpenXR | Exact runtime/device support must be proven |
| Graphics | Native graphics stack | X11-first host policy does not itself qualify an XR runtime |

WARENA's desktop policy remains X11-first for workstation sessions: X.Org baseline, XLibre compatibility experiment, Gershwin and Guile-WM/WM-NG research tracks, Sway comparison/recovery baseline, Wayland/dwl-guile secondary/experimental. Do not infer that the desktop policy decides the headset runtime. XR runtime qualification is a separate device-level workstream.

## Operational interfaces and controls

- Every service declares inputs, outputs, privileges, data classes and shutdown behaviour.
- Wearable adapters must report connection, battery, mute/capture state and supported capabilities.
- A lost connection or expired permission terminates capture and cancels outstanding jobs.
- Local and remote inference are separate backends behind an IKAI-controlled router.
- Remote calls require an explicit purpose, payload classification, consent token, destination and retention statement.
- No API key or participant record is stored in source control.
- No raw media is retained by default; logs record lifecycle and policy events, not content.
- Build and deployment records include Guix channel revisions, package derivations, hardware/firmware, test logs and rollback instructions.

## Guix/Scheme implementation sequence

1. Add no new repository: WARENA remains the configuration home.
2. Prototype a Guile service contract and deterministic mock wearable.
3. Supervise local services with Shepherd and communicate over Unix sockets.
4. Qualify SQLite persistence, export, deletion and backup/restore using synthetic data.
5. Qualify PipeWire/GStreamer with one audio endpoint.
6. Add OpenXR only after an exact target device and runtime are selected.
7. Package dependencies in Guix; record upstream versus local patches and substitute availability.
8. Integrate with IKAI through versioned interfaces, not shared mutable internal state.

No production package, Guix service, headset integration or host deployment is asserted by this plan.

## Acceptance gates

- [ ] Source and licence audit for every dependency.
- [ ] Guix build or documented blocker for each selected component.
- [ ] Service least-privilege and lifecycle tests.
- [ ] IPC authentication and malformed-message tests.
- [ ] Audio mute, disconnect, crash and restart tests.
- [ ] Remote-egress deny-by-default test.
- [ ] Export, deletion and restore tests with synthetic data.
- [ ] Reproducible environment record and recovery procedure.
- [ ] IKAI review of consent and participant-data semantics.

## Non-goals

No new `warena-rde` repository, no upstream mutation, no cloud-first architecture, no JavaScript runtime, no browser application shell, no autonomous agent with unrestricted host access, and no claim of a validated smart-glasses product.

See the [IKAI voice and smart-glasses architecture](https://github.com/donfelohke/Ikai/pull/22) for participant-facing contracts and threat model.
