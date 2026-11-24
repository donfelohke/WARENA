# WARENA — Camera, Display and Real-Time I/O at Scale

**Date:** 24 November 2026  
**Owner:** WARENA / CAPABILITY  
**Status:** RESEARCH / ARCHITECTURE STUDY  
**Scope:** Native Linux camera acquisition, media transport, local processing, display presentation, timing and scale.  
**Relationship:** Extends the 22 November real-time I/O study; does not replace it.  
**Principle:** Reuse, adapt, interoperate and credit before inventing.

## 1. Executive position

A camera-to-display system is not one pipeline and should not be designed as one opaque application. It is a set of data paths with different timing, reliability and authority requirements:

- **Media data plane:** frames, samples and image buffers move through acquisition, processing and presentation.
- **Control plane:** configuration, start/stop, exposure, format negotiation, calibration and device lifecycle.
- **Human-authority plane:** explicit consent, capture enable/disable, visible state, override and acknowledgement.
- **Evidence plane:** timestamps, counters, configuration, faults and test results—without retaining personal media by default.

The engineering objective is not simply maximum frames per second. It is predictable end-to-end behaviour under bounded resource use, observable degradation and recoverable failure.

No hardware, driver, API stack, throughput target, latency target, benchmark or deployment is selected or claimed by this study.

## 2. A layered reference architecture

```text
Optics / Sensor
      |
      v
Kernel device + media graph
      |
      v
Camera acquisition / ISP
      |
      v
Timestamped buffer pool
      |
      +------> Local analysis / transformation
      |                    |
      |                    v
      +--------------> Composition
                           |
                           v
                    Display presentation
                           |
                           v
                    Human-visible output

Separate control: configure / authorise / stop / override / acknowledge
Separate evidence: timing / counters / faults / configuration / test record
```

Keep these boundaries explicit:

1. **Physical acquisition:** sensor, lens, exposure, readout and device interface.
2. **Kernel media topology:** entities, pads, links, formats and device-specific routing where applicable.
3. **Camera abstraction:** enumeration, stream configuration, controls, request lifecycle and device-specific pipeline handling.
4. **Buffer transport:** ownership, lifetime, fences/synchronisation, memory domain and copy/conversion points.
5. **Processing:** ISP, colour conversion, scaling, computer vision or other explicitly justified operations.
6. **Composition:** combine camera output with authored UI or overlays.
7. **Presentation:** display planes, modes, refresh and presentation timing.
8. **Orchestration:** lifecycle, policy, resource limits, supervision and recovery.

Do not make the application layer responsible for undocumented device quirks that belong in a driver or camera pipeline handler. Do not make the camera layer responsible for participant consent or the meaning of a displayed result.

## 3. Existing Linux interfaces and their proper roles

The following is a role map, not a stack selection.

| Interface / project | Appropriate role | What it does not prove |
|---|---|---|
| **V4L2** | Kernel userspace API for video devices, formats, controls and streaming queues | That two devices support the same formats, timestamp semantics or zero-copy path |
| **Media Controller API** | Describes and configures complex media-device topology | That every camera exposes an identical graph |
| **libcamera** | Higher-level camera framework; abstracts device-specific pipelines and exposes camera/stream/control models | That every sensor/ISP/platform is supported or that a particular Guix build exists |
| **DMA-BUF** | Shares buffers between devices through file descriptors where exporter/importer support and compatible layouts exist | Universal zero-copy, cache coherency, format compatibility or synchronisation |
| **PipeWire** | Graph-based media routing and scheduling between nodes | A camera driver, image-processing algorithm or guaranteed hard real-time system |
| **GStreamer** | Composable media pipelines, timestamped buffers, clocks, latency queries and synchronisation | That arbitrary pipeline elements preserve timestamps or meet a deadline |
| **DRM/KMS** | Kernel display modesetting, planes, connectors and atomic display-state commits | A complete compositor, application UI or guaranteed camera-to-photon latency |
| **EGL / GBM / Vulkan / OpenGL** | Candidate graphics and composition interfaces depending on hardware and stack | Interoperability across arbitrary drivers or permission to assume a browser/runtime |

### 3.1 V4L2 and Media Controller

V4L2 streaming uses queued buffers: userspace and the driver exchange buffer ownership rather than requiring a synchronous read for every frame. Memory-mapped and DMA-BUF modes have different allocation and ownership contracts. The exact queue type, pixel format, multi-planar layout, timestamp flags, field order and device capabilities must be queried at runtime.

For complex camera devices, the Media Controller graph matters. A sensor, receiver, ISP and scaler may be independently represented and linked. Record the actual media graph and negotiated formats; do not infer the topology from a product name.

### 3.2 libcamera as a camera abstraction candidate

libcamera provides a common camera-facing model while delegating hardware-specific configuration and execution to pipeline handlers. This is useful where an SoC camera path includes sensor, CSI receiver, ISP and output nodes. It should be evaluated against direct V4L2 access for each target:

- Does the platform have a maintained pipeline handler?
- Are all required sensor controls exposed?
- Are stream combinations and formats supported?
- What are the timestamp and request-completion semantics?
- Can the application obtain the metadata needed for calibration and evidence?
- What are the packaging, firmware and licence constraints?

Direct V4L2 may be appropriate for a simple UVC camera or a narrowly scoped device. libcamera may be preferable for supported complex camera pipelines. Neither should be mandated before hardware is known.

### 3.3 DMA-BUF and the zero-copy qualification

DMA-BUF can enable buffer sharing between devices, but “zero-copy” is a property of a measured end-to-end path, not a checkbox. Compatibility depends on:

- exporter and importer support;
- pixel format, plane layout, stride and modifier;
- allocation and memory domain;
- cache coherency and explicit/implicit synchronisation;
- fence availability and lifecycle;
- whether any element maps, converts, scales or copies the buffer;
- whether the display plane accepts the buffer layout.

Document every boundary as one of: shared buffer, imported buffer, CPU map, GPU conversion, copy, or unknown. A shared file descriptor does not prove that no internal copy occurs.

### 3.4 PipeWire and GStreamer are not interchangeable

PipeWire is a graph and routing/scheduling system. Its driver-node and quantum model are important for understanding processing cadence and the latency cost of asynchronous links. It may be useful when devices and applications need flexible graph connections.

GStreamer is a media-processing framework with explicit pipeline clocks, timestamps, segments and latency negotiation. Its live-source timing rules and latency queries are important when composing capture, transforms and sinks.

Choose based on the required topology and operations. A simple camera preview may not need both. Running both can be justified when PipeWire owns system routing and a GStreamer pipeline owns a particular media-processing graph, but the boundary, clock mapping and buffering must be measured rather than assumed.

### 3.5 DRM/KMS and presentation

DRM/KMS exposes display resources and atomic state changes. Atomic test-only commits can check whether a proposed display configuration is supported without applying the hardware change. This is useful for probing planes, formats and routing. It is not a promise that a particular overlay will be accepted or that a frame will be visible immediately.

For a mirror or kiosk, test the actual panel, connector, refresh mode, plane formats, scaling, colour path, compositor policy and display power state together. Record whether composition occurs in a compositor, GPU, display controller or a combination.

## 4. Timing model: clocks before latency claims

A pipeline can contain several clocks:

- sensor/device clock;
- kernel or driver timestamp clock;
- host monotonic clock;
- media-framework pipeline clock;
- audio-device clock;
- display/vblank clock;
- external motion or control-device clock.

Every timestamp must carry a documented clock domain and origin. If clocks differ, estimate offset and drift and record how they are mapped. Do not subtract timestamps from different domains without a validated conversion.

Separate these measurements:

1. **Exposure-to-buffer:** exposure/readout to completed capture buffer.
2. **Buffer-to-processing:** dequeue to processing completion.
3. **Processing-to-submit:** completed frame to display submission.
4. **Submit-to-photon:** display submission to visible panel update.
5. **Glass-to-glass:** physical scene change to visible displayed result.
6. **Control-to-visible-state:** user action to acknowledged and visible system state.
7. **Inter-stream skew:** difference between corresponding audio, video, sensor or movement events.

Report distributions, not just means: sample count, median, p95, p99, maximum, jitter definition, dropped frames and deadline misses. A high average frame rate can coexist with unacceptable tail latency.

For a live interactive preview, stale frames may be worse than dropped frames. A bounded latest-frame policy can be preferable to an unbounded FIFO. For recording or archival capture, completeness and ordered delivery may matter more than minimum latency. These are different workload contracts and should not share a queue policy by accident.

## 5. Scale: calculate the data movement first

For uncompressed video, the nominal payload rate is:

[
R = W 	imes H 	imes F 	imes B
]

where:

- (W) = pixels per frame horizontally;
- (H) = pixels per frame vertically;
- (F) = frames per second;
- (B) = bytes per pixel for the chosen packed representation.

This is a lower-bound payload estimate. Actual bus and memory traffic can be higher because of row stride, plane alignment, blanking/transport overhead, multiple reads and writes, format conversion, copies and additional consumers.

For (N) streams, a first-order aggregate is (sum R_i), but it is not a complete capacity model. Also account for:

- sensor/CSI lane or USB bandwidth and controller topology;
- PCIe or SoC interconnect bandwidth;
- memory bandwidth and contention with CPU/GPU/display;
- number of full-frame reads/writes per stage;
- simultaneous display scanout and composition;
- buffer-pool size and lifetime;
- ISP/GPU/CPU compute capacity;
- thermal throttling, power budget and sustained operation;
- storage bandwidth if recording is enabled;
- network bandwidth only if remote transport is explicitly required.

### 5.1 Buffering and queue depth

For a queue holding (Q) frames at frame rate (F), its nominal residence time is approximately:

[
T_Q approx Q/F
]

This is a useful first-order estimate, not a latency guarantee. Scheduling, queue policy, device buffering and synchronisation add further delay. Deep queues can absorb bursts but also make the displayed result stale. Bound queues and state the overload policy.

### 5.2 Scale dimensions

Scale should be tested along independent axes:

- **Spatial scale:** resolution, field of view, sensor count and display size.
- **Temporal scale:** frame rate, exposure, event rate and sustained duration.
- **Topological scale:** number of cameras, processors, displays and graph branches.
- **Data scale:** bytes per frame, number of consumers, recording and retention.
- **Operational scale:** hot-plug, restart, thermal conditions, device failure and recovery.
- **Human scale:** multiple users, physical controls, consent state and visibility of capture status.

A single-camera bench result does not qualify a multi-camera or multi-display system.

## 6. Workload profiles and queue contracts

| Profile | Primary objective | Queue / overload posture | Evidence |
|---|---|---|---|
| Mirror live preview | Fresh visible feedback | Bounded; discard stale frames where safe | Glass-to-glass latency, drops, jitter |
| Static mirror UI | Stable readable information | No camera queue required | Display timing, readability, thermal stability |
| Multi-camera observation | Time-aligned streams | Bounded per stream; explicit synchronisation | Inter-camera skew, clock drift, drop rates |
| Motion/choreography capture | Preserve authored movement record | Completeness and timestamp integrity | Missing/reordered samples, clock mapping |
| Live audiovisual performance | Align audio, visual and movement events | Explicit clock master and bounded buffering | Audio/video skew, underruns, event alignment |
| Recording/archive | Preserve complete data | Sustained throughput and storage integrity | Write rate, dropped data, checksums, recovery |
| Remote/federated transport | Tolerate network variation | Explicit jitter buffer and loss policy | Network latency/loss, local fallback |

No workload is approved merely because a framework supports its data type. Define the human task and acceptable failure mode first.

## 7. Proposed interface contracts

Keep device-specific details behind adapters and publish stable contracts between stages.

| Contract | Required fields / behaviour |
|---|---|
| Frame descriptor | Stream ID, sequence, format, dimensions, planes, stride, modifier, buffer handle and ownership |
| Timing descriptor | Timestamp, clock ID/domain, origin, precision and conversion provenance |
| Stream configuration | Requested and negotiated formats, frame interval, controls and capability result |
| Buffer lifecycle | Acquire, queue, complete, consume, release; cancellation and teardown semantics |
| Synchronisation | Fence or other mechanism, readiness, timeout and error behaviour |
| Back-pressure | Queue bound, drop/block policy, overload counter and recovery |
| Control command | Command ID, issuer/authority, target, requested state, acknowledgement and result |
| Privacy state | Capture enabled/disabled, visible indicator, purpose, retention and physical override state |
| Fault event | Device/process ID, timestamp domain, stage, code, severity, degraded mode and recovery |
| Evidence record | Host, hardware, kernel, driver, packages, config revision, test method and raw-result location |

The contracts are conceptual. They are not implemented APIs or a new proprietary protocol.

## 8. Failure handling and degraded modes

Design and test failures as normal system states:

- camera absent or hot-unplugged;
- stream configuration rejected;
- buffer starvation or queue saturation;
- timestamp discontinuity or clock provider loss;
- ISP/decoder/transform failure;
- display hot-unplug, mode change or plane rejection;
- process crash or service restart;
- thermal or power limit;
- capture disabled or consent withdrawn;
- storage full, if recording is explicitly enabled.

A safe fallback for the mirror is an ordinary usable reflection and/or a clearly defined static display state—not a blank system that hides why capture stopped. A failed sensor must not silently trigger another sensor or an alternate capture route.

## 9. WARENA implementation posture

- Prefer Linux-native interfaces and upstream-maintained components.
- Evaluate V4L2/Media Controller, libcamera, DMA-BUF, PipeWire, GStreamer and DRM/KMS as separate roles.
- Keep Guile/Scheme suitable for policy, orchestration, configuration and state management; use native interfaces for high-throughput device and graphics operations where justified.
- Do not require a browser engine, JavaScript runtime or web application architecture.
- Do not introduce a distributed system for a single-node workload without a demonstrated requirement.
- Keep Guix package availability, successful build, driver support, host installation and measured operation as separate evidence gates.
- Record upstream project, exact revision, licence, maintainers, local patches and test status.
- Do not claim hard real-time guarantees from a general-purpose Linux system without a defined deadline model and measured/analysed worst-case behaviour.

## 10. Validation programme

### Stage A — inventory and compatibility

1. Identify exact camera/sensor, display, host SoC, kernel and driver.
2. Record V4L2 capabilities, media graph, formats, frame intervals and controls.
3. Record libcamera support status if applicable.
4. Record DRM/KMS resources, plane formats/modifiers and display modes.
5. Record Guix package/channel availability and reproducible build result separately.

### Stage B — single-stream baseline

1. Capture synthetic target or non-identifying test chart.
2. Measure frame interval, timestamp continuity and dropped frames.
3. Display a known test pattern and measure presentation timing.
4. Measure capture-to-display latency using an explicitly documented method.
5. Repeat under idle and representative concurrent load.

### Stage C — buffer and graph study

1. Compare V4L2 MMAP and DMA-BUF where the device supports them.
2. Trace buffer ownership and all mapping/conversion/copy points.
3. Compare direct capture/display with candidate PipeWire or GStreamer routing.
4. Record queue depth, scheduling, CPU/GPU load and latency distribution.
5. Verify teardown, restart and hot-plug behaviour.

### Stage D — scale and endurance

1. Increase resolution and frame rate one variable at a time.
2. Add streams and graph consumers incrementally.
3. Record aggregate memory/bus traffic estimates and observed utilisation.
4. Run sustained tests with thermal and power observation.
5. Inject overload, device loss, clock discontinuity and display reconfiguration.
6. Verify bounded queues, visible degradation and recovery.

### Stage E — IKAI/GENJE integration boundary

1. IKAI defines the participant-facing task and optical/display requirements.
2. WARENA supplies qualified device, timing, transport and compute interfaces.
3. GENJE supplies authored movement/score/event semantics only where a creative task requires them.
4. FELOH Corpus records shared decisions and evidence provenance.
5. No sensing, motion interpretation or data retention is enabled by default.

No stage is complete until test conditions, raw evidence, failures and limitations are recorded.

## 11. Open questions before hardware selection

- Which exact sensor class and interface are required: USB UVC, MIPI CSI-2, depth, event camera or no camera?
- Is camera capture necessary for the first IKAI M1 demonstrator? The existing M1 specification says no camera is required for its baseline modes.
- Which SoC and ISP pipeline has maintained upstream support and reproducible Guix packaging?
- Does the chosen display controller expose the formats/modifiers needed for the intended composition?
- Can buffers be shared across the selected capture, processing and display devices without a conversion or copy?
- Which clock is authoritative for each workload, and how is drift measured?
- Which streams require synchronisation, and what is the task-specific tolerance?
- What is the required resolution/frame rate and the acceptable freshness/completeness trade-off?
- What are the real room, lighting, thermal and power constraints?
- What is the smallest demonstrator that can falsify the architecture cheaply?

Until these questions are answered, a detailed BOM or fixed framework stack would be premature.

## 12. Research conclusions

1. **Treat the system as a graph of contracts, not a monolithic camera app.**
2. **Keep media data, control, human authority and evidence as distinct planes.**
3. **V4L2, libcamera, DMA-BUF, PipeWire, GStreamer and DRM/KMS solve different problems.** Their combination must be justified by the target hardware and workload.
4. **Zero-copy and low-latency are measured end-to-end properties.** API support alone is insufficient.
5. **Scale is primarily a data-movement and scheduling problem.** Calculate payload, memory traffic, queue residence and thermal limits before choosing a platform.
6. **Freshness and completeness are different workload objectives.** Define the correct queue and loss policy for each.
7. **The M1 mirror baseline should remain camera-independent.** Optional sensing must earn its place through a specific, consented and testable requirement.

## 13. Sources and upstream references

All links below are upstream technical documentation. They support interface descriptions, not WARENA deployment claims. Recheck the selected release/version and target platform before implementation.

1. Linux Kernel Documentation — [V4L2 streaming I/O (memory mapping)](https://docs.kernel.org/userspace-api/media/v4l/mmap.html).
2. Linux Kernel Documentation — [V4L2 DMA-BUF importing](https://docs.kernel.org/userspace-api/media/v4l/dmabuf.html).
3. Linux Kernel Documentation — [DRM/KMS](https://docs.kernel.org/gpu/drm-kms.html).
4. libcamera — [Architecture](https://docs.libcamera.org/master/libcamera_architecture.html) and [Camera Model](https://docs.libcamera.org/master/public-api/camera-model.html).
5. PipeWire — [Graph Scheduling](https://docs.pipewire.org/page_scheduling.html) and [Latency Support](https://docs.pipewire.org/devel/page_latency.html).
6. GStreamer — [Clocks and Synchronisation](https://gstreamer.freedesktop.org/documentation/application-development/advanced/clocks.html), [Latency Design](https://gstreamer.freedesktop.org/documentation/additional/design/latency.html), and [Synchronisation Design](https://gstreamer.freedesktop.org/documentation/additional/design/synchronisation.html).

## 14. Related WARENA / IKAI / GENJE records

- [WARENA — Real-Time Bidirectional I/O and Display Pipelines (2026-11-22)](REALTIME-BIDIRECTIONAL-IO-AND-DISPLAY-PIPELINES-2026-11-22.md).
- [IKAI — Mirror Systems, Cameras, Displays and Real-Time Bidirectional I/O (2026-11-22)](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-REALTIME-BIDIRECTIONAL-IO-AND-MIRROR-SYSTEMS-2026-11-22.md).
- [IKAI M1 Engineering Validation Specification (2026-11-18)](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-MIRROR-M1-ENGINEERING-VALIDATION-2026-11-18.md).
- [GENJE — Kinetics, Livecoding & Reflective Interaction (2026-11-18)](https://github.com/donfelohke/Genje/blob/main/docs/KINETICS-LIVECODING-AND-IKAI-INTERACTION-2026-11-18.md).
- [WARENA Technology Constitution (2026-11-17)](TECHNOLOGY-CONSTITUTION-2026-11-17.md).
- [WARENA Stack Register](STACK-REGISTER.md).

---

**Status:** RESEARCH / ARCHITECTURE STUDY. No implementation, procurement, performance qualification or deployment is claimed.
