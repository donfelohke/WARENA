<!--
FELOH / WARENA CONSOLIDATED IMPLEMENTATION DOCUMENT
Revision: 2026.10-R2
Format: UTF-8 Markdown
This is a working governance and implementation reference. It is not proof that a component is installed or deployed.
-->

# FELOH — Master Technology Register & WARENA Implementation Handbook

**Consolidated edition:** 2026.10-R2  
**Format:** Markdown source (`.md`)  
**Scope:** FELOH · WARENA · NAKEBUSEN · IKAI · GENJE  
**Document purpose:** Maintain a broad technology inventory while preserving a narrow, reproducible implementation baseline and explicit ownership, security, validation, and recovery gates.

## How to use this file

1. Read the governance and status model before treating any technology as a requirement.
2. Use the master register to discover candidates; do not interpret it as an instruction to install every item.
3. Use the WARENA handbook for implementation decisions, provisioning, validation, and recovery.
4. Record decisions, tests, and deployment evidence against a named target.
5. Treat unknown status as unknown. Do not upgrade status based on intention, memory, or a successful build alone.

**Revision note:** This file was regenerated as a new UTF-8 Markdown artifact, with operational appendices added. The detailed body below preserves the consolidated register and handbook material as its source content, followed by additional implementation templates and verification runbooks.

---

## 0. Governance and status model

### 0.1 Three kinds of status must not be conflated

| Status layer | Question answered | Examples |
|---|---|---|
| Technology lifecycle | What role does this technology have in the ecosystem? | `PLANNED`, `EXPERIMENTAL`, `OPTIONAL`, `DEPRECATED` |
| Implementation evidence | What has actually been demonstrated on a specific target? | `UNKNOWN`, `DOCUMENTED`, `CONFIGURED`, `TESTED`, `DEPLOYED`, `PRODUCTION-VERIFIED` |
| Document/design maturity | How authoritative is the decision? | `CANONICAL`, `PROPOSED`, `DOCUMENTED`, `BLOCKED` |

A technology may be `PLANNED` at ecosystem level while its package definition is `CONFIGURED` on a test node; neither fact means it is `PRODUCTION-VERIFIED`. Every implementation claim must identify the target node/profile, date, relevant versions or channel pins, test conditions, and evidence location.

### 0.2 Master implementation statuses

| Status | Definition | Minimum evidence |
|---|---|---|
| `VERIFIED-IN-USE` | Directly observed in active use on a named target | Observation record, target, date, version/configuration where relevant |
| `DOCUMENTED` | Appears in a project record or design | Source document or repository path; does not imply execution |
| `CONFIGURED` | A configuration exists | Exact configuration path and revision; runtime may still fail |
| `TESTED` | A defined test passed | Test definition, environment, result, date, and log/evidence reference |
| `DEPLOYED` | Accepted into a named environment | Deployment record, target, revision, rollback path |
| `PRODUCTION-VERIFIED` | Operational evidence supports production use | Build/provenance, acceptance tests, operational history, monitoring and tested recovery appropriate to the service |
| `PLANNED` | Accepted as a future requirement | Requirement, rationale, owner/domain and acceptance criteria |
| `EXPERIMENTAL` | Being evaluated in a bounded environment | Scope, limitations, test plan and rollback path |
| `OPTIONAL` | Not required for the current baseline | Rationale and activation conditions |
| `BLOCKED` | A dependency, decision, or failure prevents progress | Blocker, impact, next action and review point |
| `DEPRECATED` | Not recommended for new work; retained temporarily or historically | Replacement and removal/migration criteria |
| `UNKNOWN` | Evidence is insufficient to classify it | No claim beyond unknown; inspection required |

The WARENA handbook's statuses `BUILT` and `VALIDATED` remain useful intermediate evidence gates. `BUILT` means the reviewed configuration builds successfully. `VALIDATED` means the defined profile-level acceptance suite—including boot, required services, storage, input/network as applicable, and recovery—passes. These do not automatically imply deployment or production verification.

### 0.3 Governing principles

1. **Human authorship and authorization:** AI and automation may suggest, inspect, transform, or prepare. Consequential execution, publication, permission changes, and customer-facing actions require explicit authorization under the applicable project policy.
2. **Local-first where practical:** prefer local processing, portable data, documented interfaces, and user-controlled export. A cloud dependency must be justified by a real requirement.
3. **Reproducibility and provenance:** record versions, source revisions, build inputs, licenses, and material deviations where practical.
4. **Minimal coherent baseline:** the register is not an instruction to install everything. Add a dependency only when a requirement and acceptance test justify it.
5. **Evidence before claims:** distinguish proposals, package declarations, successful builds, hardware tests, deployment, and sustained operation.
6. **Security and privacy by design:** least privilege, data minimisation, explicit trust boundaries, secret protection, and auditable authorization.
7. **Recovery is part of implementation:** backups require restore tests; rollback plans require a known procedure.
8. **Interoperability and exit:** use documented APIs and portable formats; preserve a path to export and migrate data.
9. **Reversibility:** review diffs, retain known-good generations, stage risky changes, and define rollback before deployment.
10. **Separate observation from inference:** a sensor reading, log, model output, or third-party statement is evidence with context—not automatically ground truth.

## 1. Operating systems, environments and reproducibility

- **Operating systems:** GNU/Linux, GNU Guix System, Debian, Ubuntu, Fedora, Arch Linux, Alpine Linux, FreeBSD.
- **Environment management:** GNU Guix, Guix channels, manifests, profiles, package definitions, system declarations, home environments.
- **Configuration frameworks:** RDE, Guix Home, declarative configuration, dotfiles.
- **Isolation:** QEMU/KVM, virtual machines, containers, namespaces, cgroups.
- **System utilities:** GNU Coreutils, Findutils, GNU `sed`, GNU `awk`, `grep`, `tar`, `gzip`, `xz`, `zstd`.
- **Shells:** Bash, POSIX shell, Zsh, Fish.
- **Reproducibility:** pinned revisions, lockfiles where supported, content hashes, deterministic builds, build provenance, software bills of materials (SBOMs).

## 2. Programming languages and runtimes

- **Systems programming:** C, C++, Rust, Assembly.
- **Functional and configuration languages:** Guile Scheme, Scheme, Emacs Lisp.
- **Scripting:** Bash, POSIX shell, Python, Perl.
- **Web:** HTML, CSS, JavaScript, TypeScript.
- **Data and querying:** SQL, JSON, YAML, TOML, XML.
- **Other languages when required:** Go, Java, Kotlin, Swift, Ruby, PHP, Lua.
- **Runtimes and interpreters:** Python runtime, Guile runtime, JavaScript engines, JVM, .NET runtime.
- **Foreign-function interfaces:** C ABI, language bindings, command-line interfaces, inter-process communication.

## 3. Compilers, build systems and debugging

- GCC, Clang/LLVM, GNU Binutils, GNU `ld`, `ar`, `as`.
- GDB, LLDB, Valgrind.
- GNU Make, Autoconf, Automake, Libtool.
- Meson, Ninja, CMake.
- `pkg-config`, compiler flags, linker flags, build manifests.
- AddressSanitizer, UndefinedBehaviorSanitizer, compiler diagnostics.
- Unit tests, integration tests, regression tests, fuzz testing.
- `perf`, `strace`, `ltrace`, system profiling and tracing.

## 4. Editors, terminals and desktop computing

- **Editors:** GNU Emacs, Vim, Neovim, VS Code.
- **Emacs ecosystem:** Org mode, Magit, Eglot, Emacs Lisp packages.
- **Terminals:** foot, Alacritty, Kitty, WezTerm, tmux, GNU Screen; Tilix remains a previously expressed user preference to resolve per node and desktop environment.
- **Wayland:** Wayland protocols, wlroots, Sway, Niri, dwl, dwl-guile.
- **Desktop components:** D-Bus, XDG portals, PipeWire, WirePlumber.
- **Toolkits:** GTK, Qt, GNUstep.
- **Display and graphics:** DRM/KMS, Mesa, OpenGL, Vulkan.
- **Accessibility and input:** keyboard navigation, input methods, screen readers, high-contrast themes.

## 5. Version control and collaborative engineering

- Git, GitHub, GitHub repositories, GitHub Pages.
- Git branches, commits, tags, releases, merges, rebases.
- Pull requests, code reviews, issues, milestones, discussions.
- CODEOWNERS, contribution guidelines, governance files.
- GitHub Apps, GitHub API, GitHub CLI.
- GitHub Actions, reusable workflows, release automation.
- Dependabot, dependency review, secret scanning, push protection.
- Signed commits and tags, release provenance, changelogs.
- Forge alternatives and mirrors: Codeberg, GitLab, self-hosted Git.
- Git LFS where large binary assets justify it.

## 6. Data, databases and local-first storage

- **Databases:** SQLite, PostgreSQL, MariaDB, MySQL.
- **SQLite extensions/features:** FTS5, JSON functions, transactions, indexes, database migrations.
- **Data interchange:** CSV, TSV, JSON, JSON Lines, YAML, TOML, XML.
- **Structured schemas:** JSON Schema, SQL constraints, data dictionaries.
- **Search:** SQLite FTS5, Tantivy, Meilisearch, OpenSearch, Elasticsearch when justified.
- **Caching:** filesystem caches, SQLite caches, Redis where a shared service is necessary.
- **Local-first design:** append-only records, event logs, conflict handling, exportable data, offline operation.
- **Integrity:** checksums, content hashes, provenance records, validation rules.
- **Interoperability:** CSV exports, documented APIs, stable identifiers, open formats.

## 7. Research, evidence and knowledge infrastructure

- Markdown, Org mode, reStructuredText, AsciiDoc.
- BibTeX, BibLaTeX, CSL, citation managers.
- Zotero, JabRef, Pandoc.
- PDF extraction, OCR, document parsing, metadata extraction.
- Search and retrieval, full-text indexes, metadata catalogues.
- Knowledge graphs, controlled vocabularies, taxonomies, ontologies.
- Primary-source archives, annotated bibliographies, research dossiers.
- Source URLs, access dates, quotations, page references, provenance.
- Evidence classifications: verified, corroborated, disputed, unverified, interpretation, opinion, testimony.
- Decision records, technical standards, versioned policies, change logs.
- Automated link checks, citation checks, schema validation.
- File formats: PDF, EPUB, HTML, DOCX, ODT, CSV, XLSX, PPTX.

## 8. Networking, communications and connectivity

- **Network fundamentals:** Ethernet, Wi-Fi, TCP/IP, IPv4, IPv6, CIDR, subnetting, routing, switching, MTU.
- **Core services:** DNS, DHCP, NTP, mDNS, reverse DNS.
- **Network management:** `iproute2`, `ethtool`, `iw`, `nmcli`, NetworkManager, systemd-networkd.
- **Firewalls:** nftables, iptables, firewalld, OPNsense, pfSense.
- **Network analysis:** tcpdump, Wireshark, iperf3, `mtr`, traceroute, ping, `ss`, `dig`.
- **Remote access:** OpenSSH, mosh, WireGuard, IPsec, OpenVPN.
- **Network segmentation:** VLANs, subnets, guest networks, management networks, ACLs.
- **Resilient networking:** multi-WAN, ISP failover, QoS, traffic shaping, load balancing.
- **Wireless:** Wi-Fi 5/6/6E/7, access points, mesh networking, wireless bridges.
- **Local and decentralised networking:** GNUnet, peer-to-peer protocols, local service discovery, offline caches.
- **Infrastructure protocols:** HTTP/HTTPS, TLS, SSH, SFTP, SMB, NFS, WebDAV, MQTT.
- **Network services:** DHCP reservations, local DNS resolvers, reverse proxies, VPN gateways.

## 9. Servers, systems administration and infrastructure

- Linux system administration, users, groups, permissions, processes and services.
- systemd, Shepherd, runit, OpenRC.
- GNU Guix services, service configuration, system generations and rollback.
- SSH administration, remote shell, SFTP and remote command execution.
- Web servers: Nginx, Apache HTTP Server, Caddy.
- Reverse proxies, TLS termination, virtual hosts.
- Application services, scheduled jobs, cron, systemd timers.
- Virtualisation: QEMU, KVM, libvirt, virt-manager.
- Containers: Podman, Docker, containerd, OCI images.
- Infrastructure automation: Ansible, Salt, Nix, Terraform/OpenTofu where appropriate.
- Configuration management, service health checks, capacity planning.
- Hardware diagnostics, firmware updates, SMART monitoring, thermal monitoring.
- Edge computing, local services, LAN-hosted applications and offline-first infrastructure.

## 10. Storage, backups and disaster recovery

- **Filesystems:** ext4, Btrfs, XFS, ZFS, FAT32, exFAT.
- **Storage management:** partitioning, LVM, RAID, filesystem quotas.
- **Encryption:** LUKS/dm-crypt, encrypted archives, encrypted backups.
- **Backup tools:** Restic, BorgBackup, rsync, `rclone`, `tar`.
- **Snapshots:** Btrfs snapshots, ZFS snapshots, filesystem-level rollback.
- **Data integrity:** checksums, hash verification, SMART tests.
- **Replication:** Git remotes, file synchronisation, database backups.
- **Recovery:** bootable recovery media, rescue environments, restore procedures, recovery objectives.
- **Backup destinations:** external drives, local servers, remote storage, offline copies.
- **Operational practice:** backup schedules, retention policies, restore drills, recovery documentation.

## 11. Cybersecurity, identity and privacy

- Linux permissions, Unix users and groups, sudo, least privilege.
- SSH keys, key rotation, hardware security keys, MFA.
- LUKS, TLS, certificate management, encryption at rest and in transit.
- GnuPG, OpenPGP, age, password managers.
- Threat modelling, attack-surface analysis, security reviews.
- nftables, network isolation, VPNs, service hardening.
- Secret management, environment variables, secret scanning.
- Software supply-chain security, SBOMs, dependency pinning.
- Code signing, signed commits, release attestations.
- Vulnerability tracking, patch management, CVE review.
- Audit logs, access logs, incident response procedures.
- Privacy by design, data minimisation, local processing.
- Security testing: Semgrep, CodeQL, ShellCheck, static analysis, fuzzing.
- Policy frameworks when required: CIS Benchmarks, NIST Cybersecurity Framework, OWASP guidance.
- No unnecessary telemetry, tracking, DRM or forced cloud dependencies in the preferred architecture.

## 12. Web development, design and publishing

- **Web foundations:** HTML, CSS, JavaScript, TypeScript, HTTP, HTTPS.
- **Layouts:** CSS Grid, Flexbox, responsive design, fluid typography.
- **Accessibility:** semantic HTML, keyboard access, WCAG guidance, contrast testing, reduced-motion support.
- **Frameworks:** Astro, Eleventy, Hugo, Jekyll, Svelte, React, Vue, SolidJS.
- **Styling:** vanilla CSS, design tokens, CSS custom properties, utility CSS when justified.
- **Content:** Markdown, MDX, structured data, static assets, content collections.
- **Hosting:** GitHub Pages, static hosting, self-hosted Nginx/Caddy, other hosting providers where needed.
- **Search and metadata:** canonical URLs, XML sitemaps, robots directives, Open Graph, social preview metadata.
- **Testing:** Playwright, Vitest, browser developer tools, Lighthouse, axe-core.
- **Website quality:** link checking, HTML validation, image optimisation, responsive checks, browser-console checks.
- **Internationalisation:** English default, Kiswahili toggle, translation files, locale-aware content.
- **User experience:** information architecture, user journeys, content design, conversion measurement without intrusive tracking.
- **Brand design:** typography, colour tokens, logo rules, image direction, tone of voice, brand guidelines.

## 13. AI, machine learning and agentic systems

- **AI interfaces:** model APIs, command-line interfaces, local model interfaces.
- **Local inference:** Ollama, llama.cpp, compatible local inference servers.
- **Model families:** language models, embedding models, speech recognition, speech synthesis, vision models.
- **Model formats and quantisation:** GGUF, quantised weights, model metadata.
- **Retrieval-augmented generation:** document ingestion, chunking, embeddings, retrieval, citations.
- **Vector search:** FAISS, Qdrant, Chroma, pgvector, SQLite-based approaches where suitable.
- **Orchestration:** n8n, Python scripts, Guile scripts, workflow engines.
- **Agent frameworks:** adopt only where a demonstrated need outweighs complexity.
- **Tool integration:** REST APIs, CLI tools, MCP-compatible integrations, webhooks.
- **Evaluation:** test datasets, factuality checks, retrieval evaluation, regression tests.
- **Governance:** human approval, permissions, audit trails, prompt-injection resistance, provenance.
- **Model operations:** version tracking, hardware profiling, resource limits, inference monitoring.
- **Publishing controls:** draft generation, source verification, review, approved release.
- **Core principle:** AI output is assistance, not automatic evidence or authority.

## 14. Automation, workflows and integration

- Bash and POSIX shell scripts.
- Guile Scheme automation.
- Python automation.
- GNU Make and task runners.
- Git hooks, GitHub Actions, scheduled workflows.
- n8n, webhooks, REST APIs.
- Cron, systemd timers, queues and background jobs.
- File watchers, event-driven automation, directory processing.
- Email and messaging integrations where authorised.
- SQLite-backed job tracking and execution logs.
- Retry policies, idempotency, failure handling, rate limits.
- Human-in-the-loop approvals.
- Workflow documentation, test fixtures and audit records.

## 15. Testing, quality engineering and software delivery

- Unit, integration, system and acceptance testing.
- Regression testing, property-based testing, fuzz testing.
- GCC warnings, sanitizers, GDB, Valgrind.
- ShellCheck, checkbashisms.
- Pytest, unittest, Hypothesis.
- CTest, GoogleTest, Catch2 where appropriate.
- Vitest, Jest, Playwright.
- HTML validation, CSS checks, link checking.
- Accessibility audits, keyboard-navigation testing.
- Schema validation, database migration tests.
- Dependency audits, licence checks, SBOM generation.
- Reproducible build checks and clean-environment builds.
- CI pipelines, test reports, release gates.
- Rollback tests, restore tests and operational runbooks.
- Review requirements and explicit release approval.

## 16. Observability, monitoring and performance

- **System monitoring:** `top`, `htop`, `btop`, `vmstat`, `iostat`, `sar`.
- **Hardware:** `smartctl`, `sensors`, `lshw`, `lsusb`, `lspci`.
- **Logs:** journald, syslog, structured logs, log rotation.
- **Metrics:** Prometheus, node_exporter, Grafana.
- **Tracing:** `perf`, `strace`, eBPF tools where appropriate.
- **Network monitoring:** tcpdump, Wireshark, iperf3, Netdata.
- **Application monitoring:** health endpoints, error logs, latency metrics.
- **Alerting:** email, messaging integrations, threshold-based alerts.
- **Performance analysis:** CPU, RAM, disk I/O, network throughput, startup time.
- **Operational records:** incident reports, capacity trends, maintenance logs.

## 17. Hardware, electronics and edge computing

- **Workstations:** x86-64 laptops and desktops, AMD Ryzen and Intel platforms.
- **Compute boards:** ARM SBCs, Rockchip RK3568-class devices, Raspberry Pi-class devices.
- **Networking hardware:** managed switches, routers, access points, multi-WAN gateways.
- **Interfaces:** USB, PCIe, SATA, NVMe, Ethernet, serial, GPIO.
- **Hardware diagnostics:** firmware tools, SMART, memory testing, temperature and power measurements.
- **Embedded development:** C, cross-compilation, serial consoles, bootloaders.
- **Device integration:** udev, Linux device drivers, system services.
- **Edge compute:** local inference, caching, offline services, lightweight databases.
- **Power resilience:** UPS monitoring, safe shutdown, power budgeting.
- **Compatibility records:** exact model, chipset, firmware, kernel and driver versions.

## 18. Creative computing, music and live coding

- **Live coding:** TidalCycles, SuperCollider.
- **Programming:** Haskell for TidalCycles, SuperCollider language, Guile Scheme.
- **Protocols:** MIDI, OSC, JACK-compatible workflows.
- **Audio:** PipeWire, JACK, ALSA, audio routing and device configuration.
- **Visuals:** Processing, p5.js, openFrameworks, Blender.
- **Graphics:** GIMP, Krita, Inkscape, ImageMagick.
- **Video:** Kdenlive, FFmpeg, Blender.
- **Performance:** versioned patches, session notes, reproducible setups.
- **Embodied practice:** movement notation, Laban/Bartenieff frameworks, choreohacking.
- **Documentation:** scores, recordings, source files, licences and provenance.

## 19. Beauty services, customer experience and commerce

This domain is specific to NAKEBUSEN Locs and its digital services.

- **Customer acquisition:** public website, search visibility, social profiles, referrals.
- **Communication:** WhatsApp Business or direct WhatsApp contact, telephone, email.
- **Bookings:** booking request forms, appointment calendar, manual confirmation, reminders.
- **Service catalogue:** service names, descriptions, durations, prices, availability.
- **Payments:** M-Pesa and other locally supported payment methods, subject to verification.
- **Customer records:** minimum necessary contact and appointment data, with controlled access.
- **Operations:** appointment logs, cancellations, customer follow-up, service records.
- **Marketing:** campaign landing pages, approved photography, service FAQs, customer feedback with consent.
- **Business analytics:** booking enquiries, confirmed appointments, conversion rates, repeat visits.
- **Policies:** pricing clarity, consent, privacy, cancellation rules and service limitations.
- **Brand architecture:** NAKEBUSEN Locs • Digital — Powered by WARENA.

Do not collect sensitive customer information merely because a software platform supports it. Commercial booking and customer-data systems must remain under NAKEBUSEN's authority; WARENA supplies enabling technology and must not become a competing customer-facing booking brand.

## 20. Digital services, business operations and administration

- Service catalogues, quotations, invoices, receipts.
- Customer relationship management (CRM), where justified.
- Inventory and asset registers.
- Support requests, issue tracking, service-level expectations.
- Project planning, task tracking, documentation.
- Financial records, bookkeeping and reconciliation.
- Business communications, email and calendars.
- Contract records, licence registers, consent records.
- Service deployment checklists and maintenance schedules.
- Technical audits, network inventories, handover documentation.
- Client backup and recovery procedures.
- Reporting, metrics and business continuity planning.

## 21. Documentation, standards and technical interoperability

- Markdown, Org, reStructuredText, AsciiDoc.
- HTML, PDF, EPUB, CSV, JSON, YAML, XML.
- OpenAPI, JSON Schema, AsyncAPI where applicable.
- RFCs and Internet standards.
- POSIX, Linux man pages, GNU manuals.
- WCAG accessibility guidance.
- OWASP security guidance.
- SPDX and CycloneDX for software component inventories.
- Semantic Versioning, changelogs, release notes.
- Architecture decision records, runbooks, threat models.
- Contributor guides, code of conduct, governance and succession documentation.
- Licences: GPL family, LGPL, AGPL, MIT, Apache-2.0, BSD, Creative Commons, selected according to the asset and intended freedoms.

## 22. Decentralised, offline-first and sovereign technology

- Git-based replication and exportable project history.
- Local-first applications and local databases.
- SQLite and portable file formats.
- Offline documentation and local search.
- LAN services and local DNS.
- Peer-to-peer networking and GNUnet research.
- Local package caches and reproducible builds.
- Self-hosted services where operationally sustainable.
- Encrypted offline backups.
- Portable identity and data export.
- Local AI inference where hardware permits.
- Interoperable protocols and documented APIs.
- No single mandatory cloud provider or AI provider.
- Human-controlled migration, backups and publication.

## 23. Product architecture, systems design and governance

- Requirements engineering.
- System architecture and component boundaries.
- Domain-driven design where useful.
- API and data-contract design.
- Dependency graphs and build graphs.
- Threat models and trust boundaries.
- Failure-mode analysis.
- Architecture decision records.
- Semantic versioning and compatibility policies.
- Contributor onboarding and succession planning.
- Distributed stewardship and documented authority.
- Reproducibility and evidence requirements.
- Separation of conceptual design from implementation evidence.
- Separation of research, experimentation, deployment and production claims.

## 24. Domain ownership across the FELOH ecosystem

| Domain | Primary project | Boundary |
|---|---|---|
| Canonical knowledge, research and governance | FELOH Corpus | Governs knowledge and shared standards; not a substitute for project-specific operational records |
| Reproducible environments and systems engineering | WARENA | Owns technical baseline, infrastructure, provenance, operations and recovery |
| Beauty services, customer experience and transactions | NAKEBUSEN Locs | Owns customer relationship, service promises, pricing, bookings and transactions |
| Technology services and digital products | NAKEBUSEN Digital | Commercial/service-facing digital offer; WARENA supplies enabling technical capability |
| Reflective, privacy-respecting compute | IKAI | Owns reflective-computing concepts and user-agency requirements; implementation depends on WARENA where applicable |
| Creative computing and embodied practice | GENJE | Owns creative practice, live coding, movement research and performance artefacts |
| Public presentation and discovery | Website and publishing layer | Public content must be reviewed, accessible and consistent with the owning domain |
| Cross-project automation | WARENA-managed workflows with project-specific permissions | Shared automation must not collapse project authority or reuse data without authorization |
| Security and recovery | Shared standards, implemented and verified per system | Shared policy; local evidence and controls required on each system |

## 25. Cross-cutting standards for every domain

- **Evidence:** distinguish verified facts from proposals, interpretation and opinion.
- **Reproducibility:** pin or record dependencies and versions wherever practical.
- **Security:** least privilege, secrets protection and explicit trust boundaries.
- **Privacy:** collect the minimum necessary data and prefer local processing where appropriate.
- **Interoperability:** use documented interfaces and portable formats.
- **Resilience:** maintain backups and test recovery, not just backup creation.
- **Quality:** automate checks and require review for consequential changes.
- **Governance:** document ownership, approval authority and contributor succession.
- **Maintainability:** prefer a small coherent base over unnecessary dependencies.
- **Truthfulness:** do not label a feature production-ready until implementation and operation have been verified.

## 26. Master status register template

Use one record per technology **per target or project context**, rather than assigning one global status to a technology name.

| Field | Required content |
|---|---|
| Record ID | Stable identifier |
| Technology/component | Exact package, service, standard, tool or system |
| Owning domain | FELOH, WARENA, NAKEBUSEN, NAKEBUSEN Digital, IKAI, GENJE, or shared |
| Purpose/requirement | Why it is needed; link to requirement or decision |
| Lifecycle status | `PLANNED`, `EXPERIMENTAL`, `OPTIONAL`, `DEPRECATED`, etc. |
| Implementation status | One of the evidence statuses in §0.2 |
| Target | Machine, node, repository, service, or customer environment |
| Version/source | Version, package source, channel revision, URL or commit |
| Configuration | Repository path and revision, if applicable |
| License/provenance | License and source provenance as relevant |
| Verification | Test name, date, result, and evidence path |
| Risk/limitation | Compatibility, resource, privacy, security or operational caveats |
| Decision owner | Person/role authorized to accept the change |
| Next action | Explicit action or `NONE`; include review date if blocked |

## 27. Register-to-handbook crosswalk

| Register domains | WARENA handbook coverage | Integration treatment |
|---|---|---|
| 1 Operating systems/reproducibility; 2 languages; 3 compilers/build/debugging | Channels, Guix/RDE architecture, package/build workflow, implementation phases | Handbook defines the immediate Guix/RDE implementation path; other systems and tools remain alternatives until a requirement selects them |
| 4 Editors/terminals/desktop; 18 creative computing | Desktop migration, Emacs-centred environment, optional software inventory | Keep desktop alternatives explicit; choose and record terminal/editor/audio tools per node and task |
| 5 Version control/collaboration; 14 automation; 15 testing/delivery | Git, provenance, change control, validation and deployment records | Repository review, explicit diffs, tests, and approval are release gates |
| 6 Data/storage; 7 research/knowledge; 21 documentation/interoperability; 22 sovereign/offline | Records, SQLite and local tools, backups, versioned declarations | Prefer portable data and local records; select databases/search tools only when scale or concurrency warrants them |
| 8 Networking; 9 servers/infrastructure; 16 observability | Core services, system services, hardware/network checks, operations | Use Shepherd as WARENA's Guix-native supervisor; systemd and other supervisors are ecosystem alternatives, not a second simultaneous baseline |
| 10 storage/DR; 11 security/privacy | LUKS/Btrfs where appropriate, Restic, secrets handling, recovery runbooks | Backup and restore evidence are mandatory; filesystem and encryption choices depend on hardware and recovery requirements |
| 12 web/publishing; 19 commerce; 20 digital services | Not fully implemented by the WARENA machine handbook | Separate project specifications required; NAKEBUSEN retains commercial/customer authority |
| 13 AI/ML/agents | Optional local inference, human authorization and privacy controls | Keep optional and resource-bounded; no agent receives authority merely by being integrated |
| 17 hardware/edge | Hardware inventory, live ISO, firmware decision gate and acceptance tests | Record exact model/chipset/firmware/kernel/driver; do not infer compatibility from product family alone |
| 23 architecture/governance; 24 domain ownership; 25 cross-cutting standards; 26 statuses | Governing rules, decision records, status register and completion criteria | Master register governs inventory and domain boundaries; handbook governs WARENA implementation procedures |

## 28. Reconciliation decisions and unresolved selections

The following are not contradictions to be “solved” by installing every alternative. They are explicit selection points.

1. **Operating system baseline:** GNU Guix System + RDE is the WARENA target. Debian, Ubuntu, Fedora, Arch, Alpine and FreeBSD remain in the broad register for compatibility, client work, testing or future needs; they are not co-equal components of one host installation.
2. **Service supervision:** GNU Shepherd is the primary Guix/RDE target. systemd, runit and OpenRC remain alternatives for other environments and client systems.
3. **Wayland compositor:** the WARENA handbook's transition is Sway to `dwl-guile` + `dtao-guile`; Niri and other compositors remain listed alternatives, not an instruction to combine sessions. The `dwl-guile` target remains experimental until verified on the actual hardware.
4. **Terminal:** the WARENA handbook lists foot/Alacritty as the current draft preference, while Tilix is a previously stated preference. Resolve per node and actual Wayland requirements; do not silently elevate one to a universal canonical choice.
5. **Repository root spelling:** the earlier handbook uses `warema/` in its proposed repository tree and checklist. This integration does not silently rename existing paths. Before creating the repository, decide whether `warena/` is the canonical spelling; if so, approve a diff and update all references consistently. Until that change is made, treat `warema/` as a documented draft typo/legacy string, not a verified existing repository.
6. **Kernel and firmware:** Linux-libre is preferred where it supports required hardware. Nonguix is an explicit, documented exception only after a concrete compatibility need is established.
7. **Storage:** LUKS and Btrfs are preferred candidates where appropriate, not universal mandates. Final layout depends on device, encryption, boot, snapshot, and recovery requirements.
8. **Database/search:** SQLite is the lightweight local-first default candidate. PostgreSQL/MariaDB/MySQL and dedicated search/vector services are selected only when concurrency, data volume, service boundaries, or measurable requirements justify their operational cost.
9. **AI/local inference:** llama.cpp is an optional candidate; Ollama and other interfaces remain alternatives. No model, accelerator, or inference server is presumed installed or hardware-compatible.
10. **Cloud and forge services:** GitHub and GitHub Pages are in the register, not compulsory infrastructure. Codeberg, GitLab, self-hosted Git, and other hosting choices remain available according to portability, collaboration, privacy, and continuity requirements.
11. **Commerce and customer records:** NAKEBUSEN owns transactions, customer communications, prices, consent, and booking policy. WARENA provides enabling systems under explicit access controls; it must not become a parallel booking brand or data owner by default.
12. **Status truthfulness:** all phase checklist items in Part II remain unchecked unless completion is supported by direct evidence. This document has not inspected the user's current workstation or repositories and therefore does not certify any package, machine, service, or workflow as deployed.

## 29. Immediate controlled workflow

1. Inventory the actual workstation and current repositories before modifying anything.
2. Record hardware, firmware, storage layout, OS/Guix version, channels, active generations, current desktop, critical services, and backup state.
3. Compare the observed state with the WARENA handbook and master register; mark unknowns as `UNKNOWN`, not as failures or successes.
4. Produce a proposal-only diff for repository naming, channel pins, system/home declarations, and desktop transition.
5. Review the diff for security, data-loss, privacy, license, and rollback implications.
6. Build in the safest available test context; do not make a daily-driver reconfiguration the first experiment when a VM, spare disk, or live environment can validate the change.
7. Run the documented acceptance tests and record exact results.
8. Test a real restore from the intended backup path.
9. Obtain explicit approval before deploying consequential changes.
10. Update the register and implementation record from observed evidence; never update a status merely because a plan was written.

---

# Part II — WARENA Implementation Handbook

The following handbook is preserved from the previous consolidated edition. Its implementation checklists remain unchecked until completed and verified. The master register in Part I governs inventory scope and ecosystem ownership; this part governs WARENA's concrete technical workflow.

---

## 0. Purpose, scope, and document model

This handbook defines how to evaluate hardware, establish a reproducible GNU Guix/RDE base, configure and operate a WARENA node, migrate the desktop from Sway to a Guile-native target, preserve data, and recover from failure.

WARENA is an **RDE-based, Guile-native computing environment** with WARENA-owned configuration policy, provenance records, operational validation, and recovery discipline. The current target is built around:

- GNU Guix and RDE for declarative system and user-environment composition;
- GNU Shepherd for service supervision;
- Emacs as the central authoring, programming, documentation, and research environment;
- `dwl-guile` as the intended Wayland compositor and `dtao-guile` as the intended status bar;
- Sway as a documented transitional desktop until the target desktop is proven;
- Git, channel pinning, system generations, Btrfs where appropriate, LUKS disk encryption, and Restic for configuration control and recovery;
- optional local inference through `llama.cpp`, enabled only after the base system is stable and privacy rules are documented.

This document unifies the architecture handbook and implementation checklist. It includes policies, target architecture, implementation phases, a verification register, change control, backup and recovery procedures, and operational records. It does **not** assert that all software is installed, that a migration is complete, or that any checklist item has passed.

### 0.1 Document status vocabulary

Use these labels consistently in declarations, records, portfolio descriptions, and status reports.

| Status | Meaning | Evidence required |
|---|---|---|
| **CANONICAL** | A governing design choice or policy | Approved WARENA documentation |
| **DOCUMENTED** | A known or intentionally recorded state | Dated note, configuration, or inventory; not necessarily tested |
| **PROPOSED** | A planned design not yet implemented and validated | Explicit proposal and acceptance criteria |
| **EXPERIMENTAL** | Being tested in a bounded environment | Test record, known limitations, rollback path |
| **BUILT** | The intended configuration builds successfully | Build result and source provenance |
| **TESTED** | A defined test procedure passed | Dated test evidence and test conditions |
| **VALIDATED** | Required build, boot, service, input, storage, and recovery checks passed for the stated profile | Completed validation record with hardware and channel pins |
| **DEPLOYED** | Accepted configuration is in actual use | Deployment record, rollback path, and validation evidence |
| **DEPRECATED** | Retained only for migration, compatibility, or historical reference | Replacement and removal criteria documented |
| **BLOCKED** | A dependency or unresolved failure prevents progress | Blocker, impact, owner/action, and next review recorded |

A status applies to a **specific configuration on specific hardware**, not to a package name in isolation. For example, “dwl-guile: VALIDATED” is incomplete without the machine profile, channel revisions, tested session configuration, and date.

### 0.2 Scope boundaries

In scope:

- channel configuration, provenance, and pinning;
- Guix System and RDE configuration composition;
- system and home declaration separation;
- service management and core tools;
- transitional and target desktop configurations;
- installation, validation, change control, backup, and recovery;
- hardware compatibility observations and optional local inference.

Out of scope unless a later specification explicitly adds them:

- claiming a particular machine has already been installed or tested;
- assuming proprietary firmware is required before testing hardware;
- silently enabling Nonguix or other non-free sources;
- treating local AI inference as an authority to execute actions;
- allowing desktop migration to compromise the ability to boot, work, or restore data;
- treating a mirror, camera, microphone, or other sensor as an unrestricted capture system. IKAI-related sensing must follow its separate consent and privacy rules.

---

## 1. WARENA governing rules

These rules constrain technical choices and operational decisions.

1. **Human remains the author.** The operator owns configuration intent, system policy, approvals, and execution decisions. Automation can assist but must not silently redefine policy.
2. **Capability without unnecessary capture.** Prefer local processing, explicit sensor states, minimal data collection, and clear retention rules. Do not collect data merely because a component can collect it.
3. **Implementation is proven by operation.** A declaration is not proof of a working system. Build, boot, service, input, storage, network, and recovery checks must be performed and recorded.
4. **Runtime layers are replaceable.** The desktop, bar, terminal, and launchers are replaceable layers. They must not become hidden dependencies of system recovery.
5. **Recovery must be exercised.** A backup is not proven until a restore has succeeded. A rollback path is not proven until the operator has confirmed how to use it.
6. **Non-free components are explicit opt-ins.** Nonguix may be used when hardware requires firmware or a kernel unavailable in the chosen libre configuration. Record the reason and scope; do not add it as an undocumented default.
7. **Significant changes must be reversible.** Preserve a known-good generation and a tested path back from risky changes.
8. **Provenance is part of system ownership.** Record which channels, commits, Guix version, declarations, and hardware produced an accepted generation.
9. **Prefer composable declarations.** Compose small, understandable features and service extensions instead of accumulating one opaque monolithic configuration.
10. **Separate policy from observation.** A log or sensor reading is evidence with a source and timestamp, not an unquestionable account of reality.
11. **No hidden operational state.** Manual changes that cannot be reproduced from the repository must be documented, converted into declarations, or removed.
12. **Keep optional capability optional.** AI, experimental compositors, extra services, and additional packages are introduced only when there is a clear use case and a defined test.

### 1.1 Decision rule

When two options are otherwise comparable, prefer the one that is easier to inspect, reproduce, replace, test, and recover. Do not optimize for novelty at the expense of operational control.

---

## 2. Target architecture

```text
Physical hardware
  ├── CPU / GPU / RAM / storage / network / input devices
  └── firmware compatibility assessment
          ↓
RDE Live ISO — evaluation and installation medium
          ↓
GNU Guix System + RDE — declarative base
          ↓
GNU Shepherd — service supervision
          ↓
Wayland runtime
  ├── Transitional: Sway (documented current/default path)
  └── Target: dwl-guile + dtao-guile (experimental until validated)
          ↓
Emacs-centred user environment
  ├── Geiser / Guile
  ├── Magit / Git
  ├── Org-mode / research and operations records
  └── document, completion, and communication tools as required
          ↓
Local tools and optional research services
  ├── SQLite / media / document utilities
  ├── optional llama.cpp and hardware-appropriate acceleration
  └── WARENA-owned policy, provenance, backup, and recovery
```

### 2.1 Architecture layers

| Layer | Responsibility | Ownership rule |
|---|---|---|
| Hardware and firmware | Device operation, compute, storage, input/output | Inventory exact models and observed compatibility |
| Guix channels and package definitions | Software source and build inputs | Pin and record source provenance for accepted configurations |
| Guix System declaration | OS, users, filesystems, kernel, system services | Version-control the declaration; keep secrets out of Git |
| RDE features | Reusable system and home configuration composition | Use RDE’s documented extension model; record local overrides |
| GNU Shepherd | Service supervision | Declare service intent; verify expected runtime state |
| Wayland session | Compositor and graphical session | Keep Sway fallback until target desktop passes acceptance tests |
| Home environment | Emacs, terminal, tools, user-level configuration | Keep separate from system declaration where practical |
| WARENA policy | Pinning, privacy, change control, records, recovery | Store in the repository and apply to each accepted node |
| Backups and recovery | Independent preservation and restoration | Keep backups separate from the system and test restores |

### 2.2 Known transition state

The practical transitional path is **Sway under RDE**, if that is what the chosen RDE configuration supplies and the machine can use reliably. The target path is **`dwl-guile` + `dtao-guile`**. Do not claim the target desktop is the daily driver until the migration and full validation checklist have passed on the actual machine.

### 2.3 Architecture acceptance criteria

The architecture is accepted for a particular machine only when:

- its hardware profile is recorded;
- source channels and their exact revisions are recorded;
- system and home declarations build and are version-controlled;
- a usable session boots and essential services work;
- a prior known-good generation remains available;
- backup and restore have been tested;
- the declared desktop status matches observed reality;
- the operator can explain how to rebuild and recover without relying on undocumented manual state.

---

## 3. Channels, source provenance, and pinning

### 3.1 Channel roles

| Channel | Role | Policy status |
|---|---|---|
| Official GNU Guix | Base package definitions and Guix System | **CANONICAL** |
| RDE | Feature system and coherent configuration defaults | **CANONICAL** |
| `engstrand-config` | Candidate source for `dwl-guile`, `dtao-guile`, and related Guile configuration | **PROPOSED / EXPERIMENTAL** until built and tested |
| Nonguix | Optional full Linux kernel and proprietary firmware where required | **EXPLICIT OPT-IN ONLY** |

The exact channel URL, branch, commit, and authentication/signature expectations must be recorded from the authoritative channel source at implementation time. Do not rely on a moving branch as the only provenance record for an accepted generation.

### 3.2 Pinning record requirements

For every accepted system or home generation, record:

- node identifier and hardware profile identifier;
- channel names and URLs;
- exact commit hashes or equivalent immutable references;
- Guix version and the generation or profile used for the build;
- system and home declaration commit IDs;
- date/time of build and validation;
- result: passed, failed, or partial;
- known exceptions and manual steps;
- whether Nonguix is enabled and why;
- any local patches, substitutions, or overlays needed.

A system that cannot answer “which sources and declarations produced this generation?” is not yet under WARENA control.

### 3.3 Channel workflow

1. Create and review `channels.scm` before relying on the channel set.
2. Include only channels needed for the current phase.
3. Pin each channel using Guix’s supported channel specification for the chosen workflow.
4. Pull the pinned channel set.
5. Record the resolved channel revisions and Guix version in `records/`.
6. Build/reconfigure from the reviewed declarations.
7. Validate the resulting generation.
8. Commit the declarations and provenance record together, without committing secrets.

Use the installed Guix version’s own help and official documentation to confirm command options before executing changes on the daily-driver system. Command syntax can differ across versions and workflows; do not paste unverified commands into a production change.

### 3.4 Nonguix decision gate

Before enabling Nonguix:

1. Test the target hardware using the chosen libre configuration where feasible.
2. Record the exact failing device or function, such as Wi-Fi firmware or graphics support.
3. Determine whether a supported libre or upstream option resolves the issue.
4. If not, document the operational need and the non-free component required.
5. Add only the necessary source/component, with explicit review.
6. Record the change in the hardware report, channel pins, and accepted configuration.
7. Re-run relevant security, boot, network, suspend/resume, and recovery checks.

Do not enable Nonguix merely because it is familiar, convenient, or included in an unrelated example configuration.

---

## 4. Installation and initial provisioning

### 4.1 Before installation

Confirm and record:

- target machine make, model, and exact variant;
- CPU, integrated/discrete GPU, RAM, storage devices and capacities;
- Wi-Fi/Bluetooth chipset and Ethernet controller;
- display, keyboard, touchpad, camera, audio, and other required peripherals;
- firmware/UEFI state and boot method;
- whether the disk contains data that must be preserved;
- whether disk encryption is required and where recovery material will be stored;
- availability of a known-good USB drive and a separate backup drive;
- current RDE Live ISO source and checksum/signature information if published;
- whether the installation is a clean install, replacement, or dual-boot arrangement.

**Data safety:** Verify backups before modifying partitions. Installation can destroy data. Never proceed on the assumption that a disk is empty without checking the actual target.

### 4.2 Evaluation using the RDE Live ISO

1. Obtain the current RDE Live ISO from the project’s authoritative source.
2. Verify the published checksum or signature when available.
3. Flash the image to the intended USB device, carefully checking the destination.
4. Boot the target machine from USB.
5. Test keyboard, pointer/touchpad, display, brightness, audio, Ethernet/Wi-Fi, storage access, and suspend/resume where supported.
6. Record device names, observed behaviour, failures, and workarounds.
7. Check whether required firmware is available under the chosen kernel configuration.
8. Decide to proceed, change hardware, adjust configuration, or explicitly opt into a non-free component.

A live-session success does not prove the installed system will work identically. Repeat critical checks after installation.

### 4.3 Base installation

1. Use the RDE project’s documented installation and configuration approach, adapting only after understanding the base example.
2. Prefer **LUKS + Btrfs** when suitable for the machine and operator’s recovery needs. Document the actual partition and subvolume design rather than assuming one universal layout.
3. Establish the minimum required user account and administrative access.
4. Keep secrets, recovery keys, and passwords out of the repository.
5. Install and reboot into the declared system.
6. Verify disk unlock, filesystem mounts, boot reliability, networking, and Shepherd service state.
7. Confirm that the previous boot medium or another rescue path remains available until the new system is proven.
8. Record the first successful boot and any unresolved defects.

### 4.4 Immediate post-installation

- Configure the intended official Guix and RDE channels.
- Add `engstrand-config` only for the bounded desktop experiment or when otherwise required.
- Add Nonguix only after the explicit decision gate in Section 3.4.
- Pull the intended channel set and record its resolved revisions.
- Apply the initial system and home declarations.
- Reboot and repeat core hardware/service checks.
- Establish the first encrypted Restic backup to a separate device or repository.
- Perform a small test restore before relying on the backup.

---

## 5. Repository layout and declaration architecture

Recommended repository root: `warema/`.

```text
warema/
├── README.md                    # purpose, current status, quick navigation
├── channels.scm                 # channel set and pins
├── system.scm                   # Guix System declaration
├── home.scm                     # Guix Home declaration, if used
├── features/                    # selected RDE and WARENA feature composition
├── services/                    # custom Shepherd/system service extensions
├── desktop/
│   ├── sway/                    # transitional configuration and notes
│   ├── dwl-guile/               # experimental/target configuration
│   └── shared/                  # portable Wayland utilities and scripts
├── packages/                    # local package definitions, if necessary
├── policy/
│   ├── principles.md
│   ├── privacy.md
│   ├── change-control.md
│   └── software-policy.md
├── recovery/
│   ├── boot-recovery.md
│   ├── guix-generation-rollback.md
│   ├── restic-restore.md
│   └── disaster-recovery.md
├── records/
│   ├── hardware/                 # per-machine inventory and compatibility
│   ├── channels/                 # pin and provenance records
│   ├── builds/                   # build and reconfigure outcomes
│   ├── validation/               # test results and evidence
│   ├── backups/                  # backup and restore test records
│   └── decisions/                # architecture decision records
└── tests/                        # repeatable local validation scripts/checklists
```

The directory names are recommendations, not a claim that this structure already exists. Adjust the layout to the actual RDE configuration conventions while preserving the separation of concerns.

### 5.1 System declaration

The system declaration owns machine-wide policy: operating system, kernel selection, bootloader, filesystems, users, required system packages, and system services. It should remain small enough to review and rebuild. Hardware-specific details should be explicit and recorded.

### 5.2 Home declaration

The home declaration owns user-level packages, Emacs configuration, terminal preferences, shell and user tools, and other home-scoped configuration supported by the chosen RDE/Guix Home workflow. Keep user preferences out of the system declaration unless they genuinely require system scope.

### 5.3 RDE feature composition

Use RDE’s feature composition mechanisms to select the desired capabilities. Avoid copying large portions of an RDE configuration when a small feature override will express the intent. Record local deviations from RDE defaults so that an update does not silently change the expected desktop or package set.

### 5.4 Secrets and private state

Never commit passwords, private keys, recovery keys, API tokens, model access credentials, or private personal data. A public configuration repository should describe how secrets are provisioned without containing the secrets themselves. Validate repository history before publishing; removing a secret from the current file does not erase it from Git history.

---

## 6. Core operating system and storage policy

### 6.1 Kernel and firmware

- Prefer Linux-libre when it supports the required hardware and workflow.
- Treat the full Linux kernel and proprietary firmware through Nonguix as explicit exceptions, not invisible defaults.
- Record the reason for each exception and the exact hardware function it enables.
- Re-test relevant hardware after kernel, firmware, or channel changes.

### 6.2 Bootloader and encryption

GRUB and LUKS/cryptsetup are candidate components in the base design. The exact boot arrangement must match the machine’s firmware mode and the chosen Guix System configuration. Confirm that encrypted storage can be unlocked after a cold boot and that the operator has a safe, documented recovery path.

Recovery keys must be stored separately from the encrypted system, protected against unauthorized access, and available to the authorized operator during recovery. Do not store the only recovery key on the volume it unlocks.

### 6.3 Btrfs

Btrfs is preferred where its features and maintenance requirements fit the hardware and workflow. Record the actual filesystem layout, mount options, and snapshot approach. Snapshots can help with short-term rollback, but they are not a substitute for independent backups. Avoid adding subvolume complexity without a specific operational benefit and a tested restore procedure.

### 6.4 Generations

Keep prior known-good Guix system and home generations where supported by the chosen workflow. Before a high-risk change, record the current generation and the method to select or restore it. Confirm that the prior generation remains bootable; do not infer this solely from a generation listing.

---

## 7. Desktop strategy: Sway to dwl-guile + dtao-guile

### 7.1 Transitional desktop

Sway is acceptable as the transitional/default session if it is what the selected RDE configuration provides and it works on the target machine. The transitional desktop is a deliberate risk-control measure, not a rejection of the Guile-native target.

### 7.2 Target desktop

- **`dwl-guile`:** intended compositor and window-management environment.
- **`dtao-guile`:** intended status bar.
- **Supporting tools:** `foot` (preferred terminal in the current draft) or Alacritty; `bemenu` or `rofi-wayland`; `mako` if notifications are used; `grim` + `slurp` for screenshots; `wl-clipboard`; `swaybg` or an appropriate background utility; `wlroots` as required by the selected build/runtime.
- **Audio:** PipeWire + WirePlumber preferred, with compatibility components such as `pipewire-pulse` where needed.

The exact package names, channel locations, and service/session integration must be verified against the pinned sources. Do not assume every listed package is available under the same name or supported by every channel revision.

### 7.3 Migration gates

Do not begin migration until the Sway-based daily driver has passed the stabilization phase. Then:

1. Pin the `engstrand-config` channel and record the commit.
2. Build `dwl-guile` in a controlled environment or non-critical generation.
3. Launch a test session without removing Sway.
4. Test opening and closing applications, focus, movement, tiling/floating behaviour as supported, keyboard bindings, terminal launch, launcher, notifications if used, clipboard, screenshots, audio, display configuration, and exit/recovery from a failed session.
5. Test multiple monitors if relevant to the actual machine.
6. Add and test `dtao-guile` after the compositor itself is usable.
7. Verify bar startup, displayed information, restart behaviour, and failure handling.
8. Add a session entry or equivalent integration using the chosen system’s documented mechanism.
9. Switch the default only after explicit review.
10. Retain Sway configuration and a bootable prior generation for at least one successful validation cycle.
11. Re-run the full validation suite under the new session.
12. Record known limitations, patches, and rollback instructions.

### 7.4 Desktop acceptance criteria

The Guile-native desktop is **VALIDATED** only if it provides a usable session and all required core tasks work reliably on the target hardware. A successful compile alone is only **BUILT**. A compositor that launches but cannot recover from a broken configuration is not accepted as the sole daily-driver path.

---

## 8. Emacs-centred authoring and development environment

GNU Emacs is the primary environment for configuration authoring, software development, documentation, research notes, and operational records.

### 8.1 Core components

- **Emacs:** central editor and working environment.
- **Geiser:** interactive Scheme/Guile development, where compatible with the pinned Emacs/Guile stack.
- **Magit:** Git workflow inside Emacs.
- **Org-mode:** notes, research, tasks, implementation checklists, change logs, and decision records.
- **Completion and navigation:** Vertico, Consult, Embark, Corfu, or the equivalent coherent set already provided by RDE.
- **Documents:** `pdf-tools` or `nov.el` as needed.
- **Mail:** `mu4e` or another selected client only if it has an actual use case and is configured securely.

RDE may already provide many of these components. The list defines the desired capabilities, not an instruction to install duplicates. Inspect the resolved environment before adding packages.

### 8.2 Configuration policy

- Version-control Emacs configuration.
- Prefer declarative package selection and reproducible configuration.
- Avoid uncontrolled package accumulation.
- Record whether a package comes from RDE defaults, a WARENA override, or a manual experiment.
- Keep private mail data, credentials, and sensitive local notes out of public repositories and generic backup manifests.
- Test Emacs startup and the essential Guile/Org/Git workflow after a major reconfigure.

### 8.3 Minimum authoring acceptance test

1. Emacs launches from the intended session.
2. Org-mode opens and saves a local note.
3. Git can inspect and commit the WARENA repository.
4. Magit works if selected.
5. Geiser can connect to the intended Guile environment if configured.
6. The configuration remains recoverable from the version-controlled source and pinned environment.

---

## 9. Software inventory and selection policy

This inventory combines required foundations with optional capabilities. It must not be interpreted as a requirement to install every item.

| Category | Candidate software | Policy / status |
|---|---|---|
| System and packages | GNU Guix, RDE | Canonical foundation |
| Service supervision | GNU Shepherd | Canonical foundation; verify expected service state |
| Kernel | Linux-libre; full Linux via Nonguix if necessary | Libre default; exception documented |
| Storage | Btrfs, `btrfs-progs`, LUKS/cryptsetup | Preferred where suitable; test recovery |
| Boot | GRUB | Configure for actual firmware/layout |
| Desktop | Sway; target `dwl-guile` + `dtao-guile` | Sway transitional; Guile-native target experimental until validated |
| Wayland utilities | `wlroots`, `foot` or Alacritty, `bemenu` or `rofi-wayland`, `mako`, screenshot and clipboard tools | Select only what the session uses |
| Audio | PipeWire, WirePlumber, `pipewire-pulse` if needed | Preferred; validate devices and applications |
| Editor and research | Emacs, Geiser, Magit, Org-mode, completion stack | Core user environment |
| Development | Guile, GCC or Clang as needed, Git, make, pkg-config, SQLite, ripgrep, fd | Add based on project needs and source availability |
| Shell environment | `direnv` | Optional; use when project environment isolation benefits from it |
| Local inference | `llama.cpp` | Optional; CPU first, acceleration only after test |
| GPU acceleration | Vulkan/Mesa RADV where supported; ROCm experimental where appropriate | Hardware- and build-specific; never assume availability |
| Networking | NetworkManager **or** an iwd-based configuration with required integration | Choose one coherent managed approach; avoid competing managers |
| Remote access | OpenSSH, `curl`/`wget`, `rsync` | Enable services only when required; secure access deliberately |
| Identity/secrets | GnuPG, `password-store` or `rbw` | Select and configure; keep secrets out of repository |
| Media | mpv, imv or feh, FFmpeg | Optional to workload, useful for media/research |
| Documents | Zathura, optional LibreOffice, `pdf-tools` or `nov.el` | Add for actual document workflows |
| Backup | Restic | Canonical recovery requirement; encrypted and independently stored |
| Browser | qutebrowser or Nyxt; Firefox if needed | Optional; choose based on compatibility and real use |
| Synchronization | Syncthing | Optional; not a substitute for backup |
| Monitoring | htop/btop, nvtop, brightnessctl, playerctl | Optional convenience/diagnostics |

### 9.1 Network manager selection

Choose one coherent network management model for the node. NetworkManager is a candidate for integrated desktop use. An iwd-based setup may be appropriate where its required integration and service configuration are understood. Do not enable overlapping managers without a specific design and documented reason. Test Wi-Fi after cold boot, resume, and relevant system upgrades.

### 9.2 Terminal choice

The current WARENA implementation draft prefers **foot**, with **Alacritty** as an alternative. A prior user preference has identified Tilix as a favourite terminal. Treat this as an unresolved per-node preference rather than silently declaring one universal answer: choose the terminal that best fits the current Guix/Wayland session, resource profile, and desired workflow; record the choice in the home declaration.

### 9.3 Day-one minimum viable system

The first useful WARENA node should stay deliberately small:

- GNU Guix + RDE;
- GNU Shepherd and required base services;
- a validated Sway session as the transitional desktop;
- Emacs + Org-mode, with Geiser where needed;
- one terminal and essential input/clipboard utilities;
- Git and the WARENA repository;
- one coherent network configuration;
- Restic with a separate encrypted repository;
- LUKS/Btrfs where selected and correctly configured.

`dwl-guile`, `dtao-guile`, `llama.cpp`, GPU acceleration, extra browsers, synchronization, and nonessential utilities should be added only when the base system is stable and their acceptance tests are defined.

---

## 10. Local inference and compute policy

Local inference is an optional research capability, not a prerequisite for WARENA to be useful.

### 10.1 Enablement sequence

1. Stabilize the base system and backup/restore path first.
2. Build or install `llama.cpp` from the pinned, supported source path.
3. Validate a small model through the CPU path before introducing acceleration.
4. If the hardware supports it, test Vulkan/Mesa RADV or another appropriate backend based on the actual GPU and software stack.
5. Treat ROCm as optional/experimental and use it only if the exact hardware and build path are supported.
6. Store model weights outside the Guix store, with an explicit location, permissions, provenance, and retention policy.
7. Record model identity, quantization, source, license, and configuration for reproducible experiments where applicable.
8. Measure memory use, latency, thermal behaviour, stability, and power impact.

### 10.2 Privacy and authority boundaries

- Do not send local prompts, files, or personal information to external services without explicit authorization.
- Model output is a proposal, not a command.
- Do not allow a model to silently alter system declarations, deploy a generation, change access controls, delete data, or execute high-impact actions.
- Require human review and explicit authorization for consequential changes.
- Keep model weights and caches out of source control unless there is a specific, justified artifact-management design.
- Document what is logged, where it is stored, and when it is removed.

The governing rule remains: **AI suggests. The human decides.**

---
## 11. Security, privacy, and operational boundaries

### 11.1 Least privilege

Install only the services needed for the node’s declared role. Avoid enabling network listeners, remote access, sync services, or background daemons by default. When a service is enabled, document its purpose, access boundary, expected state, and test procedure.

### 11.2 Updates and change exposure

Channel updates can change package versions, service definitions, build outcomes, and desktop behaviour. Do not update channels and reconfigure a critical daily-driver system without preserving provenance and a rollback path. Test risky changes in a separate generation or controlled environment first.

### 11.3 Personal and sensor data

WARENA is a local-first environment. If it is used with IKAI or other sensor-equipped systems, sensing must have visible and explicit states. Camera and microphone controls, retention policy, and authorization boundaries must be documented in the relevant system specification. System capability is not blanket consent to capture.

### 11.4 Integrity and authenticity

Use Git history for source changes and provenance records for builds. Where a checksum or signature is published for installation media or an artifact, verify it using a trustworthy process. A checksum proves byte equality to the referenced digest; it does not independently prove the source is trustworthy. Record both source and verification result.

---

## 12. Validation framework

A configuration moves from proposed to validated only through repeatable checks. Each test record should state the test, environment, expected result, observed result, date, operator, relevant channel/declaration commit, and evidence or log path.

### 12.1 Build and provenance checks

- [ ] Channel configuration parses and resolves.
- [ ] Exact channel revisions and Guix version are recorded.
- [ ] System declaration builds without error.
- [ ] Home declaration builds/reconfigures where used.
- [ ] No secret is committed in source or history intended for publication.
- [ ] The built generation corresponds to the reviewed declaration commit.

### 12.2 Boot and hardware checks

- [ ] Cold boot reaches a usable system.
- [ ] Disk encryption unlocks correctly.
- [ ] Expected filesystems and mount points are present.
- [ ] Keyboard and pointer/touchpad work.
- [ ] Display resolution, brightness, and external display use are acceptable where applicable.
- [ ] Networking works after cold boot.
- [ ] Audio input/output works if required.
- [ ] Suspend/resume works or the limitation is explicitly documented.
- [ ] Bluetooth and other required peripherals work.
- [ ] Thermal and power behaviour are acceptable for the intended workload.

### 12.3 Service and user environment checks

- [ ] GNU Shepherd is running and required services are in the expected state.
- [ ] No unexplained failed or repeatedly restarting service blocks acceptance.
- [ ] The intended desktop session starts and can exit cleanly.
- [ ] Terminal, launcher, clipboard, and screenshot tools work if selected.
- [ ] Audio stack works with the intended applications.
- [ ] Emacs starts and essential packages load.
- [ ] Org-mode can create and save a note.
- [ ] Git can inspect and commit the WARENA repository.
- [ ] Geiser/Guile workflow works if selected.
- [ ] Network and remote-access services match the documented policy.

### 12.4 Recovery checks

- [ ] A prior known-good system generation remains available.
- [ ] The rollback procedure has been reviewed and is accessible when needed.
- [ ] Restic repository is encrypted and separate from the primary system.
- [ ] Initial backup completes and is listed by Restic.
- [ ] At least one file or directory has been restored to a temporary location and verified.
- [ ] Recovery notes identify the repository, credentials/key requirements, and restore destination without exposing secrets.
- [ ] The operator can explain how to rebuild from pinned sources and declarations.

### 12.5 Validation outcome

- **PASS:** expected behaviour observed; evidence recorded.
- **FAIL:** expected behaviour not observed; issue logged and acceptance blocked if critical.
- **PARTIAL:** some checks pass, but a known gap remains.
- **NOT RUN:** no test has been performed; never treat as pass.
- **NOT APPLICABLE:** justified for this machine/workload, with reason recorded.

A configuration is not fully **VALIDATED** while a critical boot, storage, network, core service, or recovery requirement is failing or untested. Any omitted test must be justified, not silently ignored.

---

## 13. Implementation checklist — phase-gated execution

**Rule:** Mark an item complete only after it has actually been completed and verified on the target machine. The checkboxes below intentionally begin unchecked.

### Phase 0 — Preparation

- [ ] Read and accept the WARENA governing rules.
- [ ] Identify the exact target machine and create a hardware profile record.
- [ ] Record CPU, GPU, RAM, storage, Wi-Fi/Bluetooth, Ethernet, firmware mode, and required peripherals.
- [ ] Identify any data that must be preserved and verify a backup before partition changes.
- [ ] Decide whether Nonguix may be required; do not enable it yet without evidence.
- [ ] Prepare a known-good USB drive for the RDE Live ISO.
- [ ] Prepare a separate external drive or destination for Restic backups.
- [ ] Create the `warema/` working repository and initial README.
- [ ] Define where channel pins, validation evidence, and recovery records will live.
- [ ] Record the date, machine identifier, and initial implementation status.

**Gate 0:** Do not begin installation until the target machine and data-risk situation are understood.

### Phase 1 — Evaluation (RDE Live ISO)

- [ ] Obtain the current RDE Live ISO from its authoritative source.
- [ ] Verify checksum/signature when available and record the result.
- [ ] Flash the ISO to the correct USB device.
- [ ] Boot the target machine from USB.
- [ ] Test keyboard, pointer/touchpad, display, and brightness.
- [ ] Test networking over available interfaces.
- [ ] Test audio.
- [ ] Test suspend/resume where applicable.
- [ ] Test storage visibility and access without modifying data unintentionally.
- [ ] Record all hardware observations, failures, and workarounds.
- [ ] Decide whether to proceed, change hardware, alter the configuration, or document a Nonguix requirement.

**Gate 1:** Installation proceeds only after hardware limitations and data risks are understood.

### Phase 2 — Base installation

- [ ] Install using the RDE project’s documented configuration approach.
- [ ] Configure the intended disk layout and document it.
- [ ] Use LUKS + Btrfs if selected and appropriate for the machine.
- [ ] Create the initial user and required administrative access.
- [ ] Reboot into the installed system.
- [ ] Confirm disk encryption unlocks correctly.
- [ ] Confirm filesystems mount as expected.
- [ ] Confirm GNU Shepherd and essential services are running.
- [ ] Confirm basic networking works after installation.
- [ ] Preserve a rescue path until the installed system is validated.
- [ ] Record the first successful boot and any outstanding defects.

**Gate 2:** Do not proceed to broad customization if the base system cannot boot or unlock storage reliably.

### Phase 3 — Channels and pinning

- [ ] Create `channels.scm` with official Guix and RDE sources.
- [ ] Pin sources according to the chosen supported Guix workflow.
- [ ] Add `engstrand-config` only for the intended experimental/target desktop work.
- [ ] Add Nonguix only if a documented hardware requirement justifies it.
- [ ] Pull the intended channel set.
- [ ] Record channel URLs and exact resolved revisions.
- [ ] Record Guix version, date, and relevant generation information.
- [ ] Store the provenance record in `warema/records/channels/`.
- [ ] Commit the reviewed channel declaration and provenance record.

**Gate 3:** Do not call the system reproducibly controlled if accepted generations cannot be tied to source revisions.

### Phase 4 — First declarative configuration

- [ ] Create a minimal `system.scm`.
- [ ] Create a minimal `home.scm` if using Guix Home.
- [ ] Select only essential RDE features.
- [ ] Verify that local overrides are documented and intentional.
- [ ] Build and reconfigure the system.
- [ ] Reconfigure the home environment if used.
- [ ] Reboot and verify the system still boots.
- [ ] Verify Emacs starts.
- [ ] Verify terminal, networking, Git, and basic tools work.
- [ ] Confirm the previous generation is still available.
- [ ] Commit the initial declarations and record the generation/source mapping.

**Gate 4:** The initial system must be rebuildable from reviewed declarations before further complexity is introduced.

### Phase 5 — Core services validation

- [ ] Verify Shepherd service state.
- [ ] Verify audio via PipeWire/WirePlumber if selected.
- [ ] Verify networking is stable across reboot.
- [ ] Verify Git and repository access.
- [ ] Verify Emacs and Org-mode.
- [ ] Verify Emacs + Geiser/Guile if configured.
- [ ] Verify clipboard and basic Wayland utilities.
- [ ] Verify required storage mounts and permissions.
- [ ] Record every failure, workaround, and retest.

**Gate 5:** Critical system, network, storage, and authoring workflows must work before backup is treated as operationally useful.

### Phase 6 — Backup and recovery foundation

- [ ] Install and configure Restic.
- [ ] Create an encrypted Restic repository on a separate device or destination.
- [ ] Protect repository credentials and recovery material separately from the backed-up system.
- [ ] Define a backup scope for declarations, critical data, and recovery documentation.
- [ ] Exclude reproducible caches and large artifacts where appropriate; document exclusions.
- [ ] Perform the first backup.
- [ ] Verify the backup snapshot is listed and accessible.
- [ ] Restore at least one file/directory to a temporary location.
- [ ] Verify the restored content.
- [ ] Document the restore procedure in `warema/recovery/`.
- [ ] Confirm a prior Guix generation remains available and identify how to select it.
- [ ] Record the backup and restore test in `records/backups/`.

**Gate 6:** No daily-driver acceptance without a successful test restore and an understandable rollback path.

### Phase 7 — Daily-driver stabilization

- [ ] Use the Sway-based system for real work over several consecutive days.
- [ ] Confirm no critical regressions after reconfigure and reboot.
- [ ] Confirm channel pins and generation records remain accurate.
- [ ] Define a backup schedule and verify it runs as intended.
- [ ] Document known issues and limitations.
- [ ] Confirm the operator can roll back a failed generation.
- [ ] Confirm recovery documentation is available independently of the primary system.
- [ ] Review the complete validation checklist and resolve critical failures.

**Gate 7 outcome:** The system may be marked **VALIDATED — Sway-based daily driver** only when the required tests and recovery criteria pass on the actual machine.

### Phase 8 — Desktop migration (`dwl-guile`)

Begin only after Phase 7 is stable.

- [ ] Confirm the `engstrand-config` channel pin.
- [ ] Build `dwl-guile` successfully.
- [ ] Launch it in a test session or controlled environment.
- [ ] Verify application launch/exit, focus, movement, tiling/floating behaviour as supported, and recovery from configuration errors.
- [ ] Configure minimal, documented keybindings.
- [ ] Verify terminal and launcher.
- [ ] Integrate `dtao-guile` after the compositor is usable.
- [ ] Verify status bar launch, information display, and restart behaviour.
- [ ] Verify clipboard, screenshots, notifications, audio, and display controls as applicable.
- [ ] Test multi-monitor operation if relevant.
- [ ] Add the target session to the login/session mechanism.
- [ ] Switch the default session only after explicit review.
- [ ] Retain Sway configuration and rollback path.
- [ ] Run the full validation suite under the target desktop.
- [ ] Document patches, known issues, and the tested configuration.

**Gate 8 outcome:** Target status advances from **EXPERIMENTAL** to **VALIDATED — Guile-native desktop** only after the full test suite passes. Sway remains the fallback until that point.

### Phase 9 — Optional capabilities

- [ ] Build/test `llama.cpp` through the CPU path.
- [ ] Test Vulkan/Mesa RADV or another suitable accelerator only if the hardware supports it.
- [ ] Test ROCm only if the exact hardware/software combination is appropriate; label experimental results clearly.
- [ ] Store model weights outside the Guix store.
- [ ] Record model provenance, license, quantization, and storage/retention policy as appropriate.
- [ ] Document privacy boundaries for inference and prohibit silent external transmission.
- [ ] Measure resource use, stability, and thermal behaviour.
- [ ] Add optional tools only when a concrete use case and acceptance test exist.

### Phase 10 — Ownership and long-term control

- [ ] All system/home declarations and policy documents are under version control.
- [ ] Every accepted generation has a matching source/provenance record.
- [ ] Recovery has been tested from a simulated failure or isolated restore exercise.
- [ ] The system of record, runtime desktop, and backups remain distinct.
- [ ] WARENA policy boundaries are documented and followed.
- [ ] The node can be rebuilt from pinned sources and declarations without undocumented manual state.
- [ ] Secrets are absent from public source history.
- [ ] The maintenance and update cadence is documented.
- [ ] A periodic review date is set for hardware, channels, backups, and recovery instructions.

---

## 14. Backup, restoration, and disaster recovery

### 14.1 What must be protected

At minimum, define and back up the material necessary to reconstruct the node and preserve irreplaceable data:

- system and home declarations;
- channel specifications and pin records;
- custom features, services, scripts, and local package definitions;
- WARENA policies, this handbook, and recovery notes;
- critical user data selected by the operator;
- important research notes and project records;
- any irreplaceable artifacts that cannot be regenerated from source.

Do not blindly back up every cache or temporary file. Define inclusions and exclusions, then test that the resulting scope matches the recovery objective.

### 14.2 Independent mechanisms

| Mechanism | Intended role | Limitation |
|---|---|---|
| Guix system/home generations | Fast rollback to an earlier declared environment | Not a substitute for user-data backup or off-machine recovery |
| Btrfs snapshots | Convenient short-term filesystem recovery where configured | May share the same device/failure domain; not a complete independent backup |
| Git | History and review of configuration/documentation | Does not automatically protect untracked files, secrets, or arbitrary user data |
| Restic | Encrypted independent backup of selected data | Useful only if repository access and restore procedures are available and tested |
| Rescue USB / installation medium | Bootstrapping and repair access | Must remain current enough and be tested on the target hardware |

### 14.3 Backup procedure

1. Verify the destination is the intended backup repository/device.
2. Ensure the repository is encrypted and credentials are available to the authorized operator.
3. Run the defined backup command using the actual configured repository and paths.
4. Confirm completion and inspect the snapshot list.
5. Record timestamp, snapshot identifier, scope, and errors.
6. Disconnect or otherwise protect the external backup device when it is not needed, where practical.
7. Periodically test restoration to a separate temporary destination.

Do not place literal secrets, passwords, or private keys in the log. Record references to the approved secret-storage method instead.

### 14.4 Test restore procedure

A minimum restore exercise should:

1. Select a known file or small directory included in a backup.
2. Restore it to a temporary directory, not over the only original copy.
3. Compare the restored content or checksum with the source where appropriate.
4. Confirm filenames, permissions, and relevant metadata required by the use case.
5. Record the repository/snapshot identifier, test scope, outcome, and any issues.
6. Remove the temporary restored test data after recording the result, if it is no longer needed.

A successful backup command alone does not satisfy the recovery requirement.

### 14.5 Disaster recovery runbook

**Scenario A — Failed system reconfiguration**

1. Stop repeating the failing change.
2. Select or boot the known-good generation using the machine’s documented Guix/bootloader workflow.
3. Confirm the machine can boot and the critical services work.
4. Preserve relevant logs and the failed declaration revision.
5. Reproduce the issue in a controlled environment if possible.
6. Correct the declaration, review the diff, rebuild, and validate before accepting a new generation.

**Scenario B — Broken desktop session**

1. Use the documented alternative session or recovery route to regain a usable environment.
2. Restore the known-good desktop configuration from version control or a prior generation.
3. Keep Sway available while the `dwl-guile`/`dtao-guile` issue is investigated.
4. Record the failing revision and the exact behaviour.
5. Do not remove the fallback until the replacement has passed validation.

**Scenario C — Lost or damaged user data**

1. Stop writes to the affected destination where continued writes could worsen the damage.
2. Identify the last known-good backup snapshot.
3. Restore to a separate destination first.
4. Verify content and permissions before replacing or merging anything.
5. Record the restored scope and any missing data.

**Scenario D — Unbootable or damaged primary disk**

1. Use a tested rescue medium and the hardware-specific boot procedure.
2. Verify disk identity before running repair or restore operations.
3. Recover access to encrypted storage using the documented key procedure, if the disk remains usable.
4. Rebuild from pinned channels and declarations, or restore critical data to a replacement system.
5. Restore user data from Restic and verify it.
6. Re-run the full validation checklist before declaring the replacement node operational.

### 14.6 Recovery objectives

The operator must be able to:

- return to a previous known-good generation;
- rebuild from pinned channels and declarations;
- recover critical data from Restic;
- boot a known-good rescue environment if the primary installation is damaged;
- explain which recovery secrets and physical devices are required without placing those secrets in the repository;
- record the outcome and update the runbook after each recovery exercise.

Recovery is considered real only when it has been exercised.

---

## 15. Hardware policy and practical procurement notes

### 15.1 Evaluation priorities

Prefer hardware with:

- mature support in the selected kernel/firmware configuration;
- repairable storage and memory where possible;
- reliable keyboard, display, Wi-Fi, suspend/resume, and power management;
- adequate RAM and sustained compute for the intended development and research workload;
- documented device identifiers so compatibility findings are reproducible;
- accessible replacement parts and reasonable local servicing options.

ThinkPad T14 AMD-class business laptops and equivalent business systems are candidate categories for evaluation, not universal guarantees. Framework-class modular hardware may be attractive architecturally, but regional shipping, repair, parts, and support must be checked at purchase time. No specific model should be marked compatible before the exact variant is tested.

### 15.2 Hardware record template

For every node, record:

- node ID and human-readable machine name;
- manufacturer, model, exact variant, and approximate acquisition date;
- CPU and microarchitecture;
- GPU and driver/backend used;
- RAM capacity and upgradeability;
- storage models, capacities, layout, and encryption status;
- Wi-Fi, Bluetooth, Ethernet chipsets and firmware status;
- display and external-monitor details;
- audio, camera, microphone, keyboard, pointer, and special devices;
- firmware version and boot mode;
- observed suspend/resume and power behaviour;
- kernel/channel pins used for testing;
- known defects and workarounds;
- whether the hardware is **EVALUATED**, **TESTED**, or **VALIDATED** for the intended profile.

---

## 16. Change control and decision records

### 16.1 Change lifecycle

```text
PROPOSED
   ↓
REVIEWED
   ↓
BUILT
   ↓
TESTED
   ↓
ACCEPTED
   ↓
DEPLOYED
   ↓
VERIFIED
```

If a build or test fails, return the change to investigation. Do not skip stages because a patch is small or because a package appears familiar.

### 16.2 Required change record

For a significant change, record:

- change ID and date;
- problem or use case;
- proposed change and expected benefit;
- affected declarations, services, channels, and hardware;
- risks and possible failure modes;
- test plan and acceptance criteria;
- rollback method;
- build and test results;
- decision and rationale;
- resulting source commit and generation/provenance record.

### 16.3 Architecture decision record template

```text
ADR ID:
Title:
Date:
Status: PROPOSED | ACCEPTED | SUPERSEDED
Context / problem:
Constraints:
Options considered:
Decision:
Rationale:
Consequences and trade-offs:
Security / privacy implications:
Validation plan:
Rollback plan:
Evidence / references:
```

### 16.4 Update discipline

Before a channel update or system change:

1. inspect current state and record the current generation;
2. confirm backups are current enough for the risk;
3. review the declaration diff and channel changes;
4. preserve the fallback path;
5. build and test;
6. deploy only after the relevant checks pass;
7. update the records and this checklist if the procedure changes.

---

## 17. Operational maintenance

### 17.1 Routine review

A maintenance review should cover:

- channel pin validity and source availability;
- system/home declaration drift;
- pending security and compatibility updates;
- service failures and unexplained resource use;
- disk space, filesystem health, and backup capacity;
- last successful backup and restore test;
- known issues and workaround relevance;
- desktop stability and input/output behaviour;
- recovery medium and runbook readiness.

Set a realistic cadence for the actual node. The cadence itself should be documented; do not claim periodic checks are occurring unless they are recorded.

### 17.2 Incident record

```text
Incident ID:
Date/time:
Node / generation:
Observed symptom:
Impact:
Recent changes:
Logs / evidence:
Immediate containment:
Root cause (if known):
Resolution / rollback:
Validation after resolution:
Follow-up action:
```

### 17.3 Known issues register

Each known issue should include a short ID, affected hardware/configuration, symptom, severity, workaround, upstream/local reference, owner/action, and status. A workaround does not equal a fix; keep the distinction explicit.

---

## 18. Implementation records and templates

### 18.1 Build record

```text
Build ID:
Node ID:
Date/time:
Guix version:
Channel pins / provenance record:
Declaration commit:
Build target:
Build result: PASS | FAIL | PARTIAL
Generation ID (if applicable):
Warnings / failures:
Next action:
```

### 18.2 Validation record

```text
Validation ID:
Node ID / hardware profile:
Date/time:
Configuration commit:
Channel pin record:
Desktop profile: Sway | dwl-guile | other
Tests performed:
Passed:
Failed:
Partial / not run / not applicable:
Evidence paths:
Known limitations:
Overall result: PROPOSED | EXPERIMENTAL | VALIDATED
Reviewer / operator:
```

### 18.3 Backup record

```text
Backup ID:
Date/time:
Node ID:
Repository identifier (not credentials):
Snapshot ID:
Scope and exclusions:
Result:
Restore test date:
Restore test scope/result:
Errors or follow-up:
```

### 18.4 Deployment record

```text
Deployment ID:
Node ID:
Date/time:
Accepted declaration commit:
Channel pins:
Generation:
Desktop/session:
Validation record:
Backup/restore record:
Rollback path confirmed:
Status: DEPLOYED | ROLLED BACK | BLOCKED
Notes:
```

---

## 19. Completion criteria

A WARENA node is considered properly implemented for a stated profile only when all applicable criteria below are evidenced:

1. It boots reliably from a declared configuration tied to recorded channel revisions.
2. The operator can identify the sources and declarations that produced the accepted generation.
3. Core services, storage, networking, input devices, and Emacs workflows are stable.
4. A prior known-good generation or equivalent tested recovery path remains available.
5. Encrypted backup exists independently of the primary system and a restore has been tested.
6. The selected desktop is under explicit configuration control; experimental desktop work has a rollback path.
7. The system can be rebuilt without undocumented manual steps.
8. Nonguix or other non-free components, if present, have a documented justification and scope.
9. Secrets are protected and not committed to the repository.
10. Known issues, exceptions, and limitations are recorded honestly.
11. The validation record is dated and specific to the hardware and configuration tested.
12. All untested requirements remain marked **NOT RUN**, **PROPOSED**, or **EXPERIMENTAL**, rather than being implied complete.

### 19.1 Status definitions for a WARENA node

- **BOOTSTRAPPED:** base system is installed and can boot, but full validation is incomplete.
- **VALIDATED — Sway daily driver:** Phases 0–7 have passed for the actual machine, including backup and test restore.
- **EXPERIMENTAL — Guile-native desktop:** `dwl-guile`/`dtao-guile` is under active test while Sway remains available.
- **VALIDATED — Guile-native desktop:** target desktop has passed the full required validation suite.
- **DEPLOYED:** the accepted profile is in intended use, has provenance records, and has a working rollback/recovery route.
- **BLOCKED:** one or more critical requirements prevent safe progress.

---

## 20. Immediate next actions

Unless actual records show that these are already complete, use this order:

1. Identify the exact machine and create the hardware record.
2. Evaluate the RDE Live ISO and record hardware behaviour.
3. Establish official Guix + RDE channels and pin the exact source revisions.
4. Create the smallest working system and home declarations.
5. Boot and validate the Sway-based daily-driver path.
6. Commit declarations and provenance records to Git.
7. Configure Restic, back up critical data, and test a restore.
8. Stabilize the system over several days of real work.
9. Only then begin the isolated `dwl-guile`/`dtao-guile` migration.
10. Add local inference and other optional capabilities after the base environment and recovery path are stable.
11. Update the status register after each phase using evidence, not intention.

---

## 21. Status register — Draft 0.2

| Component / capability | Intended status | Evidence still required before claiming implementation |
|---|---|---|
| GNU Guix + RDE base | CANONICAL design | Actual pinned channels, successful build/boot record |
| GNU Shepherd | CANONICAL | Service-state validation on target machine |
| Channel pinning discipline | CANONICAL | Pin records tied to accepted generations |
| System/home separation | CANONICAL design | Declarations reviewed, version-controlled, and reconfigurable |
| Sway transitional desktop | DOCUMENTED path | Actual daily-driver validation record |
| `dwl-guile` + `dtao-guile` | PROPOSED / EXPERIMENTAL | Successful build, session tests, full validation |
| Emacs-centred environment | CANONICAL design | Emacs/Org/Git and selected Guile workflow tests |
| LUKS + Btrfs | PREFERRED where suitable | Actual layout record, cold-boot unlock and storage checks |
| Restic encrypted backup | CANONICAL requirement | Successful backup and test restore records |
| Prior generation rollback | REQUIRED | Actual rollback path confirmed and documented |
| Linux-libre | DEFAULT preference | Hardware compatibility validated |
| Nonguix | OPTIONAL, explicit opt-in | Documented need and exact component scope |
| `llama.cpp` | OPTIONAL | CPU test, privacy policy, and optional acceleration tests |
| Full disaster recovery | REQUIRED before full acceptance | Simulated recovery or equivalent documented exercise |

---

## 22. Final operating rule

WARENA is not defined by a list of packages or the novelty of its desktop. It is defined by **declarative ownership, inspectable provenance, controlled change, local-first capability, and tested recovery**.

A machine is not “done” because the configuration looks complete. It is done for a declared profile when the system builds, boots, works, records its source state, preserves its data, and can recover from failure — with the operator still in control.

**Human authorship. Explicit provenance. Reversible change. Tested recovery.**

**End of WARENA Implementation Handbook — Consolidated Draft 0.2**


---

# Part III — Consolidated operating rules and release gate

## 30. Source-of-truth hierarchy

When documents overlap, apply this order:

1. **FELOH governing corpus and approved cross-project policy** for constitutional principles, evidence rules and domain ownership.
2. **This FELOH Master Technology Register** for ecosystem inventory, technology lifecycle status, cross-project standards and ownership boundaries.
3. **The WARENA Implementation Handbook in Part II** for WARENA-specific technical procedures, phases, validation and recovery.
4. **Machine-specific configuration and operational records** for what is actually configured, built, tested and deployed on a named target. Machine evidence may correct an inaccurate documented assumption, but any resulting policy change must be reviewed and recorded.
5. **Upstream documentation and source repositories** for current command syntax, compatibility, licenses, and technical facts. Record the exact version/revision consulted when it affects an implementation decision.

No lower-level document may silently override an approved policy. If a conflict is found, open a decision record, state the impact, and resolve it through a reviewed diff.

## 31. Minimum release gate

A change is not ready for deployment until the relevant items below are evidenced:

- [ ] Requirement and owning domain are identified.
- [ ] Proposed diff is reviewed; unrelated changes are excluded.
- [ ] Dependencies, source revisions, licenses, secrets, and trust boundaries are checked.
- [ ] Build/test environment and target hardware are recorded.
- [ ] Build succeeds or failure is recorded without being misrepresented.
- [ ] Required acceptance tests pass.
- [ ] Backup and rollback are available; restore has been tested where the change affects data or system recoverability.
- [ ] Human approval is recorded for consequential changes.
- [ ] Deployment is recorded separately from testing.
- [ ] Post-deployment checks pass and the register is updated with evidence.

These are template checkboxes, not a claim that any work has been completed.

## 32. Known limitations of this consolidation

- This document consolidates the supplied inventory with the existing WARENA handbook; it is not a live audit of a workstation, Git repository, installed packages, firmware, subscriptions, licenses, or production services.
- Technology names in the register are candidates or recognized options, not a procurement list or universal baseline.
- Hardware and software compatibility can change by model, firmware, kernel, package version, and upstream release. Verify at implementation time.
- Security and compliance obligations depend on the actual service, jurisdiction, data, and deployment context; generic inclusion in this register does not certify compliance.
- The detailed WARENA phase checklist has intentionally not been checked off during document consolidation.

**Final operating principle:** document broadly; select narrowly; implement declaratively; inspect every diff; test against explicit acceptance criteria; authorize consequential actions; prove recovery; and make status claims only from evidence.

---

# Appendix A — Implementation Operating Model

This appendix is an operational companion to the inventory and WARENA handbook. It turns the document's principles into repeatable work without asserting that any target machine or service has already been configured.

## A1. The implementation unit

Every change must be scoped to a named implementation unit. A unit can be a workstation, server, edge node, repository, website, data service, creative workstation, or customer-facing workflow.

Record at minimum:

| Field | Required value |
|---|---|
| Unit ID | Stable identifier, e.g. `WRN-NODE-001` |
| Owner | Accountable human or project role |
| Domain | One primary domain from the ownership register |
| Purpose | The need this unit serves |
| Target | Hardware, host, service, or repository |
| Baseline | OS/profile, architecture, channel/revision, and relevant versions |
| Data class | Public, internal, confidential, personal, credential, or other documented classification |
| Dependencies | Required upstream services, packages, devices, credentials, and networks |
| Status | One approved status label, with evidence |
| Recovery | Backup, rollback, rebuild, or re-provisioning method |
| Review date | Date for the next review or an explicit event that triggers review |

Do not use a product name as a substitute for the implementation unit. “Guix” is a technology; “the Guix System profile on the WARENA edge node” is a unit that can be tested and governed.

## A2. Standard change lifecycle

1. **Request:** state the problem, user impact, expected outcome, owner, and urgency.
2. **Inspect:** read the current configuration and relevant documentation before editing. Capture the current revision and status.
3. **Design:** state the proposed solution, alternatives considered, dependencies, security impact, migration, and rollback.
4. **Diff:** make a narrow change. Do not mix unrelated refactors, package upgrades, and policy changes.
5. **Validate:** run formatting, static checks, build checks, unit tests, integration tests, and target-specific tests as applicable.
6. **Review:** another qualified person reviews material changes where feasible. The responsible human approves consequential operations.
7. **Stage:** deploy to a test profile or limited target when practical.
8. **Deploy:** record the exact revision, target, operator, time, and commands or automation used.
9. **Observe:** verify service health and user-visible behavior after deployment.
10. **Recover or close:** if acceptance fails, roll back or repair. Record the result and update the status register.

A successful build is not the same as a successful runtime test. A successful test is not the same as a deployment. A deployment is not proof of sustained production reliability.

## A3. Evidence record template

Copy and complete this template for each material change:

```yaml
record_id: "CHG-YYYYMMDD-NNN"
title: ""
owner: ""
domain: ""
target_unit: ""
request:
  problem: ""
  expected_outcome: ""
  acceptance_criteria: []
baseline:
  os_or_runtime: ""
  architecture: ""
  source_revision: ""
  configuration_revision: ""
change:
  summary: ""
  files_changed: []
  dependencies_added_or_removed: []
  security_and_privacy_impact: ""
validation:
  commands: []
  tests: []
  results: ""
  evidence_paths: []
recovery:
  rollback_method: ""
  backup_or_snapshot: ""
  restore_tested: false
approval:
  approver: ""
  approval_record: ""
deployment:
  deployed: false
  target: ""
  timestamp: ""
post_deployment:
  health_check: ""
  user_impact: ""
status_after_change: "UNKNOWN"
review_date: ""
```

The YAML above is a template, not a record of completed work. Replace all blank values and examples before using it as evidence.

## A4. Decision record template

```markdown
# Decision: <short title>

- ID: ADR-YYYY-NNN
- Status: PROPOSED | ACCEPTED | REJECTED | SUPERSEDED
- Date:
- Owner:
- Scope:

## Context
What need, constraint, failure, or opportunity requires a decision?

## Decision
What is being selected, and what is explicitly not being selected?

## Alternatives
- Option A:
- Option B:
- Option C:

## Rationale
Compare maintainability, reproducibility, cost, hardware fit, security, privacy,
offline operation, accessibility, interoperability, and exit cost.

## Consequences
List benefits, trade-offs, migration requirements, risks, and future constraints.

## Validation
State how the decision will be tested and what would invalidate it.

## Review trigger
Name a date, event, upstream change, failure, or threshold that requires review.
```

## A5. Minimum acceptance criteria by change class

| Change class | Minimum checks |
|---|---|
| Package addition | Need documented; license and transitive dependencies reviewed; package builds; functionality tested |
| OS/service configuration | Diff reviewed; system builds; boot/service checks pass; rollback generation available |
| Network/firewall change | Existing access preserved or recovery path available; rule behavior tested; unintended exposure checked |
| Storage/filesystem change | Capacity and integrity checked; backup verified; recovery plan; destructive operations explicitly authorized |
| Data schema change | Migration tested against a copy; backup taken; forward and rollback compatibility documented |
| Website/publication | Links and rendering checked; privacy/secret scan; accessibility basics; human approval of public release |
| AI/model integration | Data-flow and retention review; local/cloud boundary documented; output limits; human review and disable path |
| Customer-facing workflow | Prices, service scope, contact, booking path and claims verified; owner approves publication |
| Security-sensitive change | Threat model reviewed; least privilege checked; secrets handled safely; failure and recovery behavior tested |
| Creative/media pipeline | Source assets and licenses recorded; output reviewed; project files and export path retained |

---

# Appendix B — Domain-by-Domain Selection and Verification Matrix

The master register lists a broad technology universe. Use this matrix to choose a small, coherent subset for a specific target.

| Domain | Selection question | Evidence before status advances |
|---|---|---|
| OS and reproducibility | Is this the supported OS/profile for the target? | Pinned configuration, successful build, boot evidence |
| Languages and runtimes | Does a real project require this runtime? | Minimal working example, version record, tests |
| Compilers and builds | Can the source be built reproducibly? | Build command, logs, dependency provenance |
| Editor and desktop | Does it support the user's actual workflow and hardware? | Input/display/audio checks, recovery path |
| Version control | Is the authoritative history and review path clear? | Repository URL/path, branch protections, tested restore |
| Databases | Is the data model and ownership clear? | Schema, migration tests, backup and export test |
| Research and knowledge | Can claims be traced to sources? | Citation checks, provenance, clear evidence classes |
| Networking | Are trust boundaries and required ports explicit? | Connectivity tests, firewall tests, topology record |
| Administration | Can services be managed and diagnosed? | Service definitions, health checks, logs, rollback |
| Storage and recovery | Can data be recovered after realistic failure? | Successful restore test and integrity verification |
| Security and privacy | What are the assets, threats, and permissions? | Threat model, secret handling, least-privilege review |
| Web and publishing | Can the content be maintained and exported? | Build, link, rendering, accessibility and privacy checks |
| AI and agents | Is AI necessary, bounded, and governable? | Data-flow review, evaluation set, human override |
| Automation | Is the action repeatable and safe to rerun? | Idempotence test, dry run, logs, permissions |
| Quality and testing | What observable behavior defines correctness? | Test cases, expected results, failure handling |
| Monitoring and performance | What signal indicates health or degradation? | Baseline, alert thresholds, privacy review |
| Hardware and edge | Is the target compatible under real conditions? | Model/firmware record, thermal, power and peripheral tests |
| Creative computing | Can the project be recreated and exported? | Source/session files, software versions, rendered output |
| Beauty/commerce | Are the real offered services and prices correct? | Human-verified service list, booking and customer test |
| Business operations | Who owns each transaction and record? | Process owner, reconciliation, access control |
| Documentation | Can another operator reproduce the procedure? | Clean-room walkthrough, version and review date |
| Decentralised/offline | Does the system work without its assumed network? | Offline test, sync-conflict test, export/exit test |
| Product architecture | Are domain boundaries and decisions explicit? | Architecture decision record and dependency map |
| Domain ownership | Is accountability unambiguous? | Named owner, escalation and approval route |
| Cross-cutting standards | Are shared rules applied without erasing domain-specific needs? | Standards checklist and exception record |
| Master status register | Does every status claim have evidence? | Source, target, date, reviewer and next review |

---

# Appendix C — WARENA Provisioning Runbook

This is a guarded sequence, not a command script to run blindly. Hardware, firmware, disk layout, network interfaces, and existing data must be inspected first.

## C1. Preflight checklist

- [ ] Identify the exact device model, CPU architecture, RAM, storage, NICs, Wi-Fi chipset, GPU/display, audio, and firmware.
- [ ] Confirm the intended role: workstation, server, edge node, test VM, or recovery device.
- [ ] Identify all disks by stable device identifiers; do not infer a target disk from `/dev/sda` alone.
- [ ] Back up any data that must be preserved and verify the backup.
- [ ] Confirm power stability and network access, while documenting whether installation must work offline.
- [ ] Record the current firmware and boot mode, including UEFI/Secure Boot status where relevant.
- [ ] Decide the encryption, filesystem, partitioning, swap, hibernation, and recovery requirements.
- [ ] Confirm how the machine can be recovered if the new system does not boot.
- [ ] Review the installation procedure for the exact Guix release and hardware architecture.
- [ ] Obtain explicit authorization before destructive disk operations.

## C2. Baseline design

The default direction is GNU Guix System with a declarative configuration, RDE where useful, and Shepherd service management. The exact channel set, desktop, kernel variant, firmware path, and package list must be decided for the target rather than assumed.

Record these choices before implementation:

1. Guix release and channel revisions.
2. System architecture and kernel/firmware requirements.
3. Host name, locale, time zone, keyboard layout, and user accounts.
4. Network configuration and management access.
5. Filesystem, encryption, mount points, backup target, and restore method.
6. Service list and required listening interfaces/ports.
7. Desktop and session configuration, or explicit headless role.
8. Essential applications and development toolchains.
9. Logging, monitoring, update, and rollback policy.
10. Acceptance tests and the person authorizing deployment.

## C3. Repository organization

A repository may use a layout similar to the following. This is a proposed structure; reconcile it with the existing repository before moving or renaming anything.

```text
warema/                         # Existing spelling in the handbook; resolve explicitly
├── README.md
├── channels.scm                # Pinned channels / channel provenance
├── manifests/
│   ├── base.scm
│   ├── development.scm
│   └── creative.scm
├── systems/
│   ├── <host-name>.scm
│   └── modules/
├── home/
│   ├── <user-name>.scm
│   └── modules/
├── services/
├── packages/
├── tests/
├── scripts/
├── docs/
│   ├── decisions/
│   ├── runbooks/
│   └── evidence/
└── CHANGELOG.md
```

The `warema/` spelling is a known discrepancy, not an approved rename. Decide whether to preserve it for continuity or migrate to `warena/` with a reviewed diff, link/path audit, and updated references.

## C4. Build and validation gates

1. **Inspect:** read the current repository, README, channels, manifests, host declarations, and existing status records.
2. **Pin:** identify the channel and package revisions; avoid uncontrolled mixing of incompatible channels.
3. **Format and statically inspect:** validate Scheme syntax and repository conventions.
4. **Build:** build the relevant manifest/profile or system configuration without switching the production machine prematurely.
5. **Review output:** inspect warnings, substitutions, unsupported packages, unfree/nonfree choices, and hardware-specific assumptions.
6. **Test:** use a VM or spare target when practical; test the actual target for hardware-specific behavior.
7. **Stage:** keep the last known-good generation and a recovery route.
8. **Apply:** switch or deploy only after review and approval.
9. **Verify:** reboot where appropriate; test login, networking, storage, services, peripherals, and required workloads.
10. **Record:** attach logs and update the implementation status; do not mark a checklist complete based solely on intent.

## C5. Desktop migration gate

Sway is a known transitional baseline in the existing handbook. The proposed direction includes dwl-guile and dtao-guile; Niri and Noctalia have also appeared as exploratory options. Do not combine these into one assumed desktop configuration.

For any migration:

- Keep a known-good login/session available until the replacement passes acceptance.
- Test keyboard layout, input methods, multi-monitor behavior, scaling, screenshots, clipboard, notifications, screen lock, idle/suspend/resume, audio, portals, and application compatibility.
- Test a clean login and a restart after configuration changes.
- Document session selection and a route back to the prior session.
- Verify that the chosen components are packaged and supported for the pinned Guix channels.
- Classify each desktop option as canonical, transitional, experimental, or rejected in a decision record.

## C6. Hardware and firmware gate

A board name or product listing is not compatibility evidence. For a candidate such as the LinkStar-H68K/RK3568 platform, confirm the exact board revision, boot firmware, kernel support, device-tree requirements, Ethernet controller support, Wi-Fi firmware, video output, storage behavior, thermals, power, and recovery method. A listed NPU does not prove that a specific inference runtime supports it or that acceleration is functional.

Record actual tests and results. Where a proprietary firmware blob or nonfree package is required, document the necessity and scope before enabling it.

---

# Appendix D — Security, Privacy and Recovery Baseline

## D1. Threat-model worksheet

For each unit, answer:

- What data, credentials, services, hardware, and people must be protected?
- Who may access the unit locally, over the network, through an account, or through automation?
- What is the realistic threat model: accidental loss, theft, unauthorized account access, malware, exposed services, malicious dependencies, supply-chain compromise, or physical access?
- What is the consequence of compromise or loss?
- Which controls reduce the risk, and what residual risk remains?
- How will a suspected compromise be detected, contained, investigated, and recovered?
- Which actions require explicit human approval?

## D2. Baseline controls

- Use unique user accounts and least-privilege permissions.
- Keep administrative access separate from routine work where practical.
- Use SSH keys or other appropriate strong authentication; disable obsolete access paths when safely possible.
- Do not place secrets, private keys, access tokens, customer data, or credentials in public repositories or logs.
- Keep secrets out of command history, screenshots, issue trackers, and build output.
- Bind services to the minimum required interfaces; verify firewall behavior from the network.
- Keep a documented patch and vulnerability review process.
- Review dependencies, provenance, package sources, licenses, and trust boundaries.
- Encrypt sensitive storage and backups when the threat model requires it.
- Establish a process for lost devices, revoked credentials, and suspected compromise.- Collect only logs needed for operations and security; avoid unnecessary personal-data retention.
- Provide a documented export and deletion process for personal or customer data where applicable.

## D3. Backup policy

Define a recovery point objective (RPO: acceptable data loss) and recovery time objective (RTO: acceptable time to restore) for each important unit.

At minimum, distinguish:

1. **Configuration backup:** source repository, channel pins, host and home declarations, scripts, service configuration.
2. **User-data backup:** documents, project files, databases, media, and other irreplaceable data.
3. **Secrets backup:** keys and recovery material stored under separate access controls.
4. **System recovery:** known-good generation, bootable recovery media, reinstall instructions, firmware notes.
5. **Off-device copy:** separate storage or location appropriate to the risk; do not treat a second partition on the same disk as a complete backup.

A backup is not verified until restoration is tested. A checksum confirms data integrity relative to the checksum; it does not prove the backup contains everything needed or that the restore procedure works.

## D4. Restore test record

```markdown
# Restore Test

- Test ID:
- Date:
- Operator:
- Source backup:
- Backup date:
- Target system:
- Data/configuration restored:
- Expected result:
- Actual result:
- Integrity checks:
- Time to restore:
- Data loss observed:
- Problems:
- Corrective actions:
- Result: PASS | FAIL | PARTIAL
- Evidence path:
- Next test date:
```

Do not store the only copy of a decryption key beside the encrypted backup. Protect recovery material while ensuring an authorized recovery remains possible.

---

# Appendix E — Local-First, AI and Automation Controls

## E1. IKAI reflective-computing principles

IKAI is a reflective, local-first computing project, not an autonomous judge or a beauty-scoring system.

- **Human remains author:** the system may present information and options, but does not become the owner of a person's identity, decisions, or creative work.
- **Mirror is not judge:** observations and model outputs must not be presented as definitive judgments about a person.
- **Local-first:** prefer local processing and user-controlled storage where practical; disclose any network transmission.
- **AI is replaceable:** avoid making the system unusable if one model or provider disappears.
- **Observation is not truth:** sensor readings, inferred labels, and model-generated summaries carry uncertainty and context.
- **No silent authorization:** consequential actions require explicit permission.
- **No hidden profiling:** do not create advertising profiles, identity classifications, or beauty scores as implicit system behavior.
- **Inspectable and reversible:** provide understandable controls, logs appropriate to privacy needs, and a clear way to disable or reset features.

## E2. AI/agent integration gate

Before adding a model or agent, document:

1. The specific task that requires it and why deterministic software is insufficient.
2. The exact inputs and whether they contain personal, customer, confidential, or sensitive data.
3. Where inference occurs: local, private infrastructure, or third-party service.
4. Data retention, training use, logging, and deletion behavior as verified from the applicable provider or runtime.
5. Expected error modes, uncertainty, evaluation set, and unacceptable outcomes.
6. What the model is allowed to read, write, execute, publish, or transmit.
7. Human confirmation points and a way to interrupt or disable the integration.
8. How outputs are labelled as generated, inferred, or unverified.
9. How to export data and replace the model or provider.
10. The person responsible for approval and incident response.

Default permissions should be read-only. Write access, shell execution, external communication, deletion, account changes, publication, payments, and other consequential actions must be separately scoped and authorized.

## E3. Automation quality gates

Automation should be:

- **Idempotent** where feasible: rerunning it does not create duplicate or destructive effects.
- **Bounded:** explicit inputs, targets, permissions, timeouts, and resource limits.
- **Observable:** logs record useful outcomes without leaking secrets.
- **Recoverable:** failed steps leave a clear state and a documented recovery path.
- **Reviewable:** code and configuration are version-controlled and diffable.
- **Testable:** dry-run or test mode exists for risky actions when practical.
- **Authorized:** external side effects are not inferred from the mere presence of credentials.
- **Scoped:** shared automation does not grant one project unbounded access to another.

---

# Appendix F — Project and Brand Architecture Crosswalk

This section is an ownership and boundary reference, not a claim that all listed products or services are currently operational.

## F1. Enterprise structure

- **NAKEBUSEN:** parent enterprise and the only customer-facing commercial/transaction interface.
- **NAKEBUSEN LOCS:** loc craft and beauty services actually offered. Do not advertise shaving or braiding as services; they are explicitly excluded.
- **NAKEBUSEN DIGITAL:** the enterprise's technology services and digital-product division.
- **WARENA / WARENA Systems:** the technical identity and systems/infrastructure practice for NAKEBUSEN Digital: GNU/Linux, reproducible computing, systems administration, infrastructure, and technical operations.
- **IKAI Mirror:** reflective, privacy-respecting, local-first computing project; not a system that judges a person's appearance.
- **GENJE ZA WARENA:** cultural identity and motivating intention, expressed as **“THE FIRE OF THE FORMIDABLE.”** It is not a separate commercial division by default.
- **FELOH:** author, practitioner, research, and creative identity spanning the relevant work.
- **GENJE Node / creative computing:** movement, sound, live coding, and embodied creative practice; it is not an extra constitutional business division merely because it has its own technical workflow.

## F2. Transaction boundary

Customer discovery, offers, booking, service confirmation, customer communication, and commercial records should remain coherent through NAKEBUSEN. WARENA, IKAI, and other technical projects support delivery and infrastructure; they should not accidentally create competing booking funnels.

Any exception requires a documented reason, owner, data-flow decision, and customer-experience review.

## F3. Brand meaning versus linguistic evidence

Use two distinct categories:

- **Evidence claim:** a linguistic or historical statement supported by a source with context, date, and limitations.
- **Proposed brand meaning:** the intended meaning assigned by the brand, even where it is a creative interpretation rather than established etymology.

“Genje Za Warena — The Fire of the Formidable” is a proposed brand framing. It must not be presented as independently verified dictionary etymology without suitable evidence. The same rule applies to claims about “NIA,” “Genje,” “Za,” “Warena,” and “Genjeness.”

---

# Appendix G — Master Status Register Template

Use one row per concrete component or deployment, not one row per broad technology category.

| ID | Component | Domain | Owning project | Target | Lifecycle | Implementation status | Evidence | Owner | Next action |
|---|---|---|---|---|---|---|---|---|---|
| REG-001 | GNU Guix System baseline | OS/reproducibility | WARENA | Name exact host | PLANNED until evidenced | UNKNOWN until inspected | Repository/build/test evidence | Assign | Inspect pinned configuration |
| REG-002 | RDE configuration | OS/configuration | WARENA | Name exact host | PLANNED/EXPERIMENTAL as decided | UNKNOWN until evidenced | Configuration path and build log | Assign | Confirm current channel compatibility |
| REG-003 | Backup and restore | Storage/recovery | Shared standard; target-specific implementation | Name exact target | REQUIRED control | UNKNOWN until restore test | Restore-test record | Assign | Run a controlled restore test |
| REG-004 | IKAI local processing | Reflective computing | IKAI | Name exact device | Design/experimental as decided | UNKNOWN until tested | Data-flow and offline test | Assign | Map local/cloud boundary |
| REG-005 | Customer booking workflow | Business operations | NAKEBUSEN | Name exact channel/system | Operational requirement | UNKNOWN until verified | End-to-end booking test | Assign | Verify current transaction path |

The entries above are examples to demonstrate how the register works. They do not certify that the listed components have been built, configured, or deployed.

## G1. Review cadence

- Review status when a material configuration changes.
- Review dependencies and security posture when a vulnerability, upstream release, or support change affects the unit.
- Review backup and restore evidence on a defined schedule appropriate to data importance.
- Review experimental technologies before they become dependencies.
- Review deprecated components before removal or migration.
- Reconcile the register against repository and target evidence; do not use memory or a planned design as a substitute for inspection.

---

# Appendix H — Final Acceptance Checklist

A material implementation is ready to be accepted only when the applicable checks have evidence.

- [ ] Purpose and owning domain are clear.
- [ ] Target unit and responsible owner are identified.
- [ ] Baseline versions and source revisions are recorded.
- [ ] The proposed diff is reviewed and contains no unexplained unrelated changes.
- [ ] Dependencies, licenses, provenance, and trust boundaries are reviewed.
- [ ] Security and privacy implications are documented.
- [ ] Build or configuration validation passed, or failures are recorded accurately.
- [ ] Functional and target-specific tests passed.
- [ ] Backup, rollback, or rebuild path is documented.
- [ ] Restore has been tested when data or recoverability is affected.
- [ ] Required human approval is recorded.
- [ ] Deployment is distinguished from testing.
- [ ] Post-deployment behavior is checked.
- [ ] Evidence is linked from the status register.
- [ ] Next review trigger or date is recorded.

## Final operating rule

**Document broadly. Select narrowly. Inspect before editing. Pin what must be reproducible. Test on the actual target. Preserve recovery paths. Keep authority with the responsible human. Update statuses only when evidence supports them.**