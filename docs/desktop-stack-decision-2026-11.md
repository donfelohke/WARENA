# Desktop Stack Decision — Nix, Niri, Noctalia and Alternatives

**Document ID:** WARENA-DSD-2026-11  
**Date:** 2026-11-07  
**Status:** RESEARCH DECISION / NOT A DEPLOYMENT  
**Owner:** WARENA Systems  
**Governing rule:** specification ≠ implementation ≠ verification ≠ deployment.

## 1. Decision summary

Keep **GNU Guix + RDE** as the preferred WARENA system-management and reproducibility research foundation. Evaluate **Niri + Noctalia v5** as the leading practical Wayland desktop combination. Retain **Sway** as the conservative compositor baseline and **dwl-guile** as a separate Guile-native research track. Benchmark **Nix/NixOS** as an alternative declarative ecosystem; do not silently migrate the WARENA baseline to NixOS.

This is a documentation and evaluation decision only. It does not authorize host changes, package installation, service activation, deployment, or a production migration.

## 2. Layer separation

| Layer | Primary candidate | Alternatives / comparators | Responsibility |
|---|---|---|---|
| System and package management | GNU Guix + RDE | Nix/NixOS; Fedora Silverblue | Packages, system generations, declared environments |
| Wayland compositor | Niri | Sway, Hyprland, MangoWC, labwc, dwl-guile | Window placement, input, outputs, workspaces |
| Desktop shell | Noctalia v5 | DankMaterialShell (DMS), Waybar, custom Quickshell | Panels, launcher, notifications, OSD and desktop controls |
| Application delivery | Guix packages | Flatpak, Nix profiles, distro packages | Application packaging and isolation |
| Configuration | Guix + RDE | Nix flakes, Home Manager, declarative dotfiles | Versioned user and system configuration |

Do not treat Nix, Nixpkgs, NixOS, Niri and Noctalia as interchangeable:
- **Nix** is the package manager and build system.
- **Nixpkgs** is its package collection.
- **NixOS** is a Linux distribution configured with Nix.
- **Niri** is a Wayland compositor.
- **Noctalia** is a desktop shell.

## 3. Current evidence and packaging notes

### Noctalia v5

The upstream installation documentation lists GNU Guix and NixOS among supported distribution routes. It documents a Guix channel at github:noctalia-dev/noctalia, providing noctalia-git through the (noctalia) module. The main Guix package is noctalia-shell in (gnu packages window-management); the upstream docs warn that the main channel can lag and that alternative channels may require local compilation without substitutes.

Noctalia v5 is a fresh implementation, not an in-place upgrade from v4; v4 settings are not migrated. Pin the selected release/channel commit and validate runtime dependencies before using it in a declared home environment.

The upstream release index surfaced v5.4.1 (29 October 2026) as the latest tagged release during this review. This is a time-stamped research observation, not a permanent pin. Choose a full commit or release tag in any reproducible experiment.

### Niri and shell compatibility

Noctalia documents compositor-specific integration for Niri and other Wayland compositors. Its Niri integration is a reason to test the pair, not proof that every feature works on every graphics stack. Verify portals, screen capture, notifications, lock/idle, display hot-plug, input and multi-monitor behaviour on the target hardware.

### Alternatives

- **Sway:** conservative baseline and fallback comparator.
- **Hyprland:** feature-rich alternative; evaluate complexity, resource use and operational fit rather than visual features alone.
- **MangoWC / labwc:** alternative compositor integration candidates.
- **dwl-guile:** WARENA's Guile-native research track; not a production replacement for Niri.
- **DankMaterialShell:** direct shell comparator for Niri; do not run two shells' bars/notifications concurrently without an explicit integration plan.
- **Waybar:** component/status bar, not a complete shell replacement.
- **Flatpak:** complementary application delivery, not a replacement for Guix or Nix system configuration.
- **Fedora Silverblue:** immutable-image Linux comparator; different operational model from Guix/Nix.

## 4. Recommended WARENA configurations

### Practical workstation evaluation
- GNU Guix + RDE
- Niri
- Noctalia v5
- Sway available as fallback session
- Flatpak only where package availability or application isolation justifies it

### Declarative alternative benchmark
- NixOS
- Niri
- Noctalia v5
- Flake inputs pinned in flake.lock
- Same user configuration and workload as the Guix test

### Guile-native research
- Guix + RDE
- dwl-guile
- Noctalia v5 only after protocol and compositor integration checks
- Keep separate from the daily-driver configuration

## 5. Verification matrix

| Area | Required checks | Evidence to retain |
|---|---|---|
| Build and pinning | Exact source revisions, build inputs, closure availability | Lock/channel files, build logs, hashes |
| Session lifecycle | Login, shell start, shell crash, compositor restart | Reproducible test log |
| Displays | Scaling, multi-monitor, hot-plug, resolution changes | Hardware/driver matrix |
| Input | Keyboard layouts, pointer, touch, shortcuts | Test results |
| Desktop services | Notifications, audio, network, Bluetooth, portals | Functional checks |
| Security | Locking, screen capture permission, clipboard, secrets | Threat/control notes |
| Recovery | TTY access, fallback session, rollback | Recovery runbook |
| Offline operation | Install/rebuild/rollback without WAN | Cached closure and channel/source inventory |

No test result should be marked PASS until performed on identified hardware with versions and logs. A successful build is not proof of a working desktop session.

## 6. Decision gates

1. **DS-00 — source audit:** record upstream releases, packaging ownership, Guix/Nix availability and licence.
2. **DS-01 — package build:** build pinned Niri and Noctalia v5 packages in Guix; record substitute versus local-build status.
3. **DS-02 — session test:** run Niri + Noctalia on a disposable profile or VM; test portals, audio, notifications and recovery.
4. **DS-03 — comparator:** reproduce the same workload on NixOS; compare build closure, update, rollback and offline recovery.
5. **DS-04 — shell comparison:** compare Noctalia and DMS on the same compositor and hardware.
6. **DS-05 — production proposal:** only after evidence review, issue a separate explicit deployment proposal.

## 7. Non-goals and constraints

- No production migration to NixOS is approved.
- No host configuration or live package installation is authorized by this document.
- No claim that Niri, Noctalia or dwl-guile is installed on a WARENA host.
- No implication that Noctalia v5 settings migrate from v4.
- No assumption that package presence guarantees substitutes, offline completeness or hardware compatibility.
- Preserve human control, inspectability, local-first operation and a working recovery path.

## 8. Upstream references

- Noctalia installation (v5+): https://docs.noctalia.dev/noctalia/getting-started/installation/
- Noctalia v5 documentation: https://docs.noctalia.dev/noctalia/v5.3.0/
- Noctalia releases: https://github.com/noctalia-dev/noctalia/releases
- Noctalia NixOS packaging notes: https://wiki.nixos.org/wiki/Noctalia_Shell
- Niri getting started: https://github.com/niri-wm/niri/wiki/Getting-Started
- Nix manual: https://nix.dev/manual/nix/latest/
- NixOS manual: https://nixos.org/manual/nixos/stable/
- GNU Guix manual: https://guix.gnu.org/manual/

**Review note:** Re-check upstream docs and package definitions immediately before implementation. Documentation links are evidence pointers, not immutable pins.
