# Gershwin Session — Upstream Delta and Packaging Decisions — 2026-11-18

**Owner:** `donfelohke/WARENA`  
**Status:** RESEARCH ADDENDUM — no Guix build, session launch, or host deployment claimed  
**Applies to:** `GERSHWIN-GUIX-PACKAGING-PLAN-2026-11.md` and `GERSHWIN-UPSTREAM-SOURCE-AUDIT-2026-11.md`

## 1. Why this addendum exists

A fresh GitHub inspection on 2026-11-18 found meaningful upstream changes since the earlier source audit. The package plan remains valid in its core approach (separate store-native recipes, immutable source lock, no root-level `/System` installer), but the compatibility and qualification matrix needs to reflect current upstream direction.

## 2. Current upstream source state

### 2.1 Developer checkout behaviour

The current `gershwin-developer/Library/Scripts/checkout.sh` was fetched from upstream. Its blob SHA is:

`9bff33f3f517bb962fca8370891c7fd4a59751c4`

The script confirms:

- External GNUstep/runtime repositories are pinned by default (`PINNED=1`).
- `PINNED=0` opts out and follows moving upstream heads.
- Gershwin-owned repositories are deliberately **not pinned**; they follow their default branches.
- `BRANCH=dev` prefers a dev branch where one exists and falls back per repository where it does not.
- `SKIP_REPOS` allows selected repositories to be supplied externally.
- The pinned external set includes libobjc2, libs-back, libs-base, libs-gui, swift-corelibs-libdispatch, tools-make, libs-av and libs-steptalk. The pin table also includes libs-opal and libs-corebase, although those are absent from the current REPOS checkout list. QuartzCore remains explicitly unpinned and absent from that list.

**Packaging implication:** the upstream developer checkout is an orchestration convenience, not a reproducible Guix source manifest. WARENA must lock each actual component to a full immutable commit and source hash. The dev channel is useful for evaluation but must not silently become a release pin.

### 2.2 Gershwin desktop and window-manager activity

The current upstream window-manager repository shows recent work in areas that matter directly to a WARENA desktop qualification:

- HiDPI-aware Alt-Tab sizing and icon selection.
- Correct UTF-8 and ICCCM title decoding, including fallback from empty EWMH names.
- Window compositor damage tracking to avoid unnecessary Xorg processing.
- CI coverage for multi-monitor tests using a dummy-driver X.Org server.
- Fixes around compositing and X window identifiers.

These are not cosmetic-only changes. They affect display scaling, internationalized application interoperability, compositor CPU usage and multi-monitor reliability.

The top-level Gershwin repository also continues to integrate system-service changes and its RC/dev image pipelines. Its current source list includes multiple BSD and Linux targets; the published live-image flavors are narrower.

### 2.3 XLibre is now a material upstream compatibility target

The current Gershwin upstream work has moved beyond merely discussing XLibre: recent platform integration replaces X.Org with XLibre on several Linux/BSD targets. The project’s packaging notes describe the XLibre server and driver packages as a matched set; server/driver ABI compatibility must be respected.

This updates the earlier WARENA risk classification:

- **X.Org remains the first controlled Guix baseline** for initial WM/session bring-up because the Guix X.Org packaging and Xephyr development workflow are established.
- **XLibre becomes a first-class upstream compatibility target**, not a casual optional alternative. It needs its own server/driver closure, ABI and session qualification.
- Do not mix X.Org DDX modules with an XLibre server or vice versa unless upstream explicitly establishes compatibility.
- Gershwin upstream success on another distribution does not prove a Guix XLibre build or driver closure.

The XLibre packaging-center repository is community coordination/documentation, not itself a Guix package channel. A 2025 community Guix configuration example exists, but its present package/module status and Guix 1.5.0 compatibility remain unverified.

## 3. Revised qualification matrix

| Gate | X.Org path | XLibre path |
|---|---|---|
| Server and driver package closure | Existing Guix X.Org baseline to verify on target | Separate Guix package/module and matched drivers required |
| Nested test server | Xephyr / X.Org test server | Verify compatible nested-server option; do not assume Xephyr is XLibre |
| Gershwin WM build | Build and test against X.Org headers/runtime | Build against XLibre SDK and ABI |
| Window-management tests | ICCCM/EWMH, HiDPI, UTF-8, RandR/multi-monitor | Repeat same tests independently |
| Workspace and desktop components | LoginWindow, menu, Workspace, preferences | Repeat session-level tests |
| Runtime qualification | Boot/login/logout, compositor, input and recovery | Independent boot/login/logout and driver recovery |
| Promotion | X.Org-qualified session | XLibre-qualified profile only after all gates pass |

## 4. Revised WARENA packaging decisions

1. Keep each GNUstep library and Gershwin application as a separately versioned package where the upstream source and dependency boundary support it.
2. Keep upstream patches with explicit provenance, checksums and applicability tests against their exact pinned source revisions.
3. Keep `gershwin-developer` as a source/build-graph reference. Do not execute its root-oriented installation process as a Guix build phase.
4. Package GNUstep system-domain data and session resources into declared Guix outputs; do not create mutable global `/System` writes.
5. Preserve the upstream native Gershwin WindowManager as the initial desktop integration baseline. WM-NG remains a separate WARENA X11 session proposal and must not compete for X11 WM ownership.
6. Do not declare Guix 1.5.0 package availability based on Guix mainline or a third-party configuration. Record the target channel revision with `guix describe` and verify package exports/builds there.
7. Keep X.Org and XLibre build outputs and qualification results separate.

## 5. Immediate next actions

### G1 — Source lock
- Re-fetch the upstream checkout script at the time of packaging.
- Resolve the full libdispatch pin; the prior audit still marks it unresolved.
- Record full commit IDs and source hashes for all active external and Gershwin repositories.
- Select either the upstream default branch snapshot or a tested dev-channel snapshot; do not mix them unintentionally.

### G2 — Guix 1.5.0 inventory
On the target system, record `guix describe` and inspect GNUstep, X.Org, XCB, Clang/LLVM, libobjc2, libdispatch and XLibre package exports. Where a package is absent, distinguish a backport from a new WARENA package.

### G3 — Minimal GNUstep/X11 proof
Build a minimal GNUstep Foundation application, then a minimal GNUstep GUI application against X.Org. Confirm store-contained paths and runtime library/backend lookup before packaging the complete desktop.

### G4 — Gershwin component build
Build in upstream dependency order; test the native WindowManager and Workspace before adding the full set of components. Include HiDPI, UTF-8 titles, multi-monitor and compositor load in the test matrix.

### G5 — XLibre qualification
Only after G3/G4 pass on X.Org, establish a matched XLibre server/driver package closure and repeat the tests. Do not promote based solely on upstream distro images.

## 6. Evidence boundaries

This addendum records source inspection and architecture decisions. It does **not** claim:
- a Guix 1.5.0 package build;
- a Guix XLibre package installed or tested;
- a complete Gershwin desktop session on Guix;
- a successful login/display-manager integration;
- hardware qualification or deployment.

The existing Gershwin package plan and source audit remain the canonical detailed source maps. This addendum captures the new upstream delta and updates the XLibre qualification policy.
