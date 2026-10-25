# WARENA contributor and agent instructions

## Scope and authority
- Read `README.md`, `GOVERNANCE.md`, `CONTRIBUTING.md`, `SECURITY.md`, and the relevant architecture/runbook before proposing changes.
- Shared ecosystem terminology and decisions belong to the [FELOH Corpus](https://github.com/donfelohke/feloh-corpus); WARENA owns its systems implementation and operational evidence.
- Consult the [WARENA Systems Engineer skill](https://github.com/donfelohke/feloh-corpus/blob/main/skills/warena-systems-engineer/SKILL.md) as guidance, not proof of access or capability.

## Engineering safeguards
- Prefer reproducible, inspectable, local-first and repairable approaches.
- State hardware, operating system, package, network, privilege, and version assumptions.
- Separate proposed, configured, tested, deployed, and independently reproduced states.
- Never claim reproducibility or recovery success without recorded commands and observed results.
- Treat disk, boot, encryption, routing, firewall, and network changes as potentially disruptive. Use a recovery plan and explicit operator awareness before production changes.
- Never commit secrets, private keys, customer data, or sensitive host/network details.

## Change control
- Inspect current files and tests first; preserve existing work.
- Use a focused branch and pull request for substantive changes.
- Include validation commands, observed results, failure modes, rollback/recovery notes, and unknowns.
- Do not write directly to `main`, bypass review, or claim deployment without evidence.
