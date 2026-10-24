# Contributing to WARENA

## Before opening a pull request

1. Read `README.md`, `GOVERNANCE.md`, and the relevant architecture or runbook.
2. Keep the change focused and state the problem it solves.
3. Identify hardware, operating-system, package, channel, and network assumptions.
4. Include reproducible commands and expected outcomes where relevant.
5. State what was actually tested and what remains unverified.
6. Remove credentials, private keys, customer data, and machine-specific secrets from examples and logs.

## Pull request description

Include:
- Summary and motivation.
- Scope and affected components.
- Prerequisites and environment.
- Commands used to validate the change.
- Observed results and evidence links.
- Risks, rollback/recovery notes, and known limitations.

## Infrastructure changes

Never test potentially disruptive networking, disk, boot, firewall, or encryption changes on a production system without a recovery plan and explicit operator awareness. Prefer disposable environments and non-destructive validation first.

## Documentation quality

Distinguish intended, implemented, tested, and deployed behaviour. Do not claim a build is reproducible until another run or independent environment has verified the documented procedure.
