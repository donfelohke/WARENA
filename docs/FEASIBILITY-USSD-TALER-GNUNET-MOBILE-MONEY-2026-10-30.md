# Feasibility studies: USSD · GNU Taler · GNUnet · mobile money

**Status:** RESEARCH  
**Date:** 2026-10-30  
**Maturity:** Not implemented. Not LIVE. Not a CBK licence application.

Related: [STACK-REGISTER.md](./STACK-REGISTER.md) · [CAPABILITY-MAP.md](./CAPABILITY-MAP.md) · [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md)

Governing rules:

- Separate **access UI**, **value rail**, and **network path**.
- Upstream availability ≠ Kenya production readiness.
- ONLY NAKEBUSEN TRANSACTS commercially; WARENA documents systems research.

---

## 1. Layer model

| Layer | Function | Examples |
|-------|----------|----------|
| Access UI | How humans interact | USSD, STK, app, web |
| Value rail | How money moves | M-Pesa, bank, card/PSP, Taler coins |
| Network | How systems connect | MNO signalling, TLS/HTTPS, GNUnet |

**USSD is not money. Taler is not USSD. GNUnet is not a wallet.**

---

## 2. Feasibility summary matrix

| Option | Technical feasibility | Kenya market readiness | Regulatory clarity | WARENA posture |
|--------|----------------------|------------------------|--------------------|----------------|
| M-Pesa Daraja (STK/C2B/B2C) | High | High | Established licensed-operator framework; merchant permissions/onboarding still required | **Production candidate** for NAKEBUSEN, conditional on onboarding |
| USSD menus for booking/status | High | High | Depends on use, shortcode provisioning and whether the flow initiates or facilitates payments | Production candidate (UI), conditional on operator/aggregator onboarding |
| Card / licensed PSP gateways | High | Medium–High | Licensed PSPs | Optional commerce path |
| GNU Taler (exchange + wallet + merchant) | High (upstream) | **Low** (no mass KES adoption) | **UNKNOWN / external** | RESEARCH |
| USSD → Taler order + status assistant | Medium | Low until wallets exist | UNKNOWN if public money movement | RESEARCH |
| Custodial “Taler PIN on USSD” | Medium | Low | Likely regulated as e-money/PSP | **Avoid** as non-custodial Taler |
| GNUnet as payment rail | N/A | N/A | N/A | **Out of scope** |
| GNUnet as optional bridge transport | Unproven for this use case | Low operational need demonstrated | N/A | RESEARCH only; no automatic security benefit assumed |
| Crypto / unapproved stablecoins | Variable | High legal risk | Tightening VASP/stablecoin rules | Not WARENA default |

---

## 3. Study A — Mobile money and internet payments (Kenya-first)

### 3.1 Findings

- **M-Pesa** remains the default retail value rail. Developer integration via **Daraja**: OAuth, STK Push (Lipa na M-Pesa Online), C2B register/callbacks, B2C payouts.
- **STK Push** is usually a better payment UX than free-form USSD amount entry; USSD remains valuable for feature-phone menus and status. This is a UX recommendation, not a universal operator rule.
- **Airtel Money / T-Kash** and bank rails (PesaLink, cards) are secondary paths, not full substitutes for M-Pesa reach.
- Licensed **PSPs / gateways** support internet checkout. Their licensing does not automatically extend to a merchant integrating their service; the merchant's actual role and onboarding terms still matter.

### 3.2 Feasibility verdict

| Question | Answer |
|----------|--------|
| Is M-Pesa/Daraja a viable real-KES payment path for NAKEBUSEN? | **Yes, as a candidate after merchant onboarding and product/shortcode approval.** This study does not verify that NAKEBUSEN currently has live credentials, a Paybill/Till, or production go-live. |
| Is USSD required for every payment? | **No.** STK/app/web often sufficient; USSD expands feature-phone coverage. |
| Does WARENA need a custom payment network first? | **No** for commerce. Research tracks are separate. |

### 3.3 Risks

- Operator dependency and fee schedules.
- Callback URL security, idempotency, reconciliation. Repeated callbacks must not create duplicate payment requests or fulfilments.
- Confusing research rails with customer-facing payment promises.

### 3.4 Acceptance criteria (commerce)

- [ ] Documented Paybill/Till or STK configuration (or explicit “not yet onboarded”).
- [ ] Sandbox test of STK or C2B with logged results.
- [ ] Production path only after merchant KYC/go-live — evidence recorded separately.

---

## 4. Study B — GNU Taler

### 4.1 What upstream provides

- Blind-signed electronic coins; **buyer privacy** on spend; **merchant income transparency**.
- Components: wallet, exchange, merchant backend (REST order create / pay / status).
- Not a blockchain; not “crypto” in the public-chain sense.

### 4.2 Feasibility verdict

| Question | Answer |
|----------|--------|
| Can engineers run a local test exchange/merchant? | **Yes**, upstream components support a local test deployment; this does not establish production exchange readiness or that every dependency operates offline. |
| Can Kenyan retail customers pay with Taler at scale today? | **No** (wallet + KES exchange adoption missing). |
| Is CBK treatment of a public Taler exchange settled for WARENA? | **UNKNOWN** — treat as external blocker. |
| Should Taler replace Daraja for NAKEBUSEN bookings now? | **No.** |

### 4.3 Recommended research scope

1. Pin Taler component versions in a lab Guix/manifest experiment (when hardware allows).
2. Prove order create + wallet pay + status poll on a **test** currency/instance.
3. Map withdrawal/deposit to bank or MM **only** after regulatory mapping.
4. Keep maturity **RESEARCH** until host + config + date + recovery exist.

### 4.4 Non-goals

- Claiming Taler as licensed Kenyan e-money.
- Advertising Taler checkout on the public NAKEBUSEN site without evidence.

---

## 5. Study C — USSD + Taler bridge

### 5.1 Design fork

| Model | Description | Feasibility | Decision |
|-------|-------------|-------------|----------|
| **Payment assistant** | USSD creates a Taler **order** and reports limited status; a separate compatible wallet/device must claim and pay | Medium, with an unresolved handoff requirement | **Preferred research path** |
| Custodial USSD wallet | Server holds coins/keys | Medium tech / high trust & legal cost | Deferred / avoid as “true Taler” |
| GNUnet-native USSD replacement | Decentralised session layer | Hard; not MNO-compatible | Separate thesis |

### 5.2 Proposed architecture (research)

```text
Feature phone
  → USSD (MNO/aggregator)
    → WARENA Access Bridge (session, auth, audit, deduplication)
      → GNU Taler Merchant Backend (authenticated order creation/status)
      → order reference + tested out-of-band handoff (companion wallet/PoS)
Separate compatible Taler wallet claims the order and performs cryptographic payment
```

### 5.3 Feasibility verdict

| Question | Answer |
|----------|--------|
| Can USSD talk to a backend that calls Taler merchant APIs? | **Yes** in principle, using authenticated HTTPS calls to the merchant's private API. |
| Can a stock feature phone complete the full non-custodial Taler wallet flow through USSD alone? | **No.** A separate compatible wallet/device and a tested order handoff are required. |
| Does this preserve Taler privacy properties? | **Only if** payment authorisation and coin handling stay in a genuine wallet. The bridge must not hold wallet secrets or coins. The bridge may still learn order metadata, so data minimisation and correlation risks need review. |
| Is the assistant useful where no compatible wallet/device or handoff channel exists? | **No** for actual Taler settlement; it is limited to demonstrations or order-intent capture. |

### 5.4 Research phases

| Phase | Work | Evidence |
|-------|------|----------|
| R0 | Read merchant order/status APIs; lab instance | Version pins, logs |
| R1 | Spec USSD menu ↔ bridge endpoints | Sequence diagram |
| R2 | Minimal bridge: authenticated order creation + status polling; explicit idempotency/deduplication for repeated USSD callbacks | Automated tests, including duplicate/retry cases |
| R3 | Threat model (SIM swap, session, clerk fraud) | Written model |
| R4 | Regulatory mapping if any public value held | Counsel / CBK map |
| R5 | Optional GNUnet only if R2 shows networking gap | Justification note |

---

## 6. Study D — GNUnet / GNUnet NG

### 6.1 Findings

- GNUnet provides DHT, CADET, GNS and a transport stack; **TRANSPORT-NG** remains roadmap work. Using GNUnet between the bridge and merchant would require a concrete reachability, threat-model and operations case; it does not automatically harden the service and does not remove MNO dependence at the USSD edge.
- No upstream product that settles KES or replaces M-Pesa.

### 6.2 Feasibility verdict

| Question | Answer |
|----------|--------|
| Use GNUnet as mobile money alternative? | **No.** |
| Use GNUnet as an alternative bridge-to-merchant network path later? | **Maybe**, only after a concrete requirement, threat model and operational test. |
| Block Taler or Daraja work on TNG completion? | **No.** |

---

## 7. Decision record (2026-10-30)

| ID | Decision |
|----|----------|
| D1 | **Commerce payments:** prioritise M-Pesa/Daraja (and documented PSP paths). |
| D2 | **Taler:** RESEARCH only; no LIVE or customer-facing claim. |
| D3 | **USSD+Taler:** assistant model only; no custodial “wallet on USSD” as Taler-equivalent. |
| D4 | **GNUnet:** not a value rail; optional transport research. |
| D5 | **Evidence:** no maturity upgrade without named host, config, date, test outcome, recovery note. |

---

### 7.1 Regulatory and operator qualification

The regulatory entries above are feasibility assessments, not legal opinions. A licensed mobile-money operator or PSP does not automatically authorise a merchant, aggregator, wallet operator or exchange to perform every payment activity. Before any public-money movement, map the actual roles (merchant, technical service provider, PSP, issuer, exchange, agent), the legislation and CBK instruments in force at that time, contractual permissions, customer-funds handling and safeguarding obligations. The National Payment System Bill, 2026 is a bill and must not be described as enacted law unless its enactment and commencement are independently verified.

For Daraja, distinguish sandbox credentials from production onboarding. Safaricom's developer documentation describes separate production account/shortcode and product-permission requirements; no such NAKEBUSEN production setup is evidenced by this study.

### 7.2 Taler API and handoff constraints

- Merchant order creation uses the authenticated private API; merchant-side status checks use the private order-status API. Wallet claim/payment uses the separate public wallet-facing flow.
- The merchant order-creation endpoint is not idempotent unless an explicit `order_id` is supplied. The bridge must implement a stable request/idempotency key and deduplicate retries before creating an order.
- USSD cannot display a QR code or launch a `taler://` wallet URI on an ordinary feature phone. A second device, compatible smartphone wallet handoff, merchant PoS, or another explicitly tested mechanism is a prerequisite for actual payment. Do not describe the USSD interaction alone as a completed Taler payment.
- Status shown to the USSD user must be derived from authenticated merchant-side status, with minimal disclosure and protection against order-ID enumeration.

## 8. Open questions

1. When (if ever) will a KES Taler exchange operate under a clear Kenyan authorisation path?
2. How should M-Pesa funding/redeem of Taler balances be designed without breaking privacy or law?
3. Is feature-phone Taler viable via agent POS / second device rather than pure USSD crypto?
4. Does any NAKEBUSEN Digital client need offline-first settlement beyond M-Pesa callbacks?

---

## 9. Primary technical references

- GNU Taler Merchant Backend API: <https://docs.taler.net/core/api-merchant.html>
- GNU Taler API overview: <https://docs.taler.net/core/api-overview.html>
- GNU Taler Point-of-Sale integration: <https://docs.taler.net/pos-integration.html>
- GNUnet roadmap (TNG/CONG status): <https://www.gnunet.org/en/roadmap.html>
- Safaricom Daraja developer portal and production onboarding notes: <https://developer.safaricom.co.ke/>
- Central Bank of Kenya, National Payment System information: <https://www.centralbank.go.ke/national-payments-system/>

These references are starting points; versions, legal status, operator requirements and availability must be checked again at the time of implementation.

## 10. Status line

**RESEARCH documentation only.** These feasibility studies do not implement software, open MNO contracts, or assert regulatory approval. Production customer payments remain on conventional mobile-money or licensed PSP rails until evidence and authorisation say otherwise.

---

## 11. Kenya merchant payment integration update (2026-10-30)

This supplement compares practical SME integration paths. It is research, not evidence that NAKEBUSEN has a shortcode, production credentials, an aggregator contract or a bank partnership.

### 11.1 Market evidence — define the denominator

The Communications Authority reported Safaricom at 89.7% of mobile-money subscriptions in Q1 FY2025/26 and 89.1% in Q3; reporting on the quarter ended June 2026 puts the figure at 88.8%. These are **subscription market shares**, not transaction-value share, transaction-count share, unique customers or merchant checkout preference. Use the latest dated CA report and preserve the metric's exact denominator.

Safaricom stated at its M-PESA Integrators Forum in December 2025 that approximately 25% of M-PESA transactions ran through APIs, with 130,000+ developers and 70,000+ active integrations. These are company-reported ecosystem metrics, not independently audited service-level evidence. Daraja 3.0 is the current Safaricom developer platform; sandbox access/testing is not production approval.

**Decision implication:** M-PESA/Daraja is the rational first integration to qualify for a Kenya SME booking journey, given its subscription footprint and established merchant API surface. The market statistic does not prove NAKEBUSEN has access or that every customer prefers M-PESA.

### 11.2 Integration map — conceptual, not settlement topology

\`\`\`text
Payer account / wallet
  ├─ M-PESA ────────────────┐
  ├─ Airtel Money / T-Kash ─┤
  └─ Bank / fintech ────────┤
                            v
       Merchant instrument / acquirer / provider product
          ├─ Daraja STK / C2B
          ├─ other MMP or bank partner API
          └─ licensed PSP / aggregator / card acquiring
                            |
                            v
              NAKEBUSEN order + payment ledger
              callbacks · status · reconciliation

Separate interbank context:
  Bank / participating PSP channels ↔ PesaLink (IPSL)
  KEPSS is CBK's high-value RTGS system; do not depict it
  as a mandatory sequential hop for every PesaLink retail transfer.
\`\`\`

The real route depends on payer product, merchant instrument, acquirer, scheme rules and settlement arrangement. Do not infer a direct API or settlement connection from a high-level diagram.

### 11.3 SME integration path comparison

| Path | Feasibility | Gates / limitations | Posture |
|------|-------------|---------------------|---------|
| **Daraja STK Push / M-PESA Express** | Strong candidate for remote booking payments | Merchant onboarding, eligible Paybill/Till/product, production app and permissions, HTTPS callback registration, fees, limits, reversals and support | **P1 candidate** |
| **Daraja C2B** | Strong candidate for customer-initiated Paybill/Till payments and walk-ins | Correct shortcode/product, validation/confirmation URL registration, callback semantics and reconciliation | Complement STK if journey requires |
| **Manual Paybill/Till + SMS/reference** | Low engineering effort if an authorised instrument already exists | Instrument ownership/use, statement access, manual matching, refund and exception process | **P0 fallback**; SMS alone is not authoritative reconciliation |
| **PSP / aggregator** | Potentially fastest multi-method checkout | Contracting entity, licence/authorisation scope, merchant-of-record role, custody, settlement timing, fees, reversals, chargebacks and data access | Optional if multi-rail value beats margin/dependency |
| **Airtel Money direct** | Possible secondary route | Current Kenyan merchant API, onboarding, commercial terms, sandbox and production support must be confirmed | Phase 2 only on demand |
| **T-Kash direct** | Current SME API access not established by this study | Confirm operator product availability, API access and merchant support | Do not plan until verified |
| **Bank APIs (e.g. Jenga/Buni)** | Technically possible; partner/product dependent | Bank-specific agreement, eligibility, credentials and settlement semantics | B2B/account workflows if justified |
| **PesaLink** | Relevant to participating bank/PSP channels and interbank transfers | Confirm whether the merchant's bank/PSP offers an actual merchant acceptance product | Not required for initial loc bookings |
| **KE-QR** | Potential in-person presentation/acquiring option | Acquirer participation, merchant credentials, supported payer apps and settlement route | Nice-to-have later |
| **GSMA Mobile Money API** | Harmonised API specification | Only useful as an integration surface where a provider has implemented the relevant version/use case and grants access | Not a universal Kenyan gateway |
| **Taler KES / USSD→Taler** | No public KES exchange or pure-USSD non-custodial wallet established | Exchange, wallet adoption, legal path and separate wallet handoff | RESEARCH |
| **GNUnet** | No clearing/acquiring/KES settlement role | Separate network requirement only | Out of payment-rail scope |

“High reliability” is not inherent in an API name. Availability, callback delivery, status-query behaviour, reversals, support SLAs and reconciliation must be measured against the actual contracted production service.

### 11.4 Interoperability — do not overgeneralise

The April 2022 Safaricom/Airtel/Telkom announcement described its first phase as allowing customers on the three networks to pay a **Lipa na M-PESA Buy Goods Till**; the announcement explicitly excluded PayBills from that phase. This is evidence of a specific merchant interoperability scope, not proof that every Paybill, till, biller, disbursement, refund or API use case is interoperable today. Confirm current scheme rules and test each payer journey.

Interoperability may reduce the need for a merchant to integrate separately with every payer network. It does not remove the need for a valid merchant instrument, authoritative confirmation, refunds or reconciliation.

### 11.5 PesaLink, KEPSS, KE-QR and GSMA API

- IPSL describes PesaLink as a 24/7/365 real-time payment service for the Kenyan banking ecosystem, with banks, PSPs, SACCOs and a telco among participants; IPSL describes its modernised platform as based on ISO 20022. Access/acceptance products are mediated by participating institutions. Do not assume a generic self-service “PesaLink merchant key” comparable to a Daraja sandbox app.
- KEPSS is a separate CBK high-value RTGS system, not an assumed direct retail hop for every PesaLink transfer.
- CBK issued the KE-QR Standard 2023 to guide regulated banks and PSPs issuing QR codes. It is a merchant-presented information/presentation standard based on EMVCo; it does not itself provide acquiring or guarantee universal wallet acceptance.
- The GSMA Mobile Money API is a harmonised specification, not a central switch. It does not guarantee all Kenyan providers expose the same API, use cases, commercial terms or production access.

### 11.6 Daraja gates — evidence before maturity promotion

| Gate | Required evidence | False positive to avoid |
|------|-------------------|------------------------|
| **P0 Instrument** | Written confirmation of Paybill/Till ownership or authorised use, product, settlement account, fees and support; otherwise record “not onboarded” | Assuming a shortcode exists because manual payments are possible |
| **P1 Sandbox** | OAuth, STK request, captured callback, status handling and redacted test logs | Treating sandbox success as production |
| **P2 Hardening** | Stable order reference; idempotent callback processing; duplicate/out-of-order tests; pending/failed/unknown states; reversal/refund and reconciliation procedures | Duplicate fulfilment or treating timeout as success/failure |
| **P3 Production** | Production app and shortcode/product permissions, registered HTTPS callbacks, support/escalation, controlled live payment evidence | Sandbox app/shortcode mismatch or missing product permission |
| **P4 Operations** | Daily reconciliation to authoritative provider/bank statements, exception queue, refund controls, audit trail and incident runbook | Unmatched payments, fee disputes and unresolved unknowns |

Confirm Safaricom's exact current checklist and permissions when applying. Do not assume C2B collection and B2C disbursement share identical permissions or configuration. B2C is a payout capability and is not needed merely to collect booking payments.

### 11.7 Minimum payment-state design

1. Persist a merchant order/reference before initiating STK or displaying payment instructions.
2. Bind the request to order, amount, currency, customer reference and provider transaction identifiers.
3. Validate callback authenticity to the extent supported by the provider; check expected merchant, amount, currency, reference and state.
4. Make callback processing idempotent; repeated callbacks must not create duplicate payment or fulfilment.
5. Keep PENDING, SUCCEEDED, FAILED, CANCELLED, REVERSED and UNKNOWN distinct; map provider states explicitly.
6. On timeout/missing callback, query the provider's authoritative status mechanism where available. A client timeout is not proof of payment failure.
7. Keep immutable audit events and reconcile the current ledger projection to provider statements.
8. Minimise personal data and never store customer PINs or wallet secrets.
9. Fulfil only after the agreed authoritative success condition; define partial payment, overpayment, duplicate and refund handling.

This is a design checklist, not a claim that code or endpoints have been implemented or tested.

### 11.8 Costs and non-code risks

No current operator, aggregator or bank quote is established. Obtain written terms for shortcode/Till/Paybill setup and recurring fees; transaction and settlement charges; aggregator MDR, reserves and settlement schedule; reversal/refund costs; callback/status limits; uptime/support commitments; escalation; KYC; and settlement-account requirements.

Onboarding, instrument provisioning, production permissions and reconciliation may dominate engineering effort. Treat that as a planning hypothesis until actual onboarding timelines and support evidence are collected.

### 11.9 Phased recommendation

| Phase | Goal | Pass condition | Status |
|-------|------|----------------|--------|
| **P0** | Accept KES using an existing authorised instrument or documented manual Paybill/Till | Instrument and settlement path confirmed; manual reconciliation/refund process written | Commerce — manual |
| **P1** | Automated M-PESA STK | Production onboarding; HTTPS callback; status handling; controlled live payment logged and reconciled | Commerce — integrated |
| **P2** | Operational quality | Idempotent ledger, exception handling, daily reconciliation, refunds and runbook demonstrated | Commerce — operated |
| **P3** | Optional second rail | Measured demand/conversion loss, signed terms, tested settlement and support | Commerce — optional |
| **R1–R3** | Taler lab, USSD assistant, independent regulatory analysis | Pinned lab evidence, handoff/threat model, counsel memo | RESEARCH |

**NAKEBUSEN decision:** Qualify Daraja STK first; retain C2B as a complementary option; use manual Paybill/Till only if an authorised instrument already exists and reconciliation is workable. Add Airtel, bank APIs, PesaLink, KE-QR or an aggregator only when measured demand or settlement requirements justify them. Keep Taler, USSD→Taler and GNUnet in RESEARCH. Do not begin implementation merely because this comparison is complete; first record actual shortcode/instrument status and obtain production onboarding evidence.

### 11.10 Additional references

- [Communications Authority — sector statistics](https://www.ca.go.ke/node/270) (quote the specific quarter and metric).
- [Safaricom — Daraja developer portal](https://developer.safaricom.co.ke/).
- [Safaricom — M-PESA Integrators Forum](https://www.youtube.com/watch?v=HYb39pBL1OU) (company-reported API metrics, 5 December 2025).
- [Telkom Kenya — merchant interoperability announcement](https://telkom.co.ke/press-release/telkom-safaricom-and-airtel-integrate-mobile-money-services/) (8 April 2022; Buy Goods Till scope).
- [IPSL — About PesaLink](https://www.ipsl.co.ke/about-us).
- [CBK — KE-QR Standard launch](https://www.centralbank.go.ke/2023/05/03/launch-of-the-kenya-quick-response-code-standard/) and [standard PDF](https://www.centralbank.go.ke/QR/KenyaQuickResponseCodeStandard.pdf).
- [GSMA — Mobile Money API](https://www.gsma.com/solutions-and-impact/connectivity-for-good/mobile-for-development/mobile-money/mobile-money-api-2/).
- [CBK — Draft National Payment System Policy and Bill, 2026](https://www.centralbank.go.ke/2026/09/21/draft-national-payment-system-policy-and-national-payment-system-bill-2026/).

These sources establish market context, standards and provider descriptions. They do not establish NAKEBUSEN's eligibility, live shortcode, production credentials, contracted service levels, pricing or legal position. Confirm those directly before implementation.

## 12. Status line — reaffirmed

**RESEARCH documentation only.** No implementation, MNO/aggregator contract, bank partnership, live payment, KES Taler exchange, CBK authorisation or production readiness is claimed. ONLY NAKEBUSEN TRANSACTS commercially; WARENA remains the systems-research/documentation context.
