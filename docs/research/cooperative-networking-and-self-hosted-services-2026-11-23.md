# Cooperative Networking, Federation and Self-Hosted Services — Research Update

**Date:** 2026-11-23 · **Status:** RESEARCH / ARCHITECTURE STUDY · **Owner:** WARENA

## 1. Question and scope

How could WARENA support locally owned cooperative digital infrastructure that remains useful under intermittent connectivity while preserving interoperability, privacy, repairability and member control?

This consolidates the discussion of community Wi-Fi, Bluetooth, GNUnet, GNU Taler, Tor, ActivityPub/Fediverse, self-hosting, GNU Artanis, NGINX, MariaDB and USSD. It is an architecture map, not a bill of materials, deployment plan or claim that any component is installed.

## 2. Keep the layers distinct

| Layer | Candidate systems | Responsibility |
|---|---|---|
| Physical access | Wi-Fi, Ethernet, fibre, cellular, Bluetooth/BLE | Physical connectivity |
| Local/community network | OpenWrt, LibreMesh, mesh routing | Connect nearby sites and local services |
| Overlay / peer services | GNUnet | Peer identity, naming, discovery and application transport |
| Privacy network | Tor; I2P for comparison | Reduce exposure of network relationships for supported use cases |
| Federation | ActivityPub, XMPP, Matrix | Interoperation between independently operated services |
| Self-hosted applications | Forgejo, Nextcloud, GoToSocial, PeerTube | Collaboration, publishing and media |
| Service/data layer | Guile/Scheme, SQLite, MariaDB, PostgreSQL | Application logic and durable state |
| Cooperative economy/governance | GNU Taler; member rules | Payment protocol and collective accountability |

These are complementary, not interchangeable. Wi-Fi mesh is not anonymity; Tor is not a local mesh; GNUnet is not a Wi-Fi replacement; federation is not peer-to-peer networking; self-hosting does not itself establish cooperative ownership.

## 3. Community connectivity

### Wi-Fi

OpenWrt and LibreMesh are existing projects to evaluate before custom network work. Device support, radio count, flash/RAM, regulatory domain, power, antenna placement, interference and backhaul quality must be checked per site.

Research candidates include routed community networks, 802.11s, BATMAN-adv or Babel where compatible, point-to-point backhaul, local DNS/caching and local services during upstream outages. Do not assume every router supports every mode or that mesh automatically provides adequate throughput, resilience or security. A site survey and controlled latency, loss and throughput tests are prerequisites.

### Bluetooth

Bluetooth Classic and BLE serve different interaction and power profiles from Wi-Fi. Treat Bluetooth as a short-range peripheral, provisioning, discovery or device-I/O link unless a specific application justifies another role. Bluetooth Mesh is a distinct standard and is not ordinary pairing or Wi-Fi mesh.

Identify the exact profile, BlueZ/kernel support, device roles, pairing/key lifecycle, range, power, interference and failure behaviour. A Bluetooth link does not by itself prove end-to-end application security.

## 4. GNUnet, Tor and federation

### GNUnet

GNUnet is a free-software framework for decentralised networking. Its documented architecture includes pluggable transports, the R5N distributed hash table, CADET encrypted peer-to-peer messaging and GNS naming. Its multi-process architecture separates services and supports tighter process permissions.

Position GNUnet as a candidate overlay and decentralised service architecture. It does not replace access networking, power, routing, hardware support or governance. Verify current transport availability and maturity on the intended GNU/Linux/Guix target before claiming compatibility.

### Tor

Tor routes traffic through relays; onion services can be reached without publishing an ordinary public IP address, and bridges provide alternative entry paths. Tor complements selected privacy use cases but does not encrypt every application end-to-end, make endpoints trustworthy or prevent all traffic analysis.

Do not operate an exit relay casually. Relay type, bandwidth, abuse handling, legal exposure and incident response require a separate decision. Onion services do not replace service hardening, authentication or backups.

### Fediverse / ActivityPub

ActivityPub is a W3C Recommendation defining client-to-server and server-to-server APIs for decentralised social networking.

**Policy conflict:** ActivityPub is HTTP-based Web technology. A JavaScript-free implementation is not therefore web-independent. Under the current WARENA Technology Constitution, ActivityPub applications are not approved as WARENA/IKAI core application architecture. Study it as an interoperability/publication boundary only unless an explicit policy decision changes that position. Compare it with XMPP and Matrix on federation, offline delivery, identity, metadata, moderation, client diversity and operational burden.

## 5. Self-hosting and operations

Candidate services include Forgejo for source collaboration; XMPP or Matrix for messaging; GoToSocial or Mastodon for social publishing; Nextcloud for files/calendar/collaboration; PeerTube for media. ActivityPub and other web-based candidates remain subject to the WARENA policy boundary.

A self-hosted service still requires patching, monitoring, backups, restore tests, access control, moderation, abuse handling, storage planning and succession. Federation increases interoperability but also exposure to remote content, spam, denial-of-service and policy conflicts. Prefer a small service set with named operators over an unmaintainable catalogue.

## 6. Artanis, NGINX and databases

### GNU Artanis

GNU Artanis is a Guile/Scheme web application framework with routing, asynchronous server functionality, WebSockets and database interfaces. It is relevant to the Artanis-versus-mainstream comparison because it offers a Scheme-native web stack.

However, the current WARENA Technology Constitution excludes web technologies as application architecture, runtime, UI framework or systems-integration substrate. Artanis is therefore a comparative/interop study, not an approved WARENA core runtime. Use would require an explicit policy exception or constitutional change.

### NGINX

NGINX is a web server and reverse proxy, not a direct competitor to Artanis. It can serve static content and proxy requests to application servers. Its use as a WARENA integration boundary still needs review against the current web-technology exclusion; it is not a default systems layer.

### MariaDB, PostgreSQL and SQLite

- SQLite is a candidate for embedded, single-node and local-first state where its concurrency and deployment model fit.
- MariaDB with InnoDB is a candidate for multi-user relational services requiring transactions, foreign keys, crash recovery and concurrent writes.
- PostgreSQL is a separate candidate with a strong data-integrity ecosystem. GNU Taler's current reference merchant backend documentation specifies PostgreSQL; do not claim MariaDB is a supported drop-in backend for that implementation.

Preserve schema portability where practical, but do not assume SQL dialects, migrations, locking, replication, backups and operational semantics are identical. Benchmark and test restore and failure recovery with representative data.

## 7. USSD and mobile-network access

USSD is a mobile-network supplementary service used for interactive session-oriented menu exchanges. It can provide a low-bandwidth access channel for basic handsets, but depends on operator support and usually a gateway/aggregator integration.

Proposed flow: handset → mobile operator → USSD gateway → application adapter → service logic → database.

Callback protocol, session timeout, encoding, menu limits, short-code ownership, pricing and delivery guarantees are provider-specific. No Kenyan operator or aggregator integration is selected or verified here. USSD may be investigated for service discovery, network status or support requests. A USSD response is not proof of payment, booking or settlement; reconcile financial state against the authoritative payment provider's verified transaction records. NAKEBUSEN remains the sole commercial interface; an enquiry is not a booking.

## 8. GNU Taler and cooperative economics

GNU Taler is an open payment protocol with a free-software reference implementation; it is a payment system, not a cryptocurrency. Its privacy model aims to protect customer anonymity while retaining merchant accountability. Deployment still depends on banking, exchange operator, currency, legal and compliance arrangements.

The current merchant-backend manual specifies PostgreSQL for the reference implementation and describes a web server such as NGINX as an optional component for TLS termination and access control. These are compatibility facts, not approval of a WARENA web stack.

Taler could be researched for member contributions or local merchant settlement only after operator roles, exchange access, banking integration, currency, legal obligations, fees and support are understood. It cannot create cooperative governance: membership, voting, reserves, financial reporting, disputes and stewardship remain human institutional design.

## 9. Candidate architecture — research only

1. Local access: supported OpenWrt/LibreMesh nodes, wired links and ordinary IP routing.
2. Local continuity: local DNS and essential services that survive upstream outages.
3. Peer layer: evaluate GNUnet for specific naming, identity and messaging requirements.
4. Privacy: optional Tor path, separate from basic network security.
5. Federation: compare ActivityPub, XMPP and Matrix; resolve the web-technology policy before selecting web-based federation.
6. Applications: only services with named operators, backups, restore tests and moderation/security ownership.
7. Data: select SQLite, MariaDB or PostgreSQL per workload.
8. Economics: research GNU Taler within a separately governed cooperative.
9. Control: publish membership, maintenance, data, incident, financial and succession rules.

No candidate is approved for production by this document.

## 10. Research backlog

| ID | Work package | Evidence required |
|---|---|---|
| NET-01 | Community topology | Site survey, coverage, interference, backhaul and power |
| NET-02 | Router/radio selection | OpenWrt support, firmware, regulatory and lifecycle review |
| NET-03 | Mesh comparison | Reproducible throughput, latency, loss and partition tests |
| NET-04 | Bluetooth | Profiles, BlueZ support, pairing/key lifecycle and power tests |
| NET-05 | GNUnet | Version, transports, Guix build, resource use and threat model |
| NET-06 | Tor | Use case, relay policy and operational risk review |
| NET-07 | Federation | WARENA web-boundary decision; ActivityPub/XMPP/Matrix comparison |
| NET-08 | Service operations | Operators, patching, monitoring, backup and restore exercise |
| NET-09 | Data layer | Workload benchmark, migrations, concurrency and restore tests |
| NET-10 | USSD | Written operator/aggregator technical and commercial documentation |
| NET-11 | GNU Taler | Exchange/bank/currency/legal model and backend compatibility |
| GOV-01 | Cooperative governance | Membership, voting, financial transparency, moderation and succession |

## 11. Decision summary

- Reuse and evaluate OpenWrt/LibreMesh and GNUnet before designing new networking components.
- Treat Wi-Fi, Bluetooth, GNUnet, Tor and federation as different layers.
- Tor is optional; anonymity is not endpoint or application security.
- ActivityPub is Web technology even without a JavaScript runtime; policy conflict remains open.
- Artanis is Guile-native but is not approved as a WARENA core runtime under current policy.
- NGINX is a reverse proxy/static server; its use as an integration boundary requires policy review.
- MariaDB/InnoDB is a viable relational candidate, but GNU Taler's documented reference backend currently supports PostgreSQL.
- USSD is provider-dependent and not payment settlement authority.
- GNU Taler may support cooperative payments; it cannot replace governance.
- No deployment, hardware selection, provider agreement, installation or commercial offering is approved.

## 12. Primary technical sources

Accessed 2026-11-23; recheck current documentation before implementation.

1. GNUnet architecture: https://www.gnunet.org/en/architecture.html
2. LibreMesh getting started: https://libremesh.org/getting-started.html
3. Tor relay types: https://community.torproject.org/relay/types-of-relays/
4. W3C ActivityPub: https://www.w3.org/TR/activitypub/
5. GNU Artanis: https://artanis.dev/
6. NGINX reverse proxy: https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/
7. NGINX static content: https://docs.nginx.com/nginx/admin-guide/web-server/serving-static-content/
8. MariaDB InnoDB: https://mariadb.com/docs/platform/mariadb-faqs/storage-engines/innodb-storage-engine
9. GNU Taler merchant backend manual: https://docs.taler.net/taler-merchant-manual.html
10. GNU Taler documentation: https://www.taler.net/en/docs.html

**Evidence limitation:** Documentation-level review only. No code build, radio survey, benchmark, operator integration or legal/regulatory review was conducted.
