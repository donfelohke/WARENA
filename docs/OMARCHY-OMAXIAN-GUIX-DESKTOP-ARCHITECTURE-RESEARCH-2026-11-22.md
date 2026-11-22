# Omarchy, Omaxian and the Reproducible Desktop — Comparative Architecture Research

**Document ID:** WARENA-DESKTOP-CASE-STUDY-2026-11-22  
**Date:** 2026-11-22  
**Owner:** WARENA  
**Status:** RESEARCH / ARCHITECTURE ANALYSIS — NOT AN IMPLEMENTATION SPECIFICATION OR DEPLOYMENT RECORD  
**Decision authority:** WARENA Technology Constitution (2026-11-17), current X11-first desktop policy, and the FELOH Corpus evidence standards.

> **Research question:** Can WARENA deliver Omarchy-level desktop coherence, Guix-level reproducibility and native GNU/Linux extensibility in one user-controlled computing environment?

## 1. Executive finding

**Yes, as a feasible architectural objective; not yet as a demonstrated WARENA system.** The three properties are compatible when their responsibilities are separated:

- **Desktop coherence:** one understandable interaction and visual system across the session.
- **Reproducibility:** declarative, pinned and auditable system and user configuration, with tested recovery.
- **Native extensibility:** independent components with documented interfaces, explicit capabilities and replaceable implementations.

The recommended research direction is a **modular native desktop with a shared Guile/Scheme integration and policy layer**, not a monolithic shell and not a direct port of Omarchy's implementation.

No WARENA desktop shell, shared service bus, unified settings application, plugin framework, complete workstation image, or production session is claimed by this document. The recommendation remains RESEARCH / ARCHITECTURE PROPOSAL until its interfaces, dependencies, builds, runtime behaviour and recovery are demonstrated.

## 2. Evidence boundary and terminology

This study separates four kinds of evidence:

1. **Upstream fact:** a capability, release or architecture documented by the project that owns it.
2. **Comparative analysis:** an interpretation of how the projects differ.
3. **WARENA policy:** an owner-directed constraint already established in the WARENA Technology Constitution and desktop architecture.
4. **WARENA proposal:** a candidate design or test that has not been implemented or approved as a deployed system.

Project-reported download, star, contributor and pull-request numbers are not active-user, retention, reliability or sustainability measurements. A release or upstream feature does not prove WARENA compatibility. A document or Git commit is not a build, test, installation or deployment.

## 3. Omarchy: product and architecture case study

### 3.1 Release and project momentum

The official Omarchy release repository identifies **v4.5.0**, published 2026-11-05, as the latest release checked for this study. Its release notes report more than 740 pull requests merged from over 180 contributors in twelve weeks, a traditional desktop mode alongside the tiling default, Apple Silicon support for M1/M2/M3/Neo MacBooks, and 50 interface languages.

These are project-reported release facts, not independently verified active-user or retention figures. They are useful evidence of continuing release and contributor activity, but do not by themselves establish long-term institutional sustainability.

Source: https://github.com/omacom/omarchy/releases/tag/v4.5.0

### 3.2 Quattro's integration lesson

Omarchy 4.0 (Quattro) replaced a set of previously separate desktop-shell components with a Quickshell-based shell. The project release description identifies the bar, launcher, menus, notifications, on-screen displays, control panels, lock screen and authentication agent among the consolidated functions.

The transferable lesson is **integration at the user-experience boundary**: shared appearance, state, interaction patterns and lifecycle can reduce the feeling that the desktop is a collection of unrelated utilities.

It does not follow that all those functions should share one process in every architecture. A unified process can reduce integration friction, but it also enlarges the failure domain and makes in-process extension security more consequential.

Source: https://github.com/omacom/omarchy/releases/tag/v4.0.0

### 3.3 Quickshell is a toolkit, not a distribution

Quickshell describes itself as a toolkit for desktop-shell components. Its official overview says it is based on QtQuick and configured with QML, and lists integrations spanning X11/Wayland windowing, compositor-specific workspace management, PipeWire, BlueZ, authentication, power and media interfaces.

This makes Quickshell a useful reference for desktop integration and rapid shell development. It is not itself an operating system, a package manager or a guarantee of cross-compositor equivalence.

**WARENA policy constraint:** Quickshell/QML must not be adopted as a WARENA runtime dependency without a policy change approved through the existing technology-governance process. QML is a declarative UI language but permits JavaScript expressions and is executed through the Qt/QML runtime. WARENA's current constitution prohibits JavaScript as a language, runtime, framework or architectural dependency and excludes web technologies as system architecture. Quickshell is therefore a reference implementation for study, not an approved WARENA dependency.

Sources:
- https://quickshell.org/about/
- https://github.com/omacom/omarchy

## 4. Omaxian: portability case study and its limits

Omaxian is an independent project porting the Omarchy shell and command surface to Debian-family systems using X11/XLibre and i3. Its repository README describes an init-agnostic approach, with no requirement for Wayland, Hyprland or systemd. It also documents Omaxian-specific components and adaptations rather than claiming that every Omarchy subsystem is unchanged.

The official GitHub repository's latest release endpoint returned **v1.2.2** (published 2026-11-16); the repository metadata showed a push on 2026-11-22. These are point-in-time upstream observations, not a WARENA compatibility test.

Omaxian demonstrates that a recognisable desktop-shell experience can be separated from the original distribution and compositor. It also shows that porting is not frictionless: display-server differences, window-manager integration, session management, notifications, audio, power handling, dependencies and component substitutions still require explicit adaptation.

**Important limitation:** Omaxian also uses Quickshell/QML. Its X11 portability does not resolve WARENA's JavaScript/QML policy constraint, and it does not establish that a Quickshell-based shell is the right architecture for WARENA.

Sources:
- https://github.com/aozora/omaxian
- https://github.com/aozora/omaxian/releases/tag/v1.2.2
- https://omaxian.org/shell

## 5. Guix and RDE: the reproducibility foundation

GNU Guix provides declarative system configuration, package and system generations, channel revision inspection and rollback mechanisms. The Guix manual documents `guix describe` as a way to record the Guix and channel revisions in use, and `guix system reconfigure` as creating a new system generation while retaining earlier generations for recovery.

These properties make Guix a strong foundation for describing and reconstructing a system. They do not make every aspect of a physical computer automatically reproducible. Firmware, hardware-specific behaviour, mutable user data, external services, nondeterministic inputs and unrecorded host state remain separate concerns.

RDE remains an upstream Scheme-based configuration framework used as a WARENA research dependency. This study does not claim a newly verified RDE release, Guix package build, pinned RDE channel, or working WARENA host configuration.

Sources:
- https://guix.gnu.org/manual/en/
- https://guix.gnu.org/manual/en/html_node/Using-the-Configuration-System.html
- https://github.com/abcdw/rde

## 6. Existing WARENA constraints that govern this study

This study does not supersede existing policy:

- GNU Guix + RDE remains the preferred system/configuration research foundation.
- WARENA desktop research remains **X11-first**.
- X.Org remains the initial X11 compatibility baseline.
- XLibre remains a separately qualified compatibility experiment.
- Gershwin and Guile-WM / WM-NG remain the intended X11 session research tracks under the existing decision records.
- Wayland remains secondary/experimental; dwl-guile and its Guix Home service remain supporting research forks, not the default desktop direction.
- WARENA is libre-first, native-first, local-first, inspectable and user-controlled.
- JavaScript and web technologies remain prohibited as WARENA system/application architecture under the current Technology Constitution.
- No new `warena-rde` repository or replacement repository is proposed. WARENA remains the configuration home; RDE remains upstream; the existing forks retain their separate identities and provenance.

Read this document together with:
- [Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md)
- [Desktop Architecture](DESKTOP-ARCHITECTURE.md)
- [Guile-WM / WM-NG X11 session audit](GUILE-WM-WMNG-GUIX-SESSION-AUDIT-2026-11.md)
- [Fork and Configuration Architecture](FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md)
- [Stack Register](STACK-REGISTER.md)

## 7. Proposed WARENA architecture: modular native desktop

The research recommendation is a hybrid, modular design. It aims for one coherent experience without requiring every interface element to run inside one process.

```text
User experience and design system
  ├── panel / status / launcher / notifications / settings
  ├── native applications and accessibility
  └── consistent keyboard, pointer and workspace workflows

Session and window-management layer
  ├── X11: X.Org baseline; XLibre compatibility experiment
  ├── Gershwin and Guile-WM / WM-NG session tracks
  └── Wayland: dwl-guile experimental track

WARENA integration and policy layer (proposal)
  ├── Guile/Scheme configuration and session orchestration
  ├── documented service interfaces and event contracts
  ├── capability-aware adapters for X11 and Wayland
  └── independent process lifecycle and health/recovery policy

System and user environment
  ├── GNU Guix System
  ├── Guix Home
  ├── RDE upstream configuration framework
  └── pinned channels, generations, provenance and recovery

Hardware and native interfaces
  ├── display / input / audio / camera / network
  └── kernel, firmware, filesystems and device permissions
```

This is a research architecture, not a selected implementation stack. It does not select a new window manager, desktop shell, UI toolkit, IPC protocol or service daemon.

### 7.1 Service boundaries to investigate

Prefer existing standards and upstream components before defining new interfaces. Candidate service domains include:

| Domain | Responsibilities to evaluate |
|---|---|
| Session | Startup, shutdown, environment and session health |
| Applications | Desktop-entry discovery, launch and application metadata |
| Windows/workspaces | Focus, workspace state and window actions |
| Display | Monitors, modes, layout and profile persistence |
| Audio/media | Devices, streams, volume and media controls |
| Input | Keyboard layouts, pointer, touch and input methods |
| Notifications | Delivery, actions, history and quiet modes |
| Power | Battery, suspend, power profiles and lid events |
| Appearance | Theme tokens, typography, density and accessibility |
| Extensions | Discovery, compatibility, permissions and lifecycle |

Potential existing interfaces include D-Bus, freedesktop specifications, X11 ICCCM/EWMH and RandR, Wayland protocols, PipeWire, MPRIS, BlueZ and UPower. Each interface must be checked for suitability on the selected session. X11 and Wayland do not expose identical authority or capabilities; do not pretend that every operation can be made fully portable behind one lowest-common-denominator API.

### 7.2 Modularity and failure containment

The default research hypothesis should be **independent native processes coordinated through documented interfaces**, with a small number of shared services only where shared state or lifecycle genuinely requires them.

Advantages to test:
- A failed panel should not terminate notifications or the session.
- A service should be restartable without restarting the whole desktop.
- UI components should be replaceable without changing system configuration semantics.
- Interfaces should be versioned and documented.
- Logs and health state should identify which component failed.

A unified shell process remains a valid comparator. It should only be preferred if measured integration and resource benefits outweigh its failure-domain and extension-security costs.

### 7.3 Extension security

Do not equate extensibility with unrestricted in-process code execution.

A WARENA extension proposal should define:
- Stable identifier, version and manifest.
- Declared interface and API compatibility.
- Required capabilities and data access.
- Source, licence, maintainer and provenance.
- Explicit user enablement and removal.
- Resource limits, logging and failure behaviour.
- Upgrade and rollback behaviour.

Prefer out-of-process extensions with least-privilege IPC. Any in-process extension model requires a separately documented trust model; process separation alone is not a sandbox. Do not claim sandboxing until enforcement is implemented and tested.

## 8. Reproducibility and recovery contract

The user-facing update experience should make system changes understandable, while Guix remains the authoritative system description.

A future update workflow should explain:
1. Which pinned channel revisions and configuration commit are being evaluated.
2. Which packages, services and configuration objects will change.
3. What derivations will be built or substituted.
4. Which new system and Home generations will be created.
5. Which migrations run and whether they are idempotent.
6. What must be backed up separately.
7. How to boot or select a prior generation.
8. How to verify the restored state.

**Rollback boundary:** a Guix system generation is not a backup of `/home`, application databases, external services, firmware or user-created data. Home configuration and mutable data need their own backup and recovery procedures. A successful generation switch is not a complete recovery test.

Minimum evidence for a reproducibility claim:
- Exact repository commit and configuration files.
- Exact Guix version and `guix describe` output.
- Authenticated channel URLs, introductions and pinned commits.
- Package source revisions and build logs.
- Hardware/firmware inventory where relevant.
- Clean-environment rebuild or substitute evidence.
- Boot, service and application checks.
- Prior-generation boot and recovery test.
- Explicitly listed non-reproducible or external inputs.

## 9. Research work packages

| ID | Work package | Required output | Status |
|---|---|---|---|
| WDE-01 | Upstream reuse and dependency audit | Candidate inventory, licences, maintenance and Guix availability | PROPOSED |
| WDE-02 | Desktop workflow and design-system study | User journeys, interaction contract and visual tokens | PROPOSED |
| WDE-03 | X11 integration feasibility | X.Org session, window manager and native service interface map | PROPOSED |
| WDE-04 | Native UI feasibility | GTK/G-Golf, GNUstep/Objective-C and other native toolkit comparison | PROPOSED |
| WDE-05 | Guile integration feasibility | Scheme service lifecycle, IPC, error handling and configuration model | PROPOSED |
| WDE-06 | Extension threat model | Trust boundaries, capabilities, process isolation and auditability | PROPOSED |
| WDE-07 | Guix reproducibility prototype | Pinned configuration, VM build, generation switch and recovery record | PROPOSED |
| WDE-08 | XLibre compatibility experiment | Separate X.Org/XLibre compatibility evidence | PROPOSED |
| WDE-09 | Wayland interoperability study | dwl-guile service and capability adapter evidence | PROPOSED / SECONDARY |
| WDE-10 | User acceptance and accessibility | Keyboard, pointer, display, audio, notifications, reduced motion and recovery tests | PROPOSED |

Each work package must reuse existing projects where suitable and document why any proposed new component is necessary. Do not create a new repository or framework as a default response to a gap.

## 10. Validation matrix and promotion gates

No candidate becomes a WARENA default merely because it looks coherent or works on one machine.

| Test area | Evidence required before promotion |
|---|---|
| Clean install | Repeatable installation in a disposable VM or test host |
| Configuration | Declarative source and pinned inputs reconstruct the session |
| Build | Successful Guix derivations with retained logs |
| Session lifecycle | Startup, logout, restart and crash recovery |
| X11 baseline | X.Org behaviour verified independently |
| XLibre | Separate compatibility evidence; no mixed ABI assumptions |
| Wayland | Experimental evidence kept separate from X11 claims |
| Display | Single/multiple monitors, mode changes and reconnect |
| Input | Keyboard, pointer, touch and input-method operation |
| Audio/media | Device switching, streams, mute and media controls |
| Notifications | Delivery, actions, history and service restart |
| Extensibility | Install, inspect, enable, disable, update and remove an extension |
| Security | Capability enforcement and negative tests for denied access |
| Offline use | Essential desktop functions remain usable without network access |
| Recovery | Prior system generation boots; user data restored from backup |
| Accessibility | Keyboard-only operation, focus, contrast, scaling and reduced-motion modes |
| Maintenance | Documented ownership, upstream update path and migration tests |

Promotion states must remain distinct: RESEARCH → SPECIFICATION → PROTOTYPE → TESTED → RELEASED. Use IMPLEMENTED only for code actually present; TESTED requires recorded test results; RELEASED requires an identifiable release artifact. A green source-level test does not prove graphical or hardware operation.

## 11. Decisions and non-decisions

### Research conclusions

- Omarchy is a useful product-integration and desktop-experience case study.
- Quattro demonstrates the benefits and trade-offs of shell consolidation.
- Omaxian demonstrates a real X11/XLibre/i3 porting path for the Omarchy shell, while retaining Quickshell/QML.
- Guix provides a strong declarative and generation-based system foundation.
- A modular native architecture is compatible in principle with a coherent user experience.
- WARENA should study the integration contracts and product discipline, not copy the implementation stack.

### Not decided or not approved

- No Quickshell, QML or JavaScript dependency is approved.
- No single-process shell is selected.
- No new shell, service bus, IPC protocol, plugin manager or framework is approved for implementation.
- No change to the X11-first policy or existing Gershwin / Guile-WM / WM-NG research tracks is made.
- No change to the experimental status of dwl-guile or its Guix Home service is made.
- No package, build, host, hardware, migration, deployment or release is claimed.
- No new repository is proposed.
- No upstream project is represented as WARENA-authored work.

## 12. Primary sources and review record

Primary sources reviewed 2026-11-22:

1. Omarchy v4.5.0 release: https://github.com/omacom/omarchy/releases/tag/v4.5.0
2. Omarchy Quattro v4.0.0 release: https://github.com/omacom/omarchy/releases/tag/v4.0.0
3. Omarchy source repository: https://github.com/omacom/omarchy
4. Quickshell official architecture overview: https://quickshell.org/about/
5. Omaxian source repository and README: https://github.com/aozora/omaxian
6. Omaxian v1.2.2 release: https://github.com/aozora/omaxian/releases/tag/v1.2.2
7. Omaxian shell project: https://omaxian.org/shell
8. GNU Guix manual: https://guix.gnu.org/manual/en/
9. GNU Guix configuration system: https://guix.gnu.org/manual/en/html_node/Using-the-Configuration-System.html
10. RDE upstream repository: https://github.com/abcdw/rde
11. WARENA Technology Constitution: https://github.com/donfelohke/WARENA/blob/main/docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md
12. WARENA Desktop Architecture: https://github.com/donfelohke/WARENA/blob/main/docs/DESKTOP-ARCHITECTURE.md

### Review limitations

This is a documentation and source review. It did not build Omarchy, Omaxian, Quickshell, Guix, RDE or any WARENA configuration; inspect a live desktop session; test hardware; run performance measurements; or audit every source file in the upstream projects. Upstream release and repository metadata are time-sensitive and should be refreshed before implementation decisions.

**Final status: RESEARCH / ARCHITECTURE ANALYSIS. No WARENA implementation or deployment is asserted.**
