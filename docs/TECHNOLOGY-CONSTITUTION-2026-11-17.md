# WARENA Technology Constitution — Native, Libre and User-Controlled Computing

**Effective date:** 2026-11-17  
**Status:** CANONICAL POLICY — owner-directed  
**Authority:** WARENA architecture; shared terminology and provenance governed by the FELOH Corpus  
**Related principle:** **Freedom Is a System.**

## 1. WARENA identity

**WARENA — Warena Architecture Re Network/ed Artefact.**

This is the canonical project expansion. Preserve the deliberate form **Network/ed**: it accommodates both network architecture and networked artefacts. Do not silently replace it with older expansions or treat it as an ordinary acronym whose components must be forced into a single grammatical phrase.

WARENA is an architecture for creating, connecting, reproducing, maintaining and evolving computational artefacts. It is not merely a Linux distribution, desktop environment or product catalogue.

## 2. Governing technology policy

WARENA and WARENA-governed IKAI infrastructure are native-first, libre-first, local-first, inspectable, reproducible and user-controlled.

### 2.1 JavaScript prohibition

JavaScript is a **prohibited technology** for WARENA and IKAI system architecture. Do not introduce JavaScript as:
- an application or systems programming language;
- a runtime or execution dependency;
- a framework, package ecosystem or build/deployment dependency;
- a desktop-shell, greeter, settings, agent or application implementation;
- a required interface or control plane.

This excludes Node.js, Deno, Bun, Electron and JavaScript-dependent application stacks. Do not route around the prohibition by renaming or embedding the runtime.

### 2.2 Web-technology exclusion

Do not use web technologies as the application architecture, runtime, UI framework or systems integration substrate for WARENA or IKAI. Excluded as architectural dependencies are browser-hosted application shells, WebXR, WebGL, web-first UI frameworks and HTML/CSS/JavaScript application stacks.

A web page, static HTML publication, external documentation page or ordinary source-code browser is not automatically a system runtime. Such material must not be mistaken for an approved WARENA/IKAI application architecture. Existing publication artefacts are historical/current assets to be assessed separately; this policy does not silently authorize a site redesign or migration.

### 2.3 Preferred native direction

Evaluate technologies against the workload and evidence, with the following preferred research direction:
- GNU/Linux and GNU Guix; RDE as a configuration research layer;
- GNU Guile, Scheme and GOOPS for programmable system and application logic;
- GNUstep / Objective-C for native application environments where appropriate;
- X11-first desktop research, with X.Org as the initial compatibility baseline and XLibre as a compatibility experiment; Wayland remains a separately labelled research/experimental track;
- native graphics, display, input, audio, camera and hardware interfaces;
- OpenGL/Vulkan and native scene-graph or rendering approaches where justified;
- OpenXR as a native XR API candidate; **OpenXR is not WebXR**;
- local files, SQLite, Git and other inspectable local persistence;
- local networking and distributed protocols only where required, with bounded offline operation.

C, C++, Objective-C, Python, Haskell, Ada and shell may be used where a documented subsystem requires them. This does not weaken the JavaScript prohibition or make any language a default. Every non-Scheme component needs a bounded responsibility, interface contract, build provenance, dependency/runtime cost, test strategy and replacement path.

### 2.4 Selection rules

1. Prefer native interfaces over browser-mediated ones.
2. Prefer free software and inspectable source; record unavoidable nonfree firmware or hardware exceptions.
3. Keep core operation local and useful without network access.
4. Network access is a capability, not a prerequisite for an artefact's essential operation.
5. No telemetry, tracking, DRM, tivoization, remote execution or cloud dependency by default.
6. Do not add a dependency merely for convenience, fashion or breadth.
7. A candidate technology is not an approved dependency until evaluated and explicitly selected.
8. Preserve upstream authorship and licence obligations; fork and configure rather than misrepresenting upstream work.
9. Research proposals, installed packages, tested prototypes and deployed systems must remain separately labelled.

## 3. Philosophical reference

Richard Stallman, **“The JavaScript Trap”** (GNU Project, 2009):  
https://www.gnu.org/philosophy/javascript-trap.html

This essay is a required philosophical reference for the JavaScript prohibition. It examines the user-control and software-freedom problems created when browsers execute nonfree JavaScript programs delivered by websites. WARENA adopts the essay as a reference point, then makes an explicit project policy choice: JavaScript is prohibited and web technologies are excluded as architectural dependencies. Do not misrepresent the essay as a blanket technical analysis of every web standard; the broader exclusion is WARENA's own policy decision.

## 4. IKAI identity and scope

**IKAI is a Turkana female name meaning “home.”** This user-confirmed cultural meaning is primary. Do not invent an acronym expansion or substitute an unverified etymology.

IKAI's technical descriptor may be **Reflective / Embodied Spatial Computing**; “a mirror, not a judge” remains a guiding metaphor, not a translation of the name.

The mirror is one possible interface, not the definition or limit of IKAI. Beauty/appearance and movement/choreography are distinct application domains that may share embodied spatial infrastructure:
- Beauty: appearance, hair and loc-care consultation, visualisation, craft documentation and self-expression.
- Movement: pose and motion representation, rhythm, gesture, choreography, rehearsal and performance.
- Shared platform research: geometry, spatial relationships, time-based observations, interaction, rendering, persistence and participant control.

Do not claim a working mirror, validated sensing pipeline, motion-tracking accuracy or deployed XR system without implementation and evaluation evidence. No beauty scoring, person ranking, covert profiling, face identification, diagnosis or default continuous recording.

## 5. Architecture decisions retained

- WARENA remains the infrastructure and systems-engineering domain.
- IKAI remains reflective, embodied and spatial-computing research; its name means home.
- GENJE remains the cultural, movement and creative-practice domain.
- FELOH Corpus remains the shared source of record for terms, governance, provenance and evidence.
- NAKEBUSEN remains the sole commercial interface.
- Desktop and XR architecture decisions remain subject to their own dated decision records. This policy does not by itself approve a package, runtime, display manager, compositor, graphics engine, sensor or hardware purchase.

## 6. Change control

This policy supersedes conflicting undated proposals and draft technology lists from its effective date. Historical documents must not be silently rewritten to pretend that this policy existed earlier. Mark superseded recommendations with a dated note and link here. Preserve the original evidence and decision context.

No repository code, system configuration, deployment, hardware procurement or production service is changed merely by this policy document.


## 7. AI and agent services — explicit opt-in

AI inference, model downloads, file indexing, media capture, remote inference and agent execution are **optional capabilities, disabled by default**. They must not become implicit dependencies of the desktop, spatial environment, XR runtime, login session or base system.

- Activation is explicit and scoped to a service, task, data source and purpose.
- Local inference is preferred; remote inference requires separate explicit opt-in and disclosure of destination, payload and retention.
- No silent indexing of personal files, screen capture, microphone/camera access, telemetry or persistent personal profile.
- Context and tool access are mediated by least-privilege brokers. Read-only access is the initial permission tier.
- Agents receive no unrestricted shell, filesystem, network, device or credential access.
- Consequential or irreversible actions require human approval.
- Model outputs are untrusted proposals, not verified facts or authority.
- Users can inspect grants, audit actions, revoke permissions and disable services cleanly.
- Do not infer identity, emotion, health, personality, ability or intent from appearance or movement.

Guile/Scheme may implement orchestration and policy interfaces; inference engines remain replaceable components. This policy does not select a model, provider, inference engine or agent framework.

See [WARENA's spatial/XR/opt-in intelligence architecture (2026-11-20)](https://github.com/donfelohke/WARENA/blob/main/docs/SPATIAL-COMPUTING-XR-AI-ARCHITECTURE-2026-11-20.md). This is a policy boundary, not evidence of an implemented AI service.
