# WARENA — RDE · Guix · dwl-guile revision pins

**Status:** RESEARCH · upstream anchors only  
**Date:** 2026-10-30  
**Rule:** Documented version ≠ installed package ≠ operational session.

Related: [STACK-REGISTER.md](./STACK-REGISTER.md) · [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) · [DESKTOP-PROFILES.md](./DESKTOP-PROFILES.md)

---

## 1. Primary pins

| Component | Pin type | Value | Notes |
|-----------|----------|--------|------|
| GNU Guix | Release | **1.5.0** (2026-01-23) | Installer/ISO/binary baseline |
| GNU Guix | Rolling lock | **UNKNOWN** until `guix describe` | Mandatory for reproducible freezes |
| RDE | Documented release | **0.6.0** | Manual + live image series |
| RDE Live ISO | Filename | `rde-live-0.6.0-x86_64.iso` | From files.trop.in/rde/ — **Sway path, not dwl-guile** |
| RDE channel intro | Commit | `257cebd587b66e4d865b3537a9a88cccd7107c95` | Published channel introduction |
| dwl-guile | Tag | **v2.0.2** | Latest release as of research pass |
| dwl-guile | Commit | `c671e3d17996040447765976f7be58819e9181ec` | Tag tip |
| dwl base (claimed) | Upstream README | **dwl 0.4** + **wlroots 0.16.x** | Verify at Guix build time |
| home-service-dwl-guile | Channel intro | `314453a87634d67e914cfdf51d357638902dd9fe` | From project README |

### Sources

- Guix 1.5.0: https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/
- RDE manual (0.6.0): https://trop.in/rde/manual
- RDE ISO directory: http://files.trop.in/rde/
- RDE channel (GitHub mirror): https://github.com/abcdw/rde
- dwl-guile v2.0.2: https://github.com/engstrand-config/dwl-guile/releases/tag/v2.0.2
- home-service-dwl-guile: https://github.com/engstrand-config/home-service-dwl-guile

---

## 2. Important distinctions

| Requirement | Finding |
|-------------|--------|
| Official RDE live ISO | Available (**Sway**) |
| Ready-made RDE + dwl-guile live ISO | **Not established** |
| Engstrand guix-dotfiles | ISO *build* + RDE feature composition reference |
| dwl-guile Guix Home service | Available as channel |

Do **not** treat the official RDE live ISO as a dwl-guile pin.

---

## 3. Profile application

| Profile ID | Pins used |
|------------|-----------|
| `wayland-stable` | Guix (1.5.0 or locked channel) + RDE 0.6.0 path + **Sway** |
| `wayland-scheme` | Same Guix/RDE lock + **dwl-guile v2.0.2** via home-service-dwl-guile |

---

## 4. Illustrative channels.scm (template only)

```scheme
;; RESEARCH template — paste Guix commit from `guix describe` before freeze
(list
 (channel
  (name 'guix)
  (url "https://git.savannah.gnu.org/git/guix.git")
  ;; (commit "PASTE-FROM-guix-describe")
  (branch "master"))

 (channel
  (name 'rde)
  (url "https://git.sr.ht/~abcdw/rde")
  (introduction
   (make-channel-introduction
    "257cebd587b66e4d865b3537a9a88cccd7107c95"
    (openpgp-fingerprint
     "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))

 (channel
  (name 'home-service-dwl-guile)
  (url "https://github.com/engstrand-config/home-service-dwl-guile")
  (branch "main")
  (introduction
   (make-channel-introduction
    "314453a87634d67e914cfdf51d357638902dd9fe"
    (openpgp-fingerprint
     "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C")))))
```

---

## 5. Freeze procedure (acceptance)

On a Guix host:

```bash
guix describe -f channels > channels-lock.scm
# add/freeze rde + home-service-dwl-guile commits
guix pull -C channels-lock.scm
guix describe > guix-describe-$(date -I).txt
```

Record: lock file, describe output, built dwl-guile version, host, date, and pass/fail for session start, keybind, config reload, Sway fallback.

---

## 6. Status

| Item | State |
|------|--------|
| Upstream version anchors | Documented |
| Guix channel commit for WARENA freeze | **UNKNOWN** |
| Build/test on target hardware | **Not done** in this document |
| LIVE claim | **No** |

**Next:** obtain `guix describe` on a real host; attempt Profile B build against dwl-guile `c671e3d…`.
