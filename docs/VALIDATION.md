# WARENA — Validation discipline

| Claim type | Minimum evidence |
|------------|------------------|
| Service offered publicly | Listed on site + SERVICE-CATALOG / TECHCOPY alignment |
| Host is LIVE | Hostname/role, OS, recovery path, last verified date |
| Backup works | Restored successfully at least once (record date) |
| Network change | Before/after behaviour noted |

**Open:** Automated acceptance tests for lab hosts are not claimed here.


## Upstream and reproducibility claims

For any upstream-dependent claim, record:
- canonical upstream and any mirror;
- full immutable source revision and observation date;
- licence and imported-source obligations;
- Guix channel URL, introduction commit and signing fingerprint;
- dependency evaluation and build result;
- named target, test procedure and observed result;
- failure, rollback and recovery evidence.

A successful documentation CI check validates the documentation workflow only. It does not validate package compatibility, a Guix build, runtime operation, hardware support, security or recovery. Use [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md) and [EVIDENCE-STATUS.md](./EVIDENCE-STATUS.md).
