# WARENA Reproducibility Plan

## Stage 0 — define the target

Record the target hardware, firmware assumptions, storage layout, distribution, boot method, network interfaces, threat model, and intended use. Do not assume that a planned machine or deployment already exists.

## Stage 1 — reproduce a development environment

- Pin the relevant configuration source and package/channel revisions.
- Record exact commands and required inputs.
- Keep secrets outside the repository.
- Test evaluation/build in a disposable or otherwise recoverable environment.
- Record the output and any nondeterministic steps.

## Stage 2 — validate host configuration

- Confirm boot, storage, encryption and network assumptions.
- Separate destructive operations from read-only inspection.
- Document rollback and recovery prerequisites before applying changes.
- Record hardware-specific exceptions.

## Stage 3 — service and network validation

- Document topology, trust boundaries, exposed ports, DNS, addressing and firewall intent.
- Test access control and failure cases in an isolated environment.
- Record expected and observed behaviour.
- Do not publish sensitive configuration or real customer data.

## Stage 4 — backup and restoration

- Identify what must be backed up, where it is stored, and who can access it.
- Verify integrity and retention.
- Perform a restoration test into a safe target.
- Record restoration duration, missing dependencies, and limitations.

## Stage 5 — release evidence

A release record should contain the repository commit, configuration revisions, hardware/software target, validation commands, test results, known issues, rollback path, and maintainer handover notes.

## Acceptance rule

A stage is complete only when its stated tests have actually been run and evidence is recorded. Plans and specifications remain `RESEARCH` or `CONCEPT` until implementation evidence justifies another status.
