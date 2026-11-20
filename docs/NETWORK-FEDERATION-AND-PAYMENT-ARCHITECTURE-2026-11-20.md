# WARENA Network, Federation, Distributed Objects and Payment Architecture

**Document ID:** WARENA-ARCH-NETWORK-01  
**Revision:** 2026-11-20  
**Status:** RESEARCH / ARCHITECTURE SPECIFICATION  
**Authority:** WARENA owns infrastructure architecture; FELOH Corpus owns shared definitions and governance.  
**Decision boundary:** This document records candidate boundaries and qualification gates. It does not claim implementation, production readiness, provider approval, or a live payment integration.

## 1. Executive position

WARENA should not select one protocol as a universal replacement for the Internet. Networking, naming, identity, federation, messaging, object capabilities, storage, and payment settlement solve different problems and must remain separate layers.

The recommended direction is a **local-first core with replaceable network adapters**:

- Local state and durable records remain usable without a network.
- SQLite is a candidate local persistence engine for small services and edge applications; it is not a distributed consensus database.
- Ordinary IP networking remains the compatibility and reachability baseline.
- WireGuard is a practical encrypted site-to-site / device-to-device tunnel where an administrator controls endpoints and keys.
- GNUnet is the principal GNU alternative-network research track, with GNS as the first bounded evaluation.
- Reticulum is a separate candidate for heterogeneous, delay-tolerant and off-grid communication; evaluate its actual interface and transport constraints rather than assuming it replaces IP.
- ActivityPub is an Internet federation protocol for social/application objects, not a network transport.
- Pubstrate is a Guile/Scheme ActivityPub implementation and historical research reference; current maintenance, completeness, security and deployability must be re-audited before use.
- Spritely Goblins and OCapN are relevant to distributed object-capability programming, not substitutes for network infrastructure or payment rails.
- GNU Taler is a distinct payment protocol and settlement system. Mobile-money systems such as M-Pesa are provider-operated payment rails that require contractual/API integration.

The intended architectural composition is: **local application state → explicit application/service interfaces → optional federation or P2P adapters → replaceable transports**. Payments cross a separately governed financial boundary.

## 2. Layer model and component boundaries

| Layer | Responsibility | Candidate technologies | WARENA position |
|---|---|---|---|
| Local persistence | Durable local records, queues, indexes, recovery | SQLite, filesystem, append-only logs | Preferred local-first baseline; no distributed-write semantics assumed |
| Local IPC | Process boundaries and service communication | Unix sockets, pipes, D-Bus where justified | Prefer narrow, authenticated local interfaces |
| Identity and keys | Peer identity, signing, key custody and rotation | OpenPGP, Ed25519/X.509 where appropriate; GNUnet identities | Explicit identity model per application; never conflate a public key with a human identity |
| Naming | Human-usable names and resolution | DNS, GNS, application directory | GNS research; DNS remains compatibility baseline |
| Transport | Packet/stream delivery | IP, TCP, UDP, QUIC, WireGuard, Reticulum interfaces | Pluggable; do not bind application data models to one transport |
| P2P overlay | Peer discovery, routing and distributed services | GNUnet, libp2p, Yggdrasil, Reticulum | Comparative research; select per use case |
| Federation | Server-to-server exchange of application objects | ActivityPub | Optional Internet-facing projection |
| Distributed objects | Secure references and asynchronous object invocation | Goblins, OCapN/CapTP | Guile-aligned research; capability security is a design influence |
| Messaging / pub-sub | Event delivery and group communication | GNUnet Messenger, libp2p pubsub, Matrix | Evaluate threat model, metadata leakage and offline delivery separately |
| Storage | File/object replication and shared namespace | OpenAFS, NFS, Syncthing, Tahoe-LAFS, IPFS, Ceph | Select by consistency, trust, scale and operations; no universal winner |
| Payments | Value transfer, wallet, merchant and settlement | GNU Taler, mobile-money/bank APIs | Separate subsystem, explicit reconciliation and regulated-provider boundary |
| Supervision | Service lifecycle, restart, dependency ordering | Shepherd | Preferred Guix-native service manager where supported |
| Reproducible deployment | Package and system provenance | GNU Guix, Guix Home, RDE | Configuration home remains WARENA |

**Critical distinction:** encryption, authentication, anonymity, decentralisation and availability are different properties. A protocol can provide one without the others. A P2P topology does not automatically provide anonymity, censorship resistance, integrity, or fault tolerance.

## 3. GNUnet and relevant alternatives

### 3.1 GNUnet

GNUnet is the leading GNU-native alternative-network research candidate. Its architecture includes independently supervised services and cryptographic peer identities. The major conceptual subsystems include:

- TRANSPORT: peer connectivity over available transports.
- CORE: authenticated, encrypted links to neighbouring peers.
- CADET: end-to-end encrypted channels across the overlay.
- DHT: distributed lookup and data placement.
- GNS: decentralized, cryptographic naming.
- RPS: random peer sampling.
- SETU / SETI: set reconciliation and intersection.
- Applications: messaging, file sharing, identity and VPN-related components.

The current upstream status page (reviewed for GNUnet 0.29 in November 2026) identifies GNS as the most mature component. Other components remain under development, with known performance, privacy and compatibility limitations. The network is small and cannot currently promise strong anonymity. Major-version protocol incompatibility is also a practical operational risk.

**Recommendation:** evaluate GNS independently first. Do not deploy GNUnet as WARENA's default network substrate or describe it as production-ready. A controlled two-to-five-peer lab should measure peer discovery, lookup latency, NAT behaviour, restart recovery, metadata exposure, resource consumption and version compatibility.

### 3.2 Comparison matrix

| Technology | Primary problem | Strength | Limitation / boundary | WARENA assessment |
|---|---|---|---|---|
| GNUnet | Decentralized secure networking and services | GNU ecosystem, GNS, service isolation, integrated research architecture | Alpha maturity, small network, changing protocols and known privacy issues | Primary GNU alternative-network research |
| Reticulum | Heterogeneous/off-grid networking | Transport abstraction and operation across diverse link types | Must validate actual hardware interfaces, routing behaviour, scale and security for each deployment | Strong candidate for isolated field/off-grid experiments |
| Yggdrasil | Encrypted IPv6 mesh overlay | Mesh addressing and encrypted overlay routing | Not a complete application/federation or anonymity system; topology and reachability constraints | Comparator for mesh/site connectivity |
| libp2p | Modular P2P application networking | Reusable transports, security handshakes, multiplexing, discovery and pub-sub | Framework rather than a complete user-facing network; implementation ecosystem and language choices matter | Strong architectural comparator; not a GNU-native default |
| Tor | Anonymous communication and onion routing | Mature anonymity network and ecosystem | Not a general LAN mesh or generic distributed object platform; latency and exit limitations | Privacy comparator, not general WARENA transport |
| I2P | Anonymous internal network | Garlic routing and internal services | Different design and application ecosystem; operational complexity | Anonymity comparator |
| WireGuard | Encrypted IP tunnels | Small, comprehensible, high-performance VPN design | Central configuration/key distribution; not P2P discovery, anonymity or federation | Practical operational baseline for trusted links |
| Tailscale / Headscale | Managed or self-hosted coordination around WireGuard | Easy device connectivity and NAT traversal | Coordination/control plane and implementation choices; not a sovereign P2P application architecture | Operational comparator only |
| IPFS | Content-addressed distribution | Content identifiers and distributed retrieval | Content addressing does not guarantee persistence, privacy or availability | Storage/distribution layer, not network identity |
| BitTorrent | Swarm-based file distribution | Mature bulk distribution | Not a general secure naming, identity or application network | Distribution comparator |
| Matrix | Federated real-time communication | Practical interoperable messaging ecosystem | Homeserver trust, metadata and operational dependencies | Application-level comparator, not transport |

Sources: GNUnet architecture and current status (https://docs.gnunet.org/master/status.html; https://www.gnunet.org/en/architecture.html); GNUnet roadmap (https://www.gnunet.org/en/roadmap.html); libp2p architecture/specifications (https://libp2p.io/docs/; https://github.com/libp2p/specs); Reticulum documentation (https://reticulum.network/manual/).

### 3.3 GNUnet vs Reticulum

These should not be forced into a single winner decision.

- GNUnet is the deeper GNU alternative-network and decentralized-services research environment.
- Reticulum is the candidate to investigate for heterogeneous links and constrained/off-grid environments.
- WireGuard remains the practical baseline for known endpoints and managed infrastructure.
- A common WARENA application interface may permit multiple adapters, but no existing GNUnet↔Reticulum interoperability should be assumed.

Test cases: local LAN, multi-site WAN, intermittent mobile links, low-bandwidth radio/modem links where lawful, NAT-restricted peers, disconnected operation, and delayed synchronization. Measure delivery guarantees and queue persistence explicitly.

## 4. Pubstrate, ActivityPub and Spritely

### 4.1 Protocol and implementation distinction

ActivityPub is a W3C federated social-networking protocol with client-to-server and server-to-server interaction. It defines exchange of ActivityStreams objects between actors and servers. It is not a replacement for TCP/IP, a P2P routing system, or a payment rail.

Pubstrate is a Guile/Scheme-oriented ActivityStreams/ActivityPub implementation associated with Christine Lemmer-Webber. It is relevant to WARENA's Scheme ecosystem, but its current code health, protocol coverage, test status, security posture and deployment viability must be verified directly. Historical relevance is not production readiness.

**No GNUnet transport plugin or maintained Pubstrate↔GNUnet integration has been established.** Treat any bridge as a new adapter project requiring a protocol design and threat model.

### 4.2 Goblins and OCapN

Spritely Goblins is a distributed object programming environment with object-capability security, asynchronous message passing, transactional updates and persistence/upgrade concepts. OCapN/CapTP provides a capability-oriented distributed communication model.

This is particularly relevant to Guile and WARENA's human-controlled authority model. It offers a way to reason about explicit object references and delegated authority. It does not remove the need for transport security, persistence policy, key lifecycle, revocation, resource limits, auditability or denial-of-service controls.

**Recommendation:** evaluate Goblins as a Guile application/service model in a local lab. Do not use it as a substitute for a general network stack or database.

### 4.3 Proposed composition

1. Local canonical state remains on the device.
2. An application service exposes typed local operations.
3. Goblins/OCapN may be evaluated for capability-secure remote object calls.
4. ActivityPub may project selected, explicitly publishable objects to the federated Internet.
5. GNUnet GNS may provide alternative naming in a separate adapter.
6. Reticulum may carry selected messages across constrained links.
7. Every adapter has its own identity, trust, revocation and availability policy.

Private records, mirror data, customer records, financial data and raw sensor streams must never be federated by default.

## 5. GNU Taler and Kenyan mobile-money integration

### 5.1 GNU Taler architecture

GNU Taler is an electronic payment protocol and reference implementation, not a cryptocurrency. Its architecture includes wallets, an exchange that issues and redeems digital cash, merchant backend and merchant-facing APIs, merchant frontends and point-of-sale interfaces, bank integration / wire gateway for settlement, and auditing and reserve/financial reconciliation functions.

The exchange maintains a settlement relationship with a bank. The settlement account needs transaction-query and payment-initiation capabilities. Taler's bank-integration documentation describes APIs and adapters; the actual banking integration depends on the institution and its supported interfaces.

The merchant backend encapsulates sensitive payment logic and communicates with the exchange. The merchant frontend should not handle exchange signing keys or settlement credentials.

### 5.2 Kenya: mobile money is not automatically a Taler bank adapter

Kenya has established mobile-money interoperability, but interoperability between mobile-money providers does not mean that every payment service exposes the settlement and account-query interfaces required by a GNU Taler exchange.

Relevant provider and regulatory references:

- Central Bank of Kenya National Payment System overview: https://www.centralbank.go.ke/national-payments-system/
- CBK draft National Payment System Policy and Bill (2026): https://www.centralbank.go.ke/2026/09/21/draft-national-payment-system-policy-and-national-payment-system-bill-2026/
- Safaricom Daraja developer portal: https://developer.safaricom.co.ke/apis/GettingStarted
- M-Pesa Business developer portal: https://business.m-pesa.com/developers/
- CBK authorised PSP directory: https://www.centralbank.go.ke/wp-content/uploads/2026/09/Directory-of-Authorized-Payment-Service-Providers-August-10-2026.pdf

The 2026 CBK policy and Bill are draft materials at the time of this research. They must not be described as enacted law. They signal regulatory attention to interoperability, open finance, customer-data protection and payment-system governance. Recheck final legislative status before implementation.

### 5.3 Candidate integration patterns

| Pattern | Description | Feasibility | Main risk |
|---|---|---|---|
| Manual merchant reconciliation | Customer pays using existing provider rails; merchant reconciles provider statement | High operational simplicity | Human error, delayed confirmation |
| Provider checkout/API | Merchant integrates a provider-approved API such as Daraja | Subject to account, product and provider approval | Credential security, callbacks, reversals, idempotency and service availability |
| Bank settlement adapter | A bank exposes Taler-compatible settlement-account operations | Technically aligned with Taler architecture | Requires bank cooperation and suitable API access |
| M-Pesa-to-Taler adapter | A separately developed adapter maps approved provider transactions to Taler settlement operations | Research only; no standard adapter established | Semantic mismatch, settlement finality, reversals, legal/provider approval |
| Interoperability gateway | A licensed/authorised PSP provides a compliant bridge across payment rails | Potentially useful at institutional scale | Regulatory scope, safeguarding, audits, liability and contracts |
| Taler-only pilot | Use a supported Taler exchange/bank environment for a bounded pilot | Possible only where banking and currency support are available | Kenyan bank/currency/provider integration not established |

**Do not represent M-Pesa as a GNU Taler wallet, Taler exchange, or direct drop-in bank API.** A bridge must specify the source of funds, transaction finality, settlement timing, fees, reversals, disputes, reconciliation identifiers, exchange reserves, KYC/AML responsibilities, data protection, licensing and support ownership.

### 5.4 Security and correctness requirements

- Never treat a client redirect or screenshot as payment confirmation.
- Verify provider callbacks using documented authentication and transaction-query APIs.
- Use idempotency keys and immutable transaction identifiers.
- Reconcile provider statements against internal ledgers.
- Model pending, successful, failed, reversed, disputed and expired states distinctly.
- Protect API credentials and signing keys; never commit them to Git.
- Log only necessary metadata and enforce retention controls.
- Separate customer identity from payment records where possible.
- Define incident, reversal and refund procedures before production.
- Obtain provider approval and qualified Kenyan legal/compliance review before operating a payment service.

**WARENA/NAKEBUSEN boundary:** this is infrastructure research, not authorization to add payment automation to the public NAKEBUSEN website. Existing manual payment and direct-confirmation decisions remain in force. ONLY NAKEBUSEN TRANSACTS.

## 6. Security architecture

Threat modelling must be performed per layer and per deployment. Minimum threat classes:

| Threat | Relevant controls |
|---|---|
| Malicious peer / Sybil participation | Admission policy where appropriate, rate limits, resource accounting |
| Identity/key theft | Hardware-backed storage where available, encrypted key storage, rotation, revocation and recovery |
| Traffic analysis | Minimise metadata; do not claim anonymity without demonstrated protections |
| Malicious naming / resolution | Cryptographic validation, trust-root transparency, expiry and revocation semantics |
| Replay / message duplication | Nonces, bounded timestamps, sequence numbers and idempotency |
| Network partition | Local queues, explicit conflict policy, bounded retries and operator-visible degraded state |
| Malicious content | Content validation, sandboxing, quotas, provenance and safe rendering |
| Storage compromise | Encryption at rest where needed, least privilege, backups, integrity checks and restore tests |
| Capability leakage | Object-capability discipline, narrow references, attenuation and explicit revocation strategy |
| Payment fraud | Provider-side verification, reconciliation, separation of duties and auditable ledger transitions |
| Supply-chain compromise | Pinned sources, signatures, reproducible builds, review and controlled updates |

Security is not achieved by adding encryption alone. WARENA must document trust assumptions, adversary capabilities, failure behaviour and recovery for every deployment.

## 7. Guix and Shepherd feasibility

Guix is the configuration and package-management home for WARENA. Candidate services should be packaged as Guix packages with pinned source revisions, explicit inputs, licence review and tests. Avoid introducing a second configuration repository.

For each network service, qualify package availability, maintained upstream revision, build-system support, transitive dependency closure, privilege and filesystem requirements, service configuration and secrets handling, offline installation, upgrade, rollback and state migration.

Shepherd is suitable for supervising long-running local services where service definitions and dependencies are available. A candidate service should define start/stop commands, dependencies and ordering, readiness and health checks, restart/backoff behaviour, log handling, service identity, network-online assumptions, degraded-mode behaviour, shutdown and persistent queue handling.

Do not assume GNUnet's internal service manager can be replaced by Shepherd. GNUnet may run as its own multi-process service system; Shepherd should supervise the appropriate top-level service or deployment unit only after integration tests.

### Suggested logical service boundaries

| Service | Candidate responsibility | Initial maturity |
|---|---|---|
| warena-local-state | SQLite database and local queue ownership | DESIGN |
| warena-network-adapter | Common local API over selected transport adapters | CONCEPT |
| gnunet | GNUnet peer and selected services | RESEARCH |
| reticulum | Reticulum daemon/interface integration | RESEARCH |
| warena-federation | Explicit ActivityPub projection | CONCEPT |
| warena-object-service | Goblins/OCapN experiment | RESEARCH |
| warena-reconciliation | Import and reconcile external payment statements | CONCEPT |
| taler-merchant | GNU Taler merchant integration | RESEARCH |

These are logical boundaries, not claims that packages or Shepherd service definitions already exist.

## 8. Phased qualification plan

**N0 — Evidence baseline:** pin upstream revisions and maintenance state; verify licences, security advisories, build dependencies, supported platforms and protocol maturity.

**N1 — Local-only prototype:** SQLite-backed event queue, local IPC and explicit service contracts; no network dependency for core read/write workflows.

**N2 — Trusted connectivity:** WireGuard baseline between controlled nodes; test partitions, key rotation, restore and service restart.

**N3 — Alternative network trials:** GNUnet GNS and peer discovery; Reticulum on a constrained-link testbed; compare Yggdrasil and libp2p where their design goals apply.

**N4 — Federation and distributed objects:** ActivityPub interoperability test with synthetic public data; Pubstrate source/build/security audit; Goblins/OCapN local and remote capability experiment.

**N5 — Storage and payment adapters:** OpenAFS/NFS and content-addressed storage trials; GNU Taler sandbox; provider-approved mobile-money sandbox and reconciliation prototype, if available.

**N6 — Operational qualification:** Guix package and Shepherd service integration; offline recovery, backup/restore, monitoring and security review; independent review before any production recommendation.

Every phase ends with logs, revisions, test data, known limitations and a go/no-go record.

## 9. Current decisions and non-decisions

| Area | Position |
|---|---|
| Local-first persistence | ADOPT AS DESIGN PRINCIPLE |
| SQLite | PREFERRED SMALL-LOCAL-STATE CANDIDATE; not distributed consensus |
| IP networking | RETAIN compatibility baseline |
| WireGuard | PRACTICAL TRUSTED-LINK BASELINE |
| GNUnet | APPROVE RESEARCH; GNS first |
| Reticulum | APPROVE COMPARATIVE OFF-GRID RESEARCH |
| Yggdrasil / libp2p / Tor / I2P | COMPARATORS, not default selections |
| ActivityPub | OPTIONAL FEDERATION LAYER |
| Pubstrate | HISTORICAL / RESEARCH; audit before any adoption |
| Goblins / OCapN | APPROVE GUARDED GUILE RESEARCH |
| GNU Taler | PAYMENT-ARCHITECTURE RESEARCH |
| M-Pesa / mobile money | PROVIDER-API AND SETTLEMENT RESEARCH; no assumed adapter |
| Guix | RETAIN CONFIGURATION HOME |
| Shepherd | SERVICE-SUPERVISION CANDIDATE |
| Production deployment | NOT APPROVED BY THIS SPECIFICATION |

## 10. References

1. GNUnet current component status: https://docs.gnunet.org/master/status.html
2. GNUnet architecture: https://www.gnunet.org/en/architecture.html
3. GNUnet roadmap: https://www.gnunet.org/en/roadmap.html
4. GNUnet FAQ / comparison: https://git.gnunet.org/gnunet/gnunet-handbook/file/faq.rst.html
5. libp2p documentation: https://libp2p.io/docs/
6. libp2p specifications: https://github.com/libp2p/specs
7. Reticulum manual: https://reticulum.network/manual/
8. Spritely Goblins: https://www.spritely.institute/goblins/
9. Goblins documentation: https://files.spritely.institute/docs/guile-goblins/
10. GNU Taler documentation: https://www.taler.net/en/docs.html
11. Taler exchange manual: https://docs.taler.net/taler-exchange-manual.html
12. Taler merchant manual: https://docs.taler.net/taler-merchant-manual.html
13. Taler banking integration: https://docs.taler.net/core/intro-bank-apis.html
14. Central Bank of Kenya NPS: https://www.centralbank.go.ke/national-payments-system/
15. CBK draft NPS policy and Bill (2026): https://www.centralbank.go.ke/2026/09/21/draft-national-payment-system-policy-and-national-payment-system-bill-2026/
16. Safaricom Daraja: https://developer.safaricom.co.ke/apis/GettingStarted
17. M-Pesa Business Developer Portal: https://business.m-pesa.com/developers/
18. CBK authorised PSP directory (10 August 2026): https://www.centralbank.go.ke/wp-content/uploads/2026/09/Directory-of-Authorized-Payment-Service-Providers-August-10-2026.pdf

**Review rule:** upstream status, regulatory status, API versions, provider eligibility and package availability are time-sensitive. Revalidate before implementation.
