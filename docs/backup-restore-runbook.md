# Backup and Restoration Runbook

**Status: PROPOSAL.** A written plan is not proof that backups exist, are complete, or can be restored.

## 1. Define recovery objectives

- System/data set:
- Owner:
- Business or technical impact:
- Recovery Point Objective (maximum tolerable data loss):
- Recovery Time Objective (target restoration time):
- Required retention:
- Legal, privacy, or contractual constraints:
- Dependencies required to recover:

Choose objectives with the system owner; do not invent targets.

## 2. Define backup scope

List configuration, source, manifests, application data, databases, user files, encryption metadata, and system-specific state that must be protected. Explicitly list excluded or regenerable data. Do not put secrets in the public repository.

For each backup target, record its location reference, access control, encryption approach, retention, versioning, capacity, and failure domain. Where practical, keep at least one protected copy independent of the primary host.

## 3. Before taking a backup

- Confirm source and destination identities.
- Check available space and destination health.
- Ensure application-consistent capture or document the consistency limitation.
- Verify permissions and encryption settings.
- Avoid overwriting the only known-good backup.
- Record start time, tool/version, configuration, and result.

## 4. Verify integrity

Run the tool's supported integrity/check operation and inspect exit status. Record what the check proves and does not prove. A checksum verifies bytes against a reference; it does not by itself prove the data is complete or restorable.

## 5. Restore test

1. Select a representative backup and record its identifier.
2. Choose an isolated, non-production target with sufficient capacity.
3. Confirm restore prerequisites, keys availability (without recording keys), and overwrite risk.
4. Restore using the documented tool and exact steps.
5. Validate file/application consistency and permissions.
6. Run application-level acceptance checks.
7. Measure elapsed time and identify missing dependencies.
8. Clean up the test environment securely.
9. Record the result and remediation actions.

Never experiment with destructive restore commands against the only production copy.

## 6. Restore evidence

- Backup ID/date:
- Source and tool/version:
- Integrity-check command and result:
- Restore target (safe alias):
- Restore start/end time:
- Data/sample checked:
- Application-level checks:
- Expected vs observed result:
- Missing items/dependencies:
- RPO/RTO observed:
- Cleanup completed:
- Operator and reviewer:
- Status: `NOT RUN` / `PASS` / `FAIL`
- Follow-up issue:

## 7. Operational review

Review backup failures, retention, access, encryption, capacity, and restore tests on an agreed schedule. Update procedures after platform changes. Mark restoration capability `LIVE` only when current evidence supports the claim.
