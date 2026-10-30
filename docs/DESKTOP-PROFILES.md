# WARENA desktop profiles (summary)

| Profile ID | Stack | Maturity intent | Notes |
|------------|-------|-----------------|-------|
| `wayland-stable` | Sway | Reference candidate | Lowest Wayland ops risk |
| `wayland-scheme` | dwl-guile | RESEARCH | Guile config/REPL; pin wlroots/dwl baseline |
| `x11-gnustep` | Gershwin | RESEARCH | Full DE study |
| `x11-minimal` | Window Maker | Fallback / compare | Minimal NeXT-like WM |

Promote to LIVE only after [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) qualification gate.


## Upstream qualification — 2026-10-30

These are profile intents, not deployed profiles. Source snapshots and channel introductions are recorded in [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md).

- Sway is the reference Wayland candidate; no WARENA build or host validation is claimed.
- dwl-guile remains experimental. Its observed upstream source is based on dwl v0.4 and wlroots 0.16.x; compatibility with the selected Guix/RDE channel set is unverified.
- Do not promote any profile to LIVE without immutable inputs, a successful build, target-hardware tests, failure recovery and operator acceptance.
