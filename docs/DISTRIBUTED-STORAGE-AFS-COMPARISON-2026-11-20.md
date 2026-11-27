# WARENA Distributed Storage Study: Andrew File System and Alternatives

**Document ID:** WARENA-RSCH-STORAGE-01  
**Revision:** 2026-11-20  
**Status:** RESEARCH / COMPARATIVE ARCHITECTURE  
**Decision boundary:** No storage platform is selected for production by this note.

## 1. Executive summary

Andrew File System (AFS) is a distributed file system designed around a global namespace, cells, volumes, client-side caching and callback-based cache coherence. OpenAFS is an open-source implementation. AFS is valuable for understanding managed, multi-site shared filesystems, but it is not automatically a better choice than NFS, SMB, Ceph, GlusterFS, Syncthing, Tahoe-LAFS or content-addressed storage.

The right question is not “which filesystem is best?” It is “what consistency, trust, scale, offline behaviour, operational skill and recovery model does this workload require?”

WARENA should retain a simple local filesystem plus verified backup as the baseline. Evaluate network filesystems only for workloads that need shared mutable files. Evaluate object/content-addressed systems for immutable artefacts and distribution. Keep personal synchronization distinct from a shared enterprise filesystem.

## 2. AFS concepts

- **Cell:** an administratively managed AFS realm with its own servers, users and protection database.
- **Volume:** a manageable unit of filesystem data that can be moved, replicated or backed up independently.
- **Namespace:** a client-visible path, commonly rooted under /afs, spanning cells.
- **Fileserver:** serves file data and related operations.
- **Volume Location Database (VLDB):** maps volumes to their hosting servers.
- **Protection database:** records users, groups and access-control identities.
- **Client cache:** keeps file data locally to reduce latency and server load.
- **Callbacks:** servers notify clients when cached data may no longer be valid; clients can invalidate cached state.

AFS's design is shaped by distributed operation and wide-area use. The callback model is not equivalent to a general distributed database or multi-master conflict-free editing system. Correctness depends on client/server protocol behaviour, connectivity and the file access pattern.

## 3. OpenAFS architecture and security

OpenAFS commonly uses Kerberos-based authentication and AFS access-control lists. The security model is not simply POSIX mode bits shared across a network. Identity, tokens, cell administration, protection groups and ACLs must be understood by operators.

Operational concerns:
- Cell administration and trusted identity infrastructure.
- Kerberos realm and key management.
- VLDB and fileserver availability.
- Volume placement, backup and restore.
- Client cache correctness and disconnected behaviour.
- ACL administration and least privilege.
- Firewall and network reachability.
- Upgrade compatibility across clients and servers.

A globally visible namespace does not mean files are public. Access remains governed by cell identity and ACLs. Do not expose a cell or mountpoint without a clear trust and access model.

## 4. Comparison with alternatives

| Technology | Best fit | Consistency / access model | Offline / decentralisation | Operational cost |
|---|---|---|---|---|
| OpenAFS | Managed multi-site shared filesystem | Client cache and callback-based coherence; cells and volumes | Requires reachable infrastructure; disconnected semantics are limited | High: cell, Kerberos, VLDB, servers and clients |
| NFSv4 | Unix/Linux network file sharing | Server-based filesystem semantics with protocol-defined caching/locking | Generally online; not a P2P sync system | Moderate |
| SMB3 | Mixed Windows/Linux enterprise shares | Server-mediated file sharing, locking and ACL integration | Generally online | Moderate |
| CephFS | Scale-out distributed filesystem | Distributed metadata and object storage backend | Cluster-dependent; not an offline-first personal sync tool | Very high |
| GlusterFS | Scale-out network filesystem | Distributed/replicated volumes with configurable modes | Cluster/network dependent; split-brain handling matters | High |
| Syncthing | Device-to-device file synchronization | Replication with conflict handling; not a single shared POSIX filesystem | Strong disconnected synchronization use case | Low to moderate |
| Tahoe-LAFS | Encrypted, distributed fault-tolerant storage | Immutable capability-based files and shares | Distributed storage nodes; application-level update model | Moderate to high |
| IPFS | Content-addressed distribution | Immutable content identifiers; mutable naming requires additional mechanisms | Content retrieval can be peer-to-peer; persistence is not automatic | Moderate |
| Git / content-addressed object store | Versioned source and immutable artefacts | Immutable objects and explicit history | Excellent offline workflows | Low for source; not general mutable home directories |
| Local filesystem + Restic/Borg | Single host and backup/recovery | Local POSIX semantics; snapshot/backup model | Strong offline capability when backup media is available | Low to moderate |

No row is a universal replacement for another. Synchronisation is not the same as a shared filesystem; object storage is not POSIX; backup is not replication; replication is not backup.

## 5. Workload mapping for WARENA

| Workload | Starting recommendation | Why |
|---|---|---|
| Workstation home directory | Local filesystem | Lowest dependency and best local responsiveness |
| Laptop backup | Restic or Borg to local/NAS/off-site repository | Versioned recovery, integrity checks and explicit retention |
| Shared office files | NFSv4 or SMB3 pilot | Simpler server-mediated semantics and broad client support |
| Multi-site research shares | OpenAFS evaluation | Cells, volumes and global namespace are relevant |
| Large clustered storage | Ceph evaluation only when scale and operations justify it | Clustered object/block/file architecture adds complexity |
| Personal device sync | Syncthing | Designed for synchronization across intermittently connected devices |
| Immutable release artefacts | Git plus content hashes; optionally IPFS distribution | Integrity and provenance are first-class |
| Sensitive distributed archives | Tahoe-LAFS research | Capability-oriented encrypted distribution; test recovery and key custody |
| Long-term preservation | Multiple verified copies + periodic restore tests | Independent media, integrity verification and recoverability |

## 6. Security and failure model

1. Authenticate users and hosts independently of network location.
2. Use least-privilege ACLs and group membership.
3. Encrypt network transport; assess at-rest encryption and key custody.
4. Treat caches as sensitive copies of data.
5. Protect server metadata and identity databases.
6. Plan for compromised clients and stolen credentials.
7. Monitor replication lag, server health and volume capacity.
8. Test restore from independent backups, not merely server failover.
9. Define conflict resolution for synchronization workloads.
10. Document what happens during partitions, stale cache conditions and partial recovery.

AFS callbacks can improve cache coherence, but do not remove the need to understand partitions, client cache state and application locking. Ceph replication does not replace backups. Syncthing conflict copies do not constitute an enterprise transactional model.

## 7. Guix and Shepherd integration

Guix can provide reproducible package and service configuration where packages are available and tested. Shepherd can supervise server/client daemons where service definitions exist or are authored and validated.

For each candidate:
- Confirm upstream maintenance and security advisories.
- Confirm Guix package status and buildability.
- Identify kernel, filesystem, FUSE, PAM, Kerberos and network dependencies.
- Keep keys and credentials outside version control.
- Define service users, permissions, startup dependencies and shutdown behaviour.
- Test boot, restart, upgrade, rollback and offline recovery.
- Keep data migration and backup procedures separate from package deployment.

No OpenAFS, Ceph, Syncthing or Tahoe-LAFS deployment is asserted by this document.

## 8. Recommended experiment sequence

**S0 — Requirements:** define users, file count, working-set size, latency, WAN quality, access model, recovery objectives and data classification.

**S1 — Baseline:** local filesystem plus Restic/Borg; measure backup duration, restore time and integrity verification.

**S2 — Shared LAN:** compare NFSv4 and SMB3 for permissions, locking, client compatibility, throughput and outage behaviour.

**S3 — Sync:** evaluate Syncthing with conflict and deletion recovery tests.

**S4 — AFS:** deploy a disposable OpenAFS cell; test Kerberos, ACLs, volume movement, client cache, callbacks, WAN latency and recovery.

**S5 — Distributed storage:** only if scale justifies it, compare Ceph and Tahoe-LAFS against a quantified requirement.

**Acceptance:** documented workload fit, measured results, security review, recovery test and explicit operating cost.

## 9. Sources

- OpenAFS documentation: https://docs.openafs.org/
- OpenAFS project: https://www.openafs.org/
- OpenAFS official release and documentation archive: https://www.openafs.org/pages/release/ (the former docs.openafs.org/Reference/1/Concepts/ path returned 404 in the 2026-11-27 link audit; consult the documentation archive shipped with the selected release)
- AFS operational example (OpenDev): https://docs.opendev.org/opendev/system-config/latest/afs.html
- Ceph documentation: https://docs.ceph.com/
- Syncthing documentation: https://docs.syncthing.net/
- Tahoe-LAFS documentation: https://tahoe-lafs.readthedocs.io/
- IPFS documentation: https://docs.ipfs.tech/
- NFSv4 protocol overview (RFC 7530): https://www.rfc-editor.org/rfc/rfc7530
- Restic documentation: https://restic.readthedocs.io/

**Review rule:** verify current release, supported platforms, security advisories and Guix package status before selecting a candidate.
