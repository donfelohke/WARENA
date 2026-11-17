# Gershwin Session — GitHub Source Map and Guix Packaging Plan

**Document ID:** WARENA-GERSHWIN-GUIX-2026-11  
**Review date:** 2026-11-18  
**Status:** RESEARCH / PACKAGING PLAN — NOT A BUILD OR DEPLOYMENT RECORD  
**Configuration owner:** `donfelohke/WARENA`  
**Desktop policy:** X11-first; X.Org initial compatibility baseline; XLibre separate compatibility experiment.  
**Rebase policy:** deferred.

## 1. Decision and scope

Gershwin is the GNUstep-based desktop environment track in WARENA's X11-first dual-session architecture. It is a complete desktop environment, not simply a window manager. Its upstream project includes Workspace, a native X11 window manager, system components, Terminal, TextEdit, System Preferences and theme assets.

WARENA will consume and package upstream sources; it will not claim ownership of the upstream projects or replace their build/release process. WARENA configuration, Guix package definitions, channel pins, session declarations and qualification records belong in `donfelohke/WARENA`.

**Current status:** upstream source repositories were inspected on 2026-11-18. A WARENA Guix package set, successful Guix builds, a complete desktop session and host deployment have not been verified by this audit.

## 2. Upstream GitHub source map

Primary source organisation: [gershwin-desktop](https://github.com/gershwin-desktop)

| Repository | Responsibility | Packaging treatment |
|---|---|---|
| [gershwin-developer](https://github.com/gershwin-desktop/gershwin-developer) | Source checkout, bootstrap, patches and aggregate build targets | Reference the build graph and patch provenance; do not run its root-level install workflow as a Guix package recipe |
| [gershwin-desktop](https://github.com/gershwin-desktop/gershwin-desktop) | Project overview and live-image definitions | Reference/documentation; not the desktop runtime package |
| [gershwin-system](https://github.com/gershwin-desktop/gershwin-system) | Files and scripts for the `/System` domain | Package data/scripts with explicit path review |
| [gershwin-workspace](https://github.com/gershwin-desktop/gershwin-workspace) | Workspace/file manager and desktop services | Separate package |
| [gershwin-windowmanager](https://github.com/gershwin-desktop/gershwin-windowmanager) | Native X11 window manager and XCBKit | Separate package; validate X.Org and XLibre independently |
| [gershwin-components](https://github.com/gershwin-desktop/gershwin-components) | Menu, LoginWindow, preference panes and other components | Split packages or outputs where dependency boundaries justify it |
| [gershwin-systempreferences](https://github.com/gershwin-desktop/gershwin-systempreferences) | System Preferences application | Separate package |
| [gershwin-terminal](https://github.com/gershwin-desktop/gershwin-terminal) | Terminal application | Separate package |
| [gershwin-eau-theme](https://github.com/gershwin-desktop/gershwin-eau-theme) | GNUstep Eau theme | Separate data/theme package |
| [gershwin-assets](https://github.com/gershwin-desktop/gershwin-assets) | Shared artwork and resources | Separate data package |
| [gershwin-textedit](https://github.com/gershwin-desktop/gershwin-textedit) | TextEdit application | Separate package; verify repository and current source state before recipe work |

Upstream source checkout also includes the GNUstep and runtime dependencies below. Exact source revisions must be captured from the upstream checkout metadata and verified against fetched commits before building.

## 3. Dependency and build order

The upstream developer checkout script explicitly includes these external projects and pins several of them because its patch set targets specific source revisions:

1. `swift-corelibs-libdispatch`
2. `libobjc2`
3. `tools-make`
4. `libs-base`
5. `libs-gui`
6. `libs-back`
7. `libs-av`
8. `libs-steptalk`

Gershwin's own repositories are handled separately by the upstream checkout script and are not included in its external-library pin list. WARENA should improve reproducibility by recording a complete source manifest for every dependency and desktop component, not inherit a moving branch as a deployment pin.

### Proposed Guix package layering

| Layer | Source | Guix work | Gate |
|---|---|---|---|
| Objective-C runtime | GNUstep `libobjc2` | Verify/extend package; Clang/LLVM toolchain and CMake build | Runtime/compiler ABI test |
| GNUstep build tools | `tools-make` | Verify/extend package; ensure GNUstep make environment is relocatable | Build a minimal Foundation application |
| Foundation | `libs-base` | Package dependencies and environment setup | Foundation test suite |
| GUI framework | `libs-gui` | Package headers, libraries, resources and runtime paths | Headless/build tests plus GUI smoke test |
| X11 backend | `libs-back` | Xlib/X11 dependencies and backend selection | Open a minimal GNUstep GUI application on X.Org |
| Additional libraries | `libs-av`, `libs-steptalk`, libdispatch | Include only where current Gershwin targets require them | Per-component linkage/runtime evidence |
| Gershwin system | `gershwin-system`, assets | Package scripts and shared data | No writes outside declared outputs |
| Desktop applications | Workspace, WM, components, preferences, Terminal, TextEdit, theme | One recipe per independently versioned source | Component build and runtime tests |
| Session integration | WARENA Guix Home/System declarations | Session entry, environment, launch and recovery | Login/logout/crash/recovery tests |

Do not assume all optional libraries are required by every component. Derive native inputs and propagated inputs from the actual build files and dependency metadata.

## 4. Guix packaging policy

### 4.1 Package availability audit — preliminary evidence

The first source-level pass found existing GNUstep definitions in Guix's `gnu/packages/gnustep.scm`, including `libobjc2` and `gnustep-base`. Guix commit history records `libobjc2` updated to 2.3 on the moving master branch in August 2026, and a Clang 22 compatibility patch in October 2026. A separate October 2026 commit adjusts `gnustep-base` packaging by removing a bundled certificate file. These are evidence of active mainline packaging, **not proof that those post-release changes are present in the Guix 1.5.0 release snapshot**.

| Dependency / package candidate | Preliminary classification | Evidence and next check |
|---|---|---|
| GNUstep Objective-C runtime (`libobjc2`) | EXISTING in Guix mainline; exact 1.5.0 version requires confirmation | Mainline update to 2.3 and Clang compatibility patch recorded in 2026. Query selected Guix revision and build with its declared Clang. |
| GNUstep Base (`gnustep-base`) | EXISTING in Guix mainline; exact 1.5.0 recipe requires confirmation | Mainline package has active packaging fixes in October 2026. Check compiler/runtime pairing and package tests. |
| GNUstep Make (`gnustep-make`) | NOT YET CLASSIFIED | Inspect exact package exports and selected channel revision; do not infer from helper procedures alone. |
| GNUstep GUI (`gnustep-gui`) | NOT YET CLASSIFIED | Verify whether the release channel exports a package and whether its source version matches Gershwin's pinned set. |
| GNUstep Backend (`gnustep-back`) | NOT YET CLASSIFIED | Verify package and X11 backend options; confirm Xlib/XCB runtime closure. |
| Swift libdispatch (`libdispatch`) | EXISTING package candidate in Guix's C package module; dependency use is optional until proven | Verify exact revision and whether Gershwin targets actually link it. |
| GNUstep AV / StepTalk (`libs-av`, `libs-steptalk`) | NOT YET CLASSIFIED | Check whether Guix has equivalent packages; package only if current targets require them. |
| Gershwin desktop components | NEW unless an equivalent package is discovered | No WARENA package recipes or Guix component builds have been evidenced. |

**Important release distinction:** Guix 1.5.0 was released in January 2026. The cited August–October 2026 package commits are later mainline history; they must not be silently attributed to the 1.5.0 release. The exact package inventory must be queried against the user's selected Guix revision, recorded with `guix describe`, and checked with `guix show PACKAGE`. After the RDE/Guix installation is available, run:

```sh
guix describe
for p in libobjc2 gnustep-base gnustep-make gnustep-gui gnustep-back libdispatch; do
  guix show "$p" || true
done
```

For each result, record the package name, version, source origin, build system, inputs, patches and channel commit. A package being discoverable is not proof that it builds or that its ABI matches the Gershwin source pins.

A Guix mailing-list report from January 2026 documents a real integration failure involving overlapping GCC Objective-C and libobjc2 runtime headers while building GNUstep Base. This makes the runtime/compiler/header selection an explicit G1 blocker to resolve, rather than assuming that merely placing Clang and libobjc2 in the same profile is sufficient.

Reuse or extend existing Guix packages where technically correct. Do not create duplicate package definitions merely to rename upstream software.

### 4.2 Store-native installation

The upstream developer workflow installs into a shared `/System` domain and uses root-level bootstrap/install commands. This is not directly suitable as a Guix package recipe.

Guix recipes must:
- install into the package output under the store;
- avoid writes to the host's `/System`, `/usr`, `/etc` or home directory during build;
- avoid network access during build phases;
- use declared native inputs, inputs and build tools;
- patch hard-coded paths and runtime lookup paths where required;
- preserve application bundles, resources, libraries and GNUstep domain semantics without mutable global installation;
- avoid invoking upstream scripts that perform privileged host installation;
- use wrappers or declared environment variables for runtime paths where justified;
- document any unavoidable compatibility patch and keep it isolated from upstream source.

Do not assume the upstream `/System` domain can be mapped one-to-one to a Guix profile. First prove how GNUstep discovers frameworks, bundles, resources, defaults and applications when installed into isolated outputs.

### 4.3 Source provenance and patch discipline

- Pin every source to a full immutable commit or verified release source.
- Record upstream URL, commit, license, source hash and patch list.
- Keep WARENA patches in the WARENA package source or a clearly versioned patch directory.
- Do not modify upstream GitHub repositories without a separate contribution decision.
- Test patches against the exact source revision they target.
- Never claim a reproducible build until a clean, offline rebuild has been demonstrated.

## 5. X.Org / XLibre compatibility

WARENA's current architecture names X.Org as the initial X11 compatibility baseline and XLibre as a separate compatibility experiment. Gershwin upstream has been testing XLibre on some Linux live-image flavours, so WARENA must not assume the two server stacks are interchangeable in practice.

Build and validate two explicit configurations where feasible:

- **Profile X:** Guix + X.Org + Gershwin.
- **Profile XL:** Guix + XLibre + Gershwin.

Record the exact X server, drivers, input stack, XCB/Xlib libraries and package closure for each profile. Test window-manager startup, display discovery, input, clipboard, multi-monitor, suspend/resume and logout. Keep the X.Org baseline recoverable while evaluating XLibre.

## 6. Session and display-manager integration

Gershwin's developer instructions document starting the session through `/System/Library/Scripts/Gershwin.sh`; its `LoginWindow.sh` can start the X server itself. The Guix integration must decide which component owns the display-server lifecycle.

**Initial integration rule:** use one display-manager/session owner. Do not enable Gershwin LoginWindow as an independent display manager while another display manager or greeter is already responsible for starting and supervising X.

Proposed separation:

- Guix System / Shepherd owns system services and the selected display-manager service.
- The display manager launches a WARENA-managed Gershwin session entry.
- The session entry sets the required GNUstep environment and starts the desktop process tree.
- Logout, crash and restart behaviour are explicit and tested.
- TTY access and a separate recovery session remain available.

Do not enable a greeter or display-manager service until its package, service definition, seat/session handling, PAM/logind or equivalent integration, X server lifecycle and recovery behaviour have been reviewed on the target Guix System.

## 7. Validation gates

| Gate | Required evidence | Promotion |
|---|---|---|
| G0 — source inventory | Repository, branch/tag, full commit, license and source hash for every dependency | Source set known |
| G1 — Guix dependency audit | Existing package status, versions, patches, compiler/runtime compatibility | Recipe plan approved |
| G2 — core framework | libobjc2, tools-make, base, GUI and backend build logs | GNUstep core buildable |
| G3 — individual components | Workspace, window manager, system, terminal, preferences, components and theme build results | Component set buildable |
| G4 — composed desktop | Complete pinned closure, session command, environment and resources | Desktop prototype |
| G5 — X server matrix | X.Org baseline and XLibre experiment results | Compatibility claims bounded |
| G6 — login lifecycle | Greeter, session start, logout, crash recovery, TTY fallback | Session prototype |
| G7 — reproducibility | Clean build, offline rebuild, closure inventory, rollback | Reproducibility demonstrated |
| G8 — host qualification | Named host, versions, logs, user acceptance and tested recovery | Eligible for maturity review |

A successful package build is not a successful desktop session. A successful desktop session in a VM is not proof of hardware qualification or LIVE deployment.

## 8. Immediate work queue

1. Complete a full upstream repository and license inventory.
2. Extract all pinned external commits and the patch series from `gershwin-developer`.
3. Query the pinned Guix channel for existing GNUstep/Objective-C/X11 packages.
4. Build a dependency-to-recipe matrix; mark each item EXISTING / EXTEND / NEW / BLOCKED.
5. Package the smallest viable GNUstep core before any full desktop meta-package.
6. Package and test the native X11 window manager separately.
7. Add desktop components in dependency order.
8. Add a WARENA session definition only after component paths and runtime environment are known.
9. Integrate the selected display manager in a separate change set.
10. Retain X.Org recovery while qualifying XLibre.

**Do not begin by packaging the upstream all-in-one root installer as one opaque Guix package.** The dependency layers must remain inspectable, testable and independently rebuildable.

## 9. Current evidence ledger

| Claim | Status on 2026-11-18 |
|---|---|
| Gershwin is GNUstep-based | VERIFIED from upstream project documentation |
| Gershwin is an X11 desktop track | VERIFIED from upstream developer instructions and WARENA architecture |
| Upstream component repositories exist | VERIFIED for repositories listed above |
| Upstream developer script pins external GNUstep/runtime dependencies | VERIFIED by inspecting `Library/Scripts/checkout.sh` |
| Guix mainline has libobjc2 and gnustep-base definitions | VERIFIED from 2026 Guix commit records; not equivalent to Guix 1.5.0 verification |
| Exact Guix 1.5.0 package inventory for all dependencies | PARTIAL / NOT YET VERIFIED against release snapshot |
| WARENA Guix recipes exist and build | UNKNOWN / NOT EVIDENCED |
| Gershwin session starts on Guix System | NOT TESTED |
| Display-manager integration works | WIP / NOT TESTED |
| X.Org host compatibility | NOT TESTED |
| XLibre host compatibility | NOT TESTED |
| WARENA host deployment | NOT CLAIMED |

## References

- [Gershwin Desktop upstream](https://github.com/gershwin-desktop/gershwin-desktop)
- [Gershwin Developer build and checkout scripts](https://github.com/gershwin-desktop/gershwin-developer)
- [Gershwin architecture](https://gershwin-desktop.github.io/docs/developer/architecture.html)
- [Gershwin build documentation](https://gershwin-desktop.github.io/docs/developer/building.html)
- [GNUstep source and release inventory](https://www.gnustep.org/resources/downloads.html)
- [GNUstep tools-make installation notes](https://github.com/gnustep/tools-make/blob/master/INSTALL)
- [WARENA desktop architecture](DESKTOP-ARCHITECTURE.md)
- [WARENA stack register](STACK-REGISTER.md)
- [WARENA technology constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md)

