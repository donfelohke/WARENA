# Digital Service UX SOP — Discovery, Scope, Delivery and Handover

**Status:** PROPOSED OPERATING PROCEDURE · review 2026-10-26  
**Domain:** WARENA / NAKEBUSEN DIGITAL  
**Principle:** Freedom Is a System. Capability without capture.

This SOP covers the customer-facing and operator-facing experience of technical services. It does not assert that a particular deployment, product, router configuration or recovery process is currently live or validated.

## 1. Design goal

A customer should understand what problem WARENA can help investigate, what information is needed to scope the work, what will be delivered, how the result will be tested, and how the customer can maintain or recover the system afterwards.

A technical service is not complete merely because commands ran or a dashboard looks healthy. Usability includes understandable operation, recoverability, access boundaries, documentation and a credible handover.

## 2. Customer journey

### Stage A — Discover

Describe services in customer language before naming the underlying tools.

Examples of service categories:
- GNU/Linux installation, workstation setup and administration.
- Development environment and reproducible build setup.
- Office LAN, VLAN, Wi-Fi and router configuration.
- Local services, offline-first workflow and connectivity planning.
- Backup, restoration, migration and system maintenance.
- Technical audit, troubleshooting and implementation planning.

These are service categories, not a promise that every request is available. Confirm capacity, target hardware, location and scope before commitment.

### Stage B — Enquire safely

Ask the customer to share:
- the problem and desired outcome;
- relevant device/model and software versions where known;
- whether the system is new, existing or production-critical;
- connectivity, power, time or budget constraints;
- a safe way to arrange follow-up.

Do not ask for passwords, private keys, one-time passcodes, M-Pesa PINs, full customer databases or secret-bearing configuration files through a public form or chat. Provide a safe transfer method only if required and agreed.

### Stage C — Discover and scope

Before implementation, record:
- target system and current baseline;
- agreed outcome and acceptance criteria;
- assumptions, prerequisites and exclusions;
- estimated time/cost and payment milestones if relevant;
- access required and how it will be granted/revoked;
- backup and rollback plan;
- expected downtime or risk;
- documentation and handover deliverables;
- support window and responsibility boundaries.

If the scope is unclear, sell or agree a bounded audit/discovery step rather than promising an unverified solution.

### Stage D — Implement reproducibly

- Inspect the existing system before changing it.
- Prefer read-only checks and isolated tests before disruptive changes.
- Record OS, versions, hardware, dependencies, config inputs and relevant commit IDs.
- Keep secrets out of Git and logs.
- Make changes reversible where feasible.
- Record deviations from the plan and the reason.
- Do not merge upstream projects indiscriminately; integrate through explicit interfaces, pinned dependencies and tested adapters.

### Stage E — Verify

Write acceptance criteria before testing. Depending on the task, verify:
- expected functionality and user-visible behaviour;
- network segmentation, routing and firewall rules;
- access controls and least privilege;
- restart/reboot behaviour;
- dependency and version state;
- failure behaviour and logs;
- backup creation and actual restore test;
- performance under a stated workload;
- rollback or recovery procedure.

A configuration file existing is not proof that a service works. A successful command is not proof of end-to-end acceptance. State exactly what was tested, on which target, with what result and limitations.

### Stage F — Handover

Provide the agreed subset of:
- system purpose and architecture;
- inventory and versions;
- configuration location and source revision;
- service start/stop/restart and health checks;
- user and access ownership;
- backup and restoration instructions, with last tested date;
- troubleshooting and escalation route;
- known limitations, dependencies and unsupported conditions;
- upgrade and retirement notes.

The customer must not be dependent on undocumented founder-only knowledge for routine operation.

## 3. Interface and documentation standards

- Use a consistent vocabulary for service, deliverable, prerequisite, acceptance test, risk, rollback and support.
- Put next actions and prerequisites near the top.
- Use copyable commands with context, expected output and recovery notes.
- Distinguish read-only commands from commands that change state.
- Explain destructive operations and require explicit confirmation in runbooks.
- Use tables for inventory and comparison, not as a substitute for explanatory prose.
- Provide concise quick-start instructions plus deeper reference documentation.
- Keep local-first operation and offline constraints visible.
- Avoid dashboards, AI assistants or telemetry unless they solve a documented problem and have explicit privacy boundaries.

## 4. Evidence and status vocabulary

Use the same status terms across documentation and repository issues:

- **CONCEPT** — idea only.
- **RESEARCH** — sources and questions being investigated.
- **PROPOSED** — recommended design or procedure not yet implemented.
- **PROTOTYPE** — limited implementation with known boundaries.
- **IMPLEMENTED** — code/configuration exists at a named revision.
- **TESTED** — stated tests ran on a named target and results are recorded.
- **DEPLOYED** — deployment to a named environment is evidenced.
- **SUPERSEDED** — replaced by a later documented decision.
- **UNKNOWN** — insufficient evidence.

Do not label a service “production-ready” merely because it builds. For backups, distinguish scheduled backup, integrity check, restore test and disaster-recovery exercise.

## 5. SOP for a new service or interface

1. **Problem statement:** who is blocked, by what, and what outcome matters?
2. **Evidence:** current state, user report, logs or reproducible failure; redact secrets.
3. **Constraints:** hardware, connectivity, local policy, budget, maintenance skill and privacy.
4. **Design:** simplest architecture with explicit interfaces and failure modes.
5. **Acceptance criteria:** observable outcomes and a test plan.
6. **Prototype:** validate in a non-production or recoverable environment.
7. **Review:** security, maintainability, accessibility of the interface, and handover.
8. **Implementation:** branch, reviewable changes, pinned inputs and repeatable procedure.
9. **Verification:** record exact environment, commands, outputs and known gaps.
10. **Release:** documented rollback, owner, support boundary and recovery path.
11. **Learning:** update runbooks and corpus with the decision and evidence.

## 6. Service-design checklist

- [ ] Customer language describes the outcome, not only tool names.
- [ ] Discovery asks only for information needed to scope the task.
- [ ] No credentials or unnecessary private data are requested.
- [ ] Scope, exclusions, risks and acceptance criteria are explicit.
- [ ] Access is least-privilege and time-bounded where practical.
- [ ] Configurations and dependencies are versioned and reproducible where feasible.
- [ ] Tests cover normal operation and relevant failure/recovery paths.
- [ ] Rollback and backup/restore responsibilities are clear.
- [ ] Handover enables another maintainer to operate the system.
- [ ] Deployment claims are tied to a named target and evidence.
- [ ] The service does not silently add telemetry, cloud dependency or vendor lock-in.
- [ ] Documentation states what remains untested.

## 7. UX metrics and feedback

Use evidence that improves the service without surveillance:
- proportion of enquiries with enough information to scope;
- recurring clarification questions caused by unclear service descriptions;
- time from agreed scope to verified handover;
- acceptance-test pass/fail and reopened defects;
- successful customer handover tasks;
- restoration success and elapsed recovery time, when measured;
- documentation gaps found by a second maintainer.

Do not fabricate targets. Establish a baseline, state sample size, and collect the minimum data needed. Avoid covert user tracking and behavioural profiling.

## 8. Relationship to ecosystem design standards

- [FELOH Corpus — shared UI/UX SOP and case studies](https://github.com/donfelohke/feloh-corpus/blob/main/docs/research-briefs/ui-ux-sops-design-trends-case-studies.md) governs cross-domain design principles, source provenance and evidence limits.
- [NAKEBUSEN — Locs and Digital service-journey SOP](https://github.com/donfelohke/NAKEBUSEN/blob/main/docs/ui-ux-service-journey-sop.md) governs customer-facing service paths.
- This WARENA document governs technical discovery, delivery verification, operational UX and handover.
- Public website code and deployment checks remain in [donfelohke.github.io](https://github.com/donfelohke/donfelohke.github.io).

**Release rule:** an elegant interface cannot compensate for an untested recovery path. A successful build cannot substitute for customer acceptance and maintainable handover.


## Upstream integration and evidence

Do not describe upstream availability as WARENA compatibility or delivery readiness. Record source provenance, licence, immutable revisions, tests and recovery evidence for each engagement. See [WSAS-01](./WSAS-01.md) and [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md).
