# WARENA Research — Freedom in Machine-Learning Applications

**Date:** 2026-11-27  
**Status:** RESEARCH BRIEF / OPEN QUESTIONS  
**Authority:** WARENA for systems engineering; FELOH Corpus for cross-project governance.  
**Source lead:** [Free Software Foundation — FSF is working on freedom in machine learning applications](https://www.fsf.org/news/fsf-is-working-on-freedom-in-machine-learning-applications)

## 1. Purpose

This brief opens a WARENA research track on what user freedom requires across machine-learning applications and their dependencies. The FSF announcement is a research lead, not evidence that WARENA has completed an independent assessment or selected an implementation.

The central question is:

**Can a person inspect, run, understand, modify, share, replace and control the complete machine-learning system they rely on?**

An application may publish source code while depending on a model, weights, dataset, remote API, hosted inference service or non-reproducible training process that the user cannot meaningfully inspect or control. Freedom must therefore be evaluated across the stack rather than inferred from the application licence alone.

## 2. System boundary

Assess each layer independently:

1. **Application:** source code, build instructions, dependencies, licence and user-facing controls.
2. **Model architecture and implementation:** model definition, inference implementation, tokenizers, preprocessing and postprocessing.
3. **Model parameters:** weights, checkpoints, quantisation and conversion artefacts; determine their provenance, terms and practical modifiability.
4. **Training and fine-tuning:** scripts, configurations, toolchains, compute assumptions and ability to reproduce or continue training.
5. **Data:** dataset sources, licences, consent, privacy, provenance, restrictions and documented exclusions. Data availability does not automatically imply lawful or ethical reuse.
6. **Execution environment:** local hardware, drivers, accelerators, runtime dependencies, network requirements and offline behaviour.
7. **Distribution and updates:** model delivery, versioning, signatures, rollback, update authority and supply-chain integrity.
8. **Service boundary:** identify whether inference is local, self-hosted, federated or controlled by a remote provider; document what leaves the device.
9. **Governance:** user control, operator authority, telemetry, retention, deletion, moderation and appeal mechanisms.

Do not collapse source availability, open weights, open data, reproducible training and software freedom into one label. State exactly what is available and what remains restricted or unknown.

## 3. Evaluation questions

For every candidate system, record:

- Which licence governs each component and artefact?
- Can users obtain the exact model and all required runtime components?
- Can they run inference without a vendor-controlled network service?
- Can they inspect and modify the application and inference stack?
- Are weights and conversion artefacts redistributable and practically modifiable under their terms?
- Are training data and data-processing methods sufficiently documented to assess provenance and rights?
- Can the training or fine-tuning pipeline be reproduced, and what compute or data is unavailable?
- Can users replace the model or provider without losing their data or application workflow?
- What telemetry, retention, remote logging and external calls occur?
- What hardware, firmware, accelerator or driver restrictions create lock-in?
- How are updates authenticated, reviewed and rolled back?
- What are the failure modes, security risks and known limitations?

Use explicit evidence labels: **VERIFIED**, **DOCUMENTED BY UPSTREAM**, **PARTIALLY AVAILABLE**, **RESTRICTED**, **UNKNOWN** and **NOT APPLICABLE**.

## 4. WARENA design constraints

The existing WARENA engineering policy applies:

- Human authority and explicit permissions.
- Libre-first software and open interfaces.
- Local-first execution where feasible.
- Offline utility and graceful degradation.
- Reproducible environments and recorded artefact provenance.
- No unnecessary telemetry or hidden remote dependencies.
- Model/provider replaceability through documented interfaces.
- Clear separation between model capability and verified system behaviour.
- Upstream reuse and attribution before new implementation.

These principles do not imply that every model, dataset or accelerator can currently satisfy them. Gaps must be documented rather than hidden by marketing labels.

## 5. Candidate evaluation matrix

| Dimension | Minimum evidence |
|---|---|
| Application freedom | Source, licence, build and dependency inventory |
| Model freedom | Architecture, weights availability, licence/terms and modification path |
| Data provenance | Sources, rights, consent and processing documentation |
| Reproducibility | Versioned recipe, toolchain, inputs and repeatable outcome |
| Local control | Local inference, offline test and network inspection |
| Interoperability | Replaceable model/runtime interface and portable data |
| Privacy | Data-flow map, retention, telemetry and deletion behaviour |
| Security | Threat model, update integrity, isolation and vulnerability process |
| Hardware independence | Supported targets, firmware constraints and accelerator dependencies |

A missing dimension remains **UNKNOWN**; it must not be silently scored as compliant.

## 6. Initial work packages

1. Translate the FSF announcement into a source-grounded statement of its scope and intended criteria.
2. Compare relevant free-software positions and existing model/application evaluation frameworks.
3. Select a small, representative set of local and hosted ML applications for a documented comparison.
4. Inventory licences and practical restrictions for application code, model weights, datasets and runtime components separately.
5. Test local/offline operation and observe network/data flows for selected candidates.
6. Evaluate model replacement, exportability, reproducible packaging and rollback.
7. Publish a decision record identifying which systems meet which freedoms, with evidence and uncertainty.

## 7. Boundaries and non-claims

This is a research brief. It does not claim that WARENA has built an ML platform, trained a model, validated a dataset, audited the FSF project, certified any model as free, or selected a production stack.

Do not equate “open source” with “free for users” without checking the complete dependency and artefact chain. Do not make legal conclusions about dataset or model terms without qualified review.

## 8. Relationship to the ecosystem

- **WARENA:** systems freedom, local execution, reproducibility and infrastructure evaluation.
- **IKAI:** any reflective or embodied ML use must remain participant-directed, privacy-preserving and non-judgemental.
- **GENJE:** creative ML use must preserve human authorship, consent, source attribution and performer rights.
- **NAKEBUSEN:** no ML capability is a public customer service until separately scoped and approved; **ONLY NAKEBUSEN TRANSACTS**.
- **FELOH Corpus:** shared research provenance, governance and cross-domain navigation.

**Freedom Is a System.**
