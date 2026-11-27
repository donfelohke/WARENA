# RENAISSANCE BLACK OPS — WARENA Agentic Operating Environment & GNU Hurd Research

**Document ID:** WARENA-ARCH-AGENTIC-OS-HURD-01  
**Date:** 2026-11-20  
**Status:** RESEARCH / PROPOSED ARCHITECTURE  
**Canonical owner:** WARENA / CAPABILITY  
**Shared governance:** FELOH Corpus  
**Maturity:** Research synthesis and architecture proposal; no implementation, security guarantee, deployment or production readiness is claimed.

> **Freedom Is a System.** Intelligence is a service. Authority is a controlled resource. Accountability is a system property.

## 0. Executive summary

**RENAISSANCE BLACK OPS** is the working research banner for a sovereign, human-governed agentic computing environment. The technical programme is named the **WARENA Agentic Operating Environment (WAOE)**.

The central proposition is:

> An agent should be able to accomplish an assigned task without acquiring authority beyond its mandate.

The system separates:
1. human authority and consent;
2. agent reasoning and task proposals;
3. intent validation and policy decisions;
4. capability issuance, attenuation and revocation;
5. operating-system enforcement;
6. independent audit and state recovery.

GNU Hurd and GNU Mach are the principal experimental operating-system research substrate because Hurd's multi-server architecture, Mach IPC and translator model offer useful material for investigating service boundaries and resource interfaces. Hurd is not itself a complete capability-security solution, and its present package, hardware and application ecosystem is not a practical production replacement for GNU/Linux.

**GNU/Linux + Guix remains the practical development and production baseline.** ChildHurd/QEMU is the preferred initial Hurd laboratory. GNU Guile/Scheme is the preferred orchestration and policy language. Shepherd supervises services; it does not replace the policy engine or capability broker. SQLite may hold structured state and provenance, but it is not by itself an immutable audit system.

This document consolidates the agentic-OS research, Hurd research, African philosophical design questions, security requirements, technical stack, staged experiments and project boundaries. It is a research specification, not an implementation report.

## 1. Scope, terminology and identity

### 1.1 Names

- **RENAISSANCE BLACK OPS:** working research banner; not a separate company, product, covert capability or offensive cyber programme.
- **WARENA Agentic Operating Environment (WAOE):** technical programme and architecture.
- **GNU Hurd research track:** investigation of Hurd/Mach mechanisms as one execution substrate.
- **Linux prototype track:** practical first implementation of portable semantics and policy contracts.

The term “Black Ops” is used here as an internal creative/project label. The programme is defensive, transparent and human-governed. It excludes covert access, unauthorised persistence, stealth, credential theft, surveillance and offensive intrusion tooling.

### 1.2 Core objectives

1. Investigate operating-system architectures for autonomous agents.
2. Move enforcement outside the language model and into independently controlled system services.
3. Establish explicit, least-privilege, revocable delegation.
4. Support multiple specialised agents without implicit privilege inheritance.
5. Make actions attributable and audit records independently protected.
6. Preserve human authorship, consent and final authority.
7. Provide local-first, libre-first, reproducible execution environments.
8. Keep intent and policy semantics portable across GNU/Linux and GNU Hurd.
9. Investigate Hurd's Mach IPC, servers and translators without overstating their security properties.
10. Explore African intellectual traditions as situated sources of ethical and institutional questions, not as claims of historical anticipation of modern computing.

### 1.3 Non-goals

- Replacing GNU/Linux with Hurd in the near term.
- Claiming that Hurd automatically provides complete agent isolation or capability security.
- Giving an LLM unrestricted root, shell, filesystem, network or service-manager access.
- Creating covert, stealthy or unauthorised cyber operations.
- Treating prompts, model alignment or tool descriptions as OS security boundaries.
- Building a mandatory cloud service, telemetry system or remote-control dependency.
- Turning IKAI into an agent authority engine or GENJE into a WARENA product.
- Claiming a working agentic OS, prototype, deployment or security certification before evidence exists.

## 2. Research landscape: agents as operating-system actors

Two 2026 papers are important research leads:

1. **Zhao et al., “AgenticOS: An Intent-Oriented Secure Operating System Architecture for Autonomous AI Agents” (2026).** [arXiv:2606.15419](https://arxiv.org/abs/2606.15419). Its proposal motivates intent-oriented security, policy mediation and constrained execution. Treat named components and evaluation claims as the paper's proposal until independently examined and reproduced.
2. **Li et al., “Ring-0 by Default: Agents as Operating Systems (AaOS)” (2026).** [arXiv:2610.23199](https://arxiv.org/abs/2610.23199). Its analysis treats modern agents as de facto OS actors because they coordinate processes, tools, files, networks, memory, extensions and sub-agents. Its subsystem counts and classifications are source-specific findings, not universal measurements.

The papers support a key engineering question: when an agent can invoke tools, launch processes, manage state and delegate work, what OS protections must surround it?

### 2.1 Threats to address

| Threat | Failure mode | Required architectural response |
|---|---|---|
| Authority escalation | Agent reaches a resource through an alternate tool or shell path | Enforcement below the model/tool layer |
| Excessive delegation | Child agent inherits coordinator's full permissions | Explicit rights attenuation |
| Persistent-state tampering | Resumed task consumes modified memory or instructions | Integrity-checked, versioned state |
| Audit manipulation | Agent edits or deletes its own action history | Independent audit authority and append-only design |
| Network exfiltration | Local task transmits protected data | Enforced egress policy |
| Resource exhaustion | Runaway processes consume host resources | CPU, memory, storage, process and time limits |
| Partial failure | Task leaves inconsistent files or external effects | Transaction boundaries, staging and recovery |
| Untrusted content | Retrieved documents inject instructions or hostile data | Treat external content as data, not authority |
| Confused deputy | Broker or service uses its own power on behalf of an unauthorised principal | Bind every operation to principal, resource and purpose |
| Approval bypass | Agent routes around human confirmation | Separate approval authority and execution channel |

A prompt such as “do not read this file” is not a security boundary. A system-enforced denial that covers every relevant access path is.

## 3. GNU Hurd and GNU Mach as research substrate

GNU Hurd is a multi-server operating system built on GNU Mach. Many operating-system services are implemented as user-space servers. The architecture makes service interfaces, IPC and filesystem translators particularly relevant to this research.

Primary technical entry points:
- [GNU Hurd](https://www.gnu.org/software/hurd/)
- [GNU Hurd documentation](https://www.gnu.org/software/hurd/doc/)
- [GNU Mach](https://www.gnu.org/software/hurd/microkernel/mach/)
- [GNU Hurd FAQ and development material](https://www.gnu.org/software/hurd/)

### 3.1 Mach ports and rights

Mach ports are IPC endpoints; tasks hold rights that determine which operations they can perform with respect to those ports. This is a useful foundation for investigating service access as possession of specific communication rights rather than global ambient authority.

Research questions:
- How are send, receive and send-once rights created, transferred and destroyed?
- What identity and provenance can a server reliably associate with a request?
- How can a broker constrain rights to one task and one service?
- What happens to outstanding rights when an agent exits or crashes?
- What revocation patterns are possible, and what limitations remain?
- How should port handoff, namespace publication and server restart be audited?

**Boundary:** Mach port rights are not automatically a complete, object-capability security architecture. The project must specify authority creation, attenuation, transfer, revocation, identity, lifecycle and audit, then test each property. Do not claim that a capability is revocable merely because a port name is removed from one namespace.

### 3.2 Hurd translators

Hurd translators provide filesystem-facing service interfaces and can make data or services available through filesystem nodes. Passive and active translator behaviour offers an interesting area for research into task-specific namespaces and service-backed resources.

Potential experiments:
- a read-only research-corpus translator;
- a task-scoped scratch namespace;
- a source-cache interface with provenance metadata;
- an explicitly mediated report-staging interface;
- controlled service endpoints represented through filesystem operations.

A proposed namespace (not an existing Hurd standard):

```text
/
├── agents/
│   ├── coordinator/
│   ├── researcher/
│   └── analyst/
├── capabilities/
│   ├── corpus-read/
│   ├── source-fetch/
│   └── report-stage/
├── services/
│   ├── policy/
│   ├── broker/
│   ├── audit/
│   └── provenance/
├── workspace/
├── staging/
└── archive/
```

A translator running in user space is not automatically trustworthy or harmless. Its underlying authority, server identity, input validation, resource consumption, lifecycle and access to backing objects must be examined.

### 3.3 User-space servers and replaceability

Hurd's service architecture makes independent service implementation and replacement a useful research direction. WARENA should preserve stable service contracts while allowing replaceable implementations.

Design rule: **stable semantics; replaceable mechanisms; explicit authority; reproducible artefacts.**

### 3.4 Hurd maturity and evidence discipline

The 2026 research reviewed progress in x86_64, ChildHurd, SMP work, Rump driver integration, Rust support and Guix/Hurd integration. Package availability and hardware support remain much narrower than GNU/Linux. Earlier March 2026 reports gave very low runnable Guix package fractions; those figures are historical snapshots and must be refreshed before use in a current decision.

Do not infer:
- general hardware parity from x86_64 boot progress;
- complete SMP support from partial SMP work;
- production readiness from a successful QEMU boot;
- full Guix package support from Guix System integration;
- a secure agent sandbox from the multi-server design alone.

Use the existing [GNU Hurd + Nix compatibility and cross-build research note](research/gnu-hurd-nix-compatibility-and-cross-build-2026-11.md) for the separate Nix/Guix comparison. Guix is the primary Hurd integration research path; Nix remains a comparator and possible Linux-hosted cross-build experiment. A historical Nix-built Hurd image is not NixOS on Hurd.

## 4. Proposed WARENA Agentic Operating Environment

### 4.1 Logical architecture

```text
HUMAN PRINCIPAL
  │ objectives · consent · approval · revocation
  ▼
AGENT COORDINATION (Guile)
  │ intent declarations · task graph · delegation proposals
  ▼
POLICY ENGINE ───────────── CAPABILITY BROKER
  │ evaluate                  │ issue · attenuate · revoke
  └──────────────┬────────────┘
                 ▼
        AGENT EXECUTION CAPSULES
        │ filesystem scope
        │ process/resource limits
        │ network policy
        │ bounded IPC
        ▼
       OS ADAPTER / ENFORCEMENT
        ├── GNU/Linux
        └── GNU Hurd / GNU Mach

Independent supporting services:
  STATE & PROVENANCE · AUDIT · APPROVAL · RECOVERY
```

This is a logical responsibility map, not a claim that each component must be a separate process or that the diagram represents a verified Hurd topology.

### 4.2 Responsibility boundaries

| Component | Owns | Must not become |
|---|---|---|
| Human principal | Objectives, consent, final approval and revocation | A passive observer of autonomous policy |
| Agent/model runtime | Reasoning, proposals and task execution within granted scope | Root authority or permission issuer |
| Coordinator | Task decomposition and bounded delegation requests | A holder of every child agent's rights |
| Policy engine | Rules and authorisation decisions | The model's self-editable instruction file |
| Capability broker | Actual rights, scope, expiry and revocation | An unrestricted general-purpose proxy |
| OS adapter | Platform-specific enforcement | A semantic policy authority that silently changes meaning |
| State/provenance service | Versioned task state and source lineage | Unbounded personal-memory collection |
| Audit service | Independent event recording and verification | A log writable only by the agent being audited |
| Shepherd | Service lifecycle, dependency and restart supervision | The authorisation engine or complete security boundary |

### 4.3 Runtime sequence

The conceptual lifecycle is:

**OBSERVE → REFLECT → INTEND → COMPOSE → AUTHORIZE → ACT → EFFECT → REMEMBER**

- Observation does not imply consent to retain.
- Reflection does not imply judgement or diagnosis.
- Intention does not authorize action.
- Composition is a proposal until authorized.
- An agent acts only within explicit, bounded permission.
- Effects are recorded and attributable.
- Memory is purpose-bound, minimized, inspectable and subject to human control.

This is a governance and architecture model, not an implemented runtime.

## 5. Intent, policy and capability model

### 5.1 Intent is not permission

Example conceptual Scheme declaration:

```scheme
(intent
  (principal "research-agent")
  (action read)
  (resource "corpus/research/")
  (purpose "prepare-literature-review")
  (duration 300))
```

This is a request, not a grant. The policy engine must independently verify principal identity, resource classification, operation, scope, purpose, duration, delegation conditions, revocation state and human-approval requirements.

The model must not be able to enlarge its own authority by editing its intent or policy declaration.

### 5.2 Capability record

Each grant should represent at least:

| Field | Meaning |
|---|---|
| Principal | Exact holder identity |
| Issuer | Trusted authority that issued the grant |
| Resource | Object or service being accessed |
| Operation | Read, write, execute, communicate or another explicit operation |
| Scope | Exact permitted objects and constraints |
| Purpose/context | Task context, where policy uses it |
| Issued-at / expiry | Validity interval |
| Delegation | Whether onward delegation is allowed |
| Attenuation | Constraints that child grants must preserve or narrow |
| Revocation | Revocation handle/state and propagation semantics |
| Audit identity | Correlation identifier for all uses |

### 5.3 Non-negotiable rules

1. Deny by default.
2. No self-authorised escalation.
3. No implicit privilege inheritance.
4. Child agents receive only explicitly derived and attenuated rights.
5. No unrestricted global filesystem or shell access.
6. No unrestricted network egress.
7. No hidden persistence or unapproved background execution.
8. Agent processes cannot rewrite independent audit records.
9. Expired or revoked rights must fail closed.
10. Irreversible external effects require the configured human approval.
11. An agent's successful task completion does not imply permission to publish or commit.
12. Approval must bind to a specific action, scope and relevant content, not to a vague “continue” instruction.

## 6. Multi-agent cooperation

The system should support specialised principals rather than one omnipotent agent.

Example research task:
1. Human grants a coordinator permission to inspect a defined research area and stage a report.
2. Coordinator requests a read-only source-retrieval capability for a researcher.
3. Coordinator requests a separate read-only analysis capability for an analyst.
4. Each sub-agent receives only the inputs and capabilities required for its task.
5. Coordinator combines results in a staging area.
6. Independent audit records source access, delegation and output lineage.
7. Human reviews the report and separately authorizes any persistent commit or publication.

The design must prevent the common failure where sub-agents inherit the coordinator's entire authority. A child grant must be a subset of its parent's grant, with explicit restrictions on further delegation.

## 7. Technical stack and WARENA integration

| Technology | Proposed role | Status |
|---|---|---|
| GNU Guile / Scheme | Orchestration, policy representation, intent semantics and service glue | Preferred research direction |
| GNU Mach | Microkernel, tasks and IPC | Hurd research substrate |
| GNU Hurd | User-space servers and translators | Experimental OS substrate |
| Shepherd | Service lifecycle and supervision | Existing WARENA preference; not policy enforcement |
| GNU Guix | Reproducible packages and system environments | Primary Hurd integration research path |
| SQLite | Structured state, indexes and provenance metadata | Candidate; requires separate integrity/audit design |
| Native C interfaces | Bounded low-level integration | Use where platform APIs require |
| GNUstep | Possible native human-control interface | Future research candidate |
| QEMU / ChildHurd | Reproducible virtualized Hurd laboratory | Initial experiment environment |
| Git | Versioned policies, source and documentation | Provenance and review, not runtime authorization |

### 7.1 Existing WARENA decisions preserved

- GNU/Linux remains the practical development and production baseline.
- Guix + RDE remains the configuration home.
- Guile/Scheme is preferred for programmable system semantics.
- Local-first, libre-first, inspectable and reproducible operation remain defaults.
- JavaScript is prohibited as a WARENA/IKAI runtime, application language, framework or architectural dependency.
- Web technologies are not the WARENA application/runtime substrate.
- No mandatory cloud, telemetry, DRM, tivoization or remote-execution dependency.
- Preserve upstream authorship, licences, source provenance and a replacement path.
- Existing WARENA repository remains the architecture/configuration home; do not create a separate repository merely for this research banner.

### 7.2 Shepherd boundary

Shepherd can supervise service startup, dependencies, shutdown, restart and logs. It does not, by itself, determine whether an agent is authorized to read a resource, delegate a capability, access a network destination or commit an external effect. Keep service lifecycle and security policy separate.

### 7.3 Persistence and audit

SQLite is appropriate to investigate for structured local state, task metadata and provenance indexes. It should not be described as immutable or tamper-proof. Audit design should consider:
- append-only event interfaces;
- separate service/process authority;
- hash chaining or signed checkpoints where useful;
- external or separately protected checkpoint storage;
- event sequence and causal correlation;
- clock assumptions and time-source provenance;
- retention, deletion and privacy policy;
- recovery and consistency testing.

Cryptographic integrity does not prove that an event is truthful or complete. It only helps detect certain forms of modification.

## 8. GNU/Linux and GNU Hurd adapters

Keep the semantic contract independent of platform-specific enforcement.

| Shared contract | GNU/Linux research adapter | Hurd research adapter |
|---|---|---|
| Principal/task identity | Process credentials and separately managed identity | Mach task/port identity research |
| Resource scope | Linux filesystem/process isolation mechanisms | Hurd namespace and translator experiments |
| IPC | Unix sockets or selected native IPC | Mach IPC |
| Network egress | Namespace/firewall/proxy enforcement | Hurd network-service feasibility |
| Service lifecycle | Shepherd plus OS-specific controls | Shepherd/Hurd service integration investigation |
| Resource quotas | Linux resource-control interfaces | Hurd support must be verified per mechanism |
| Audit | Separate privileged audit service | Separate Hurd audit server/service research |

Do not assume equivalent security from superficially similar APIs. Each adapter must document what it can enforce, what it cannot enforce, and how tests establish the boundary.

## 9. Threat model and security test requirements

Assume the model can be wrong, manipulated by untrusted content, compromised or induced to produce unsafe requests. Assume tools, packages, translators, external services and network peers can fail or be compromised.

| Test ID | Test | Acceptance condition |
|---|---|---|
| SEC-01 | Read-only isolation | Agent cannot modify protected resources through any tested path |
| SEC-02 | Scope enforcement | Out-of-scope access is denied |
| SEC-03 | Capability expiry | Expired grants fail closed |
| SEC-04 | Revocation | Revoked grants cease to authorize subsequent access; propagation limits documented |
| SEC-05 | Delegation attenuation | Child receives no rights beyond the approved subset |
| SEC-06 | Principal attribution | Every operation is attributable to a principal and grant |
| SEC-07 | Audit separation | Agent cannot silently rewrite or suppress independent records |
| SEC-08 | Network egress | Unapproved outbound destinations are blocked |
| SEC-09 | Resource quotas | Runaway process/resource use is bounded |
| SEC-10 | Untrusted content | Retrieved instructions cannot modify policy or authority |
| SEC-11 | Recovery | Interrupted tasks leave a known, recoverable state |
| SEC-12 | Human approval | Consequential action cannot bypass the required approval channel |
| SEC-13 | Cross-substrate consistency | Equivalent policy requests have equivalent intended semantics; adapter differences are explicit |
| SEC-14 | Reproducibility | Environment and test inputs can be reconstructed from pinned declarations |

A passing unit test is not a complete security proof. Record the threat, test environment, platform revision, exact command, expected and actual result, limitations and reviewer.

## 10. Development and research roadmap

### Phase 0 — Formal architecture and threat model

Deliver:
- principal and agent identity model;
- intent schema;
- policy semantics;
- capability lifecycle and delegation rules;
- approval protocol;
- audit event schema;
- state and recovery model;
- platform adapter contracts;
- threat model and test plan.

**Gate:** no autonomous execution beyond a disposable, non-sensitive test environment until the authority model and failure boundaries are reviewed.

### Phase 1 — GNU/Linux + Guix prototype

Build the smallest practical prototype:
- Guile intent parser and policy evaluator;
- explicit capability broker interface;
- read-only filesystem scope;
- disposable task execution;
- resource and network restrictions;
- SQLite task/provenance state;
- independent audit service;
- staged outputs and human-approved persistence.

**Gate:** demonstrate denial, expiry, attribution and audit separation before expanding tool access.

### Phase 2 — ChildHurd / QEMU laboratory

1. Boot documented 32-bit and 64-bit ChildHurd environments where supported.
2. Pin and record image, Guix, Mach and Hurd revisions.
3. Launch independent test services.
4. Inspect Mach port rights and transfer semantics.
5. Prototype a minimal read-only translator.
6. Test namespace visibility and backing-resource access.
7. Test task termination, service restart and outstanding rights.
8. Test resource exhaustion and failure recovery.
9. Investigate controlled networking and egress.
10. Record blockers and unsupported assumptions.

**Gate:** repeatable boot and experiments with logs. No production claim.

### Phase 3 — Hurd integration experiments

Investigate:
- identity and authorization across Mach IPC;
- capability issuance and revocation patterns;
- translator ownership and lifecycle;
- independent audit service feasibility;
- Shepherd supervision and failure recovery;
- package/build support in Guix/Hurd;
- resource controls and network restrictions.

**Gate:** written evidence for each claimed property, including limitations. Do not port the entire runtime until the minimal experiments justify it.

### Phase 4 — Cross-substrate semantics

Implement the same intent and policy test suite against Linux and Hurd adapters. Differences in enforceability must be surfaced rather than hidden.

### Phase 5 — Human interface

Only after the authority model is stable, investigate a native GNUstep interface for:
- task and agent inspection;
- permission review;
- approval of specific operations;
- capability revocation;
- audit inspection;
- staged-output review;
- recovery and shutdown.

The interface must not become the sole enforcement point. Closing or bypassing the UI must not remove system-level controls.

## 11. African intellectual traditions: situated design questions

The African Renaissance framing is an interpretive design programme. The traditions below are distinct in origin, history, language and meaning. They are not interchangeable, and none is claimed to have historically anticipated contemporary agentic computing.

| Tradition / concept | Context | Design question it can inspire |
|---|---|---|
| Sankofa | Akan | How can a system preserve provenance, recover history and learn from prior decisions without treating the past as infallible? |
| Ma’at | Ancient Egyptian | How should truthfulness, justice, balance and accountable order inform system conduct? |
| Ubuntu | Nguni Southern Africa | How should systems recognise relational effects and human dignity? |
| Harambee | Kenya; modern national/community mobilisation context | How can people and agents cooperate toward shared goals while retaining bounded authority? |
| Ujamaa | Tanzania; Nyerere's political philosophy | How can shared infrastructure and cooperative resources be governed? |
| Omoluabi / Iwa Pẹ̀lẹ̀ | Yorùbá | How should integrity, character and responsible conduct inform evaluation of actions? |
| Gadaa | Oromo | What can institutional governance, succession and accountability teach about authority transitions? |
| Ifá | Yorùbá | How should interpretive knowledge traditions be studied with respect for context, expertise and transmission? |
| Fihavanana | Malagasy | How should reciprocal obligation and social relations be represented without flattening local meanings? |
| Oruka's Sage Philosophy | Kenya; Henry Odera Oruka | How can independent reasoning, disagreement and attributed intellectual contributions be preserved? |

These are research correspondences, not technical derivations or universal “African values.” Further work must consult language-specific scholarship, primary sources and community context. In particular, Turkana and Ateker intellectual traditions require original, properly attributed research; do not import other peoples' concepts as substitutes.

### 11.1 Constitutional interpretation

- **Sovereignty:** authority remains with the human principal.
- **Critical inquiry:** agents can question, compare and disagree; no model output becomes truth merely because it is fluent.
- **Memory:** preserve provenance and allow correction; do not create unbounded surveillance memory.
- **Cooperation:** shared work does not imply shared unrestricted permissions.
- **Accountability:** actions and effects must remain inspectable.
- **Human dignity:** no person scoring, diagnosis, covert profiling or automatic judgement.

## 12. Cross-domain boundaries

| Domain | Relationship to WAOE |
|---|---|
| WARENA / CAPABILITY | Owns infrastructure, OS architecture, runtime contracts, packaging, supervision and technical evidence |
| FELOH Corpus | Owns shared governance, research provenance, concept definitions and evidence standards |
| IKAI / MIRROR | May investigate human-facing reflection and participant-controlled interfaces; does not own agent authority or system enforcement |
| GENJE / EXPRESSION | May explore creative and embodied applications; artists, performers and cultural practitioners are not automatically data subjects or agent resources |
| NAKEBUSEN / ROOT | Remains the only live commercial practice and transaction interface; no agentic-OS commercial claims or customer-data processing are implied |

IKAI's “mirror, not a judge” boundary is compatible as an ethical design question, but IKAI is not the policy engine. GENJE may eventually explore creative agent applications, but no sensing, performer profiling or autonomous creative system is implied. The Corpus records shared concepts and source provenance; it does not replace WARENA's technical specification.

**ONLY NAKEBUSEN TRANSACTS.** This research programme does not create another commercial or checkout identity.

## 13. Evidence and maturity controls

Use claim labels: **VERIFIED · CORROBORATED · DISPUTED · UNVERIFIED · INTERPRETATION · OPINION · TESTIMONY · PROPOSAL**.

Use maturity labels: **LIVE · PROTOTYPE · RESEARCH · CONCEPT · HISTORICAL · SUPERSEDED · UNKNOWN**.

For every experiment record:
- date and responsible operator;
- repository commit and source revisions;
- machine/VM and architecture;
- Guix channel/package revisions;
- commands and configuration;
- expected and actual result;
- logs and artefact hashes;
- test limitations and failures;
- security implications;
- reviewer and next action.

A document on main proves that the document is present on main. A successful boot proves only that the tested image booted in the recorded environment. A passing test does not prove all attack paths are closed. A commit does not prove a deployment.

## 14. Decision summary

**Proposed baseline for continued research:**

| Decision | Direction |
|---|---|
| Programme identity | RENAISSANCE BLACK OPS (working banner) |
| Technical programme | WARENA Agentic Operating Environment |
| Practical baseline | GNU/Linux + Guix |
| Experimental OS | GNU Hurd / GNU Mach |
| Hurd laboratory | ChildHurd + QEMU |
| Orchestration and policy language | GNU Guile / Scheme |
| Service supervision | Shepherd, with a strict non-policy boundary |
| Structured state | SQLite candidate |
| Audit | Separate independently protected service |
| Capability model | Explicit, scoped, attenuated, expiring and revocable grants |
| Human authority | Required for consequential actions and persistent publication |
| Desktop interface | Native interface research only after core security gates |
| Portability | Shared semantics, platform-specific enforcement adapters |
| Repository | Existing WARENA repository; no new repository |

This is an architecture research baseline, not a claim that every item is implemented or finally selected after testing.

## 15. Primary and technical reading

### Agentic operating-system research
- Zhao et al., “AgenticOS: An Intent-Oriented Secure Operating System Architecture for Autonomous AI Agents” (2026), [arXiv:2606.15419](https://arxiv.org/abs/2606.15419).
- Li et al., “Ring-0 by Default: Agents as Operating Systems (AaOS)” (2026), [arXiv:2610.23199](https://arxiv.org/abs/2610.23199).

### GNU Hurd, Mach and Guix
- [GNU Hurd project](https://www.gnu.org/software/hurd/).
- [GNU Hurd documentation](https://www.gnu.org/software/hurd/doc/).
- [GNU Mach documentation](https://www.gnu.org/software/hurd/microkernel/mach/).
- [GNU Guix](https://guix.gnu.org/).
- [WARENA GNU Hurd + Nix compatibility and cross-build research](gnu-hurd-nix-compatibility-and-cross-build-2026-11.md).

### African philosophy and governance
- Oruka, H. Odera (ed.), *Sage Philosophy: Indigenous Thinkers and Modern Debate on African Philosophy* (1990).
- Nkrumah, Kwame, *Consciencism*.
- Nyerere, Julius, *Ujamaa: Essays on Socialism*.
- Scholarly and primary research on Ma’at, Sankofa, Ubuntu, Harambee, Gadaa, Ifá, Omoluabi, Fihavanana and other traditions.

Bibliographic entries must be completed and claim-level citations added before treating the philosophical survey as a fully researched comparative study. Do not invent page numbers, quotations or universal translations.

## 16. Related WARENA and Corpus records

- [WARENA README](../README.md)
- [WARENA Technology Constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md)
- [WARENA Spatial Computing, Immersive XR & Opt-in Intelligence Architecture](SPATIAL-COMPUTING-XR-AI-ARCHITECTURE-2026-11-20.md)
- [WARENA GNU Hurd + Nix compatibility and cross-build research](research/gnu-hurd-nix-compatibility-and-cross-build-2026-11.md)
- [FELOH Sovereign Master Corpus](https://github.com/donfelohke/feloh-corpus/blob/main/docs/FELOH-SOVEREIGN-MASTER-CORPUS-2026-11-20.md)
- [FELOH Corpus source register](https://github.com/donfelohke/feloh-corpus/blob/main/docs/source-register.md)

---

**Current status:** RESEARCH / PROPOSED ARCHITECTURE. This document does not claim a working agent runtime, capability broker, secure sandbox, Hurd port, Linux prototype, package, deployment, security proof or commercial product.
