# WARENA desktop profiles (summary)

**Updated:** 2026-10-30 · pins: [PINS-RDE-GUIX-DWL-GUILE-2026-10-30.md](./PINS-RDE-GUIX-DWL-GUILE-2026-10-30.md)

| Profile ID | Stack | Pin anchors (research) | Maturity intent | Notes |
|------------|-------|------------------------|-----------------|-------|
| `wayland-stable` | Sway | Guix 1.5.0 or locked channel · RDE 0.6.0 path | Daily / reference | Lowest Wayland ops risk; RDE live ISO uses Sway |
| `wayland-scheme` | dwl-guile | **v2.0.2** / `c671e3d…` · home-service-dwl-guile intro `314453a…` | RESEARCH | Guile config/REPL; verify wlroots/dwl at build |
| `x11-gnustep` | Gershwin | (unpinned this pass) | RESEARCH | Full DE study |
| `x11-minimal` | Window Maker | (unpinned this pass) | Fallback / compare | Minimal NeXT-like WM |

Promote to LIVE only after [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) qualification gate and host evidence in [STACK-REGISTER.md](./STACK-REGISTER.md).
