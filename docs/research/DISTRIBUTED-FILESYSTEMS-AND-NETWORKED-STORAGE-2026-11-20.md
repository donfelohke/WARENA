# WARENA Distributed Filesystem and Networked Storage Research

**Date:** 2026-11-20  
**Status:** RESEARCH / ARCHITECTURE STUDY — not an implementation or deployment claim  
**Scope:** OpenAFS/AFS and relevant network, clustered, content-addressed and capability-secure storage alternatives; component boundaries; security; Guix and Shepherd feasibility.

> **Decision posture:** retain local-first storage as the workstation baseline. Evaluate OpenAFS as a specialist multi-site namespace and collaboration system, not as the universal WARENA filesystem. Keep network transport, filesystem semantics, object distribution, backup and identity as distinct architectural layers.

## 1. Executive assessment

Andrew File System (AFS), as implemented by OpenAFS, is a mature distributed filesystem designed for large, administratively managed environments. Its strongest WARENA use case is a multi-site organisation or research community that wants a coherent namespace, centrally managed identities and groups, volume-level administration, and aggressive client-side caching.

AFS is not equivalent to a peer-to-peer network, a content-addressed store, a replicated object system or a general-purpose cluster filesystem. A cell is an administrative and security domain. Multiple cells can be reached through the global `/afs` namespace, but that does not remove the need for trust, administration, name-service configuration and operational agreements between cell operators.

**Preliminary disposition**

| Candidate | WARENA disposition | Why |
|---|---|---|
| Btrfs | RETAIN — local workstation baseline | Mature local filesystem, snapshots and local ownership |
| Restic | RETAIN — backup layer | Backup/recovery is separate from live shared-filesystem semantics |
| NFSv4 | QUALIFY — conventional Unix/Linux sharing | Simpler client/server shared storage; export and identity model differs from AFS |
| OpenAFS | INVESTIGATE — federated institutional namespace | Cells, volumes, VLDB and callback cache model |
| CephFS | CONDITIONAL — larger clustered storage | POSIX filesystem over RADOS; operationally substantial cluster |
| GlusterFS | COMPARATOR — scale-out file volumes | Distributed/replicated volume model; evaluate current maintenance and workload fit before selection |
| SMB3/Samba | CONDITIONAL — heterogeneous client sharing | Strong Windows interoperability; not WARENA's native-first default |
| 9P | SPECIALIST — host/guest or namespace sharing | Lightweight protocol; not a drop-in replacement for a general enterprise DFS |
| IPFS | COMPLEMENT — immutable/content-addressed distribution | Content identity and distribution, not ordinary mutable POSIX home directories |
| Tahoe-LAFS | INVESTIGATE — capability-secure storage | Encrypted, erasure-coded storage addressed by capabilities |
| GNUnet | NETWORK LAYER RESEARCH — not a filesystem | Decentralized networking and services; storage requires a distinct service/protocol |
| Coda | HISTORICAL/RESEARCH COMPARATOR | AFS-derived design with disconnected operation and optimistic replication |

No candidate is promoted to LIVE or PROTOTYPE by this document. No Guix package availability, successful build, Shepherd service, host installation, throughput result or recovery test is asserted.

## 2. AFS / OpenAFS architecture

### 2.1 Namespace and administrative units

- **Cell:** administrative domain with its own database and fileserver infrastructure, identity policy and operators.
- **Volume:** independently administered unit of filesystem space; volumes are mounted into the namespace.
- **Volume Location Database (VLDB):** maps volume identities to fileserver locations.
- **Fileserver:** serves volume data and metadata.
- **Protection Server (PTS):** maintains AFS users, groups and protection identities.
- **Cache Manager:** client component mediating filesystem access and local cache state.
- **Rx/Rx security classes:** AFS RPC transport and security mechanisms.
- **Kerberos:** authentication foundation in modern deployments.

AFS path lookup is not simply a client mounting one exported server directory. The Cache Manager resolves a volume through the VLDB, contacts an appropriate fileserver and maintains a local cache. Read-only replicated volumes can improve distribution and availability; a read-write volume has a designated authoritative location and should not be mistaken for automatic multi-master replication.

### 2.2 Callback-based cache coherence

A fileserver issues a callback when a client caches a file or directory. The callback represents the server's promise that the cached object remains valid. When another client changes the object, the server breaks outstanding callbacks; a client must validate/refetch before subsequent access that depends on the invalidated cache entry.

This is a defining AFS design choice. It reduces repeated network reads and suits workloads with many reads and comparatively infrequent writes. It is not a claim of instantaneous, strongly consistent shared-memory semantics for every open file descriptor or application workflow. Applications must still use appropriate close/fsync/locking patterns, and WARENA must test the exact semantics required by editors, build tools, databases and concurrent writers.

### 2.3 Availability and disconnected operation

Do not assume that a normal OpenAFS client provides Coda-style disconnected operation with transparent local write-back and reintegration. AFS client caching can help during transient conditions, but availability of uncached data, write operations, authentication and callback state depends on connectivity and server reachability. For mobile/offline workflows, design explicit local working copies, queues and synchronisation boundaries rather than relying on AFS to behave as an offline-first filesystem.

Read-only volume replicas can remain available when one site is down if another replica is reachable. They do not make the authoritative read-write copy automatically available. Database quorum and fileserver placement are operational design concerns.

## 3. Comparative architecture

| System | Namespace / location model | Consistency and mutation | Replication / availability model | Best-fit role |
|---|---|---|---|---|
| OpenAFS | Cell + volume namespace; VLDB indirection | Callback-based cache coherence; mutable files | Read-only volume replicas; managed cell services | Federated institutional files |
| NFSv4 | Exported server namespace; protocol-managed state | NFS protocol semantics, leases/delegations and locking | Usually server/storage-layer HA; replication external | Unix/Linux shared directories |
| SMB3 / Samba | Shares and server namespace | SMB leases/oplocks, locking and durable handles | Server/storage-layer HA | Mixed Windows/Linux file sharing |
| CephFS | POSIX namespace over RADOS; distributed MDS | Distributed metadata coordination and client cache coherency | RADOS replication/erasure coding and MDS failover | Large scale-out shared filesystem |
| GlusterFS | Distributed volumes composed from bricks | Translator/volume-specific semantics | Distributed, replicated or dispersed layouts | Scale-out file storage where operational fit is proven |
| 9P | Exported filesystem tree over Plan 9 protocol | Server-defined filesystem semantics | No inherent cluster replication | VM/container/namespace sharing |
| IPFS | Content identifiers and DAGs | Content-addressed immutable objects; updates create new identities | Peer retrieval, pinning and routing | Publish/distribute immutable artefacts |
| Tahoe-LAFS | Capability references | Immutable encrypted objects and capability-based access | Erasure coding across storage servers | Secure distributed backup/object storage |
| GNUnet | Peer identities and decentralized services | Depends on the service; not POSIX filesystem semantics | Peer-to-peer overlay and service-specific replication | Private/decentralized networking substrate |
| Coda | AFS-derived namespace and client cache | Optimistic replication/reintegration for disconnected operation | Replicated servers and client hoarding | Research comparator for offline collaboration |

These categories are deliberately not collapsed into a single ranking. NFS/SMB are file-sharing protocols; CephFS/GlusterFS are clustered filesystem designs; IPFS/Tahoe-LAFS are object/capability storage systems; GNUnet is a networking framework; 9P is a filesystem protocol.

### 3.1 NFSv4

NFSv4 is the conventional baseline for Linux/Unix network filesystems. It has a comparatively direct client-server operational model and integrates with established Unix identity, mount and export practices. NFSv4.1 adds sessions and parallel access features; NFSv4.2 adds further protocol capabilities. Availability, snapshots and replication generally depend on the server and storage platform rather than being provided as a global federated namespace in the AFS sense.

Use NFS when a small number of trusted Linux systems need shared directories and the operational team wants conventional tooling. Evaluate Kerberos security flavours, id mapping, ACL semantics, locking, failover and mount behaviour explicitly.

### 3.2 CephFS

CephFS is a POSIX filesystem built on Ceph's RADOS object store. Metadata is managed by a scalable Metadata Server (MDS) cluster, while clients access file data through RADOS. Its architecture separates metadata from data and targets high availability, throughput and large-scale shared storage.

Ceph is powerful but introduces a substantial distributed control plane: monitors, managers, OSDs, MDS, network design, failure domains, capacity planning, upgrades and recovery. It is not justified for a single WARENA workstation or a small low-maintenance site without a concrete cluster requirement and operational capacity.

### 3.3 GlusterFS

GlusterFS provides distributed volumes built from storage bricks and configurable translators, including distributed, replicated and dispersed layouts. It is a useful comparator for scale-out file storage, but the exact release, maintenance status, client compatibility, split-brain handling, healing behaviour and workload performance must be verified before any selection. Do not infer production suitability from historic popularity or a simple volume-create demonstration.

### 3.4 IPFS

IPFS is content-addressed: content is identified by cryptographic identifiers derived from its representation. This makes it useful for distributing immutable source snapshots, release artefacts, datasets and public research materials. It does not by itself provide ordinary mutable POSIX semantics, a private home-directory service or a guaranteed persistence contract. Persistence requires pinning/retention arrangements and availability planning. Private data needs encryption and careful metadata analysis before publication.

### 3.5 Tahoe-LAFS

Tahoe-LAFS uses capability-based access: possession of a capability grants defined access to encrypted distributed content. Data is encrypted and encoded across storage nodes so that it can survive some node failures. This is attractive for privacy-oriented distributed backup and sharing, but it is not a POSIX replacement. Capabilities are secrets; leak handling, revocation limitations, repair, storage-server diversity and operational monitoring require explicit design.

### 3.6 GNUnet

GNUnet is a decentralized networking framework with multiple services and protocols. It should be treated as a possible network substrate or complementary private networking environment, not as an AFS alternative or a filesystem. Any WARENA design that uses GNUnet for storage must name the actual storage service, data model, replication strategy, namespace, access control and client interface separately.

### 3.7 9P

9P is a network protocol for accessing filesystem namespaces. It is useful in Plan 9-derived environments and virtualization/guest-host sharing designs. It is not automatically equivalent to NFSv4, AFS or a fault-tolerant clustered filesystem. Evaluate transport, authentication, server implementation, cache behaviour and host/guest trust boundary for each intended use.

### 3.8 Coda

Coda is important as a research comparator because it builds on AFS concepts while emphasizing replication and disconnected operation. Its optimistic replication and reintegration model directly addresses mobile/offline use cases that should not be assumed to be solved by ordinary OpenAFS caching. Treat it as a design reference unless current maintenance, client support and deployment evidence justify more.

## 4. WARENA component boundaries

Keep the following responsibilities separate. A filesystem must not silently become the identity provider, backup system, overlay network and configuration manager.

1. **Local filesystem:** Btrfs (or another explicitly qualified local filesystem) owns local workstation files, metadata and snapshots.
2. **Network filesystem client:** OpenAFS, NFSv4 or SMB client exposes remote files under a mount namespace. Only one should be selected per workload after semantic testing.
3. **Cluster storage:** CephFS or another cluster layer is considered only when multiple storage nodes and a real scale/availability requirement exist.
4. **Object distribution:** IPFS may distribute immutable public artefacts; Tahoe-LAFS may be evaluated for encrypted capability-based storage.
5. **Network transport:** GNUnet, WireGuard or conventional IP networking provide transport/connectivity; transport does not define filesystem consistency.
6. **Identity and authorization:** Kerberos/AFS PTS, Unix identities, SSH keys and capability secrets are separate mechanisms. Map principals and group policy deliberately.
7. **Backup and recovery:** Restic and/or other tested backup tools protect data independently of live replication. Replication is not backup.
8. **Configuration and orchestration:** GNU Guix defines reproducible packages/configuration; GNU Shepherd supervises services and dependencies. Neither is itself a distributed filesystem.
9. **Observability:** health checks, logs, capacity, replication state, callback/connection failures and recovery evidence must be available without mandatory telemetry.

### 4.1 Suggested deployment profiles

- **Single workstation:** Btrfs + Restic; no distributed filesystem by default.
- **Small trusted LAN:** NFSv4 as first comparator; Samba only where SMB interoperability is required. Keep server backup independent.
- **Multi-site institutional cell:** OpenAFS candidate, with Kerberos, replicated database services, fileserver placement, read-only replicas, client cache sizing and documented operator trust.
- **Large storage cluster:** CephFS only after capacity, failure-domain, network and staffing requirements are quantified.
- **Offline/mobile work:** local-first working copies and explicit sync; study Coda's model. Do not promise OpenAFS disconnected write semantics.
- **Public immutable artefact distribution:** IPFS as an optional distribution layer, with conventional signed release and mirror paths retained.
- **Encrypted distributed backup:** Tahoe-LAFS research alongside Restic; evaluate recovery UX and capability lifecycle.

## 5. Security and threat model

### 5.1 Assets and threats

Protect file contents, metadata, identities, group membership, capabilities/keys, server administration, client cache, backups and availability. Threats include compromised clients, stolen credentials, malicious administrators, exposed cache disks, network interception, stale authorization, callback or database outages, ransomware, malicious peers, capability leakage and accidental publication of private data.

### 5.2 OpenAFS security review

- Use Kerberos-based authentication and a carefully managed realm/cell relationship.
- Review the exact Rx security class in use. Legacy RxKAD/RxGK distinctions matter; do not assume that historical AFS wire encryption meets current WARENA cryptographic expectations.
- OpenAFS's RxGK work is an active modernization path, but roadmap presence is not proof that all client/server paths or distributions are ready. Validate actual release support, interoperability and configuration before deployment.
- Restrict privileged AFS administration; protect server keys, keytabs, database backups and configuration.
- Use least-privilege PTS groups and ACLs; review inherited and nested group membership.
- Treat client cache as sensitive data. Protect cache storage, especially on laptops and shared systems; document cache clearing and device-loss response.
- Segment fileservers and database servers; restrict RPC reachability to expected peers and clients.
- Monitor VLDB/Ubik health, fileserver state, volume quota, replication freshness, callback breaks and client cache errors.
- Test restore of volume data and database state. A functioning mount is not a restore test.

### 5.3 Cross-system controls

- Encrypt network paths where the system's native security does not meet requirements.
- Separate authentication, authorization, transport encryption and storage encryption in the threat model.
- Avoid placing long-lived credentials or Tahoe capabilities in world-readable configuration or logs.
- Use signed, versioned and independently verifiable artefacts for software distribution.
- Do not expose IPFS content identifiers for private material without understanding content discovery, metadata and retention implications.
- Treat peer-to-peer availability as untrusted until content authenticity, provenance and persistence are verified.
- Maintain offline, immutable or otherwise protected backups and conduct periodic recovery drills.

## 6. GNU Guix and Shepherd feasibility

### 6.1 Guix packaging

The feasibility work is divided into separate gates:

1. **Package discovery:** inspect current Guix package definitions and upstream versions for OpenAFS, Kerberos, NFS utilities, Samba, Ceph, GlusterFS, IPFS and Tahoe-LAFS. Record package name, version, source, patches, build system, supported systems and licence. Availability is UNKNOWN until checked against the selected Guix channel revision.
2. **Build feasibility:** build in an isolated Guix environment; capture channel commit, derivation, build log and test result. Do not equate upstream support with Guix support.
3. **Kernel integration:** OpenAFS Linux client integration may require a kernel module built against the exact target kernel. Evaluate module compatibility, kernel ABI, signing/secure-boot policy and Guix System integration. A package build alone does not prove a working client.
4. **User-space and tools:** package client utilities, configuration files, keytab handling and service dependencies separately from kernel integration.
5. **Reproducibility:** pin channels and source revisions; avoid untracked host packages and imperative setup. Secrets must remain outside public manifests.
6. **Upgrade/rollback:** test client/server version compatibility, kernel changes, database upgrades and data-format migration before production use.

No current Guix package result is asserted in this research note. The package and service status must be filled from a live channel inspection.

### 6.2 Shepherd service decomposition

Potential service units (names are conceptual until implementation is verified):

| Service role | Likely process / responsibility | Dependencies and controls |
|---|---|---|
| Kerberos client | credential acquisition / ticket cache | realm configuration, time sync, secret handling |
| OpenAFS client | kernel module + `afsd` / Cache Manager | kernel compatibility, cell database, cache directory, network |
| OpenAFS fileserver | fileserver process | storage partitions, keys, network ACLs |
| OpenAFS database | VLDB/PTS and Ubik services | quorum, stable identity, protected database state |
| OpenAFS BOS | process supervision on server | service ordering, admin credentials |
| NFS server | kernel NFS service and export policy | export configuration, identity mapping, firewall |
| Ceph | monitors, managers, OSDs, MDS | cluster bootstrap, storage devices, network, secrets |
| Samba | smbd/winbind and related daemons | shares, identity backend, ACL mapping |
| Tahoe-LAFS | node process and storage configuration | capability secrets, storage directory, peer policy |

Shepherd should express process supervision, ordering, restart policy and logs, but service definitions must reflect actual daemon behaviour and shutdown semantics. A single generic service wrapper is not sufficient for a distributed system. Database quorum, storage mounts, network readiness and secret availability must be represented as explicit dependencies or preflight checks.

For a client profile, the minimum service sequence is: network readiness → time synchronisation → Kerberos credentials (where required) → kernel/module availability → Cache Manager → mount verification. Do not block the whole workstation boot indefinitely on an unavailable remote cell; provide bounded startup, clear degraded state and a documented manual recovery path.

For a server profile, separate database quorum services, fileserver services and administrative supervision. Do not deploy a two-node database topology while assuming a three-vote quorum. Validate the selected OpenAFS Ubik topology against current administration documentation.

### 6.3 Guix System integration questions

- Is the client kernel module buildable and loadable for the exact Guix kernel package and target hardware?
- Can the service be started after network and time readiness without creating a boot deadlock?
- How are `CellServDB`, cache directory, `ThisCell`, keytabs and service keys provisioned?
- Can system generations roll back safely without rolling back live server databases or user data?
- Which server state is mutable and must live outside the store?
- Can services be restarted independently under Shepherd without corrupting cache or volume state?
- How are remote mount failures surfaced to desktop sessions and applications?

## 7. Performance and semantic qualification plan

Do not publish throughput numbers until tests run on named hardware and network conditions. Compare with the same dataset and workload:

- cold-cache and warm-cache sequential read/write;
- small-file create/stat/readdir workloads;
- metadata-heavy source-tree traversal and builds;
- concurrent readers and writers;
- large-file transfer;
- latency under WAN delay and packet loss;
- cache invalidation after cross-client writes;
- lock and rename semantics;
- client restart and server failover;
- loss of database quorum;
- read-only replica failover;
- full cache and low-disk conditions;
- interrupted writes and recovery;
- backup restore and integrity verification.

Record kernel, client/server version, Guix channel, CPU, RAM, storage, network RTT/bandwidth/loss, cache state, test tool, dataset, command, raw output and limitations. Include NFSv4 as the baseline and compare OpenAFS only for workloads it is designed to serve. Do not compare an IPFS object fetch to POSIX filesystem latency as if the semantics were equivalent.

## 8. Risks and decision gates

| Risk | Consequence | Required gate |
|---|---|---|
| Kernel module mismatch | Client unavailable after kernel update | Build/load/test exact Guix kernel pairing |
| Legacy crypto path | Confidentiality/integrity below policy | Verify Rx security class and threat model |
| WAN dependency | Remote files unavailable offline | Local-first workflow and bounded failure behaviour |
| Callback/cache complexity | Stale or surprising application behaviour | Multi-client semantic tests |
| Database quorum loss | Cell lookup/administration disruption | Topology and failure exercise |
| Read-write volume server loss | Authoritative volume unavailable | Recovery and replica promotion procedure |
| Overengineering | High operational burden | Demonstrated multi-site requirement |
| Replication mistaken for backup | Data loss propagated | Independent, tested backups |
| Capability leakage | Unauthorised Tahoe data access | Secret lifecycle and incident response |
| Content persistence assumptions | IPFS artefact disappears | Pinning, mirrors and signed releases |

### Selection gates

OpenAFS should advance beyond RESEARCH only if WARENA identifies a real multi-site use case, names cell operators and trust boundaries, verifies modern security configuration, demonstrates Guix client/server feasibility, validates callback semantics on target workloads, and tests backup plus recovery.

CephFS should advance only if a real multi-node storage cluster is justified. NFSv4 should remain the default comparison for modest trusted LAN sharing. IPFS and Tahoe-LAFS remain complementary object-storage research. GNUnet remains a network-layer study and must not be labelled a filesystem.

## 9. Research sources

Sources checked for this 2026-11-20 note:

1. OpenAFS project news and releases: https://www.openafs.org/pages/ — reports OpenAFS 1.8.17pre2 (2026-11-04), support through Linux 7.3 and macOS 27, and the July 2026 IPL/GPLv2 compatibility initiative.
2. OpenAFS development roadmap: https://openafs.org/frameless/roadmap.html — describes 1.8 stable, 1.9 development and RxGK modernization work; roadmap items are not release guarantees.
3. OpenAFS Administration Guide: https://docs.openafs.org/AdminGuide.pdf — Cache Manager, VLDB lookup, fileserver callbacks and client caching.
4. OpenAFS source NEWS: https://github.com/openafs/openafs/blob/master/NEWS — upstream change record; check release tags before relying on development-branch changes.
5. CephFS documentation: https://docs.ceph.com/en/latest/cephfs/ — POSIX filesystem architecture over RADOS, MDS and client data access.
6. Tahoe-LAFS architecture: https://github.com/tahoe-lafs/tahoe-lafs/blob/master/docs/architecture.rst — capabilities, encryption, encoding and distributed storage.
7. OpenDev OpenAFS deployment documentation: https://docs.opendev.org/opendev/system-config/latest/afs.html — practical cell, database and fileserver topology; example deployment, not a universal reference architecture.
8. Survey of Distributed File System Design Choices: https://doi.org/10.1145/3465405 — architectural comparison of namespace pointers, data placement, metadata and coordination trade-offs.

### Source and status discipline

- Official project documentation takes precedence for supported releases and operational semantics.
- Development roadmap and `master` branch are not stable-release guarantees.
- Package presence must be checked against a named Guix channel revision.
- Every architecture recommendation remains RESEARCH until validated with reproducible tests.
- Upstream authorship and licensing must be respected; WARENA should package, configure or contribute upstream before considering a fork.

---

**WARENA principle:** local ownership first; network filesystems when collaboration requires them; distributed objects when content distribution requires them; independent backups always. Freedom Is a System.
