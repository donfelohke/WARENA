# IKAI / WARENA — XR Platform and Development Compatibility Matrix

**Date:** 2026-11-18  
**Status:** RESEARCH / COMPATIBILITY PLAN  
**Authority:** WARENA owns platform, runtime, SDK, graphics, build and device integration; IKAI owns participant-facing reflective experience.  
**Policy:** Subject to [WARENA Technology Constitution](./TECHNOLOGY-CONSTITUTION-2026-11-17.md).  
**Deployment:** No XR device, runtime, SDK, engine, IDE, Guix package set, prototype or host deployment is claimed.

## 1. Executive decision

Use **native OpenXR as the interoperability API to investigate first**, with a small native C/C++ application as the baseline. Evaluate **Monado as the Linux runtime**, not as an SDK or engine. Keep Android XR as a compatibility target through its OpenXR 1.1 implementation, subject to device-specific extension and permission review.

Do not select an engine before the native baseline works. Godot is a possible secondary application framework, not an approved dependency. Blender is an authoring and asset-production tool, not an XR runtime.

This plan explicitly excludes JavaScript, Node.js, Electron, WebXR, WebGL, browser-hosted application shells and web-first UI frameworks from WARENA/IKAI application architecture. VSCodium / Visual Studio Code is therefore not a recommended IDE: its standard distribution is Electron-based. Static web documentation and external source browsers are not application runtimes and remain outside this restriction.

## 2. Existing repository evidence and ownership

The current repositories already establish the following:

- IKAI is research / work in progress, not a released product.
- A mirror is one possible interface, not the definition of IKAI; a head-mounted display is not a prerequisite.
- WARENA owns compute, graphics/runtime integration, hardware, Guix, reproducibility, networking and recovery.
- IKAI owns participant-facing reflective experience.
- GENJE owns movement, choreography and creative practice.
- FELOH Corpus owns shared terminology, governance, provenance and evidence.
- No working mirror, validated sensor pipeline, motion-tracking accuracy or deployed XR system is claimed.

Relevant records:

- [IKAI spatial-computing research](https://github.com/donfelohke/Ikai/blob/main/docs/IKAI-MIRROR-SPATIAL-RESEARCH-2026-11-14.md)
- [WARENA compute and systems architecture](./IKAI-MIRROR-COMPUTE-ARCHITECTURE-2026-11-14.md)
- [Technology Constitution](./TECHNOLOGY-CONSTITUTION-2026-11-17.md)
- [WARENA stack register](./STACK-REGISTER.md)
- [IKAI privacy model](https://github.com/donfelohke/Ikai/blob/main/docs/privacy-model.md)

## 3. Platform and runtime matrix

| Candidate | Role | Policy fit | Current evidence / limitations | Disposition |
|---|---|---|---|---|
| Khronos OpenXR 1.1 | Native cross-vendor XR API | Strong: native API; C/C++ | SDK 1.1.65 and specification 1.1.65 are published (2026-10-16). API support does not guarantee a runtime/device supports a given extension. | **PRIMARY API RESEARCH** |
| Monado | Open-source OpenXR runtime | Strong: source-visible Linux/Android runtime | Project describes Linux and Android development. Linux hardware support is device/driver-specific; its compositor requires suitable Vulkan extensions. No WARENA device qualification exists. | **PRIMARY LINUX RUNTIME CANDIDATE** |
| Android XR | Android spatial platform and OpenXR target | Conditional: native OpenXR path fits; inspect every vendor extension | Official guidance states OpenXR 1.1 support plus selected extensions. Android XR features include spatial entities, anchors, tracking and passthrough; availability is device-specific. | **ANDROID COMPATIBILITY TARGET** |
| Meta Quest / Horizon OS | Android-based headset ecosystem | Conditional: native OpenXR path; vendor SDK and firmware require review | OpenXR and vendor-specific extensions; hardware, loader and store requirements vary by model. No target headset selected. | **LATER DEVICE TARGET** |
| SteamVR | PC XR runtime / ecosystem | Conditional: native OpenXR API; proprietary platform | Useful as an external runtime comparison, but not a default WARENA runtime or dependency. | **COMPARATOR ONLY** |
| WebXR | Browser XR API | **Excluded** by current policy | Web technology and browser runtime dependency. | **REJECTED FOR IKAI ARCHITECTURE** |
| WebGL / Three.js | Browser graphics / engine layer | **Excluded** by current policy | JavaScript and browser application stack. | **REJECTED FOR IKAI ARCHITECTURE** |

### Important API/runtime distinction

An OpenXR application normally links to the Khronos OpenXR loader and uses SDK headers. The loader discovers and connects the application to an installed OpenXR runtime such as Monado. The SDK, loader, runtime, vendor driver and headset are separate components and must be versioned and qualified separately.

## 4. SDK and native toolchain matrix

| Component | Responsibility | Proposed use | Qualification |
|---|---|---|---|
| OpenXR-SDK | Headers, loader, generated API components and development layers | Native application build | Pin SDK release and source hash; test loader/runtime discovery |
| OpenXR-SDK-Source | SDK source, registry-derived material, examples and API layers | Source audit, validation and sample builds | Larger build dependency closure; keep separate from runtime |
| OpenXR-CTS | Conformance test suite | Runtime/API conformance evidence | A passing subset or sample run is not full device qualification |
| Monado | OpenXR runtime and device/compositor integration | Linux runtime experiment | Record driver, GPU, Vulkan extension support and headset |
| Vulkan SDK / loader / validation layers | Graphics API development and diagnostics | Native rendering path | Separate SDK tooling from target GPU driver and runtime |
| OpenGL | Alternative native graphics path | Compare where driver/runtime support warrants | Check required interop extensions and performance |
| CMake + Ninja | Native build orchestration | Reproducible application and dependency builds | Pin toolchain and generated build configuration |
| GCC / Clang | Native C/C++ compilation | Preferred implementation languages | Record compiler version, target triple and flags |
| GDB / LLDB | Native debugging | Application and runtime diagnostics | Validate symbols and reproducible debug build |
| RenderDoc | GPU frame capture and graphics debugging | Optional graphics diagnostics | Hardware/driver compatibility must be checked |
| Python | Bounded research and asset/test tooling | Data conversion, test automation and analysis | Not a mandatory runtime dependency |

**Current upstream snapshot:** Khronos OpenXR SDK and specification 1.1.65 were published on 2026-10-16. Treat 1.1.65 as a research pin, not an automatic production pin. Re-check the registry and release signatures when locking sources.

## 5. Engine and content pipeline matrix

| Tool / format | Correct role | Policy / engineering assessment | Disposition |
|---|---|---|---|
| Native OpenXR C/C++ | Direct API baseline | Smallest way to expose loader, runtime, swapchain, input and graphics issues without engine abstractions | **BUILD FIRST** |
| Godot | Optional application engine | OpenXR integration exists. It introduces engine, renderer and scripting choices; evaluate GDScript/C# as bounded non-Scheme components. Do not introduce JavaScript modules or browser export paths. | **SECONDARY EVALUATION** |
| Godot C++ GDExtension | Native extension path | May keep critical application logic in C++; does not remove the engine/runtime dependency or replace native OpenXR baseline. | **OPTIONAL SPIKE** |
| Blender | 3D authoring, rigging, animation, procedural geometry | Useful for loc and movement assets; not the runtime or IDE for the XR application | **AUTHORING CANDIDATE** |
| glTF / GLB | Portable runtime asset interchange | Candidate for meshes, materials, skeletons and animation; verify importer and licence/provenance of assets | **FIRST FORMAT TO TEST** |
| OpenUSD | Composable scene description and complex asset interchange | Powerful but potentially excessive dependency and complexity for the first prototype | **LATER RESEARCH** |
| OpenSceneGraph / other native scene graphs | Native rendering abstraction | Compare only if direct OpenXR + Vulkan/OpenGL code becomes too costly | **ALTERNATIVE STUDY** |

Do not assume that a file format, authoring tool or engine solves spatial registration, tracking accuracy, calibration, data governance or participant consent.

## 6. IDE and developer workstation

### Preferred native-first profile

| Tool | Role | Status |
|---|---|---|
| GNU Emacs + Geiser | Primary editor, Scheme/Guile integration, Org research notes | Preferred WARENA environment |
| GCC / Clang toolchain | C/C++ build | Required for native baseline |
| CMake + Ninja | Build and test orchestration | Candidate baseline |
| GDB / LLDB | Debugging | Candidate baseline |
| Android SDK command-line tools + NDK | Android cross-build and deployment | Required only for Android target |
| Android Studio | Optional Android GUI IDE and device tooling | Convenience tool; not the architecture or mandatory editor |
| Blender | Asset authoring workstation | Optional, task-dependent |
| Godot Editor | Engine scene/script authoring | Only if Godot passes the secondary evaluation |

Do not make an Electron-based editor, JavaScript language server, Node-based build step or web UI dependency part of the WARENA environment. Any additional non-Scheme component needs a bounded responsibility, interface contract, provenance, dependency cost, tests and replacement path.

## 7. Host and target profiles

### Profile L — Linux native development

- GNU Guix + RDE as the intended configuration research foundation.
- Native C/C++ OpenXR application.
- Khronos loader and headers.
- Monado as the runtime candidate.
- Vulkan first where supported; OpenGL as a measured alternative.
- CMake + Ninja, GCC/Clang, GDB/LLDB.
- X.Org is the WARENA initial X11 compatibility baseline; XLibre is a separate qualification path.
- Do not assume desktop session choice determines XR runtime support. Test direct-mode and windowed/composited paths independently.

### Profile A — Android XR development

- Android SDK command-line tools, platform tools / ADB, NDK and a pinned JDK.
- Native C/C++ application using OpenXR.
- Device/vendor loader and runtime requirements recorded per target.
- Android XR OpenXR 1.1 feature and extension matrix recorded per device.
- Android Studio is optional for GUI debugging and device management.
- No Kotlin/Compose dependency is required for the native OpenXR baseline. If a native Android framework is later proposed, document its bounded role and policy fit separately.

### Profile S — Synthetic / desktop simulation

- No headset or human sensor data required.
- Use synthetic scene geometry, simulated poses and test input.
- Test coordinate transforms, frame lifecycle, input actions, asset loading, event recording and recovery.
- Use this profile before hardware procurement or participant sensing.

## 8. Android XR and privacy extension gate

Android XR documents OpenXR 1.1 support and selected extensions. The presence of a platform capability does not make it appropriate for IKAI.

| Capability | IKAI position |
|---|---|
| Spatial entities / planes / anchors | Candidate for object- or room-relative placement, subject to local processing and consent |
| Image / marker tracking | Candidate for fiducial calibration using synthetic or non-personal markers |
| Hand tracking | Optional only where a defined task benefits; explicit permission and visible activation |
| Eye tracking | Not part of the baseline; requires a separate necessity and privacy review |
| Face tracking | Excluded from the IKAI baseline |
| Body tracking | Excluded from the IKAI baseline unless a separately approved, participant-directed movement study demonstrates necessity |
| Emotion, identity, diagnosis or capability inference | Prohibited |
| Passthrough camera | Off by default; task-specific, visible and revocable if ever evaluated |
| Cloud/geospatial anchors | Not required; external processing and location transmission need separate authorization |

The first prototype should use manually entered records, synthetic movement and fiducials rather than identifying or continuously recording people.

## 9. Guix and reproducibility status

**No current Guix package availability, successful build, installed runtime or device deployment has been verified by this matrix.** The WARENA stack register correctly requires upstream version, Guix channel revision, package result, host, resolved configuration, verification observation and recovery evidence as separate fields.

Before packaging, inventory the exact Guix 1.5.0 channel state and determine whether the following are already packaged, need a channel update, need a WARENA package, or are unsuitable:

- OpenXR SDK loader, headers, API layers and utilities;
- Monado runtime and its optional drivers;
- Vulkan loader, headers, validation layers and GPU-driver interface;
- CMake, Ninja, GCC/Clang, GDB/LLDB;
- optional RenderDoc;
- Android SDK / NDK / platform tools and JDK;
- optional Godot and Blender.

Do not assume Android SDK licensing or redistribution terms fit a fully libre Guix closure. Keep proprietary device firmware, vendor runtimes and nonfree drivers explicitly identified rather than silently absorbing them into the system profile.

## 10. Setup and configuration sequence

1. **Inventory** — identify target host GPU, driver, kernel, display path, available storage and whether a headset exists. No hardware purchase yet.
2. **Pin sources** — record OpenXR SDK/spec release, Monado commit, compiler, CMake/Ninja, Vulkan stack and source hashes.
3. **Guix package audit** — inspect the exact Guix channel; record package presence separately from build/install status.
4. **Native hello_xr** — build the Khronos sample with CMake/Ninja; inspect loader diagnostics and runtime discovery.
5. **Monado** — build/install only in a disposable test profile; verify Vulkan extensions, runtime manifest selection and device enumeration.
6. **Synthetic application** — create a minimal C/C++ app with session lifecycle, one reference space, input actions and a simple rendered scene.
7. **Graphics validation** — record frame timing, GPU use, validation-layer output and sustained stability.
8. **Android target** — only after a target device is selected, pin NDK/JDK/SDK and vendor loader requirements; build and deploy a minimal native OpenXR application.
9. **Engine comparison** — compare Godot against the native baseline using identical tasks and assets; record renderer, scripting and runtime overhead.
10. **IKAI experience** — add participant-facing interaction only after the platform layer and privacy/data flows pass review.

## 11. Acceptance and evidence gates

A component remains RESEARCH until evidence is recorded for:

- exact upstream release, commit and licence;
- Guix channel revision and package/build result;
- exact host, GPU, driver and headset/device model;
- OpenXR runtime discovery and enabled extensions;
- graphics API and required Vulkan/OpenGL extensions;
- measured frame timing, latency, dropped frames and thermal behaviour;
- calibration method, repeatability, drift and failure response;
- offline operation and recovery;
- network/data-flow inspection;
- participant permission, visible sensor state, export and deletion tests;
- reproducible rebuild and rollback.

A sample rendering a scene is not proof of tracking accuracy, comfort, privacy, sustained reliability or production readiness.

## 12. Decision register

| Decision | Current state |
|---|---|
| Native OpenXR as API research baseline | **SELECTED FOR FIRST EVALUATION** |
| Monado as Linux runtime | **PRIMARY CANDIDATE; NOT QUALIFIED** |
| Android XR OpenXR compatibility | **TARGET; DEVICE NOT SELECTED** |
| Native C/C++ minimal application | **FIRST IMPLEMENTATION SPIKE** |
| Vulkan | **PREFERRED GRAPHICS CANDIDATE; HARDWARE GATE OPEN** |
| OpenGL | **ALTERNATIVE PATH TO MEASURE** |
| Godot | **SECONDARY; NOT APPROVED** |
| Blender | **AUTHORING CANDIDATE** |
| glTF / GLB | **FIRST ASSET FORMAT TO TEST** |
| OpenUSD | **LATER RESEARCH** |
| WebXR / WebGL / JavaScript | **EXCLUDED BY POLICY** |
| Headset / board procurement | **NOT AUTHORIZED OR SPECIFIED** |
| Human sensing / biometric capabilities | **NOT IN BASELINE** |

## 13. Primary technical references

- Khronos OpenXR SDK: https://github.com/KhronosGroup/OpenXR-SDK
- Khronos OpenXR SDK source and samples: https://github.com/KhronosGroup/OpenXR-SDK-Source
- OpenXR registry and specifications: https://registry.khronos.org/OpenXR/
- Monado project and hardware support: https://monado.freedesktop.org/
- Monado getting started / loader and runtime distinction: https://monado.freedesktop.org/getting-started.html
- Android XR OpenXR development: https://developer.android.com/develop/xr/openxr
- Godot XR setup: https://docs.godotengine.org/en/stable/tutorials/xr/setting_up_xr.html
- Godot Android XR deployment: https://docs.godotengine.org/en/latest/tutorials/xr/deploying_to_android.html
- WARENA Technology Constitution: https://github.com/donfelohke/WARENA/blob/main/docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md

**Evidence note:** upstream documentation describes upstream capability. It does not establish Guix packaging, WARENA build success, target-hardware compatibility, participant safety or deployment.
