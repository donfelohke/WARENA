# WARENA workstation setup workspace

**Status:** STAGING AREA / NO EXECUTABLE HOST CONFIGURATION YET  
**Target:** HP EliteBook 835 G8 · Ryzen 5 PRO 5650U  
**Canonical setup specification:** [EliteBook 835 G8 Sovereign Workstation](../docs/ELITEBOOK-835-G8-SOVEREIGN-WORKSTATION.md)

This directory is reserved for the reproducible WARENA workstation configuration. It intentionally does not yet contain a machine-specific Guix Home or Guix System configuration, channel lock, package overlay, or service activation.

## Why this is not executable yet

The current host OS, exact hardware SKU, RAM population, SSD state, firmware configuration and recovery path have not been inventoried. The RDE/dwl-guile/Home-service source snapshots also have not been proven to form one compatible Guix channel set.

Do not fill these gaps with guessed values or a fabricated lock file.

## Planned layout

```text
setup/
├── README.md
├── channels.scm              # only after channel authentication/compatibility gate
├── home/
│   ├── home.scm              # host-independent Guix Home entry point
│   ├── emacs.scm             # Emacs/editor packages and configuration
│   ├── guile.scm             # Guile development and coordinator environment
│   ├── agents.scm             # role/tool policy declarations
│   └── desktop.scm            # separately qualified desktop profile
├── machines/
│   └── elitebook-835-g8.scm   # only after host inventory and approval
├── packages/
│   └── README.md              # package overlays and provenance rules
├── services/
│   ├── README.md              # Shepherd service design and lifecycle
│   └── agent-coordinator.scm  # only after policy/tests are specified
└── tests/
    ├── README.md
    └── policy-tests.scm
```

The tree is a planned layout, not a claim that these files already exist or work.

## Creation gates

1. Complete the host inventory and recovery record.
2. Select and authenticate Guix channels; record exact commits and introductions.
3. Evaluate RDE against that channel set.
4. Build a minimal Guix Home profile in an isolated/recoverable environment.
5. Add Emacs and Guile tooling.
6. Define and test the agent permission broker before connecting model tools.
7. Benchmark one local inference backend on the actual laptop.
8. Add compositor integration only after a fallback session is verified.

## Change discipline

- Keep host-specific values out of reusable modules.
- Keep secrets, tokens, private keys, model weights and mutable data out of Git.
- Use small commits and reviewable pull requests.
- Preserve upstream history, licence notices and source attribution for any fork.
- Record exact inputs, commands, test outcomes and limitations.
- No live host reconfiguration without explicit approval and a tested recovery path.

**Current status:** setup specification only. No Guix Home profile, Guix System configuration, model service, agent coordinator or desktop has been installed or activated.
