# WARENA — CAPABILITY

**Freedom Is a System.**  
**Authored English interpretation:** THE POWERFUL.

**ONE CORPUS → MANY VIEWS → ONE PRACTICE.**

**Commercial interface: NAKEBUSEN.** WARENA is not a separate commercial checkout.

WARENA is the systems-engineering and infrastructure practice authored by Felix Lwova · Don Feloh · [@donfelohke](https://github.com/donfelohke). It develops and evaluates computing systems that are inspectable, reproducible, recoverable, locally controllable and interoperable.

WARENA is not a separate checkout brand or parent company. It provides technical capability within the wider FELOH practice. Customer-facing engagements, where offered, are scoped and transacted through [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN). **ONLY NAKEBUSEN TRANSACTS.**

## Start here

- [Technology Constitution](docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md) — binding native-first, libre-first, local-first and human-control policy.
- [Architecture](docs/architecture.md) · [Capability map](docs/CAPABILITY-MAP.md) · [Stack register](docs/STACK-REGISTER.md).
- [Desktop architecture](docs/DESKTOP-ARCHITECTURE.md) — current research decisions and compatibility boundaries.
- [Reproducible systems and real-time I/O validation](docs/REPRODUCIBLE-SYSTEMS-AND-REALTIME-IO-VALIDATION-2026-11-24.md) — proposed evidence and test methods.
- [Camera, display and real-time I/O at scale](docs/CAMERA-DISPLAY-REALTIME-IO-SCALE-RESEARCH-2026-11-24.md) — native media, display, buffer and clock-domain research.
- [Documentation index](docs/README.md) — research, runbooks, decisions and source routing.

## Engineering policy

1. **Human authority:** people retain decision rights; agents and automation operate within explicit, reviewable permissions.
2. **Libre-first:** prefer free software, open standards and interoperability. GNU is foundational, not an exclusive boundary.
3. **Local-first:** preserve offline utility, privacy, durable ownership and recoverability.
4. **Native-first:** use native operating-system interfaces and suitable native application technologies; do not make browser application stacks the systems substrate.
5. **JavaScript prohibition:** JavaScript is not an approved WARENA or IKAI application language, runtime, framework or architectural dependency. Static publication and documentation are separate from application architecture.
6. **Reproducibility:** record source revisions, channels, inputs, toolchains, build outputs and validation results.
7. **Do not recreate wheels:** evaluate existing scholarship, standards, projects and hardware; reuse, adapt, interoperate and credit upstream creators.
8. **Honest maturity:** distinguish research, proposal, prototype, implementation, validation and deployment.

See the [Technology Constitution](docs/TECHNOLOGY-CONSTITUTION-2026-11-17.md) for the full policy and its exceptions.

## Current research directions

| Area | Current direction | Evidence boundary |
|---|---|---|
| GNU/Linux systems | Guix and reproducible configuration; RDE evaluated as a configuration layer | Research and configuration records are not a deployed workstation |
| Desktop | X11-first compatibility research; X.Org baseline, XLibre experiment, Gershwin case study; Wayland remains a separately labelled track | No universal compatibility claim |
| Programmable systems | Guile/Scheme and GOOPS where they provide a bounded, maintainable responsibility | Candidate technologies require workload-specific evaluation |
| Real-time I/O | Camera, display, input, audio, buffers, clocks and bidirectional pipelines | Proposed measurements are not measured performance |
| Storage and networking | Local persistence, backup, federation and cooperative networking | Research is not a deployed service |
| Human-controlled agents | Explicit authority, capability boundaries and local execution | No autonomous authority is implied |

## Supporting engineering projects

- [dwl-guile](https://github.com/donfelohke/dwl-guile) — Guile-configurable dwl compositor project; a supporting experiment.
- [home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile) — GNU Guix Home integration for dwl-guile.

These projects retain their own upstream histories and licences. A fork or configuration layer does not transfer upstream ownership. Consult their source and validation records before treating a build or activation as verified.

## Relationship to the wider practice

- [FELOH Corpus](https://github.com/donfelohke/feloh-corpus) — shared identity, governance, evidence and provenance.
- [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN) — ROOT enterprise and sole transaction interface.
- [IKAI](https://github.com/donfelohke/Ikai) — MIRROR / reflective-computing research.
- [GENJE](https://github.com/donfelohke/Genje) — EXPRESSION / creative and embodied practice.
- [Gallery](https://github.com/donfelohke/Gallery) — asset rights, consent and approval.

**GRIT → WARENA.** FELOH remains the human author. WARENA is one distinct practice, not the owner of the other practices.

## Validation and contribution

Before reporting a result, record the exact repository revision, host or target, toolchain/channel versions, commands, complete outcome and known limitations. A successful compile is not runtime validation; a passing test suite is not a deployment; a research note is not an implementation.

See [CONTRIBUTING.md](CONTRIBUTING.md), [GOVERNANCE.md](GOVERNANCE.md), [SECURITY.md](SECURITY.md) and [docs/VALIDATION.md](docs/VALIDATION.md).

---

**WARENA · CAPABILITY · GRIT**  
**Freedom Is a System.**

## Canonical alignment · 27 November 2026

See [Canonical identity alignment](docs/FELOH-CANONICAL-ALIGNMENT-2026-11-27.md) for the dated cross-project definitions, evidence boundaries and repository-specific responsibilities.
