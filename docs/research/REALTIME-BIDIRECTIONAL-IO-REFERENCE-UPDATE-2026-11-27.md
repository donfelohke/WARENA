# Real-Time Bidirectional I/O — Standards and Interface Update

**Date:** 27 November 2026  
**Status:** RESEARCH UPDATE / ARCHITECTURE GUIDANCE — no integrated pipeline or benchmark is claimed.  
**Scope:** Camera capture, shared buffers, media graph scheduling, display presentation, synchronization and reverse control paths.  
**Related:** [Camera, Display and Real-Time I/O at Scale](../CAMERA-DISPLAY-REALTIME-IO-SCALE-RESEARCH-2026-11-24.md) · [Real-Time Bidirectional I/O and Display Pipelines](../REALTIME-BIDIRECTIONAL-IO-AND-DISPLAY-PIPELINES-2026-11-22.md) · [Reproducible Systems and Real-Time I/O Validation](../REPRODUCIBLE-SYSTEMS-AND-REALTIME-IO-VALIDATION-2026-11-24.md).

## 1. Research finding

The strongest reusable Linux direction is not a new universal I/O framework. It is a set of existing subsystem contracts connected through explicit buffer, format, timing, synchronization and ownership boundaries:

- **V4L2** provides device-facing video capture/output and streaming buffer queues.
- **DMA-BUF** provides file-descriptor-based sharing of buffer allocations across supported devices and subsystems.
- **DRM/KMS** provides display configuration, planes, framebuffers, format/modifier constraints and atomic commits.
- **PipeWire** provides a graph model and scheduling infrastructure for media nodes, buffers, timing and real-time processing threads.
- **OpenXR** is a native XR API contract where an XR runtime is available; the specification does not itself supply a runtime.

These components solve different layers of the problem. None is a universal end-to-end pipeline, and their presence on a system does not prove that a particular camera, GPU, compositor, display or XR runtime can interoperate.

## 2. Forward media path: camera to display

A candidate path for a native Linux camera/display workload is:

1. **Capture negotiation:** query the V4L2 device capabilities, supported formats, dimensions, frame intervals, buffer types and streaming modes.
2. **Buffer allocation and ownership:** identify which component allocates each buffer and whether the camera acts as exporter or importer.
3. **Shared-buffer handoff:** where supported, exchange DMA-BUF file descriptors rather than copying pixel payloads through an application-owned staging buffer.
4. **Metadata contract:** preserve pixel format, plane count, per-plane stride and offset, modifier, dimensions, colour interpretation, timestamp and sequence information.
5. **Processing:** run the required transform in the CPU, GPU or media hardware only after confirming format compatibility, memory access rules and synchronization.
6. **Display import:** import the buffer into the display/compositor path only when the target DRM/KMS plane or renderer supports the format/modifier combination.
7. **Presentation:** record queueing, atomic commit, vblank/presentation timing and buffer-release behavior before reusing the allocation.

The Linux V4L2 DMABUF interface explicitly supports buffer sharing between video devices and other video-related devices such as DRM. The kernel's DMA-BUF documentation describes shared file descriptors and synchronization primitives. The kernel's pixel-buffer exchange guidance also warns that a non-empty intersection of format modifiers does not guarantee successful import: consumers can impose additional constraints.

**Important:** DMA-BUF is a sharing and synchronization mechanism, not a guarantee of zero-copy, zero-latency or universal interoperability. An implementation may still need format conversion, reallocation or a copy. Record when that occurs.

## 3. Buffer and synchronization contract

For each handoff, define the contract rather than assuming that a file descriptor is sufficient.

| Contract element | Required record |
|---|---|
| Allocation | Allocator, exporter/importer roles, lifetime and ownership |
| Format | FourCC or API format, dimensions, plane count and colour interpretation |
| Layout | Per-plane stride, offset, size and DRM modifier where applicable |
| Timing | Capture timestamp, clock identifier/domain, sequence number and timebase conversion |
| Synchronization | Fence or subsystem synchronization mechanism, acquire/release conditions and timeout behavior |
| Backpressure | Queue depth, buffer starvation, drop policy and recovery behavior |
| Completion | Consumer completion event and precise condition for safe buffer reuse |
| Failure | Unsupported format, failed import, stalled fence, device loss and fallback path |

DMA-BUF uses DMA fences and reservation objects to coordinate asynchronous hardware access. V4L2 buffer timestamps carry timing information, but the driver determines the clock and timestamp point. Therefore, timestamp interpretation and clock-domain conversion must be explicit in a multi-device pipeline.

Do not reuse a buffer merely because a consumer received its file descriptor. Reuse only after the relevant ownership and completion conditions are satisfied.

## 4. PipeWire's role

PipeWire is a candidate media-graph layer, not a replacement for V4L2, DMA-BUF or DRM/KMS.

Its graph is built from linked nodes and ports. The scheduling documentation describes a main thread for IPC/configuration and one or more data-processing threads, with node resources such as buffers and I/O areas prepared in shared memory. Driver nodes initiate graph cycles; dependency links coordinate processing; asynchronous and lazy scheduling alter when nodes run.

Architecture implications:

- Use PipeWire where graph routing, negotiation, session integration or multi-client media flow is actually required.
- Keep the device-facing capture and display interfaces visible in the system design.
- Record the selected graph driver, quantum/rate, node scheduling properties, buffer negotiation and clock behavior.
- Treat asynchronous nodes as a deliberate scheduling decision; they do not automatically provide deterministic completion.
- Measure scheduling and buffer behavior on the target host. A real-time processing thread is not proof that the whole path meets a latency target.

Do not introduce PipeWire as an obligatory dependency for a narrowly scoped capture-to-display path if direct native interfaces meet the workload with fewer moving parts.

## 5. Reverse path: display/input to capture and control

“Bidirectional” must describe more than a video stream travelling in one direction. Model two connected paths:

**Media/data plane**
- Capture frames and sensor observations.
- Transform and compose data.
- Present output and record presentation timing.
- Return completion and buffer-release events.

**Control/feedback plane**
- User input and explicit interaction events.
- Camera exposure, focus, gain and capture controls where supported.
- Display mode, plane and presentation configuration.
- Sensor state, calibration and device health.
- Pause, stop, privacy shutter and capture-permission state.
- Backpressure, error and recovery signals.

Every control event needs an origin, timestamp/timebase, target, authority, acknowledgement and failure outcome. Avoid hidden continuous capture or control paths that bypass the participant/operator's visible decision.

For IKAI, a reflective environment should not be treated as a camera pipeline alone: display output, user input, sensor observations, local processing and participant-controlled state form a closed interaction system. Capture must remain purpose-limited, visible and revocable.

## 6. OpenXR boundary

OpenXR is a native API standard for XR applications and runtimes. It defines an interface; it does not itself provide a runtime implementation. Treat it as an integration candidate only where the target device and runtime support the required features.

- OpenXR is not WebXR.
- The API specification is not a headset driver, compositor, sensor stack or deployed XR system.
- Record the runtime, device, API version, extensions, graphics binding and conformance status separately.
- Do not add OpenXR to a system merely because a workload is spatial; first test whether native display/input APIs are sufficient.

## 7. Validation programme

Use a small, reproducible test matrix before claiming an integrated path.

### A. Capability and negotiation
- Enumerate V4L2 capture/output formats, sizes, intervals and buffer modes.
- Enumerate DRM/KMS planes, formats, modifiers, atomic capabilities and display modes.
- Record PipeWire nodes, ports, negotiated formats, graph driver and quantum where used.
- Record available OpenXR runtime and extensions only when an XR device is in scope.

### B. Buffer lifecycle
- Test exporter/importer combinations and multi-planar layouts.
- Verify file-descriptor lifetime, ownership transitions and release events.
- Exercise unsupported modifiers, allocation failure and import failure.
- Confirm that buffers are not reused before consumer completion.

### C. Timing and real-time behavior
- Record capture timestamp source, presentation timestamp and clock-domain mapping.
- Measure capture-to-display latency and each stage's contribution.
- Report p50, p95, p99 and maximum latency, jitter, sample count and measurement uncertainty.
- Track dropped/duplicated frames, queue depth, underruns, missed presentation deadlines and recovery.
- Test sustained operation, thermal/load variation and reconnect/device-loss behavior.

### D. Bidirectional interaction
- Measure input-event-to-visible-response latency.
- Verify camera-control acknowledgement and actual device state.
- Test pause/stop/privacy controls under load.
- Verify that capture and processing stop when permission is revoked or the session ends.

### E. Reproducibility
- Record host, kernel, driver, firmware, compositor, library and runtime versions.
- Preserve test source, fixtures, configuration, logs and raw measurements.
- Repeat on the same host and a second compatible host where feasible.
- Mark unsupported combinations as unsupported; do not silently substitute a copy path without recording it.

No performance target is claimed by this document. Targets must be defined by the workload and measured on named hardware.

## 8. Decisions and non-decisions

**Adopt as architecture guidance**
- Keep V4L2, DMA-BUF, DRM/KMS and PipeWire responsibilities distinct.
- Make format, plane, clock, fence, ownership and completion metadata explicit at every handoff.
- Treat capture/display and reverse control as separate but coordinated planes.
- Validate the exact hardware/driver combination before choosing a zero-copy or low-latency claim.
- Preserve local operation, operator authority, privacy and recovery.

**Not decided**
- A universal pipeline framework.
- A single mandatory media graph implementation.
- A specific camera, sensor, display or GPU.
- An end-to-end latency target.
- A production deployment or validated integrated prototype.
- An OpenXR runtime or XR hardware platform.

## 9. Primary references

Accessed 27 November 2026. Prefer the current official documentation for the target kernel/library release when implementing.

1. Linux Kernel Documentation — [V4L2 Streaming I/O: DMA-BUF importing](https://docs.kernel.org/userspace-api/media/v4l/dmabuf.html).
2. Linux Kernel Documentation — [Exchanging pixel buffers](https://docs.kernel.org/userspace-api/dma-buf-alloc-exchange.html).
3. Linux Kernel Documentation — [Buffer Sharing and Synchronization (DMA-BUF)](https://docs.kernel.org/driver-api/dma-buf.html).
4. Linux Kernel Documentation — [V4L2 Buffers and timestamps](https://docs.kernel.org/userspace-api/media/v4l/buffer.html).
5. Linux Kernel Documentation — [DRM/KMS](https://docs.kernel.org/gpu/drm-kms.html) and [GPU Driver Developer's Guide](https://docs.kernel.org/gpu/).
6. PipeWire — [Graph Scheduling](https://docs.pipewire.org/page_scheduling.html).
7. Khronos Group — [OpenXR Registry and API specifications](https://registry.khronos.org/OpenXR/).
8. Khronos Group — [What is OpenXR?](https://github.com/KhronosGroup/OpenXR-Guide/blob/main/chapters/what_is_openxr.md).

**Evidence note:** this is a source-grounded architecture update. It does not claim that any named device or complete pipeline has been built, measured or validated.
