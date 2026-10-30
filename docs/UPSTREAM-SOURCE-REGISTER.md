# WARENA Upstream Source Register

**Snapshot:** 2026-10-30  
**Purpose:** immutable source provenance and compatibility posture for the WARENA research stack.  
**Important:** observed upstream revisions are not a WARENA lockfile, Guix channel set, successful build or deployment.

## 1. Verified upstream anchors

| Project | Canonical source / mirror | Observed branch | Full revision | Commit date | Licence / status |
|---|---|---|---|---|---|
| RDE | [SourceHut](https://git.sr.ht/~abcdw/rde) · [GitHub mirror](https://github.com/abcdw/rde) | mirror `master` | `24955da51caf1aaad9a5f0e6c9c9845a504eff64` | 2026-05-04 | GPL-3.0; active development |
| dwl-guile | [GitHub](https://github.com/engstrand-config/dwl-guile) | `main` | `3b9eb86637777a8f82211114a9c38d1c1ede03f7` | 2024-01-12 | Multiple licence files; file-level audit required |
| home-service-dwl-guile | [GitHub](https://github.com/engstrand-config/home-service-dwl-guile) | `main` | `09045a658a17a914d1bda4d23c04d99c40a1d63b` | 2023-10-20 | GPL-3.0 |
| Sway | [GitHub](https://github.com/swaywm/sway) | `master` | `1652c54b73f67df17b7b4ab0b0f7048204aa8104` | 2026-09-21 | MIT |

These are GitHub-observed refs at the snapshot date. For RDE, the GitHub repository identifies itself as a mirror of SourceHut; the canonical upstream should be consulted before treating the mirror commit as authoritative.

## 2. Guix channel introductions

### RDE

The RDE README documents the SourceHut channel URL and this introduction:

```scheme
(channel
 (name 'rde)
 (url "https://git.sr.ht/~abcdw/rde")
 (introduction
  (make-channel-introduction
   "257cebd587b66e4d865b3537a9a88cccd7107c95"
   (openpgp-fingerprint
    "2841 9AC6 5038 7440 C7E9 2FFA 2208 D209 58C1 DEB0"))))
```

### dwl-guile Home service

The upstream Home service README documents:

```scheme
(channel
 (name 'home-service-dwl-guile)
 (url "https://github.com/engstrand-config/home-service-dwl-guile")
 (branch "main")
 (introduction
  (make-channel-introduction
   "314453a87634d67e914cfdf51d357638902dd9fe"
   (openpgp-fingerprint
    "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
```

Treat these as upstream-documented channel introductions, not proof that the current local Guix installation has authenticated or pulled them. Verify fingerprints against current upstream channel metadata before use.

## 3. Compatibility and maintenance observations

### RDE

RDE describes itself as a GNU Guix-based environment framework and states that it is stable and usable while actively developed, with APIs subject to change. It includes Guix System and Guix Home configuration patterns and examples referencing Sway. WARENA should reuse selected modules and patterns rather than inherit a full personal distribution configuration.

### dwl-guile

The upstream README states that the project is based on dwl v0.4 and wlroots 0.16.x. The observed repository commit is from January 2024. Treat this as a legacy compatibility target until its current dependency graph, patches and build instructions are independently verified. Do not pair it with a newer RDE revision by assumption.

### Home service

The Home service README explicitly describes the project as work in progress. It can install and configure dwl-guile, set Wayland environment variables, optionally auto-start, reload configuration and expose a Shepherd service. Runtime evaluation and optional REPL access are powerful capabilities and require a threat-model and access-control review. Do not enable an externally reachable or unattended REPL in a production profile.

### Sway

Sway is the reference Wayland candidate for comparative testing. Its upstream repository is active and MIT-licensed. This does not establish that the WARENA Guix package, profile, hardware or recovery path is tested.

## 4. Guix pinning rule

No single Guix channel lock or compatible RDE/dwl-guile channel set is asserted by this register. Before implementation, record:

1. Official Guix channel URL and full commit.
2. Channel introduction commit and OpenPGP fingerprint.
3. RDE channel URL, introduction and full commit.
4. Any Home service channel URL, introduction and full commit.
5. Nonguix or other channel introductions only if actually required.
6. Channel order, authentication result, `guix describe` output and resolved package versions.
7. Exact target architecture and Guix version.

Do not use an old GitHub mirror commit as a substitute for the official Guix source. Do not invent a Guix revision or infer package availability from an upstream README.

## 5. Licence handling

- RDE: preserve GPL-3.0 notices and comply with applicable source distribution requirements.
- Home service: preserve GPL-3.0 notices.
- Sway: preserve MIT copyright and permission notice.
- dwl-guile: repository-level API reports `NOASSERTION`; the repository contains multiple licence files. Audit every imported source file, patch and vendored component before redistributing a combined binary or source bundle. Do not assign one blanket SPDX identifier without evidence.

This register is not legal advice.

## 6. Required revalidation

Revalidate upstream default branches, tags, commit hashes, channel introductions, licence files and release notes immediately before creating a WARENA lockfile or merging a package change. Store the exact checked URLs, timestamp, hashes and test logs in the resulting PR.

**Current qualification:** source snapshots recorded; compatible channel set, package evaluation, build, runtime, hardware and recovery remain **NOT VERIFIED**.
