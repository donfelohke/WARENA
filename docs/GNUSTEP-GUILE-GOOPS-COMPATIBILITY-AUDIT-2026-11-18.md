# GNUstep–Guile Bridge and GOOPS Compatibility Audit

**Review date:** 2026-11-18  
**Owner:** `donfelohke/WARENA`  
**Status:** RESEARCH / COMPATIBILITY FINDING — no package build or runtime test claimed  
**Scope:** GNUstep's historical `libs-guile` bridge, Guile GOOPS, modern GNUstep and WARENA's Gershwin / WM-NG architecture.

## 1. Executive decision

**Do not adopt `gnustep/libs-guile` as the current Guile 3 / GOOPS integration for WARENA.** The upstream project is a historical GNUstep language bridge with an explicitly obsolete dependency target. Its own README says Guile 1.3–1.6; INSTALL requires Guile 1.6 (1.4 may work) and GNUstep Make/Base 1.6-era dependencies; the GNUstep downloads page lists GNUstep-Guile as unsupported and says it requires old GNUstep and Guile versions.

This is a compatibility finding, not a claim that the source is unusable for historical study. No Guile 3 build, Guile 3 runtime test, modern GNUstep integration, or GOOPS interoperability test was performed.

**Recommended WARENA separation:**
- Gershwin remains a native Objective-C / GNUstep desktop track.
- WM-NG remains a separate native XCB core with Guile 3 / GOOPS for policy.
- Do not insert the legacy GNUstep–Guile bridge into either track without a dedicated compatibility prototype and explicit acceptance decision.

## 2. Upstream evidence

Primary source: [gnustep/libs-guile](https://github.com/gnustep/libs-guile), default branch `master`.

Observed repository HEAD during this audit: `0e7d7d800111cee6bcd60bce82dd2c5eeeaeb3f4`, dated 2026-06-27, commit message “Add to ignore”. This recent repository timestamp alone is not evidence of modern Guile compatibility or active API development.

The source files make the compatibility boundary explicit:

| Source | Observed statement | Consequence |
|---|---|---|
| [README](https://github.com/gnustep/libs-guile/blob/master/README) | Says the library should work with Guile 1.3–1.6 inclusive | No Guile 3 support claim |
| [INSTALL](https://github.com/gnustep/libs-guile/blob/master/INSTALL) | Requires Guile 1.6 (1.4 should also work); notes Guile 1.3 does not work fully; requires GNUstep Make/Base 1.6-era stack | Build assumptions predate the current GNUstep / Guile toolchain |
| [NEWS](https://github.com/gnustep/libs-guile/blob/master/NEWS) | Latest listed user-visible release notes are version 1.1.4; version 1.1.0 records support for Guile 1.6 | No documented Guile 2.x or 3.x port in the project's release notes |
| [configure.in](https://github.com/gnustep/libs-guile/blob/master/configure.in) | Uses Autoconf-era configuration, GNUstep environment exports and legacy header/library paths | Requires substantial modernization and store-path review for Guix |
| [Library/GNUmakefile](https://github.com/gnustep/libs-guile/blob/master/Library/GNUmakefile) | Builds Objective-C bridge libraries `libgstep_guile`, `libgg_base`, optional GUI and GDL2 pieces | The bridge is an Objective-C/Guile binding, not a native Guile GOOPS module |

The [official GNUstep downloads page](https://www.gnustep.org/resources/downloads.html) lists GNUstep-Guile as **Unsupported** and states that it requires old versions of GNUstep and Guile. Current GNUstep core releases listed there are GNUstep Make 2.9.3, Base 1.31.1, GUI 0.32.0 and Backend 0.32.0. Those versions are far removed from the historical bridge's documented minimum-era environment.

## 3. What the bridge does — and does not establish

The historical bridge exposes GNUstep / Objective-C classes and objects to Guile scripts. Its companion ScriptKit supports the opposite direction: GNUstep applications can evaluate Guile scripts. The project describes these as complementary interfaces.

That is not equivalent to a modern GOOPS binding:

- Objective-C has its own runtime, class model, selectors, object identity and memory-management rules.
- GOOPS is Guile's Scheme object system: classes, multiple inheritance, generic functions, multi-method dispatch and a metaobject protocol.
- A bridge that wraps Objective-C objects for Guile does not automatically make those Objective-C classes native GOOPS classes, nor does it prove GOOPS generic dispatch can safely invoke Objective-C methods.
- GOOPS is already part of Guile; it is not a separate Objective-C runtime or a replacement for GNUstep's object model.

See the [Guile Reference Manual — GOOPS](https://www.gnu.org/software/guile/manual/guile.html#GOOPS) and the [GNUstep language-interface overview](https://www.gnustep.org/resources/downloads.html).

## 4. WARENA architecture decision

| Concern | Decision |
|---|---|
| Gershwin desktop | Use upstream Objective-C / GNUstep APIs directly. Keep the desktop build and runtime independent of Guile-GNUstep. |
| WM-NG core | Native C / libxcb owns the X connection, protocol resources and authoritative window state. |
| WM-NG policy | Guile 3 / GOOPS expresses layouts, bindings and high-level policy through a narrow validated API. |
| GNUstep host integration | Optional future adapter only; it must not become a dependency of `wmng-core`. |
| Legacy `libs-guile` | LEGACY / REFERENCE. Do not package as a supported Guile 3 bridge. |
| G-Golf | Not a drop-in solution: it targets GObject Introspection and GNOME libraries, not GNUstep's Objective-C runtime. |

This preserves a clean separation between the GNUstep desktop and the Scheme-native WM policy track. It also avoids introducing a second object model into the WM core before the native protocol boundary is stable.

## 5. If modern GNUstep scripting becomes a requirement

Treat it as a new compatibility project, not a version bump to the historical bridge. A minimal proof of concept should:

1. Pin exact GNUstep Make/Base/GUI/Backend, libobjc2, Clang, Guile 3 and compiler versions.
2. Build a small Objective-C GNUstep class and expose a bounded object handle to Guile through the supported Guile C API.
3. Test string, integer, collection, selector, callback and exception conversion.
4. Specify object ownership, retain/release or autorelease interaction, finalization, thread affinity and callback lifetime.
5. Decide whether GOOPS wrappers are thin proxy objects or a true interoperable class layer; do not claim the latter unless inheritance, dispatch and identity semantics are tested.
6. Run the GNUstep test suite plus explicit Guile 3 / GOOPS interoperability tests in an isolated Guix build environment.
7. Verify store-relative library/module discovery, relocatability, offline rebuild and licensing before writing a production package.

Acceptance criteria must include correct lifetime behaviour under garbage collection, no use-after-free, no leaked Objective-C objects, deterministic error propagation, and a clear rule for which runtime owns each object.

## 6. Current status and next gates

| Gate | Status |
|---|---|
| Historical bridge source inspected | DONE — README, INSTALL, NEWS, configure.in, GNUmakefile and ScriptKit README |
| Official GNUstep support status checked | DONE — listed as unsupported |
| GOOPS semantics distinguished from Objective-C | DONE — documentation-level analysis |
| Guile 3 compatibility build | NOT RUN |
| Modern GNUstep compatibility build | NOT RUN |
| GOOPS ↔ Objective-C object interoperability | NOT RUN |
| Guix package definition | NOT CREATED |
| Runtime / desktop integration | NOT IMPLEMENTED |

**Conclusion:** retain GNUstep as the native application framework for Gershwin and Guile 3 / GOOPS as the policy language for WM-NG. Revisit a GNUstep scripting bridge only when there is a concrete application requirement and a separately funded, testable compatibility scope.
