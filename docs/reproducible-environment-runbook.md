# Reproducible Environment Runbook

**Status: PROPOSAL.** This is a cautious workflow, not a claim that a specific GNU/Linux, GNU Guix, or RDE environment has been reproduced.

## Objective

Make a development or system environment inspectable, reconstructable, and maintainable by someone other than its original author.

## Before starting

Record:
- Target use and hardware/architecture.
- Distribution, release, kernel, and package tooling.
- Source repository, branch, and commit.
- Package channels/revisions, manifests, lock files, overlays, and configuration inputs.
- Required network access and external dependencies.
- Storage and rollback constraints.

Do not store tokens, private keys, personal data, or production secrets in manifests or logs.

## Procedure

1. **Inspect first.** Read existing configuration and documentation. Identify destructive operations and machine-specific assumptions.
2. **Pin inputs.** Record exact source revisions and channel/package revisions where supported. Explain any intentionally floating input.
3. **Separate configuration and state.** Keep declarative definitions distinct from credentials, caches, mutable application data, and host-specific state.
4. **Evaluate safely.** Run syntax, formatting, lint, or configuration evaluation checks that do not modify the target host.
5. **Build in isolation.** Prefer a disposable VM, container, test host, or recoverable profile. Record the environment used.
6. **Compare outputs.** Record expected versus observed output, package versions, generated artefacts, warnings, and non-deterministic inputs.
7. **Test a second run.** Repeat the documented procedure from a clean or independent environment where feasible. Record whether results match.
8. **Promote deliberately.** Do not deploy to a production host until prerequisites, backup, maintenance window, rollback, and acceptance checks are agreed.
9. **Hand over.** Document how to reproduce, update, diagnose, roll back, and retire the environment.

## Evidence record

- Source commit:
- Input/channel revisions:
- Host/VM and OS details:
- Commands executed (exact, with secrets removed):
- Expected result:
- Observed result:
- Exit status:
- Artefact or log reference:
- Independent repeat performed?:
- Differences / nondeterminism:
- Rollback tested?:
- Remaining limitations:
- Status: `RESEARCH` / `PROTOTYPE` / `LIVE` only as supported by evidence

## Acceptance criteria

- Required inputs and dependencies are identified.
- Steps can be followed without undocumented private knowledge.
- Commands and results are recorded.
- Secrets are excluded from committed material.
- Build/evaluation results are distinguished from deployment and recovery evidence.
- Any untested step is clearly labelled `NOT VERIFIED`.

## Guix/RDE notes

For Guix or RDE work, record the Guix revision, channel definitions and revisions, manifest or system declaration, relevant overlays/modules, target architecture, and exact evaluation/build commands. Do not label a profile or system reproducible solely because its configuration is declarative; record the actual build and repeatability evidence.
