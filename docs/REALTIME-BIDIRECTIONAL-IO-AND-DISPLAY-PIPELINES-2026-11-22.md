# WARENA — Real-Time Bidirectional I/O and Display Pipelines

**Date:** 22 November 2026  
**Owner:** WARENA / CAPABILITY  
**Status:** RESEARCH / ENGINEERING STUDY  
**Principle:** Reuse, adapt, interoperate and credit before inventing.

## 1. Scope

This note studies the infrastructure required to connect cameras and other input devices, local compute, display systems and human controls at interactive rates. It supports IKAI's REFLECTION± research without taking ownership of the participant-facing mirror experience.

No hardware selection, performance benchmark, integrated device, production pipeline or host deployment is claimed.

## 2. Reference pipeline

**Capture → timestamp → transport → process → compose → present → observe/control → capture**

Keep the stages separable. Record data ownership, clock domain, buffer lifetime, queue depth, format conversion, memory copies, synchronisation and failure behaviour at every boundary.

| Layer | Engineering questions |
|---|---|
| Device acquisition | Camera/sensor interface, format, exposure, frame rate, timestamp source and hot-plug |
| Transport / IPC | Local API, shared memory or message passing; permissions, back-pressure and bounded queues |
| Timebase | Monotonic clocks, device timestamps, drift, frame synchronisation and event ordering |
| Processing | CPU/GPU/accelerator path, memory bandwidth, copy count, scheduling and thermal limits |
| Display | DRM/KMS or selected display stack, refresh, presentation timing, colour and luminance |
| Human control | Input events, consent state, physical disable, explicit authorisation and observable acknowledgement |
| Operations | Logging without sensitive capture, restart, degraded mode, recovery and reproducible configuration |

## 3. Candidate native interfaces

Evaluate existing interfaces rather than assuming a new framework is needed:

- **V4L2:** Linux video capture and device control.
- **DRM/KMS:** kernel display modesetting and presentation foundations.
- **PipeWire:** media graph and device routing.
- **GStreamer:** media pipeline composition and timestamped processing.
- **OpenXR:** native spatial/XR API candidate where the use case requires it; distinct from WebXR.
- **Guile/Scheme and Shepherd:** possible local orchestration and service supervision, subject to package/API feasibility.

These are candidates for source-grounded comparison, not a selected or tested production stack. Record upstream, maintainers, licence, exact version, hardware support, Guix packaging state, build/test results and limitations.

## 4. Measurement contract

For every end-to-end path, record:

- payload and representation (frame, sample, event, command or state);
- source and destination clock; timestamp origin and precision;
- expected and observed rate, throughput and queue depth;
- median, p95, p99 and maximum latency; jitter and deadline misses;
- dropped, duplicated, reordered or corrupted data;
- synchronisation error and drift over sustained operation;
- CPU/GPU load, memory bandwidth, copies, power and temperature;
- overload, device disconnect, process crash and recovery behaviour.

A single average frame rate is not a sufficient real-time qualification. Distinguish capture-to-display latency from control-to-state latency and from inter-device synchronisation.

## 5. Reproducible test sequence

1. Qualify each device and interface independently.
2. Establish a monotonic timebase and validate timestamp behaviour.
3. Measure each transport and processing stage with synthetic or non-sensitive test data.
4. Add camera-to-display loopback; measure glass-to-glass latency and frame loss.
5. Add a separate control path; measure command acknowledgement and visible state transition.
6. Sustain load and introduce controlled back-pressure, device loss and process restart.
7. Repeat from a pinned Guix environment and record hardware, kernel, packages, configuration and logs.
8. Publish only measured results with test conditions and limitations.

Do not capture identifiable people for performance tests when synthetic targets or test charts suffice.

## 6. Desktop and platform boundary

WARENA's desktop policy remains X11-first: X.Org baseline, XLibre compatibility experiment; Wayland/dwl-guile remains secondary and experimental. Do not assume that a candidate media/display API dictates the window-system choice. Qualify acquisition, media routing, composition, display server, window manager, shell and recovery independently.

## 7. Safety, authority and privacy

Human authority remains explicit. No hidden capture, biometric identity matching, person scoring, diagnosis or covert profiling. Minimise data, keep processing local by default, and define retention/deletion before collecting participant data. Vehicle or safety-critical control paths are outside this experimental pipeline unless separately safety-engineered and independently validated.

## 8. Relationship to IKAI and GENJE

IKAI owns reflective optics, mirror system design and participant-facing interaction. WARENA owns the enabling device, compute, timing, transport and reproducible infrastructure research. GENJE owns authored movement, choreography and creative interpretation. Shared interfaces must not erase domain ownership or creator attribution.

**Related:** [IKAI real-time bidirectional I/O and mirror systems](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-REALTIME-BIDIRECTIONAL-IO-AND-MIRROR-SYSTEMS-2026-11-22.md) · [WARENA stack register](STACK-REGISTER.md) · [Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md)
