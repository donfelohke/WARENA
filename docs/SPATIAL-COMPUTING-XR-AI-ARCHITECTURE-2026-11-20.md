# WARENA — Desktop, Spatial Computing, Immersive XR & Opt-in Intelligence Architecture

**Date:** 2026-11-20  
**Status:** RESEARCH / ARCHITECTURE SPECIFICATION  
**Authority:** WARENA owns system, graphics, runtime, packaging, service and reproducibility architecture. IKAI owns reflective interaction and participant-data semantics. GENJE owns creative and embodied practice. FELOH Corpus owns shared governance and evidence rules.  
**Maturity:** RESEARCH — no implementation, package qualification, hardware validation or deployment is claimed.

## 1. Purpose and architectural decision

Extend WARENA's desktop architecture into spatial computing and immersive XR without collapsing desktop window management, graphics, XR runtime, distributed environments and optional AI into one application or daemon.

The architecture has four independently useful capabilities:

1. **Conventional desktop:** X11-first workstation sessions and their display, window-management and application layers.
2. **Spatial computing:** native 2D/3D environments, spatial objects, interaction, tracking and spatial displays.
3. **Immersive XR:** device/runtime integration through native APIs, with OpenXR as the first interoperability interface to investigate and Monado as the primary Linux runtime candidate.
4. **Opt-in intelligence:** optional local-first inference and bounded agent services, disabled unless explicitly enabled and authorized.

The conventional desktop must remain complete and useful without XR hardware, spatial tracking, network collaboration or AI. XR and AI must not become mandatory boot, login, desktop-shell or application dependencies.

**Current desktop precedence remains X11-first:** X.Org is the initial compatibility baseline; XLibre is a separate compatibility experiment; Window Maker is a compact X11 window-manager reference; Gershwin is the GNUstep/OpenStep-inspired desktop case study; Guile-WM / WM-NG is the Scheme-native window-management track. Wayland remains secondary/experimental, with dwl-guile experimental and Sway a comparison/recovery baseline. This XR architecture does not supersede that policy.

## 2. Terminology and component boundaries

| Component | Responsibility | Not responsible for |
|---|---|---|
| Desktop environment / shell | User-facing workspace, menus, launchers, settings and session conventions | Owning the display protocol or XR device drivers |
| Window manager | Focus, geometry, stacking/tiling, decorations and workspaces | Display-device management or AI policy |
| X11 display server | X protocol, input/output resources and client communication | Selecting the desktop shell |
| Wayland compositor | Wayland protocol, surfaces, input, composition and display output; commonly also window management | Being interchangeable with an X11 window manager |
| Display manager | Graphical login and session selection | Rendering desktop windows |
| Session manager | User-session startup and shutdown | General service supervision |
| Service manager | Process lifecycle, dependencies, restart and logs | Desktop policy or participant consent |
| Spatial environment | Spatial world/object model, coordinate frames and interaction semantics | Being identical to a graphics engine |
| Scene/graphics system | Geometry, visibility, rendering, composition and GPU submission | Owning authoritative application or world data |
| XR loader | Connects OpenXR applications to an installed runtime | Implementing headset drivers or compositor itself |
| XR runtime | Implements OpenXR and integrates devices, tracking, input and compositor | Being a full desktop environment |
| AI inference service | Runs a selected model | Automatically receiving personal data or host authority |
| Agent/tool broker | Mediates explicitly granted operations | Unrestricted shell, filesystem or network access |

Do not treat these as a literal process tree. They are logical responsibilities that may be implemented in separate processes or libraries.

## 3. Historical foundations: GNU/MAVERIK and DEVA3

### 3.1 GNU/MAVERIK

GNU/MAVERIK (Microkernel for Advanced Virtual Environments) is a historical free-software virtual-environment framework from the University of Manchester Advanced Interfaces Group. The published architecture describes a microkernel and supporting modules. Its central design idea is to let applications retain their own data structures and expose operations through registered object classes and callbacks, rather than requiring the application data to be copied into a framework-owned scene representation.

The research describes default and replaceable methods for spatial/display management, culling, interaction, navigation and conventional/VR input-output devices. The implementation used C and an object-oriented callback/class model; it was a programmer's framework, not an end-user desktop or a modern headset runtime.

**Architectural lessons for WARENA:**
- Keep authoritative application/domain data owned by the application.
- Let spatial services query or operate on that data through explicit interfaces.
- Make geometry, visibility, selection, navigation and device adapters replaceable.
- Avoid forcing every application into one mandatory scene graph or engine.
- Separate the spatial kernel from world persistence, distribution and application semantics.

MAVERIK is a historical architecture reference, not a current WARENA dependency recommendation. GNU archive indexes contain historical releases through the 6.x line, including 6.4 dated 2009; this is evidence of surviving source archives, not evidence of current maintenance or compatibility with modern compilers, Mesa, Vulkan, Wayland or OpenXR. Source recovery, exact release provenance, licence review and buildability remain unverified.

### 3.2 DEVA3

DEVA3 is the distributed virtual-environment architecture described by Pettifer, Cook, Marsh and West at ACM VRST 2000. Its stated problem is supporting large numbers of geographically distributed users in complex virtual environments. The paper discusses synchronization under network limitations through **subjectivity** and a flexible model for describing object behaviour.

For WARENA, the important separation is between:
- authoritative or shared environment state;
- object identity, behaviour and rules;
- participant-specific state, interests and views;
- synchronization and network distribution;
- local spatial representation and rendering.

Subjectivity is a distributed-systems design concept in this research: it allows synchronization requirements to be relaxed by recognising that participants need not always receive identical representations or updates at identical times. It must not be confused with arbitrary fabrication of facts or with a user profile.

DEVA3 is not an XR API, graphics engine, compositor or desktop environment. Its ideas are relevant to multi-user persistent worlds and collaborative simulation. A current implementation, protocol compatibility or production readiness is not claimed.

### 3.3 Relationship between MAVERIK and DEVA3

Treat the two as complementary research foundations, not interchangeable products:

- MAVERIK informs local spatial services, application-data access and rendering/interaction modularity.
- DEVA3 informs distributed environment state, object behaviour, participant-specific views and synchronization.
- A WARENA design may combine these concerns, but the exact original integration topology, version pairing and source-level interfaces must be established from primary source archaeology before claiming a faithful reconstruction.

The proposed WARENA architecture extracts their design principles; it does not claim to port either codebase.

## 4. Comparison with contemporary systems

| Project / standard | Actual architectural role | Relationship to MAVERIK / DEVA3 | WARENA disposition |
|---|---|---|---|
| GNU/MAVERIK | Historical spatial/graphics microkernel and VR application framework | Application-owned data, callbacks and spatial services | Historical architecture and source-recovery study |
| DEVA3 | Historical distributed virtual-environment architecture | Shared worlds, object behaviour and synchronization/subjectivity | Distributed-world model study |
| OpenXR | Cross-vendor application/runtime API | Standardizes application access to XR runtime capabilities; does not define a world model | Primary native XR API to investigate |
| Monado | Open-source OpenXR runtime for Linux and other targets | Runtime/device/compositor layer, not a spatial desktop or DEVA3 replacement | Primary Linux runtime candidate |
| OpenSceneGraph | Native scene-graph toolkit | Provides scene-graph/rendering facilities; more framework-led than MAVERIK's application-data callback model | Comparator; assess current maintenance and graphics backend |
| VulkanSceneGraph | Vulkan-oriented scene-graph toolkit | Modern rendering/scene graph candidate, not a distributed-world system | Native rendering candidate for evaluation |
| VR Juggler | Modular VR application framework | Device/application framework comparison | Historical and architectural comparator |
| Godot | Integrated application/game engine with XR support | Higher-level experience authoring; not a DEVA3-style distributed-world architecture | Optional prototype tool, not core platform |
| SteamVR | XR runtime/ecosystem | Alternative runtime endpoint | External compatibility comparator, not default dependency |
| WebXR / WebGL / Three.js | Browser-based XR/graphics stack | Different runtime and programming model | Excluded from WARENA/IKAI application architecture |

Do not compare all entries as if they are equivalent engines. OpenXR is an API; Monado is a runtime; scene graphs are rendering/scene-management libraries; Godot is an application engine; DEVA3 is a distributed environment architecture; MAVERIK is a historical spatial microkernel.

## 5. Proposed WARENA spatial architecture

### 5.1 Logical layers

1. **Application/domain layer:** IKAI, GENJE, scientific, educational or other native applications own their semantic data and application rules.
2. **Environment model:** object identity, state, behaviour, spatial relationships, permissions and persistence.
3. **Spatial services:** coordinate transforms, spatial indexing, intersection/query, visibility, selection, navigation and optional physics.
4. **Rendering and composition:** scene representation, render graph, GPU resource management, frame pacing and display composition.
5. **Interaction and tracking:** keyboard, pointer, touch, controllers, gaze, hands, body/prop tracking and calibration adapters. Every sensor path is optional and purpose-bound.
6. **Display/runtime adapters:** conventional display, X11/Wayland surfaces, tracked/spatial displays and OpenXR runtime sessions.
7. **Distribution services:** optional replication, synchronization, collaboration and remote transport. Local-only mode remains complete.
8. **System foundation:** Linux kernel, DRM/KMS, Mesa/drivers, Guix, Guix Home, Guile and Shepherd.

### 5.2 Data ownership and scene representation

The application remains authoritative for its domain data. A renderer may maintain derived GPU/scene caches, but those caches are not the sole source of truth. Changes must be invalidated or reconciled through documented interfaces.

A universal scene graph is not mandatory. Evaluate:
- application-owned data plus spatial query callbacks (MAVERIK-inspired);
- a shared scene graph for interoperable spatial objects;
- adapters that map selected application objects into renderer-specific representations.

Do not serialize implementation pointers or renderer-private objects as persistent world state. Persistent records need stable identifiers, versioned schemas and explicit ownership.

### 5.3 Spatial coordinate and timing contracts

Any multi-device or multi-user spatial system must declare:
- coordinate-frame names, handedness and units;
- local, device, stage/room and world transforms;
- calibration procedure, uncertainty and drift;
- timestamp source, clock domain and synchronization method;
- frame timing, prediction and stale-data behaviour;
- object ownership, authority and conflict resolution.

Do not assume audio, display, tracking, wearable and network clocks are synchronized. Preserve uncertainty rather than presenting false spatial precision.

## 6. Immersive XR architecture

### 6.1 OpenXR and Monado

OpenXR is the application-facing API boundary. The Khronos loader discovers and connects an application to an installed runtime. The runtime implements the API and integrates supported devices, tracking, input and composition. The SDK, loader, runtime, driver, GPU stack, headset firmware and application are separate qualification targets.

Monado is the primary Linux runtime candidate to investigate. Its developer architecture describes loosely coupled components and internal XRT interfaces, including instance, device and compositor interfaces. This is a useful modularity reference. Its current hardware support and Vulkan/driver requirements must be checked against the exact target device.

**Do not infer:** OpenXR support does not guarantee a particular extension, headset, passthrough mode, hand/eye tracking feature or compositor path works on a given machine.

### 6.2 Operating modes

- **Conventional desktop:** ordinary X11/Wayland session; no XR runtime required.
- **Spatial desktop/display:** spatial objects or 3D surfaces on a tracked or spatial display; headset not assumed.
- **Immersive XR:** headset runtime session, XR compositor and tracked input/display devices.
- **Headless/synthetic:** deterministic simulation and testing without a headset or human sensor data.

The XR compositor is not the same component as the X.Org server, Wayland compositor or desktop shell. Interoperation must be designed and tested rather than assumed.

### 6.3 Graphics and content

Evaluate Vulkan first where supported by the target runtime and driver; retain OpenGL/Mesa as a compatibility and lower-complexity comparator. VulkanSceneGraph and OpenSceneGraph are candidates, not preselected mandatory dependencies. A small native OpenXR application should precede adoption of a large application engine.

Godot may be used for bounded experience prototyping if it passes policy, licensing, packaging and runtime evaluation. It is not the core spatial kernel or distributed-world architecture.

### 6.4 Hardware qualification

The existing WARENA workstation reference is a conventional development baseline, not a certified immersive XR host. Do not claim high-refresh headset capability from CPU specifications alone. XR qualification needs exact GPU, driver, Vulkan extensions, headset model/revision, firmware, tracking system, connection path, compositor frame timing and thermal/power tests.

Use synthetic poses and fiducials before participant sensing or hardware procurement.

## 7. Conventional desktop relationship

The desktop remains an independent environment:
- Window Maker is an X11 window manager and NeXTSTEP-inspired interaction reference; it is not a spatial compositor.
- GNUstep supplies application frameworks and desktop components; it is not a display server or XR runtime.
- Gershwin is an integrated GNUstep desktop research track; it is not the owner of spatial world state.
- X.Org and Wayland occupy different display-protocol/compositor architectures.
- OpenXR and Monado add a distinct XR application/runtime path.
- Guix defines reproducible packages and system/user configuration.
- Shepherd supervises explicitly declared services; it is not a display manager or XR runtime.

A future spatial shell may interoperate with conventional desktop applications through defined surface and application interfaces. Do not force Window Maker or Gershwin to own 3D rendering, tracking or XR device policy.

## 8. Opt-in AI architecture

AI is an optional capability, not a desktop requirement. A default WARENA profile must not download models, start inference services, index user files, capture microphone/camera data, or grant an agent host access.

Separate the following components:

| Component | Responsibility | Required control |
|---|---|---|
| Model/inference service | Execute a selected local or explicitly remote model | User-selected model, version, resource limits and explicit activation |
| Context broker | Provide approved task context | Per-source, per-purpose grants; minimum necessary data |
| Tool broker | Expose bounded application/system operations | Capability allow-list, scoped credentials and revocation |
| Agent runtime | Plan and request actions | No implicit authority; human approval for consequential actions |
| Audit/provenance | Record decisions, tool calls and outcomes | Content-minimizing logs, inspectable retention and export/delete |
| Remote inference gateway | Optional external model routing | Disabled by default; explicit destination, payload, consent and retention disclosure |

Rules:
- Local inference is preferred but not compulsory; remote inference requires separate explicit opt-in.
- No model, provider, account or network endpoint is mandatory.
- No silent file indexing, screen capture, microphone/camera access or persistent memory.
- No unrestricted shell, filesystem, network, device or credential access for agents.
- Read-only access is the initial permission tier.
- Consequential or irreversible actions require human authorization.
- Disablement must stop services and revoke grants cleanly.
- Model outputs are untrusted proposals, not authority or verified facts.
- AI must not infer identity, emotion, health, personality, ability or intent from movement or appearance.

Guile/Scheme may implement orchestration and policy interfaces. Inference engines can be native or separately packaged components; do not require that model execution itself be implemented in Scheme.

## 9. Guix and Shepherd integration

Guix System and Guix Home are the reproducible packaging/configuration homes. Maintain separate profiles for:
- conventional X11 desktop;
- experimental Wayland desktop;
- native spatial development;
- XR runtime and device tooling;
- optional local inference;
- optional remote inference and network gateway.

Do not combine optional XR/AI dependencies into the base desktop closure without a documented reason. Record upstream source, version, licence, Guix channel commit, patches, build result, substitutes, hardware assumptions and rollback path.

Shepherd may supervise local services such as spatial brokers, optional runtime helpers, local inference servers and synchronization services when explicitly enabled. It does not replace a display manager, session manager or XR runtime. Service definitions must specify user, environment, dependencies, privileges, sockets, logs, restart limits, shutdown and disablement behaviour.

No Guix package availability, successful build, Shepherd service implementation or host deployment is claimed by this specification.

## 10. IKAI and GENJE integration boundaries

- **IKAI / MIRROR:** owns participant-facing reflective interaction, memory semantics, consent, privacy and interpretation. Mirror, Glass and Space are research interfaces, not product claims. Tracking is optional and task-specific.
- **GENJE / EXPRESSION:** owns movement, choreography, livecoding, sound, audiovisual work and performance context. Scores, measurements and interpretations remain distinct artefacts; performers retain authorship.
- **WARENA / CAPABILITY:** owns graphics/runtime integration, device adapters, Guix, local compute, networking, reproducibility and recovery.
- **FELOH Corpus:** owns shared terms, evidence and cross-domain governance.
- **NAKEBUSEN / ROOT:** remains the only commercial and transaction interface. This research creates no service, booking or product offer.

## 11. Feasibility and staged research plan

| Stage | Work | Exit evidence |
|---|---|---|
| 0 | Source archaeology: GNU/MAVERIK archives, papers, DEVA3 paper and surviving source | Exact source/version, licence, checksums, dependencies, source map and unresolved questions |
| 1 | Conventional native graphics baseline | Reproducible build, deterministic scene, input, frame timing and recovery record |
| 2 | Spatial service prototype | Application-owned data, query callbacks, coordinate frames, scene/cache invalidation tests |
| 3 | Native OpenXR baseline | Loader/runtime discovery, synthetic input, swapchain and compositor diagnostics |
| 4 | Monado hardware qualification | Exact device/GPU/driver matrix, frame timing, tracking and disconnect tests |
| 5 | Distributed environment model | Local authority, object behaviour, replication, conflict handling and participant-specific views |
| 6 | Spatial-display and immersive integration | Separate desktop/spatial/XR operating-mode tests |
| 7 | Optional AI profile | Opt-in, data-flow, permission, audit, resource and clean-disable tests |
| 8 | IKAI/GENJE task studies | Participant-authored protocol, consent, cultural context, qualitative results and limitations |

Every stage can stop independently. A later stage does not make earlier research a deployed system.

## 12. Qualification and acceptance matrix

Before any component is promoted beyond RESEARCH, record:
- source repository, exact revision and licence;
- dependency closure and Guix build result;
- runtime and hardware versions;
- coordinate frames and calibration error where relevant;
- frame-time distribution, latency and dropped-frame behaviour;
- device disconnect, process crash, restart and recovery;
- offline operation and network-egress behaviour;
- permissions, data collected, processing location, retention and deletion;
- accessibility and non-tracked interaction alternatives;
- test source, procedure, observations, failure cases and reproducibility.

For AI, also test default-off state, explicit activation, least privilege, denied requests, permission expiry, remote-egress denial, model replacement, audit inspection and full service disablement.

## 13. Research disposition

| Area | Disposition |
|---|---|
| GNU/MAVERIK | Historical architecture/source recovery; do not adopt without source/build audit |
| DEVA3 | Historical distributed-world architecture; extract subjectivity and object-behaviour ideas |
| OpenXR | Primary native API research |
| Monado | Primary Linux runtime candidate, hardware qualification required |
| VulkanSceneGraph / OpenSceneGraph | Rendering/scene-graph comparators |
| Godot | Optional application prototyping, not core infrastructure |
| X.Org / Window Maker / GNUstep / Gershwin | Conventional desktop track remains independent |
| Wayland / dwl-guile | Secondary/experimental desktop track |
| Local AI | Optional, disabled by default, permission-brokered |
| Remote AI | Separate opt-in, disabled by default |

**Overall decision:** preserve MAVERIK's application-aware spatial services and DEVA3's distributed-world separation as architectural research foundations. Build no monolithic WARENA XR/AI runtime until the source audit, native graphics baseline, exact hardware qualification and interface contracts justify it.

## 14. Sources and further reading

### GNU/MAVERIK
- Roger Hubbold et al., “GNU/MAVERIK: A microkernel for large-scale virtual environments,” *Presence: Teleoperators and Virtual Environments*, 10(1), 22–34 (2001). DOI: https://doi.org/10.1162/105474601750182298
- Toby Howard, Roger Hubbold and Alan Murta, “MAVERIK: A Virtual Reality System for Research and Teaching,” GVE'99. Open paper: https://diglib.eg.org/server/api/core/bitstreams/6dcfe6df-735f-4db6-96d3-66e37cdbdce9/content
- Adrian West, “Advanced 3-D Graphics: GNU Maverik—a VR Micro-Kernel,” *Linux Journal*, 1 September 2000: https://www.linuxjournal.com/article/4035
- GNU archive index: https://ftp.gnu.org/gnu/maverik/

### DEVA3
- Steve Pettifer, Jon Cook, James Marsh and Adrian J. West, “DEVA3: architecture for a large-scale distributed virtual reality system,” ACM VRST 2000, pp. 33–40. DOI: https://doi.org/10.1145/502393.502397
- Bibliographic record: https://dblp.org/rec/conf/vrst/PettiferCMW00
- Author bibliography: https://www.adrianwest.org/refs/r?cats=ajw_auth

### Contemporary infrastructure
- Khronos OpenXR: https://www.khronos.org/openxr/
- Monado project: https://monado.freedesktop.org/
- Monado developer architecture: https://monado.pages.freedesktop.org/monado/index.html
- OpenSceneGraph: https://openscenegraph.github.io/
- VulkanSceneGraph: https://github.com/vsg-dev/VulkanSceneGraph
- Godot XR documentation: https://docs.godotengine.org/en/stable/tutorials/xr/index.html

Source links establish research leads and published descriptions; they do not establish that WARENA has recovered, built, packaged or validated any listed component.
