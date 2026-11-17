# Guile-WM / WM-NG — X11 Session and Guix Packaging Audit

**Review date:** 2026-11-18  
**Status:** RESEARCH / ARCHITECTURE AND PACKAGE PLAN — NOT IMPLEMENTED  
**Owner:** `donfelohke/WARENA`  
**Target display stack:** X.Org first; XLibre separately qualified  
**Track boundary:** This document concerns the X11 WM-NG proposal. It does not describe the Wayland `dwl-guile` compositor.

## 1. Executive decision

There are two different projects that must not be conflated:

1. **Legacy Guile-WM** (`mwitmer/guile-wm`) is a Scheme-first X11 window-manager toolkit built on **Guile-XCB**. Its upstream build files explicitly support Guile 2.0/2.2, not Guile 3. Its last observed upstream commit is from July 2019.
2. **WARENA WM-NG** is a new X11 architecture proposal: a reusable native `wmng-core` owns XCB, WM selection and authoritative window state; Guile 3 supplies policy; GWorkspace remains a peer, not part of the core. No WM-NG source tree or validated package exists yet.

**Decision:** do not relabel the old Guile-WM package as WM-NG and do not simply replace its Guile 2.2 input with Guile 3.0. Keep the legacy project as a comparator. Build WM-NG only after its native source and API exist and Gate A closes.

## 2. Upstream and WARENA repository evidence

| Repository / document | Role | Current evidence |
|---|---|---|
| [mwitmer/guile-wm](https://github.com/mwitmer/guile-wm) | Legacy Guile-first X11 WM toolkit | Last observed commit 2019-07-08; no GitHub releases listed |
| [mwitmer/guile-xcb](https://github.com/mwitmer/guile-xcb) | Scheme implementation of XCB protocol/client stack | Last observed commit 2017-05-28; configure checks Guile 2.0/2.2 |
| [donfelohke/WARENA](https://github.com/donfelohke/WARENA) | WARENA policy/configuration home | No WM-NG source, package recipe, channel, Guix Home or session implementation evidenced on main |
| [WM-NG reusable core proposal](https://github.com/donfelohke/WARENA/blob/docs/wm-ng-reusable-core-2026-10-28/docs/WM-NG-REUSABLE-CORE.md) | Earlier architecture and acceptance gates | Proposal only; native core not implemented |
| [donfelohke/dwl-guile](https://github.com/donfelohke/dwl-guile) | Separate Guile-configurable Wayland compositor | Experimental Wayland track; not WM-NG |
| [donfelohke/home-service-dwl-guile](https://github.com/donfelohke/home-service-dwl-guile) | Guix Home service for dwl-guile | WIP service; not a template for an X11 WM-NG session |

### Legacy upstream status

The legacy Guile-WM README describes:
- a framework for creating X11 window managers and other X applications;
- configurable Scheme modules and a user init file;
- tiling and drag/drop WM examples, keymaps/minibuffer and a built-in REPL;
- partial ICCCM support;
- a wish list that still includes window decorations and additional desktop facilities.

Guile-XCB describes itself as a Scheme implementation of the XCB client stack, generating Guile object code from X protocol XML. Its own README says many extensions have not been tested and large requests may be slow. It uses a Scheme Xauth implementation with UNIX-socket-only support and limited cookie selection.

The latest observed legacy commits:
- Guile-WM: `38916e00713482b4514898181ee3e0e9b5db3a4a` (2019-07-08).
- Guile-XCB: `db7d5a393cc37a56f66541b3f33938b40c6f35b3` (2017-05-28).

These repositories are not currently maintained against Guile 3 in the evidence reviewed here.

## 3. Existing Guix package versus WM-NG

Guix has historically carried a `gnu/packages/guile-wm.scm` module with `guile-xcb` and `guile-wm` package definitions. The published Guix 1.4 source shows the dependency chain:

| Legacy package | Dependency / build behaviour |
|---|---|
| `guile-xcb` | Guile 2.2 and `xcb-proto`; Scheme modules and compiled `.go` files |
| `guile-wm` | Guile 2.2 and Guile-XCB; GNU build system; installs a `guile-wm.desktop` X session entry |

The Guile-WM package's install phase wraps `guile-wm` with the Guile module and compiled-module paths for both projects, and creates `$out/share/xsessions/guile-wm.desktop`.

This is useful historical packaging evidence. It is **not** proof that the same package definitions, versions or build results are present in the user's exact Guix 1.5.0 channel. Confirm on the target with `guix show guile-wm guile-xcb guile-3.0 libxcb xcb-util-wm` and record `guix describe`.

### Compatibility verdict

| Question | Finding |
|---|---|
| Is legacy Guile-WM a Guile 3 application? | No evidence; configure checks Guile 2.0/2.2 |
| Is Guile-XCB ready for Guile 3? | No evidence; configure checks Guile 2.0/2.2 |
| Can we just substitute `guile-3.0` in the old package? | No. Requires source/API compatibility work and a test suite |
| Is legacy Guile-WM a suitable implementation base for WM-NG? | Not selected; its Scheme-owned XCB stack conflicts with WM-NG's native-XCB ownership decision |
| Can it remain a comparison/reference? | Yes, clearly marked LEGACY / RESEARCH |

Do not patch the old package in-place or claim Guile 3 compatibility without a separate fork, compatibility test matrix and explicit decision.

## 4. WM-NG architecture boundary

The intended layering is:

```text
X.Org server (initial baseline)
        |
        v
wmng-core — native C / libxcb
  - owns XCB connection and WM selection
  - owns protocol resources and authoritative window state
  - validates every requested action
  - implements the agreed ICCCM/EWMH subset
        |
        v
Guile 3 policy layer
  - layouts, bindings, rules and user policy
  - no direct ownership of XCB pointers or connection
  - returns validated high-level actions
        |
        v
Session / host integration
  - X session entry and environment
  - optional minimal GNUstep host (kept outside core)
  - GWorkspace remains a separate peer
```

**Non-negotiable ownership:** only the native core owns the XCB connection, root-window event selection and window-state mutation. Guile policy must not retain unmanaged XCB pointers or independently issue raw protocol mutations.

### Open design decision — embedded versus separate policy process

The October WM-NG proposal describes embedded Guile in the native core. Earlier architecture discussion also considered a separate Guile policy service over local IPC for fault isolation. The initial PoC must explicitly choose one:

- **Embedded Guile:** smaller first implementation and no IPC protocol, but a blocking or faulty Scheme callback can affect the compositor process. The native event loop must never invoke unbounded policy synchronously.
- **Separate Guile policy process:** stronger restart/isolation boundary, but requires a versioned local IPC schema, timeouts, stale-response handling and policy/core state reconciliation.

Do not mix both models in one initial package. Record the decision before Gate B.

## 5. Guix dependency and packaging plan

The package names below are known Guix package candidates from the package collection. Exact versions and availability must still be confirmed against the selected Guix 1.5.0 channel with `guix show`.

| Layer | Guix package candidates | Classification | Notes |
|---|---|---|---|
| Guile runtime | `guile-3.0` | EXISTING | Guile 3 is the target policy runtime; link using `pkg-config guile-3.0` |
| Native XCB | `libxcb` | EXISTING | Core transport; direct C API |
| ICCCM/EWMH | `xcb-util-wm` | EXISTING | Provides `xcb-ewmh` and `xcb-icccm` helpers |
| Key symbols | `xcb-util-keysyms` | EXISTING | Optional convenience layer for keyboard bindings |
| Cursor helpers | `xcb-util-cursor` | EXISTING | Optional; do not add unless required |
| XKB | `libxkbcommon` and/or XCB XKB extension support | EXISTING candidate | Select one consistent keyboard model after API design |
| Build tooling | `pkg-config`, `make`, `gcc-toolchain` | EXISTING | Native C toolchain; C17 baseline proposed |
| Nested test server | `xorg-server` / Xephyr component | PACKAGE NAME TO CONFIRM | Verify Xephyr binary is available in selected Guix channel |
| X authority | `xauth` | EXISTING candidate | Use proper authority; never rely on `-ac` outside isolated local tests |
| Optional GNUstep host | GNUstep Base/GUI/Backend | CHANNEL-DEPENDENT | Not part of the native WM core; check 1.5.0 availability separately |
| WM-NG core | `wmng-core` | NEW — no source tree yet | Do not write a Guix recipe until source/build/test contract exists |
| WM-NG policy | `wmng-policy` or embedded Guile module | NEW — no source tree yet | Narrow action API and failure semantics required |
| Session integration | `wmng-session` / X session entry | NEW — after prototype | Must not become a display manager or start a competing X server |

The Guix package collection's `xcb-util-wm` package provides both EWMH and ICCCM helpers and propagates `libxcb`. This is the preferred reuse point rather than writing a duplicate protocol helper library. The Guix package `xcb-util-keysyms` is available for key-symbol conversions.

### Proposed package split

1. **wmng-core** — native shared/static library or executable (choose after the API is designed); libxcb and xcb-util-wm as direct inputs.
2. **wmng-policy** — Guile 3 module/runtime integration. Guile is policy only; no direct XCB connection.
3. **wmng-session** — X session desktop entry, launch wrapper and declared environment. Keep session package independent of display-manager implementation.
4. **wmng-host-gnustep** — optional future host application; GNUstep must not be a required dependency of `wmng-core`.
5. **GWorkspace** — separate peer, added only after core ICCCM/EWMH tests pass.

Do not add Guile-XCB to WM-NG. Do not package GWorkspace into the WM. Do not create a Guix channel or RDE module merely to fill a template; first identify the actual host configuration path and channel revisions.

## 6. Guile 3 embedding requirements

GNU Guile's C API supports embedding and extension. The official manual documents `libguile.h`, `pkg-config guile-3.0 --cflags --libs`, `scm_with_guile`, and `scm_c_catch`.

Minimum proof:
- initialize Guile safely in the chosen thread model;
- load a minimal WARENA policy module from a declared store path;
- register only high-level WM actions and read-only state accessors;
- catch Scheme exceptions at the native boundary;
- validate arguments and object/window identifiers before any protocol operation;
- prevent long-running Scheme code from starving the XCB event loop;
- define deterministic shutdown and policy reload semantics;
- keep the default session usable without a REPL or remote evaluation endpoint.

A REPL is a privileged control interface. It must be disabled by default in the session profile and restricted to the local user if a later development mode enables it.

## 7. X11 protocol and test plan

ICCCM defines baseline client/window-manager conventions. EWMH extends these for desktop environments, compositors and utilities. Implement a deliberately small advertised subset first; never publish an EWMH atom in `_NET_SUPPORTED` until its behaviour is implemented and tested.

### Gate B — native core in Xephyr

1. Start Xephyr as an isolated nested X server on a dedicated display.
2. Connect WM-NG and acquire the WM selection/root event redirection.
3. Verify a second WM-NG process or another WM is rejected cleanly; do not steal the selection.
4. Map, configure, focus, unmap and destroy a simple test client.
5. Exercise WM_DELETE_WINDOW, WM_TAKE_FOCUS and normal ICCCM client lifecycle.
6. Publish only the EWMH properties and actions implemented.
7. Stop the WM cleanly and verify the nested server remains usable.
8. Repeat with malformed client properties and unexpected X events.

Xephyr is specifically designed as a nested X server for WM development and X server/client testing. Use it before any real desktop session. Keep X.Org as the first profile; qualify XLibre separately.

### Gate C — Guile policy

- Scheme layout/rule success and reload;
- malformed return values and exceptions;
- time-budget / long-running policy behaviour;
- stale or destroyed window identifiers;
- native-core fallback when policy is unavailable;
- clean shutdown and restart;
- no raw XCB pointer exposure to Scheme.

### Gate D — session integration

- explicit `wmng.desktop` session entry under `share/xsessions`;
- start under the selected display manager, which remains the sole X server/session owner;
- correct environment and log path;
- logout, crash, restart and TTY recovery;
- no autostart-on-first-TTY behaviour copied from the unrelated dwl-guile Home service;
- optional GWorkspace interoperability after core acceptance.

## 8. Current gate status

| Gate | Required evidence | Status |
|---|---|---|
| A — architecture and package inventory | C API, policy process model, feature subset, exact Guix channel/package inventory | PARTIAL; architectural proposal exists, process boundary and exact target channel remain open |
| B — native XCB core | Compilable source and Xephyr tests | NOT STARTED — no source tree |
| C — Guile 3 policy | Embedding/IPC tests and fault isolation | NOT STARTED |
| D — session | X session entry and login/recovery tests | NOT STARTED |
| Host qualification | Named hardware, X.Org, input/display and recovery logs | NOT STARTED |

**Current maturity:** RESEARCH / PROPOSAL. No Guile-WM session package has been built, no WM-NG code exists in WARENA main, and no session has been installed or deployed.

## 9. Immediate work queue

1. Capture the exact Guix 1.5.0 channel with `guix describe`; query `guile-wm`, `guile-xcb`, `guile-3.0`, `libxcb`, `xcb-util-wm`, `xcb-util-keysyms`, `libxkbcommon`, `xorg-server` and `xauth`.
2. Decide embedded Guile versus separate local policy process.
3. Freeze the minimum ICCCM/EWMH feature set and C API.
4. Create a minimal native XCB proof-of-concept source tree only after Gate A is approved.
5. Run the WM-selection and client lifecycle suite in Xephyr.
6. Integrate Guile 3 behind a narrow, validated action interface.
7. Add the X session package only after Gate B/C pass.
8. Keep legacy Guile-WM and dwl-guile as separate comparators.

## References

- [Legacy Guile-WM source](https://github.com/mwitmer/guile-wm)
- [Legacy Guile-XCB source](https://github.com/mwitmer/guile-xcb)
- [GNU Guile library catalogue — Guile-WM and Guile-XCB are listed for Guile 2.2](https://www.gnu.org/software/guile/libraries/)
- [Historical Guix 1.4 Guile-WM/Guile-XCB package definitions](https://sources.debian.org/src/guix/1.4.0%2B154928%2Bf1810-1/gnu/packages/guile-wm.scm)
- [Guix 2026 package collection contains `guile-wm.scm`](https://mirrors.hust.edu.cn/git/guix.git/tree/gnu/packages?h=core-packages-team-2026-07-21)
- [Guix package: xcb-util-wm](https://toys.whereis.social/?show=xcb-util-wm)
- [Guix package: xcb-util-keysyms](https://toys.whereis.social/?show=xcb-util-keysyms)
- [GNU Guile Reference Manual — embedding](https://www.gnu.org/software/guile/manual/guile.pdf)
- [ICCCM / EWMH specification](https://specifications.freedesktop.org/wm/latest-single/)
- [Xephyr documentation](https://wiki.freedesktop.org/www/Software/Xephyr/)
- [Earlier WARENA WM-NG design](https://github.com/donfelohke/WARENA/blob/docs/wm-ng-reusable-core-2026-10-28/docs/WM-NG-REUSABLE-CORE.md)
