# Gershwin Upstream Source and Packaging Audit — 2026-11

**Review date:** 2026-11-18  
**Owner:** `donfelohke/WARENA`  
**Scope:** upstream checkout/build scripts, source pins, component snapshots, licenses, and Guix package readiness.  
**Status:** RESEARCH / SOURCE AUDIT. No Guix build, package install, session launch, or host deployment is claimed.

## 1. Executive decision

Gershwin can be approached as a layered GNUstep desktop build, but it is not yet a Guix-ready system-domain installer. The upstream developer workflow is explicitly root-oriented and installs into a mutable `/System` domain. WARENA must translate the build graph into store-native Guix packages and a separately managed session; it must not wrap the root installer as one opaque package.

**Architecture:** X11-first. X.Org is the initial compatibility baseline; XLibre remains a separate experiment. Keep Sway as the recoverable Wayland baseline and do not conflate the Gershwin session with the Guile-WM session.

## 2. Upstream checkout graph

The current `gershwin-developer/Library/Scripts/checkout.sh` declares these source repositories:

### External libraries and runtimes

| Repository | Checkout behaviour | Build-script use |
|---|---|---|
| `apple/swift-corelibs-libdispatch` | Pinned | Built first; supplies BlocksRuntime and dispatch headers/libraries |
| `gnustep/libobjc2` | Pinned | Built after tools-make |
| `gnustep/tools-make` | Pinned | Built before libobjc2; configures GNUstep make environment |
| `gnustep/libs-base` | Pinned | Built after libobjc2 |
| `gnustep/libs-gui` | Pinned | Built after Base |
| `gnustep/libs-back` | Pinned | X11/graphics backend, built after GUI |
| `gnustep/libs-av` | Pinned | Built after core libraries in the current script |
| `gnustep/libs-steptalk` | Pinned | Checked out, but not built by the current `corelibs` path |
| `gnustep/libs-opal` | Pin entry exists, but repository is not in the current `REPOS` list | Not fetched or built by the current checkout/install scripts inspected |
| `gnustep/libs-corebase` | Pin entry exists, but repository is not in the current `REPOS` list | Not fetched or built by the current checkout/install scripts inspected |
| `gnustep/libs-quartzcore` | Mentioned as deliberately unpinned; not in the current `REPOS` list | No current build-script use found |

The last three entries are important audit findings: `libs-opal` and `libs-corebase` occur in the `PINS` block, but are absent from the same script's `REPOS` list. The pin loop skips a repository when its source directory does not exist. `libs-quartzcore` is described as unpinned and is likewise not in the checkout list. Do not treat any of these as active build dependencies without a current upstream build-graph reference.

### Gershwin repositories

| Repository | Role |
|---|---|
| `gershwin-system` | GNUstep system-domain files and scripts |
| `gershwin-assets` | Shared system assets |
| `gershwin-workspace` | File manager, optional desktop, trash, dock and NSWorkspace services |
| `gershwin-systempreferences` | System Preferences and preference frameworks |
| `gershwin-eau-theme` | GNUstep Eau theme |
| `gershwin-terminal` | Terminal |
| `gershwin-textedit` | TextEdit |
| `gershwin-windowmanager` | Native X11 window manager |
| `gershwin-components` | Menu, LoginWindow, preference panes, plist update hook and other components |

The developer checkout also fetches `gershwin-desktop/docs` and `gershwin-desktop/gershwin-desktop.wiki` for documentation. The developer repository itself is the orchestration repository.

## 3. External pinned-source ledger

The upstream checkout script records short pins. The following full immutable commit IDs were resolved through GitHub for the listed short IDs:

| Project | Upstream short pin | Resolved full commit |
|---|---|---|
| libobjc2 | `c9f4002` | `c9f4002ade04d755f2a0e6c83daf2738dca03759` |
| libs-back | `bbcc3de` | `bbcc3de7cab63b6e65944edf02f2bbef9d8a7bbd` |
| libs-base | `5bda522` | `5bda52220a6d67382c9851cdfd91d459bfd2b489` |
| libs-gui | `8f804fd` | `8f804fd520c60800961e0bee072066f4bbadca94` |
| tools-make | `4e31a03` | `4e31a0310df5f0aa96ccd816d3b626e67c36f535` |
| libs-av | `26566e2` | `26566e25043ffc354364a9a5ff2c69252f81d404` |
| libs-steptalk | `2b57b46` | `2b57b46963d05729032a740f0697de7fed237e4f` |
| libs-opal | `98f8e4f` | `98f8e4ffdde396d662f1c7b2e4cd2da97ef65070` |
| libs-corebase | `e89ff1f` | `e89ff1f5b878414d5ec900fd37b1af64f43c5850` |
| swift-corelibs-libdispatch | `95f592a` | **UNRESOLVED** — GitHub commit lookup did not return a valid commit object; resolve before source-lock promotion |

The checkout script comments say the external pins were refreshed 2026-07-26; the `libs-opal` pin was added for a source tree dated 2026-08-17, and `libs-corebase` for a tree dated 2026-09-06. It also says the `libs-gui` pin is held behind upstream HEAD because `dropdown-tracking.patch` does not apply to newer source, and the `libs-opal` patch was tested against its stated pin. The source set therefore cannot be casually advanced as a group.

**Source-lock rule:** WARENA must record full commit IDs, source hashes, licenses, patch checksums, and the exact checkout-script commit. Do not promote the table above to a reproducible lock until the unresolved dispatch SHA is resolved and every pin is checked against the actual current upstream checkout script.

## 4. Gershwin component snapshots (not upstream pins)

The same script comments list these as known-good component commits, while explicitly stating that Gershwin's own repositories are not pinned and continue tracking branches. These are historical audit references, not the current checkout behaviour:

| Component | Known-good full commit |
|---|---|
| gershwin-windowmanager | `1f3cc1cbaf8d076d6fdbe33e5a7bed79fb2cbdde` |
| gershwin-components | `3395d9932505ccee96d53c3fb762d101b9bab732` |
| gershwin-eau-theme | `4babcb0b41b8f3f2cea3e5fdb7cfda30ba7380e8` |
| gershwin-assets | `4deb4826070addd6f49c0abdaabc3edcddf417cc` |
| gershwin-workspace | `1bc3b988ca4271a5dde621411313b3df36432e21` |
| gershwin-system | `cdeafb626ffc7307d31fbee9c8d84bd6a38c63ac` |
| gershwin-systempreferences | `8d49f505f4e09a7555ffd687a36a309a05fee03e` |
| gershwin-terminal | `71124e3ea92c68bd778cca6cea608ad870f472ac` |
| gershwin-textedit | `3df6db8e8307157edf393ed38e42886a901987af` |

For a WARENA package source set, deliberately choose either these known-good commits or a newly tested compatible set. Do not silently replace them with moving default branches.

## 5. Actual upstream build order

Inspection of `Library/Scripts/install-system-domain.sh` shows this core sequence:

1. Install `gershwin-system` and copy `gershwin-assets` into the shared system domain.
2. Patch and build `swift-corelibs-libdispatch`.
3. Build `tools-make` using the GNUstep `ng-gnu-gnu` library combo.
4. Build `libobjc2` against Clang and the BlocksRuntime supplied by libdispatch.
5. Patch and build `libs-base`.
6. Patch and build `libs-gui`.
7. Patch and build `libs-back` (with fonts disabled in the current script).
8. Build/install the Gershwin `plistupdate` integration hook.
9. Patch and build `libs-av`.
10. Build desktop components in dependency order: System Preferences before Workspace (Workspace's indexing preference pane needs PreferencePanes), then theme, Terminal, TextEdit, window manager and components.

The current script sets `CC=clang`, `CXX=clang++`, and `OBJC=clang` for the complete build. This is an explicit upstream requirement, not an optional WARENA preference. GNUstep Make documents that libobjc2 requires Clang and that its runtime ABI/features must be selected consistently.

### Important platform adaptations

- NextBSD uses a non-Mach libdispatch build to avoid Mach-specific dispatch code colliding with its kqueue behaviour.
- OpenBSD exports X11 include and library paths from `/usr/X11R6`.
- Linux removes `-liconv` in the Terminal build because iconv is part of glibc.
- Runtime backend bundles are dynamically loaded by GNUstep by default; Guix packaging must prove bundle lookup works in isolated store outputs.

These branches show why a generic one-line CMake/Autotools recipe is insufficient.

## 6. Licensing reconnaissance

Root license files were inspected where present. This is an initial repository-level inventory, not a complete per-file license scan; source subdirectories and vendored code may carry additional notices.

| Repository | Root license evidence | Packaging note |
|---|---|---|
| libobjc2 | `COPYING` begins with MIT-style permissive terms | Preserve notice; verify third-party robin-map/submodule license separately |
| tools-make | GPL-3.0 text in `COPYING` | Record any bundled/generated file exceptions |
| libs-base | GPL-2.0 text in `COPYING`; repository also advertises LGPL-2.1 files | File-level licensing review required |
| libs-gui | GPL-3.0 text in `COPYING` | File-level licensing review required |
| libs-back | GPL-3.0 text in `COPYING` | File-level licensing review required |
| libs-av | GPL-3.0 in `LICENSE.md` | Confirm optional dependency status before packaging |
| libs-steptalk | LGPL-2.1 text in `COPYING` | Not built by current corelibs stage |
| libs-opal | LGPL-2.1 text in `COPYING` | Not in current checkout/build list |
| libs-corebase | GPL-3.0 text in `COPYING` | Not in current checkout/build list |
| gershwin-system | BSD-2-Clause in `LICENSE` | Package scripts/data with source attribution |
| gershwin-workspace | GPL-2.0 text in `COPYING` | Check all file-level notices |
| gershwin-systempreferences | GPL-2.0 text in `COPYING` | Check all file-level notices |
| gershwin-eau-theme | LGPL-2.1 text in `LICENSE` | Keep license and attribution with theme assets |
| gershwin-textedit | MIT in `LICENSE` | Check icon/artwork and bundled resources separately |
| gershwin-components | BSD-2-Clause in `LICENSE` | Components may have distinct notices |
| swift-corelibs-libdispatch | No root license file found in the attempted root-name set | **BLOCKED for license sign-off**; inspect repository metadata and file-level notices |
| gershwin-terminal | No root license file found in the attempted root-name set | **BLOCKED for license sign-off** |
| gershwin-windowmanager | No root license file found in the attempted root-name set | **BLOCKED for license sign-off** |
| gershwin-assets | No root license file found in the attempted root-name set | **BLOCKED for license sign-off** |

Do not infer a license from the language, project family, or a neighbouring repository. Complete license sign-off before publishing a binary package or distributing a combined desktop image.

## 7. Guix package status and release boundary

GNU Guix 1.5.0 was released on 2026-01-23. Mainline package work from October 2026 must not be back-projected into that stable release.

| Component | Guix 1.5.0 status | Current mainline evidence | WARENA action |
|---|---|---|---|
| `libobjc2` | Existing package; the 2026 mainline update changed it from 2.2.1 to 2.3 | Update commit in August 2026 | Reuse release package as baseline; test runtime/compiler ABI, then evaluate 2.3 in a separate channel update |
| `libdispatch` | Exact 1.5.0 package/version needs local confirmation | Guix C package module has a package definition; mainline update to 6.4.0 in October 2026 | Verify package name/version in the selected Guix revision; upstream Gershwin pin differs from Guix's package source |
| `gnustep-make` | Exact 1.5.0 package/version needs local confirmation | Mainline update to 2.9.3 in October 2026 | Query the 1.5.0 channel; compare configure options and GNUstep layout |
| `gnustep-base` | Not in 1.5.0 release: mainline addition occurred after the January release | Added to mainline in the October 2026 GNUstep packaging series | Reuse only on a newer pinned channel; otherwise WARENA needs a backport/new recipe |
| `gnustep-gui` | Not in 1.5.0 release: mainline addition occurred after the January release | Added to mainline in the October 2026 series | Same as Base |
| `gnustep-back` | Not in 1.5.0 release: mainline addition occurred after the January release | Added to mainline in the October 2026 series | Same as Base; verify X11 backend build/runtime |
| `libs-av`, `libs-steptalk`, `libs-opal`, `libs-corebase`, `libs-quartzcore` | No matching Guix package confirmed by this audit | No relevant package definition established | Do not package until actual Gershwin component dependency proves necessity |
| Gershwin applications and system domain | No WARENA Guix package recipes evidenced | No upstream Guix desktop integration evidenced | New WARENA recipes and Guix Home/System session integration required |

**Release-vs-mainline consequence:** the October 2026 Guix additions of Base, GUI and Backend are useful future reuse candidates, but cannot be assumed available to the user's Guix 1.5.0 / RDE 0.6.0 setup. A WARENA packaging channel must explicitly choose either (A) strict Guix 1.5.0 compatibility with backported/new recipes, or (B) a separately pinned newer Guix channel that already contains the GNUstep framework packages. Do not silently mix the two.

## 8. Guix package architecture

Package each upstream source independently and use the actual build graph:

- `libdispatch`: CMake recipe, Clang/LLVM, BlocksRuntime headers and library.
- `tools-make`: Autotools recipe; patch FHS/System paths and configure the GNUstep library combo.
- `libobjc2`: CMake recipe; Clang/Clang++, robin-map, BlocksRuntime and explicit ABI.
- `gnustep-base`: package after runtime and make; patch all generated config and domain paths.
- `gnustep-gui`: package after Base.
- `gnustep-back`: separate backend package, initially X.Org/X11.
- `libs-av`: package only if required by the selected Gershwin component set.
- Gershwin system/assets and each app: separate recipes with pinned source and explicit resources/framework paths.
- Session: a Guix Home/System integration package or service layer that launches the selected session, not an independent display manager.

Upstream's `/System/Library` assumptions must be translated into declared outputs. GNUstep's domains, frameworks, bundles, resources, defaults, application lookup and dynamic backend selection all need tests with isolated Guix store paths. No build phase may write to the host `/System`, `/usr`, `/etc` or home directory.

## 9. Validation gates and current result

| Gate | Evidence required | Current result |
|---|---|---|
| G0 source graph | All repos, immutable commits, source hashes | Partial; 9 external short pins resolved, dispatch SHA and hashes remain |
| G1 licensing | License metadata and per-file notices for all sources | Partial; four roots not found and third-party code not audited |
| G2 Guix 1.5.0 inventory | `guix describe`, `guix show`, package definitions from the exact channel | Not run; no target Guix host/channel access in this task |
| G3 GNUstep core | Clean Guix builds and Foundation test application | Not run |
| G4 GUI backend | GNUstep GUI app on X.Org with backend bundle discovery | Not run |
| G5 Gershwin components | Each app builds and launches with declared dependencies | Not run |
| G6 session | Login/logout, crash recovery, TTY fallback, one display-manager owner | Not run |
| G7 reproducibility | Clean offline rebuild and complete closure manifest | Not run |
| G8 hardware | Named host, display/input/network/suspend tests | Not run |

**Current decision:** source graph and build order are sufficiently understood to proceed with package design, but a Guix build or desktop prototype is not yet proven. The immediate hard blockers are the exact Guix 1.5.0 inventory, the unresolved libdispatch source SHA, license completion, and the Objective-C runtime/toolchain integration test.

## 10. Required target-host commands

Run these on the installed Guix/RDE target before choosing the packaging branch:

```sh
guix describe
for p in libobjc2 libdispatch gnustep-make gnustep-base gnustep-gui gnustep-back; do
  printf '\\n===== %s =====\\n' "$p"
  guix show "$p" || true
done
```

Then test package builds in dependency order, without installing to the host profile:

```sh
guix build libobjc2
guix build libdispatch
guix build gnustep-make
```

Do not build `gnustep-base`, `gnustep-gui`, or `gnustep-back` until the package availability check and Clang/libobjc2 runtime selection are resolved. Do not enable Gershwin LoginWindow alongside another display manager.

## References

- [Gershwin developer checkout script](https://github.com/gershwin-desktop/gershwin-developer/blob/main/Library/Scripts/checkout.sh)
- [Gershwin developer build/install script](https://github.com/gershwin-desktop/gershwin-developer/blob/main/Library/Scripts/install-system-domain.sh)
- [Gershwin developer README](https://github.com/gershwin-desktop/gershwin-developer)
- [GNUstep source and release inventory](https://www.gnustep.org/resources/downloads.html)
- [GNUstep Make installation and runtime configuration](https://github.com/gnustep/tools-make/blob/master/INSTALL)
- [Guix 1.5.0 release announcement](https://lists.gnu.org/archive/html/info-gnu/2026-01/msg00004.html)
- [Guix mainline libobjc2 update](https://www.mail-archive.com/guix-commits%40gnu.org/msg385172.html)
- [Guix mainline GNUstep package additions](https://www.mail-archive.com/guix-commits%40gnu.org/msg399717.html)
- [Guix mainline GNUstep Base packaging fix](https://www.mail-archive.com/guix-commits%40gnu.org/msg402151.html)
