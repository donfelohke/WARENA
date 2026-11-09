# AI-Assisted Development and Source Provenance

**Status:** Proposed engineering policy  
**Canonical policy:** [FELOH Corpus — AI-Assisted Development and Source Integrity](https://github.com/donfelohke/feloh-corpus/blob/main/AI-ASSISTED-DEVELOPMENT.md)

WARENA applies the canonical policy to systems software, Linux infrastructure, networking, build systems, package definitions, hardware research and reproducible artefacts.

## Required practice

- GPL-first for original software where reciprocal licensing is suitable; preserve third-party licences and notices.
- Never use leaked, stolen, unreleased or otherwise unauthorised source as an AI prompt, rewrite target or implementation reference.
- Never pass restricted code through an LLM to disguise copying or manufacture a clean-room appearance.
- Record lawful source references, upstream commits, versions, patches and authorship.
- Separate hardware observations, public specifications, hypotheses and implementation.
- For reverse engineering, document the independent observation/specification path; do not claim clean-room provenance if restricted implementation material or an LLM transformation of it materially informed the result.
- Disclose material AI assistance in the PR, including tool/model where known, purpose, affected paths, authorised inputs and human review.
- Do not submit secrets, private keys, customer/network data, private logs or confidential infrastructure details to external AI services.
- Verify generated code through source review, tests, static analysis and reproducible build procedures appropriate to the change.

## Reproducibility and supply chain

Record source commit, toolchain and package versions, build environment, dependency sources, hashes/signatures where available, commands, test results and limitations. An attestation or successful local build is not independent reproducibility evidence unless the verification environment and result are recorded.

## Licensing boundary

The existing GPL-3.0 licence remains unchanged by this document. This policy does not convert the repository to GPL-2.0-or-later. Any licence change requires an explicit rights-holder decision, contributor/ownership review and compatibility analysis.

## Review checklist

- [ ] All source inputs are authorised and attributable.
- [ ] No leaked or restricted source was used as an AI rewrite input.
- [ ] AI assistance is disclosed when material.
- [ ] Human review and validation are recorded.
- [ ] Licence and dependency obligations are preserved.
- [ ] Build and reproducibility claims match actual evidence.
