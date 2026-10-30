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
| M-Pesa Daraja (STK/C2B/B2C) | High | High | High (licensed MM / shortcode path) | **Production candidate** for NAKEBUSEN |
| USSD menus for booking/status | High | High | Depends on use (info vs payment) | Production candidate (UI) |
| Card / licensed PSP gateways | High | Medium–High | Licensed PSPs | Optional commerce path |
| GNU Taler (exchange + wallet + merchant) | High (upstream) | **Low** (no mass KES adoption) | **UNKNOWN / external** | RESEARCH |
| USSD → Taler order + status assistant | Medium | Low until wallets exist | UNKNOWN if public money movement | RESEARCH |
| Custodial “Taler PIN on USSD” | Medium | Low | Likely regulated as e-money/PSP | **Avoid** as non-custodial Taler |
| GNUnet as payment rail | N/A | N/A | N/A | **Out of scope** |
| GNUnet as optional bridge transport | Medium | Low operational need proven | N/A | RESEARCH (justify per use) |
| Crypto / unapproved stablecoins | Variable | High legal risk | Tightening VASP/stablecoin rules | Not WARENA default |

---

## 3. Study A — Mobile money and internet payments (Kenya-first)

### 3.1 Findings

- **M-Pesa** remains the default retail value rail. Developer integration via **Daraja**: OAuth, STK Push (Lipa na M-Pesa Online), C2B register/callbacks, B2C payouts.
- **STK Push** is usually better payment UX than free-form USSD amount entry; USSD remains valuable for feature-phone menus and status.
- **Airtel Money / T-Kash** and bank rails (PesaLink, cards) are secondary paths, not full substitutes for M-Pesa reach.
- Licensed **PSPs / gateways** support internet checkout; they do not replace agent + USSD cash culture.

### 3.2 Feasibility verdict

| Question | Answer |
|----------|--------|
| Can NAKEBUSEN take real KES payments today? | **Yes**, via M-Pesa shortcode + Daraja (or equivalent), subject to Safaricom/merchant onboarding. |
| Is USSD required for every payment? | **No.** STK/app/web often sufficient; USSD expands feature-phone coverage. |
| Does WARENA need a custom payment network first? | **No** for commerce. Research tracks are separate. |

### 3.3 Risks

- Operator dependency and fee schedules.
- Callback URL security, idempotency, reconciliation.
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
| Can engineers run a test exchange/merchant offline? | **Yes** (upstream software exists). |
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
| **Payment assistant** | USSD creates Taler **orders** and polls **status**; wallet authorises pay | Medium | **Preferred research path** |
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
| Can USSD talk to a backend that calls Taler merchant APIs? | **Yes** in principle (HTTPS bridge). |
| Can feature phone run full non-custodial Taler wallet protocol? | **No** with stock USSD. |
| Does this preserve Taler privacy properties? | **Only if** payment authorisation stays in a real wallet — not if keys live on the bridge. |
| Production without wallets in the field? | **Not useful** beyond demos. |

### 5.4 Research phases

| Phase | Work | Evidence |
|-------|------|----------|
| R0 | Read merchant order/status APIs; lab instance | Version pins, logs |
| R1 | Spec USSD menu ↔ bridge endpoints | Sequence diagram |
| R2 | Minimal bridge: create order + poll paid | Automated tests |
| R3 | Threat model (SIM swap, session, clerk fraud) | Written model |
| R4 | Regulatory mapping if any public value held | Counsel / CBK map |
| R5 | Optional GNUnet only if R2 shows networking gap | Justification note |

---

## 6. Study D — GNUnet / GNUnet NG

### 6.1 Findings

- GNUnet provides DHT, CADET, GNS, transport stack; **TRANSPORT-NG** is ongoing redesign work, not a finished “USSD killer.”
- No upstream product that settles KES or replaces M-Pesa.

### 6.2 Feasibility verdict

| Question | Answer |
|----------|--------|
| Use GNUnet as mobile money alternative? | **No.** |
| Use GNUnet to harden bridge-to-merchant networking later? | **Maybe**, after a concrete requirement. |
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

## 8. Open questions

1. When (if ever) will a KES Taler exchange operate under a clear Kenyan authorisation path?
2. How should M-Pesa funding/redeem of Taler balances be designed without breaking privacy or law?
3. Is feature-phone Taler viable via agent POS / second device rather than pure USSD crypto?
4. Does any NAKEBUSEN Digital client need offline-first settlement beyond M-Pesa callbacks?

---

## 9. Status line

**RESEARCH documentation only.** These feasibility studies do not implement software, open MNO contracts, or assert regulatory approval. Production customer payments remain on conventional mobile-money or licensed PSP rails until evidence and authorisation say otherwise.
