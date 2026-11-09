# WARENA bare-metal materialization — RDE Live ISO → external SSD

**Date:** 2026-11-09  
**Status:** RESEARCH / PROTOCOL DRAFT — not a LIVE host claim  
**Target class:** HP EliteBook 835 G8 (AMD Cezanne / modern laptop Wi-Fi)  
**Bootstrap medium:** `rde-live-0.6.0-x86_64.iso` (ephemeral)  
**Persistent target:** external SSD only (first qualification)

## 1. Architecture distinction

| Concept | Role |
|---------|------|
| RDE Live ISO | Ephemeral bootstrap medium |
| External SSD | Persistent materialization of a declarative Guix system |
| `guix system init` | Compile configuration into the target root |
| Internal NVMe | **Out of scope** until external install boots and recovers |

We are not "installing a distro" in the traditional sense. We materialize a declared operating-system graph onto bare metal.

**Single-declaration principle (refined):** one declarative lineage is correct; the first `init` should still be a **bootable Stage A baseline**. Full RDE features and engstrand `dwl-guile` Home are Stage B/C via `reconfigure` after evidence from first boot.

## 2. Evidence posture

| Claim | Status |
|-------|--------|
| Guix manual / RDE Makefile: `herd start cow-store /mnt` then `guix system init … /mnt` | Verified upstream pattern |
| nonguix `linux` + `linux-firmware` for this hardware class | Strongly indicated |
| `modprobe.blacklist=amd_pmf` | Provisional (related HP AMD EliteBook reports); validate on this G8 |
| This protocol run on a named EliteBook 835 G8 | **NOT VERIFIED** |
| dwl-guile / full RDE feature graph in first init | **Out of Stage A scope** |

## 3. Materialization protocol

### Phase 1 — Ephemeral bootstrap

1. Boot `rde-live-0.6.0-x86_64.iso` in UEFI mode.
2. Identify block devices — never assume names:

```bash
lsblk -f
```

Record which disk is the **external SSD** and which is the internal NVMe. Wrong disk destroys data.

### Phase 2 — Prepare target (external SSD only)

Example only: if the external SSD is `/dev/sda`:

```bash
cfdisk /dev/sda
# sda1: EFI System partition ≥512M
# sda2: Linux filesystem (remainder)

mkfs.fat -F32 /dev/sda1
mkfs.ext4 -L warena-root /dev/sda2

mount LABEL=warena-root /mnt
mkdir -p /mnt/boot/efi /mnt/etc
mount /dev/sda1 /mnt/boot/efi
```

Prefer PARTUUID/UUID in the final config if labels are unreliable.

### Phase 3 — Store bridge

Guix install images start with an in-memory store. Point copy-on-write at the target:

```bash
herd start cow-store /mnt
```

(Guix manual form. RDE example Makefiles use the same pattern.)

### Phase 4 — Channels, config, init

Place Stage A files on the **target**:

- `/mnt/etc/channels.scm` ← `configs/bare-metal/channels-stage-a.scm`
- `/mnt/etc/config.scm` ← `configs/bare-metal/warena-bare-metal-stage-a.scm`

If the live environment needs the channels first:

```bash
guix pull -C /mnt/etc/channels.scm
hash guix
```

Materialize:

```bash
guix system init /mnt/etc/config.scm /mnt
```

Reboot; set firmware boot order to the external SSD. Keep the Live USB for recovery.

### Phase 5 — First-boot evidence

On the new system:

```bash
guix describe > ~/warena-guix-describe-$(date -I).txt
# Check: network, amdgpu, Wi-Fi, suspend, battery CPU frequency
# dmesg | grep -i pmf   # decide whether amd_pmf blacklist stays
```

Only then extend the same config lineage with `guix system reconfigure` (Stage B RDE features, Stage C dwl-guile research).

## 4. Stage ladder

| Stage | Content | Gate |
|-------|---------|------|
| **A** | Guix System + nonguix kernel/firmware + Sway + NM + SSH + user | Full boot from external SSD |
| **B** | RDE feature graph (Emacs-centric; Sway remains baseline) | `guix describe` pinned; reconfigure succeeds |
| **C** | engstrand dwl-guile / Guix Home | Fallback Sway session proven; RESEARCH only until runtime evidence |

## 5. Pre-flight checklist

- [ ] UEFI boot order and Secure Boot policy understood
- [ ] `lsblk -f` recorded before `mkfs`
- [ ] Power + network for long `init`
- [ ] nonguix nonfree firmware policy accepted for this host
- [ ] Internal NVMe not targeted
- [ ] Live ISO retained for recovery

## 6. Related repository documents

- `docs/desktop-stack-decision-2026-11.md`
- `docs/DESKTOP-ARCHITECTURE.md`
- `docs/STACK-REGISTER.md`
- `docs/reproducible-environment-runbook.md`
- Prior RDE + dwl-guile research PRs (do not treat as deployment proof)

## 7. Status line

**Proposal only.** Ephemeral RDE Live ISO → persistent external SSD via `cow-store` + `guix system init`. Stage A config is a research draft for EliteBook 835 G8 class hardware. No LIVE qualification is claimed by this document.
