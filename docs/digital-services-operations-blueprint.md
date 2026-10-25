# WARENA Digital Services and Operations Blueprint

**Status:** Service-design baseline; publish individual offers only when delivery capacity is confirmed.  
**Principle:** Freedom Is a System.  
**Ecosystem boundary:** ONLY NAKEBUSEN TRANSACTS.

## Positioning

WARENA designs and supports practical, maintainable digital systems. Lead with customer outcomes—reliable connectivity, recoverable data, understandable GNU/Linux systems and documented handover—then explain local-first design, reproducibility and software freedom as the methods used to pursue those outcomes.

Do not imply that a proposed architecture, device specification or research configuration is already deployed.

## Audience and problem fit

- **Small businesses and offices:** connectivity, Wi-Fi, network troubleshooting, backups and maintainable workstations.
- **Schools and labs:** lab provisioning, local services, network segmentation, repeatable configuration and staff handover.
- **Technical operators:** GNU/Linux administration, reproducible environments, storage/recovery, migration and documentation.
- **Organisations with connectivity constraints:** local-first workflows and continuity planning, with limitations stated explicitly.

These are target segments to validate, not evidence of existing clients or market demand.

## Candidate service catalogue

Publish a service only when the owner confirms scope, capacity, pricing/quotation method and support boundaries.

### 1. Network and connectivity assessment
Potential scope: router/AP configuration, LAN/Wi-Fi, VLANs, segmentation, mesh design, ISP failover and connectivity troubleshooting.  
Deliverables: agreed scope, current-state notes, topology, configuration/change record, test results and handover notes.

### 2. GNU/Linux and systems administration
Potential scope: installation, configuration, updates, service troubleshooting, user permissions, maintenance and migration.  
Deliverables: system inventory, configuration notes, known limitations, update/maintenance plan and handover.

### 3. Backup and recovery
Potential scope: storage and backup planning, retention policy, local backup design, restore procedure and recovery exercises.  
Deliverables: backup/retention design, restoration test record, agreed recovery-point/recovery-time targets and recovery runbook. A successful backup job alone is not proof that recovery works.

### 4. Reproducible environments
Potential scope: versioned configuration, dependency inventory, build/deployment steps and repeatable environment setup where supported.  
Deliverables: versioned source, declared assumptions, setup instructions, validation evidence and known deviations.

### 5. Digital presence and automation
Potential scope: static websites, GitHub Pages, documentation and simple maintainable automation.  
Deliverables: source-controlled implementation, deployment instructions, accessibility/link checks, ownership handover and rollback notes where applicable.

### 6. Assessment and training
Potential scope: infrastructure review, prioritised improvement plan and practical operator training.  
Deliverables: findings, severity/priority, constraints, costed options where possible and next-step recommendations.

## Delivery workflow

1. **Discover:** clarify the problem, environment, stakeholders, constraints and urgency.
2. **Assess:** capture a minimal baseline and identify risks.
3. **Design:** document scope, alternatives, cost assumptions, acceptance criteria and rollback/recovery plan.
4. **Approve:** obtain client agreement before changes that affect systems, cost or service availability.
5. **Implement:** use least privilege, backups and reviewable change records.
6. **Verify:** run agreed functional, security and recovery tests; record failures and limitations.
7. **Hand over:** provide operating instructions, maintenance responsibilities, inventory and secure credential-transfer procedure.
8. **Support or close:** define warranty/support period if offered; otherwise close clearly with remaining risks.

## Engineering principles

- Local-first where practical; explicitly identify functions that still require external connectivity.
- Prefer libre and inspectable components when they meet requirements.
- Record versions, dependencies, configuration inputs and hardware assumptions.
- Apply least privilege, patching, segmentation and secure credential handling.
- Minimise telemetry and external dependencies; document any that remain.
- Make data export and recovery practical.
- Design for another maintainer to understand, operate, repair and retire the system.
- Separate intended design, implementation, test evidence and independently verified outcomes.

## Service status and evidence

Use `LIVE`, `OPERATIONAL`, `PROTOTYPE`, `RESEARCH`, `PROPOSED`, `HISTORICAL`, `SUPERSEDED` or `UNKNOWN`. For each implementation record the repository/version, environment, date, test method, result, known limitations and evidence location. Do not advertise a device, deployment, monitoring system or support arrangement as operational without current evidence.

## Commercial boundaries

NAKEBUSEN remains the customer-facing transaction boundary. WARENA documentation may describe technical offers and direct enquiries to the approved contact process; it does not independently imply payment, booking, a signed contract or an active support agreement. Confirm the legal and commercial structure before introducing a separate transaction flow.

## Initial measures

- Qualified enquiries and assessments completed.
- Proposal acceptance and delivery lead time.
- Incidents and recurring faults.
- Restoration tests passed against agreed criteria.
- Changes with complete documentation and handover.
- Repeat support and client-reported outcomes.

Avoid vanity metrics. Do not publish client names, network maps, IP ranges, credentials, incident details or sensitive infrastructure evidence without explicit authorisation.

## Release checklist

- [ ] Service scope and capacity confirmed.
- [ ] Pricing or quotation method and exclusions stated.
- [ ] Security, backup, rollback and acceptance criteria considered.
- [ ] Deliverables and handover specified.
- [ ] Maturity label and evidence are accurate.
- [ ] Customer privacy and authorisation boundaries respected.
- [ ] Changes reviewed through a branch and pull request.
