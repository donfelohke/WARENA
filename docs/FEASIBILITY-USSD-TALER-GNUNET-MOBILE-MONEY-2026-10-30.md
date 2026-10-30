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
    → WARENA Access Bridge (session, auth, audit)
      → GNU Taler Merchant Backend (POST order, GET status)
Customer with Taler wallet completes cryptographic payment separately
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

### 7.1 Regulatory and operator qualification\n\nThe regulatory entries above are feasibility assessments, not legal opinions. A licensed mobile-money operator or PSP does not automatically authorise a merchant, aggregator, wallet operator or exchange to perform every payment activity. Before any public-money movement, map the actual roles (merchant, technical service provider, PSP, issuer, exchange, agent), the legislation and CBK instruments in force at that time, contractual permissions, customer-funds handling and safeguarding obligations. The National Payment System Bill, 2026 is a bill and must not be described as enacted law unless its enactment and commencement are independently verified.\n\nFor Daraja, distinguish sandbox credentials from production onboarding. Safaricom's developer documentation describes separate production account/shortcode and product-permission requirements; no such NAKEBUSEN production setup is evidenced by this study.\n\n### 7.2 Taler API and handoff constraints\n\n- Merchant order creation uses the authenticated private API; merchant-side status checks use the private order-status API. Wallet claim/payment uses the separate public wallet-facing flow.\n- The merchant order-creation endpoint is not idempotent unless an explicit `order_id` is supplied. The bridge must implement a stable request/idempotency key and deduplicate retries before creating an order.\n- USSD cannot display a QR code or launch a `taler://` wallet URI on an ordinary feature phone. A second device, compatible smartphone wallet handoff, merchant PoS, or another explicitly tested mechanism is a prerequisite for actual payment. Do not describe the USSD interaction alone as a completed Taler payment.\n- Status shown to the USSD user must be derived from authenticated merchant-side status, with minimal disclosure and protection against order-ID enumeration.\n\n## 8. Open questions

1. When (if ever) will a KES Taler exchange operate under a clear Kenyan authorisation path?
2. How should M-Pesa funding/redeem of Taler balances be designed without breaking privacy or law?
3. Is feature-phone Taler viable via agent POS / second device rather than pure USSD crypto?
4. Does any NAKEBUSEN Digital client need offline-first settlement beyond M-Pesa callbacks?

---

## 9. Primary technical references\n\n- GNU Taler Merchant Backend API: <https://docs.taler.net/core/api-merchant.html>\n- GNU Taler API overview: <https://docs.taler.net/core/api-overview.html>\n- GNU Taler Point-of-Sale integration: <https://docs.taler.net/pos-integration.html>\n- GNUnet roadmap (TNG/CONG status): <https://www.gnunet.org/en/roadmap.html>\n- Safaricom Daraja developer portal and production onboarding notes: <https://developer.safaricom.co.ke/>\n- Central Bank of Kenya, National Payment System information: <https://www.centralbank.go.ke/national-payments-system/>\n\nThese references are starting points; versions, legal status, operator requirements and availability must be checked again at the time of implementation.\n\n## 10. Status line

**RESEARCH documentation only.** These feasibility studies do not implement software, open MNO contracts, or assert regulatory approval. Production customer payments remain on conventional mobile-money or licensed PSP rails until evidence and authorisation say otherwise.
