# GNU Guile ecosystem audit — WARENA

**Status:** RESEARCH / ECOSYSTEM SURVEY  
**Review date:** 2026-10-30  
**Target:** GNU Guile 3.0 series; WARENA's Guix / RDE / Shepherd environment  
**Repository:** donfelohke/WARENA  
**Scope:** Ecosystem discovery, architectural classification, WARENA relevance, and qualification plan. This is not a package lock, compatibility certification, build report, or deployment record.

## Executive decision

Adopt a **reuse-first, evidence-gated** approach. GNU Guile is the Scheme runtime; GNU Guix supplies package and system composition; Shepherd owns service lifecycle; WARENA owns policy, integration boundaries, host profiles, evidence, and recovery.

The broad ecosystem is larger than the WARENA implementation need. Do not turn the catalogue into a dependency shopping list. The first qualification set should remain deliberately small:

1. **Core platform:** GNU Guile, GNU Guix, GNU Shepherd.
2. **Concurrency / service primitives:** Fibers; evaluate Goblins only where object-capability or distributed-actor semantics solve a demonstrated requirement.
3. **Integration and data:** Guile-Git, Guile-GnuTLS, Guile-Gcrypt, Guile-JSON, Guile-SQLite3.
4. **Optional application interfaces:** Guile-WebSocket / web utilities, Guile-Mastodon client, Hoot, Artanis — each only after a concrete use case and compatibility review.
5. **Research-only:** OCapN, ERIS, Pubstrate, 8sync, experimental bindings, and other projects without a current WARENA requirement.

**No new Guix configuration, manifest, channel lock, service, or package definition is justified by this survey alone.** The existing RDE/DWL-Guile audit remains separate and authoritative for that desktop integration question.

## 1. Evidence and method

### Primary catalogues

- [GNU Guile Libraries Directory](https://www.gnu.org/software/guile/libraries/) — the GNU-maintained directory says its project list is generated from the GNU Guix package collection and catalogs free-software projects using or enhancing current stable Guile. It is the strongest package-discovery starting point, but not a guarantee that every package is maintained, production-ready, or suitable for WARENA.
- [Guile software catalogue](https://sph.mn/foreign/guile-software.html) — a community-maintained, broader catalogue organised into Scheme-only, extension, and integration projects. It is useful for discovering projects not represented by the official directory; entries require independent maintenance and compatibility checks.
- [GNU Guile releases](https://www.gnu.org/software/guile/news/) and [Guile source repository](https://codeberg.org/guile/guile) — authoritative runtime release and source references.
- [GNU Guix](https://guix.gnu.org/) and [Guix source](https://codeberg.org/guix/guix) — authoritative package collection and package-definition source.

### Interpretation rules

1. A catalogue entry proves discoverability, not maintenance, security, suitability, or successful packaging on WARENA's selected channel.
2. A Guix package definition proves that a package recipe exists at a particular Guix revision; it does not prove that the package builds on the user's machine or that the software is installed.
3. An upstream release is not a WARENA pin. A reproducible pin requires exact upstream commit/tag, Guix channel revision and introductions, dependency closure, license, patches, and a recorded evaluation/build result.
4. Projects in a broad community catalogue may be historical, experimental, unmaintained, or tied to older Guile versions. They are retained for discovery, not automatically recommended.
5. This document is a **survey**, not an exhaustive census of every repository containing Scheme or Guile code.

### Runtime baseline

GNU Guile **3.0.11** is the current stable 3.0-series release identified for this review (released 2025-12-01). It should be the compatibility target for new WARENA evaluation unless a selected Guix channel or upstream dependency establishes a documented reason to test another version. The runtime baseline is not evidence that WARENA currently runs 3.0.11.

## 2. Ecosystem map

The following is a curated map of projects surfaced by the official and community catalogues. It is intentionally grouped by engineering function; it is not a statement that all projects are current or packaged in the same Guix revision.

| Domain | Projects / families discovered | WARENA interpretation |
|---|---|---|
| Runtime, packaging, operating system | GNU Guile, GNU Guix, GNU Shepherd, Guix Build Coordinator, Cuirass, Guix Compose, GWL / GWL-next, Gash, Mes | Core platform and adjacent build/operations tooling. Guix and Shepherd are foundational; the others need specific operational use cases. |
| Concurrency and actors | Fibers, Goblins, 8sync, miniAdapton, coroutines, parallel, OCapN-related projects | Fibers is the first concurrency candidate. Goblins is a capability-oriented actor system, not a generic replacement for every service. 8sync is retained as historical/legacy research pending current compatibility evidence. |
| Networking and protocols | Guile-GnuTLS, Guile-Gcrypt, Guile-WebSocket, Guile-Avahi, DNS, CoAP, ZeroMQ, SSH, IRC, Gemini, OAuth, Telegram, Mastodon client, Pubstrate, OCapN | Reuse protocol libraries selectively. Pubstrate and OCapN are not substitutes for production payment, identity, or federation infrastructure. |
| Data, storage, serialization | Guile-SQLite3, Guile-LMDB, Guile-GDBM, Guile-WiredTiger, Guile-Squee / DBI, Guile-JSON, libyaml bindings, CBOR, protobuf, ERIS, Guile-Git | SQLite and Git fit existing WARENA data boundaries. Add another database or serialization layer only for a measured requirement. |
| Web and publishing | GNU Artanis, Haunt, Hygguile, Guile-Webutils, Guile-Web-Driver-NG, CommonMark, Skribilo, Tissue, Sph-Web-Publish, Kolam | Haunt is relevant to static publishing; Artanis is a framework candidate requiring benchmark and maintenance review, not an automatic backend choice. |
| Graphics, desktop, media | G-Golf, Guile-GI, Guile-GNOME, Guile-Cairo, Guile-OpenGL, Chickadee, Guile-CV, SDL bindings, Wayland-SCM, Ncurses, Plotutils, Inspekt3D | Relevant to graphical or media research; not required for WARENA's initial infrastructure layer. Distinguish bindings' maturity and ABI constraints. |
| Language tools and developer workflow | Nyacc, Guile-Hall, Packrat, parser combinators, Tree-sitter integrations, syntax-highlight, Geiser ecosystem, Guile-Log, Veritas, QuickCheck, SCMUtils | Useful for tooling, parsing, testing, and observability. Select based on concrete development workflow needs. |
| Scientific / numerical | Guile-GSL, Guile-Num, Guile-Charting, FFI bindings for BLAS/CBLAS/FFTW, Atomspace | Specialist research. Native library ABI, numerical reproducibility, and test coverage require separate qualification. |
| Applications embedding Guile | Aisleriot, GnuCash, GNU LilyPond, GNU Mailutils, Snd, TeXmacs, GNU Make, gEDA, OpenCog | Evidence that Guile is used as an extension language in larger applications; not necessarily reusable WARENA libraries. |

### Additional projects and discovery names

The catalogues also surface Guile libraries and applications for UUIDs, regular expressions, XML/XSL, email, JWT, OAuth, INI/CSV/DSV, image formats, libnotify, udev, USB relays, partitioning, Redis, PostgreSQL, SPARQL, QR codes, PCRE, FUSE, inotify, epoll, Avahi, SSH, and assorted SRFI implementations. These remain **discovery leads** until a WARENA requirement, upstream source, license, current maintenance state, Guix recipe, and tests are verified.

## 3. WARENA relevance and disposition

Disposition meanings:

- **REUSE CANDIDATE** — existing upstream component aligns with a present architectural need; still requires exact pin and tests.
- **EVALUATE** — plausible but should not enter the baseline before a concrete use case and qualification.
- **RESEARCH** — valuable architectural or protocol study, not an implementation dependency.
- **HISTORICAL / HOLD** — retain for context; do not choose as a new foundation without new evidence.
- **OUT OF SCOPE** — no current WARENA requirement identified.

| Project | Function | Disposition | Rationale / qualification gate |
|---|---|---|---|
| GNU Guile 3.0.11 | Scheme runtime | **REUSE CANDIDATE** | Target runtime baseline; verify Guix channel's actual Guile package and dependent module compatibility. |
| GNU Guix | Package, system, environment composition | **REUSE CANDIDATE** | Existing WARENA platform direction; channel provenance and reproducible evaluation remain required. |
| GNU Shepherd | Service supervision | **REUSE CANDIDATE** | Natural lifecycle boundary for system and user services; test dependencies, restart semantics, logs, and shutdown. |
| Fibers | Lightweight cooperative threads / synchronization | **REUSE CANDIDATE** | First Guile concurrency library to evaluate for I/O-bound services; test cancellation, blocking boundaries, backpressure, and failure propagation. |
| Guile-Git | Git library bindings | **REUSE CANDIDATE** | Fits Git-canonical source/history and repository automation; verify libgit2 ABI, supported operations, and repository safety. |
| Guile-GnuTLS | TLS bindings | **REUSE CANDIDATE** | Prefer maintained native TLS bindings over bespoke cryptography; verify API coverage, trust configuration, and certificate validation. |
| Guile-Gcrypt | Cryptographic primitives | **REUSE CANDIDATE** | Use established cryptographic libraries, not custom primitives; define supported algorithms and key-handling boundaries. |
| Guile-JSON | JSON parsing / generation | **REUSE CANDIDATE** | General API and metadata integration; test malformed input, encoding, resource limits, and schema validation. |
| Guile-SQLite3 | SQLite bindings | **REUSE CANDIDATE** | Appropriate for generated indexes, local metadata, and projections; Git remains canonical source/history. |
| Goblins | Capability-oriented actor system | **EVALUATE** | Strong fit only where object-capability isolation, actors, or distributed object references materially simplify the design. Evaluate authority boundaries, persistence, observability, and recovery. |
| OCapN | Object-capability networking protocol work | **RESEARCH** | Protocol/design research, not a production-ready WARENA network dependency. Verify current specification and implementation maturity before any adoption. |
| Hoot | Scheme-to-WebAssembly compiler/toolchain | **EVALUATE** | Potential browser/client-side Scheme path; test module support, generated artifact size, browser compatibility, and boundary to server-side Guile. |
| Guile-WebSocket / Webutils | Web transport and helpers | **EVALUATE** | Only for an actual interactive service; test protocol compliance, TLS termination, concurrency, limits, and maintenance. |
| Guile-Mastodon | Mastodon API client | **EVALUATE** | Client library, not a Mastodon server or federation stack. Verify API coverage, pagination, OAuth, streaming, and instance compatibility. |
| Haunt | Static site generator | **EVALUATE** | Relevant to static publishing; compare with the existing website toolchain before adding a parallel generator. |
| GNU Artanis | Guile web framework | **EVALUATE** | Framework capability is not enough; review current release, supported Guile, dependencies, security posture, test coverage, and benchmark against simpler deployment. |
| Guile-GI / G-Golf | GNOME introspection / bindings | **HOLD / EVALUATE** | Different projects and maturity profiles; do not conflate them. Require current upstream status and a concrete desktop API need. |
| ERIS | Content-addressed storage / archival protocol | **RESEARCH** | Could inform immutable content storage; no requirement to replace Git or the existing backup model established. |
| LMDB / WiredTiger / PostgreSQL / Redis bindings | Alternative data stores | **OUT OF SCOPE** | Existing architecture already assigns Git canonicality and SQLite derived indexes. Require measured scale or query needs before introducing another store. |
| Pubstrate | ActivityPub prototype | **HISTORICAL / HOLD** | Useful for protocol history and experimentation, not recommended as a production service foundation. |
| 8sync | Older asynchronous framework | **HISTORICAL / HOLD** | Retain as ecosystem history; compare Fibers and current actor approaches for new work. |
| Chickadee / SDL / Cairo / OpenGL / CV | Graphics and media | **OUT OF SCOPE** | Valuable for GENJE or media research, but not part of the first WARENA systems baseline. |
| Gash / Mes / Cuirass / Guix Build Coordinator | Shell/build/CI ecosystem | **EVALUATE** | Potentially useful in specialised build and automation workflows; avoid duplicating existing Guix/CI capability without a defined gap. |

## 4. Spritely / capability-security ecosystem: correct attribution

The Spritely-related work deserves a separate classification from the general Guile package catalogue:

- **Goblins** is the Scheme object-capability actor system and a substantial technical foundation in the Spritely ecosystem.
- **OCapN** is an object-capability networking protocol effort. Treat it as evolving research / standardisation work, not as a completed Internet standard.
- **Hoot** is a Scheme-to-WebAssembly compiler/toolchain and is relevant to browser-side Scheme experiments.
- **Brassica Chat** and **GoblinShare** are demonstrations / applications illustrating capability-security, distributed and local-first ideas; they should not be described as general-purpose infrastructure packages without separate evidence.
- **Mandy** is an experimental ActivityPub-on-Goblins prototype; do not present it as a production Mastodon replacement.
- **Pubstrate** and **soci-el** are valuable historical experiments. Their original authors' later retrospective cautions against treating them as serious production deployments.

Attribution matters: Spritely is a collaborative project. Do not attribute every repository, prototype, or implementation to Christine Lemmer-Webber personally. Verify each repository's maintainers and contributor history before making authorship claims.

## 5. Architecture implications for WARENA

### 5.1 Proposed boundary

~~~text
WARENA policy and evidence
  ├── human authorization and operational policy
  ├── host profiles, recovery and qualification
  └── application-specific decisions
          |
GNU Guix
  ├── pinned channels and package provenance
  ├── system / home composition
  └── reproducible build inputs
          |
GNU Guile + Shepherd
  ├── Scheme runtime and module layer
  ├── service lifecycle and supervision
  └── logs, restart, shutdown and recovery
          |
Qualified libraries
  ├── Fibers             concurrency
  ├── Guile-Git          Git operations
  ├── Guile-GnuTLS       transport security
  ├── Guile-Gcrypt       cryptographic primitives
  ├── Guile-JSON         interchange
  └── Guile-SQLite3      derived local indexes
          |
Optional research
  ├── Goblins / OCapN    capability-oriented actors and networking
  ├── Hoot               browser-side Scheme
  └── Artanis / Haunt    application and publishing frameworks
~~~

This is a target boundary for evaluation, not a statement that these modules are integrated or installed.

### 5.2 Preserve existing data and authority boundaries

- **Git remains canonical** for authored source, configuration, decision history, and versioned records.
- **SQLite remains derived** for indexes, caches, projections, and local query acceleration. It must be rebuildable from canonical inputs where practical.
- Add LMDB, WiredTiger, Redis, PostgreSQL, or a graph database only when a measured workload establishes a need.
- Do not let a background actor, network peer, or AI component silently gain authority to alter canonical state. Human authorization remains explicit.
- Use Shepherd for service lifecycle rather than inventing a parallel supervisor.
- Do not expose a Guile REPL or remote evaluation endpoint in a production profile without an explicit threat model, access-control design, and disable/recovery procedure.

### 5.3 Relationship to RDE and DWL-Guile

This audit does not supersede [RDE + DWL-Guile reuse audit](./RDE-DWL-GUILE-REUSE-AUDIT-2026-10-28.md). That document addresses the desktop integration path and records a source-age mismatch between the observed RDE and older DWL-Guile/Home-service sources. The broader ecosystem survey does not resolve that compatibility risk.

RDE is a Guix configuration framework, not a substitute for Guile itself. DWL-Guile is a compositor experiment, not a general-purpose Guile service framework. Keep their qualification gates separate.

## 6. Package and source verification status

The catalogue review identifies package and project names, but this pass has **not** produced a pinned Guix channel snapshot or a package-by-package source audit. Therefore the following remain explicitly unknown:

- exact Guix channel revision used for any future WARENA environment;
- exact package version and source commit selected by that channel;
- package recipe inputs, patches, native inputs, and build-system details;
- license and transitive license obligations for each selected package;
- Guile 3.0.11 compatibility of each candidate;
- test-suite status, CI status, known vulnerabilities, and maintenance activity at the chosen revision;
- successful evaluation, build, installation, or runtime behaviour on a named host.

Do not copy package versions from a moving Guix branch into a lock file. Do not infer package availability from a package name appearing in a catalogue without checking the selected channel revision.

### Required source audit fields

| Field | Required evidence |
|---|---|
| Project / Guix package name | Exact package name in selected channel |
| Upstream repository | Canonical source URL |
| Upstream revision | Exact tag or commit SHA |
| Guix channel | URL, commit SHA, introduction and fingerprint |
| Package definition | File path and line range at pinned Guix revision |
| Guile compatibility | Declared/tested Guile versions and observed result |
| License | SPDX identifier or verified license text |
| Dependency closure | Direct/native inputs and relevant system libraries |
| Maintenance | Latest release/commit, issue/PR activity, maintainer status |
| Security | Advisories, vulnerability history, exposed interfaces |
| Tests | Test command, exit status, logs, skipped tests |
| WARENA disposition | Reuse / adapt / test / hold / reject, with rationale |

## 7. Qualification plan

| Stage | Work | Acceptance evidence | Current status |
|---|---|---|---|
| E0 — catalogue | Discover projects from official Guile and community catalogues | Curated domain inventory and source links | **DONE — survey only** |
| E1 — shortlist | Select packages against actual WARENA requirements | Small candidate set and explicit exclusions | **DONE — provisional** |
| E2 — channel pin | Select and authenticate one coherent Guix channel set | Channel URLs, exact commits, introductions and fingerprints | **NOT STARTED** |
| E3 — package source audit | Inspect each selected package definition and upstream revision | Package/source/license/dependency matrix | **NOT STARTED** |
| E4 — compatibility | Evaluate Guile 3.0.11 and package compatibility in the selected channel | Evaluation logs and documented exceptions | **NOT STARTED** |
| E5 — isolated build | Build a minimal non-production profile | Commands, exit status, logs, store paths, provenance | **NOT STARTED** |
| E6 — runtime tests | Exercise Fibers, Git, TLS, JSON, SQLite, Shepherd service lifecycle | Automated test results, failure cases, resource limits | **NOT STARTED** |
| E7 — integration decision | Decide whether any candidate belongs in WARENA baseline | Reviewed source-level integration specification | **NOT STARTED** |

### Suggested first package audit order

1. GNU Guile / GNU Guix / GNU Shepherd — establish the runtime and service baseline.
2. Fibers — concurrency primitive.
3. Guile-Git — canonical source/history operations.
4. Guile-GnuTLS and Guile-Gcrypt — transport and cryptographic boundaries.
5. Guile-JSON — interchange.
6. Guile-SQLite3 — derived local data.
7. Goblins — only if capability-oriented actors solve a concrete problem.
8. Hoot, Guile-Mastodon, Haunt, Artanis — only if their application use cases are approved.

No channels.scm, manifest.scm, guix.scm, or system/Home configuration should be created until E2 establishes a coherent pin and E3 confirms package compatibility. This follows the existing WARENA rule: research precedes implementation; a package list is not a build plan.

## 8. Non-goals and explicit exclusions

This survey does not:

- declare any Guile package LIVE, installed, built, or deployed on WARENA hardware;
- create a new Guix channel, manifest, package definition, Shepherd service, or production configuration;
- certify current maintenance, security, API stability, or Guile 3 compatibility for every catalogue entry;
- recommend replacing Git with a database or adopting multiple storage engines;
- recommend Pubstrate, Mandy, OCapN, or a prototype as a production social/federation service;
- authorise remote Scheme evaluation, autonomous state changes, or unattended deployment;
- change the separate Sway / DWL-Guile desktop qualification decision.

## 9. References

1. GNU Guile Libraries Directory — https://www.gnu.org/software/guile/libraries/
2. GNU Guile news and releases — https://www.gnu.org/software/guile/news/
3. GNU Guile source — https://codeberg.org/guile/guile
4. GNU Guix — https://guix.gnu.org/
5. GNU Guix source — https://codeberg.org/guix/guix
6. Guile software catalogue (community-maintained) — https://sph.mn/foreign/guile-software.html
7. Fibers — https://github.com/wingo/fibers
8. Goblins — https://gitlab.com/spritely/goblins
9. OCapN — https://github.com/ocapn
10. Hoot — https://gitlab.com/spritely/hoot
11. GNU Artanis — https://github.com/artanis-org/artanis
12. Haunt — https://dthompson.us/projects/haunt.html
13. GNU Shepherd — https://www.gnu.org/software/shepherd/
14. GNU Guix package collection — https://codeberg.org/guix/guix/src/branch/master/gnu/packages

Project URLs are discovery references. Re-check canonical repository, current maintainers, release/tag, license, and revision before relying on them in a source-level decision.

---

**Status line:** RESEARCH / ECOSYSTEM SURVEY. No implementation, build, runtime test, hardware qualification, or deployment is claimed.
