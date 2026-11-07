# NAKEBUSEN — Variable Subject Ad Poster Framework
## Desert Digital Neo-Naturalism · Universal Canonical v4

**Record date:** 2026-11-07  
**Status:** DOCUMENTATION BASELINE · HUMAN REVIEW REQUIRED  
**Applies to:** NAKEBUSEN campaign artwork and its supporting creative workflow  
**Canonical scope:** subject-variable poster generation; not a change to the public website

> **Core rule:** The human subject or subjects may change. The approved NAKEBUSEN visual identity, composition, commercial facts, contact details and publication controls do not change unless separately approved.

## Repository responsibility
WARENA owns reproducibility and technical process notes for any future local generation pipeline: tool/model versions, environment definitions, deterministic composition, offline capability claims and recovery instructions. The presence of this specification does not prove that ComfyUI, SDXL/Flux, ControlNet, IP-Adapter, OCR or an automated publishing service is installed or deployed. Record upstream, local environment and tested host separately.

## 1. Purpose and boundaries

This specification converts the supplied variable-subject poster direction into a repeatable, subject-agnostic workflow. It supports a single person, a couple or a group while preserving each person's visible individuality and cultural context without stereotyping.

The workflow has two distinct stages:

1. **Reference analysis:** inspect supplied reference photograph(s) and record only visible or explicitly provided information.
2. **Poster composition:** insert the approved subject description into the locked campaign template.

Do not treat an image-analysis description as verified identity, ethnicity, age, personal history or consent. It is a production note, not a biometric record.

### Locked elements

Unless an authorised design decision explicitly changes them, preserve:

- NAKEBUSEN brand hierarchy and approved lockup.
- Poster aspect ratio, safe margins, card geometry, alignment and typographic hierarchy.
- Glass-card material, border, radius, blur and shadow treatment.
- Approved background treatment and supporting graphic marks.
- Pricing, service names, contact details, CTA and footer copy.
- Approved brand marks, campaign labels and legal/provenance notes.

Only the human subject block is variable by default. Do not redesign the poster while performing a subject substitution.

## 2. Reference-image analysis

Before generation, inspect every supplied reference photograph separately. Produce a structured record for each subject and then a group-level description.

### Required fields

| Field | Recording rule |
|---|---|
| subject_count | single, couple or group; state the count when known |
| subjects | one record per visible person |
| gender_presentation | describe visible presentation cautiously; use unknown where unclear |
| age_range | broad visual estimate only when necessary; never state as verified age |
| skin_tone | plain visual description; optional approximate colour note is lighting-dependent |
| hair_type | visible hair form, e.g. natural locs, twists, afro, short cut |
| hair_detail | length, texture, parting, retwist state and visible styling details |
| facial_features | visible distinguishing features; retain natural texture and avoid beautification |
| expression | observable expression, not inferred personality |
| clothing | visible clothing relevant to composition |
| group_dynamic | posture, spacing, touch and interaction that are actually visible |
| cultural_context | use only when supplied by the person or supported by reliable provenance |
| background_override | retain original only when requested/approved; otherwise use the campaign background |

### Analysis rules

- Do not infer ethnicity, nationality, tribe, religion, gender identity or cultural affiliation from appearance.
- Do not infer age beyond a broad estimate, and omit it if it is not needed.
- Do not assign skin-tone hex values as objective measurements. Lighting, white balance and display calibration change apparent colour.
- Preserve real skin texture, pores, natural hair texture, scars and other visible features; do not smooth or erase them.
- Do not invent loc length, density, installation method, retwist state, accessories or cultural meaning.
- For groups, describe each person independently before describing the shared composition.
- Never combine separate people's features into a composite subject.
- Use reference likeness only with appropriate permission and a lawful, documented intended use.

### Structured record template

~~~json
{
  "subject_count": "single | couple | group",
  "subjects": [
    {
      "gender_presentation": "visible presentation or unknown",
      "age_range": "broad estimate or omitted",
      "skin_tone": "visual description; lighting-dependent",
      "hair_type": "visible hair form",
      "hair_detail": "length, texture and visible styling state",
      "facial_features": "visible details; natural texture retained",
      "expression": "observable expression",
      "clothing": "visible clothing"
    }
  ],
  "group_dynamic": "observable posture and interaction, if applicable",
  "cultural_context": "only if supplied or evidenced; otherwise unknown",
  "background_override": "approved retained background or campaign background"
}
~~~

This is a production schema. Do not store sensitive identity inferences or use it for identification, classification, scoring or surveillance.

## 3. Dynamic subject block

Replace only the subject paragraph in the master prompt:

~~~text
SUBJECT: [subject_count] portrait of [concatenated, individually grounded
subject descriptions].

[For a couple or group: Describe only the observed or requested spacing,
posture and interaction.]

Each subject retains realistic skin texture, natural pores, authentic
hair texture and visible individual features. No smoothing, face reshaping
or synthetic beautification.

Expression: [observable expression for each person].

Cultural context: [include only when supplied or reliably evidenced;
otherwise omit this sentence].

Background: [approved background override, or the campaign's softly
blurred dusk desert landscape].

Use soft, diffused warm light. Keep each subject recognisable and
compositionally distinct.
~~~

For a group, concatenate descriptions without collapsing them into a single generic identity. Keep the group dynamic as a separate sentence.

## 4. Master poster art direction

**Format:** square 1:1 campaign poster; 1080 × 1080 delivery baseline.  
**Style:** Desert Digital Neo-Naturalism; editorial, photographic, grounded and restrained.  
**Composition:** centred layout; one dominant glass card approximately 70% of canvas width; maintain 100 px safe margin at 1080 px output.  
**Background:** softly blurred dusk desert dunes, transitioning from warm sand to deep night (#1A1512); no rocks, stock desert clichés or distracting clutter.  
**Subject:** insert the dynamic subject block from Section 3.  
**Lighting:** warm, soft, diffused and even; retain believable shadow and skin detail.

### Glass card

- Bone-tinted translucent material: rgba(242,239,234,0.12).
- Backdrop blur: 20 px.
- Border: 1 px rgba(242,239,234,0.15).
- Corner radius: 16 px.
- Soft, restrained shadow.
- If transparency is unsupported, use a solid #1A1512 fallback.
- Keep all text sharp, legible, correctly spelled and undistorted.

### Campaign-variant colour discipline

The supplied v4 poster variant specifies a dark, bone, terracotta and slate treatment and prohibits green tones in this particular artwork. Treat this as a **campaign-variant constraint**, not an automatic amendment to the wider NAKEBUSEN brand palette.

- Background: #1A1512.
- Primary text: #F2EFEA.
- Accent: #E2725B.
- Secondary: #7A8B99.
- Links, sparingly: #A8C4D6.
- No green, neon, glossy gradients or decorative tech clutter in this v4 variant.

### Typography and hierarchy

Use the typefaces and typographic roles already approved for the relevant campaign master. The v4 source requires perfectly sharp, centre-aligned card typography. Do not introduce a new type family or alter hierarchy during subject substitution. Validate actual font availability before rendering.

## 5. Copy, pricing and contact integrity

The prompt supplied with v4 contains proposed copy and example prices that do not fully match the existing approved NAKEBUSEN campaign record. They must not be silently promoted to live advertising.

### Canonical commercial controls

- Current approved Eldoret campaign starting prices: **RETOUCH & STYLING — KES 700+; SISTERLOCS RETIE — KES 1,500+; ARTIFICIAL LOCS INSTALLATION — KES 3,500+.**
- State that these are starting prices and final cost depends on service and requirements.
- Do not publish the v4 example prices (Locs Retouch 700, Instant Locs 2,000, Artificial Locs & Install 3,500, Styling 200) as an approved price list without a separate owner-confirmed price decision.
- Do not substitute “Instant Locs” or “Styling” for approved catalogue service names without approval.
- Preserve the approved contact: **0719 635 415** and social handle **@donfelohke**.
- Preserve the canonical relationship lockup: **NAKEBUSEN Locs ° Powered by WARENA**. “WARENA COLLECTIVE” and “NKBSN Locs & Nails” in the supplied sample are not approved replacements for this lockup.
- An enquiry is not a booking. Do not invent availability, discounts, guarantees, testimonials or completed outcomes.
- Do not imply braiding is offered.

### Copy fields are locked inputs

The following are not generated from the subject description: business name, service list, prices, location, contact details, social handles, CTA, legal copy and footer. Load them from the approved campaign copy source and validate before rendering.

## 6. Production workflow

1. **Collect:** receive reference photographs and the intended campaign use.
2. **Rights and consent check:** record source, owner/photographer, subject permission, permitted channels, term and restrictions.
3. **Analyse:** produce the structured subject record; mark unknowns explicitly.
4. **Human review:** verify the description against the image; remove unsupported assumptions.
5. **Compile:** insert only the reviewed subject block into the locked master prompt.
6. **Generate:** use the approved image-generation pipeline. ComfyUI, SDXL/Flux, ControlNet and IP-Adapter are candidate tools, not a claim that a production pipeline is installed or operational.
7. **Compose typography:** where possible, render the photographic layer separately and typeset final copy in a deterministic layout tool to avoid model-generated text errors.
8. **QA:** perform OCR, spelling, price, contact, safe-margin, contrast, crop, identity-likeness and visual-consistency checks.
9. **Approval:** obtain human approval for the final image, copy, subject likeness and intended channel.
10. **Archive:** preserve source references, consent evidence, prompt version, model/tool versions, outputs, review notes and publication decision in the relevant asset record.

## 7. Quality-assurance checklist

- [ ] Correct subject count and distinct description for every person.
- [ ] No speculative ethnicity, nationality or cultural claims.
- [ ] No invented hair details or altered natural features.
- [ ] Realistic skin and hair texture; no smoothing or face reshaping.
- [ ] Background treatment follows the approved campaign direction.
- [ ] Card position, geometry, margins and glass treatment unchanged.
- [ ] Brand lockup and typography match the approved master.
- [ ] Service names and prices match the current approved catalogue.
- [ ] Phone number and social handle are exact.
- [ ] CTA and footer are complete and legible.
- [ ] OCR and human proofreading completed.
- [ ] Rights, consent, provenance and publication approval recorded.
- [ ] No unapproved logos, marks, QR codes, claims or decorative elements.

A failed check returns the artwork to correction; it is not publication-ready.

## 8. Versioning and change control

- **v4** establishes the subject-analysis and dynamic-substitution framework.
- A subject substitution does not create a new brand identity or authorise a copy, price, contact or layout change.
- Any change to locked commercial copy, palette, typography, card geometry, CTA or brand lockup requires a separate, attributable design decision.
- Keep source image, analysis record, prompt, generated output and approved final export linked by stable identifiers.
- Mark outputs as **DRAFT**, **IN REVIEW**, **APPROVED** or **PUBLISHED**; do not imply publication from generation alone.

## 9. Known unresolved decisions

1. Confirm whether the v4 no-green palette is a permanent NAKEBUSEN campaign variant or a one-poster treatment; it does not supersede the global brand palette by itself.
2. Reconcile the v4 example price list with the approved Eldoret starting-price catalogue before any price-card replacement.
3. Confirm whether “WARENA COLLECTIVE” or “NKBSN Locs & Nails” is intended as exploratory copy; neither replaces the canonical lockup without approval.
4. Validate exact typeface files, image-generation model versions, OCR tooling and automated publishing integration before describing the workflow as deployed.

## 10. Related canonical references

- [FELOH Corpus](https://github.com/donfelohke/feloh-corpus) — shared terminology, evidence and decision records.
- [NAKEBUSEN](https://github.com/donfelohke/NAKEBUSEN) — commercial identity and approved service catalogue.
- [Gallery](https://github.com/donfelohke/Gallery) — asset provenance, permissions and approval.
- [GENJE](https://github.com/donfelohke/Genje) — creative practice and campaign direction.
- [WARENA](https://github.com/donfelohke/WARENA) — reproducible systems and production documentation.
- [IKAI](https://github.com/donfelohke/Ikai) — separate reflective-compute research; not a subject-identification system.

---

*This document records a proposed production standard derived from the supplied Universal Canonical v4. Human review, rights clearance and approval remain mandatory.*
