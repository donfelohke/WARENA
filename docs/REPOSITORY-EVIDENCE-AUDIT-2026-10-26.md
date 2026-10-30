# Repository evidence audit — FELOH Corpus & WARENA

**Date:** 2026-10-26  
**Method:** Connected GitHub API inspection of public `main` trees  
**Rule:** Specified ≠ upstream verified ≠ package verified ≠ build/test verified ≠ deployment verified

No production deployment is asserted by this document.

---

## 1. Executive finding

| Area | Established | Not established |
|------|-------------|-----------------|
| FELOH Corpus | Governance, evidence vocabulary, topic registers, architecture **proposals** | Complete claim-to-source operational register; full research intake completion |
| WARENA | Capability boundaries, stack-register **contract**, desktop architecture policy, runbook **templates**, large technology handbook | Guix channel locks, system.scm/manifests in-repo, host inventory filled, CI build of OS images, LIVE service proof |
| Cross-repo | Eight public repos; website public-facts model | Single ops monorepo proving 40-tool fleet |

**Strongest gap:** documentation depth exceeds implementation artifacts in public GitHub.

---

## 2. FELOH Corpus — file inventory (main)

**Root (selected)**

| Path | Role |
|------|------|
| README.md | Corpus purpose |
| GOVERNANCE.md | Governance |
| EVIDENCE-AND-EDITORIAL-STANDARDS.md | Editorial labels |
| EVIDENCE-AND-PROVENANCE-METHOD.md | Provenance method |
| DOCUMENTATION-TREE.md | Doc tree |
| BRAND-CONSTITUTION.md | Brand constitution |
| CONTRIBUTING.md · SECURITY.md · LICENSE | Meta |
| docs/ | Architecture, registers, plans |
| research/ · skills/ · templates/ · .github/ | Supporting trees |

**docs/ (selected)**

| Path | Notes |
|------|--------|
| knowledge-base-architecture.md | Labelled architecture; treat as proposal-grade until operational |
| source-register.md | Schema exists; operational completeness **unverified** |
| MASTER-TOPIC-REGISTER.md | Large topic inventory |
| domain-map.md · glossary.md · decision-provenance.md | Structure |
| seed-source-catalogue.md | Seed catalogue |
| ECOSYSTEM-KNOWLEDGE-MAP.md · INFORMATION-DEPTH-STANDARD.md | Meta standards |
| website-research-implementation-plan-2026-10-26.md | Website research plan |
| ai-automation-architecture.md | AI automation architecture |
| canonical-architecture-2026-10-26.md | Canonical architecture snapshot |

**Finding:** Source-of-record **model** is present. Presence of schema ≠ every claim entered and reconciled.

---

## 3. WARENA — file inventory (main)

**Root**

| Path | Role |
|------|------|
| README.md | States docs ≠ client-site deployment proof |
| GOVERNANCE.md · CONTRIBUTING.md · SECURITY.md · LICENSE | Meta |
| docs/ | All technical content observed |
| .github/ | Workflows present (not audited as deploy proof) |

**docs/ — policy & evidence**

| Path | Role |
|------|------|
| STACK-REGISTER.md | Upstream vs Guix vs host contract |
| EVIDENCE-STATUS.md | LIVE/PROTOTYPE/RESEARCH/CONCEPT/UNKNOWN |
| DESKTOP-ARCHITECTURE.md · DESKTOP-PROFILES.md | Sway / dwl-guile / X11 track |
| CAPABILITY-MAP.md | Offered vs experimental boundaries |
| VALIDATION.md · FOUNDATIONS.md · ORIENTATION.md · PRACTICE.md · PHILOSOPHY.md | Practice framing |
| FELOH_Master_Technology_Register_WARENA_Implementation_Handbook_2026.10_R2.md | Large handbook (~127KB) — **specified/inventory prose**; not host evidence |

**docs/ — operational templates / runbooks**

| Path | Role |
|------|------|
| host-inventory-template.md | Template — not filled host register |
| backup-restore-runbook.md | Recovery procedure text |
| network-services-runbook.md | Network SOP text |
| reproducible-environment-runbook.md · reproducibility-plan.md | Repro intent |
| digital-services-operations-blueprint.md · digital-service-ux-sop.md | Service SOP |
| architecture.md · knowledge-base-index.md · ENGAGEMENT.md | Support |

**Not observed on public main (this audit)**

- `channels.scm` / channel lock commits  
- `manifest.scm` / `system.scm` / Guix Home configs as executable artifacts  
- Named host records with observed versions  
- Build logs proving image/system generation  
- Payment-integration code for Pay Core / Daraja / eTIMS  

**Finding:** WARENA public GitHub is a **documentation and policy** repository. Stack-register rows correctly remain largely **UNKNOWN** for host/config/deployment.

---

## 4. Evidence levels (apply to every component)

| Level | Meaning |
|-------|--------|
| Specified | Documented desire |
| Upstream verified | Release/tag checked |
| Package verified | Guix/channel revision checked |
| Build/test verified | Recorded build/test in defined env |
| Deployment verified | Named system observed running recorded config + recovery |

Partial upstream checks already recorded in [STACK-REGISTER.md](./STACK-REGISTER.md) for Guix 1.5.0, Shepherd 1.0.7, Guile 3.0.10, restic 0.19.1, Yggdrasil 0.5.13 — **host still UNKNOWN**.

---

## 5. Remediation plan (ranked)

| Priority | Action | Acceptance |
|----------|--------|------------|
| P0 | Keep STACK-REGISTER and handbook claims demoted from “production-deployed” language | No public CANON=LIVE without host evidence |
| P0 | Corpus: mark source-register operational status honestly (PROPOSAL vs partial entries) | Status line matches reality |
| P1 | Add one real Guix artifact (channels + minimal manifest or system) when available | Path + commit SHA in STACK-REGISTER |
| P1 | Fill host-inventory from template for at least one lab host (redact secrets) | One row LIVE or PROTOTYPE with date |
| P2 | Cross-link handbook R2 sections to STACK-REGISTER maturity cells | Handbook cites register; register cites handbook |
| P2 | Corpus claim ledger only after sources exist | No claim without source ID |
| P3 | Website public facts stay independent of stack LIVE claims | Public site does not claim unproven stack |

---

## 6. Controls preserved

- Local-first verification preference  
- Reproducibility requires channel/commit/commands/results  
- UNKNOWN when evidence missing  
- Human approval for LIVE promotion  
- No secrets in public registers  

---

## 7. What this audit is not

- Not a claim that components are absent from private machines  
- Not a full line-by-line review of the 127KB handbook  
- Not a Guix package search of all 40 inventory items  
- Not a merge of open PRs or a deployment  

**Next concrete step:** promote **one** component through package → build/test → (optional) deployment evidence, and update STACK-REGISTER for that row only.


## Historical status and later register

This audit is a historical snapshot dated 2026-10-26 and must not be treated as the current repository inventory. The later 2026-10-30 repository and branch reconciliation is recorded in [WSAS-02](./WSAS-02.md). Preserve this file as historical evidence; do not silently rewrite its original observations.
