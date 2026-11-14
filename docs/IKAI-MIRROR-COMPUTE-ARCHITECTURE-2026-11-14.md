# IKAI MIRROR+ — WARENA Compute and Systems Architecture

**Date:** 2026-11-14  
**Status:** RESEARCH / ARCHITECTURE EXPLORATION  
**Ownership:** WARENA owns infrastructure and implementation research; IKAI owns participant-facing reflective experience.  
**Deployment:** No target hardware, production host, runtime or operational service is approved or evidenced by this note.

## 1. Systems problem

Treat IKAI MIRROR+ as a local spatial-computing node, not as a smart-mirror appliance. The system may combine optical output, spatial perception, rendering, interaction, local memory and optional federation. These concerns must remain modular so the display, sensor suite, runtime and host can be replaced independently.

The infrastructure must preserve WARENA's existing rules: local-first operation, inspectable software, reproducible configuration, human-controlled authority, optional networking, explicit status and recoverability.

## 2. Proposed system decomposition

```text
Physical surface / room / lighting
             |
     Input and sensing adapters
             |
  Calibration + spatial registration
             |
      Scene / state model
             |
   XR or desktop composition layer
             |
      Renderer / display output
             |
       IKAI participant UI
             |
  Local files + SQLite operational index
             |
 Guix system / Shepherd / backup / recovery
             |
    Optional authorized federation
```

This is a decomposition to test, not an implementation diagram.

### Boundaries

- **Device adapters:** isolate display, camera, depth, IMU, audio and input hardware behind replaceable interfaces.
- **Spatial services:** calibration, coordinate frames, tracking confidence, persistence and relocalisation.
- **Graphics:** rendering, composition, scene representation and frame scheduling.
- **Application runtime:** IKAI experience and conventional desktop applications; avoid making business logic depend on one compositor or XR runtime.
- **Data:** authoritative files and source artefacts; SQLite may serve as a rebuildable operational index, not the sole archive.
- **Operations:** Guix-managed packages/configuration, Shepherd services where appropriate, logs, backup, rollback and offline recovery.
- **Network:** optional and subordinate to local operation; federation only after authorization and conflict semantics are explicit.

## 3. Historical software and reuse policy

MAVERIK and DEVA/DEVA3 are not automatically obsolete because they are old. Evaluate them by source survival, licence, provenance, architecture, dependency closure, buildability, interface boundaries, performance, maintenance burden and revival cost.

- **MAVERIK:** historical rendering/interaction micro-kernel candidate. The 1999 paper documents multiple environment representations, application callbacks, large-model processing and customizable interaction/navigation.
- **Deva:** described in that paper as a higher-level environment supporting multi-user distributed shared and persistent concurrent environments.
- **DEVA3:** a separate research lead for distributed synchronization; exact source and primary paper still require verification.

Do not port code or copy substantial source until the exact licence and provenance are confirmed. Prefer extraction of useful abstractions where direct revival is not viable.

## 4. Candidate technology families

| Concern | Candidate families | WARENA evaluation |
|---|---|---|
| XR interface/runtime | OpenXR, Monado | Device/extension support, compositor integration, maturity and test coverage |
| Scene interchange | OpenUSD, scene graphs | Dependency footprint, authoring tools, interchange and versioning |
| Rendering | Vulkan/OpenGL and historical MAVERIK study | Driver support, hardware acceleration, latency, reproducibility |
| Desktop application integration | X11, Wayland, Xpra and native application composition | Window lifecycle, input, focus, clipboard, multi-display and fallback |
| Spatial perception | OpenCV, AprilTag, depth/stereo and SLAM systems | Calibration, drift, occlusion, compute cost and data locality |
| Coordinate transforms | ROS 2 TF2 as a reference model | Whether a robotics framework is warranted or only its transform concepts |
| Runtime and services | GNU Guix, Guix Home, Shepherd, Guile | Package availability, service boundaries, declarative rebuild and recovery |
| Local state | Files, SQLite, structured event/provenance records | Portability, audit, export, retention and recovery |
| Media | PipeWire and spatial audio | Device support, synchronization and local processing |

These are research candidates, not approved stack selections. No single framework should be added merely because it is associated with XR.

## 5. Hardware qualification — no premature BOM

A reference node may eventually require:

- compute with suitable CPU/GPU/video acceleration;
- display or projection hardware matched to optical requirements;
- optional RGB/depth/stereo sensing only where justified;
- explicit input devices and physical disable controls;
- audio hardware only for defined interaction tasks;
- lighting and mounting designed for measured room conditions;
- power conditioning, thermal management and safe service access;
- local storage with tested backup and recovery.

Do not select RK3568/RK3588, x86-64 mini-PC, workstation GPU or any specific board without task-based benchmarks and driver evidence. A general workstation and an embedded mirror node may be separate roles.

## 6. Qualification gates

Before a component is promoted beyond RESEARCH:

1. Exact upstream project, version, commit and licence recorded.
2. Build dependencies and Guix availability checked; package presence is not installation.
3. Hardware acceleration and device support demonstrated on named hardware.
4. Calibration, frame latency, thermal load and sustained operation measured.
5. Offline operation and failure recovery tested.
6. Network traffic and data flows inspected.
7. Configuration can be reproduced and rolled back.
8. IKAI participant-control and privacy requirements reviewed.

## 7. Research tasks

- Recover and inspect MAVERIK source archives; compare release history and build dependencies.
- Locate primary DEVA3 papers and surviving source or demonstrators.
- Compare OpenXR/Monado with desktop-native and non-XR interaction paths.
- Survey OpenUSD and lighter scene-graph options against actual content needs.
- Benchmark camera/fiducial registration on synthetic data before human sensing.
- Compare display and compute options only after optical and interaction requirements are measurable.

## 8. Related records

- [FELOH Corpus landscape and cross-project decisions](https://github.com/donfelohke/feloh-corpus/blob/main/research/ikai-mirror-spatial-computing-landscape-2026-11-14.md)
- [IKAI participant-facing spatial research](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-MIRROR-SPATIAL-RESEARCH-2026-11-14.md)
- [WARENA stack register](./STACK-REGISTER.md)
- [WARENA desktop architecture](./DESKTOP-ARCHITECTURE.md)

**No deployment or procurement authorization is implied.**
