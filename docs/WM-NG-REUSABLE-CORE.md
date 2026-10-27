# WARENA WM-NG — Reusable Core Design

**Status:** PROPOSAL / RESEARCH  
**Date:** 2026-10-28  
**Maturity:** Not implemented. Not LIVE. Documentation only.

This document records the architectural concurrence for a reusable native window-management core (`wmng-core`) with a minimal GNUstep host and embedded Guile policy. It preserves the 2004 insight of a reusable WM core and a thin host without requiring XWiRE’s historical bundle-first packaging.

---

## Confirmed decisions

| Choice | Verdict |
|--------|---------|
| **Library first, bundle later** | Correct — reuse without unload/plugin complexity |
| **Native core owns XCB + WM selection** | Non-negotiable |
| **Guile = policy only** | Propose; native core validates |
| **GWorkspace = peer shell** | Do not merge into the WM |
| **Standalone process optional** | Same core, second host — decide later |
| **Serialized events first** | Avoid concurrent window-state mutation in PoC |

---

## Shape

```
┌──────────────────────┐
│  Minimal GNUstep host │  lifecycle, optional UI
└──────────┬───────────┘
           │ links
┌──────────▼───────────┐
│  wmng-core (library)  │  WMNGStart/Stop, events, ApplyAction
│  + embedded Guile     │  layouts, binds, rules (high-level only)
│  + libxcb adapter     │  ownership, ICCCM/EWMH subset
└──────────┬───────────┘
           │
┌──────────▼───────────┐
│  X server (Xephyr)    │
└──────────────────────┘

   GWorkspace ── peer ── struts / workarea / focus via standards
```

### Packaging stages (proposed sequence)

1. **Stage 1 — `wmng-core` native library**  
   Window-management state, lifecycle, protocol coordination, stable C-facing API. Link into a minimal GNUstep host or a dedicated WM executable.

2. **Stage 2 — optional GNUstep bundle adapter**  
   Add a loadable bundle only if a real host needs runtime discovery. Keep the interface small and versioned.

3. **Stage 3 — optional standalone host**  
   Reuse the same core in a dedicated process if isolation or a non-GNUstep host becomes necessary.

A library should not need to be unloadable to be reusable. Bundle loading is not a prerequisite for Stage 1.

---

## Illustrative native API surface

Names are illustrative. Signatures, ownership rules, and error model remain to be designed before coding.

| Interface area | Proposed responsibility |
|----------------|-------------------------|
| `WMNGCreate` / `WMNGDestroy` | Allocate and release a core instance |
| `WMNGStart` / `WMNGStop` | Begin and end WM ownership and event processing safely |
| `WMNGGetFileDescriptor` | Expose the XCB connection descriptor for event-loop integration, if appropriate |
| `WMNGDispatchEvents` | Process pending protocol events and update managed state |
| `WMNGApplyAction` | Validate and execute a high-level action from policy |
| `WMNGGetState` | Return read-only snapshots for inspection and UI |

The core owns the XCB connection and protocol resources. The host must not close that connection directly. Guile must not retain unmanaged XCB pointers.

### Scheme boundary (examples only)

```scheme
(set-layout! 'master-stack)
(focus-window window-id)
(move-window-to-workspace window-id 2)
(register-rule! my-window-rule)
```

Policy proposes; the native core validates. Malformed rules must not corrupt core state, bypass ownership checks, or leak protocol resources.

---

## What to lock before any code

1. **C API contract** — create/destroy, start/stop, fd or dispatch, apply-action, get-state, error model  
2. **Version pins** — Guile 3.x, libxcb, GNUstep base/gui/backend, GWorkspace  
3. **Xephyr gates** — WM selection conflict, map/focus/destroy one client, clean stop  
4. **No GWorkspace in gate 1** — add desktop integration only after core clients work  

### Event-loop note

Evaluate either (a) XCB readiness on the GNUstep run loop, or (b) an explicit native coordinator. First prototype: serialized event handling only.

### X11 ownership

WM-NG must acquire window-manager selection and root event selection, refuse when another WM is active, and implement required ICCCM behaviour with progressive EWMH support. GWorkspace remains a separate desktop/file application interoperating via standard conventions (work area, struts, focus).

---

## Relation to the 2004 GWorkspace / XWiRE discussion

Historical lead: discuss-gnustep thread “gworkspace desktop as wm?” (August 2004). Banlu Kemiyatorn described Window Manager Core / XWiRE as a pre-alpha bundle that a host app could load to become a WM. Source recovery of XWiRE was not established in later research; treat it as HISTORICAL design inspiration only.

| 2004 idea | WM-NG study |
|-----------|-------------|
| Loadable WM core | Same idea; **library** first, bundle optional |
| Thin host (`TestWM`) | Minimal GNUstep host |
| “Any app becomes WM” | Possible later via same core |
| Pre-alpha honesty | RESEARCH / no LIVE claim |

---

## Decision matrix

| Question | Current recommendation |
|----------|------------------------|
| Native core or bundle first? | Native library first |
| GNUstep host or Scheme host? | Minimal GNUstep host initially |
| X11 mechanism | Direct libxcb behind an adapter |
| Guile integration | Embedded runtime behind a narrow API |
| GWorkspace role | Separate desktop shell |
| Future standalone process? | Preserve the option |
| Runtime plugin loading? | Defer until a concrete requirement exists |

---

## Validation gates (before implementation claims)

- Compatibility inventory (distro, GNUstep, Guile, XCB, GWorkspace versions)  
- Core API review (lifecycle, ownership, errors, policy-action contract)  
- Guile embedding feasibility in the chosen host  
- Xephyr: WM selection, conflict exit, map/configure/focus/destroy  
- Only then: GWorkspace peer integration tests  

---

## Status line

**Proposal only.** Native `wmng-core` library + minimal GNUstep host + embedded Guile + direct libxcb; GWorkspace remains separate. This document does not authorize builds, merges to production hosts, or LIVE maturity claims.

### Related WARENA docs

- `docs/DESKTOP-ARCHITECTURE.md`  
- `docs/DESKTOP-PROFILES.md`  
- `docs/CAPABILITY-MAP.md`  
- `docs/STACK-REGISTER.md`  
- `docs/EVIDENCE-STATUS.md`  
