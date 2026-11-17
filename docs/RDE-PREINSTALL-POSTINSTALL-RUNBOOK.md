# WARENA RDE — Pre-install and Post-install Runbook

**Document ID:** WARENA-RDE-INSTALL-2026-11  
**Date:** 2026-11-18  
**Status:** RESEARCH / OPERATOR RUNBOOK — NOT A DEPLOYMENT RECORD  
**Configuration home:** `donfelohke/WARENA`  
**Foundation:** GNU Guix + upstream RDE (`abcdw/rde`)  
**Governing rule:** specification ≠ implementation ≠ verification ≠ deployment.

This runbook separates evaluation of the upstream RDE live image from installation and post-install configuration. Complete the pre-install gate before committing to disk installation. Do not treat a successful live boot, package build, or GitHub commit as evidence of a deployed workstation.

## 1. Scope and known image

RDE publishes a live ISO for trying the environment. The RDE manual currently documents the image name:

- `rde-live-0.6.0-x86_64.iso`
- Official download directory: <http://files.trop.in/rde/>
- RDE manual: <https://trop.in/rde/manual>
- RDE source mirror: <https://github.com/abcdw/rde>

**Important WARENA qualification:** the documented upstream live image is an RDE/Sway evaluation environment. It is not a WARENA-custom image and does not include proof of the WARENA DWL-Guile, Gershwin, GNUstep, or Guile-GNUstep tracks. Do not describe it as a DWL-Guile ISO. The WARENA-specific desktop profiles remain separate integration work.

The live image is for pre-install evaluation. It is not, by itself, proof that the target machine is ready for an install or that a WARENA system configuration is complete.

## 2. Pre-install — obtain and qualify the RDE live ISO

### 2.1 Identify the target

Record before downloading or writing media:

- [ ] Target machine make/model and firmware mode (UEFI/legacy)
- [ ] CPU architecture confirmed as x86_64
- [ ] RAM, storage devices and available capacity
- [ ] GPU and display outputs
- [ ] Wi-Fi/Ethernet chipset and expected network access
- [ ] Audio device, keyboard, touchpad and external peripherals
- [ ] Existing operating systems, partitions and data requiring preservation
- [ ] Backup of all data that must survive installation

Do not assume hardware compatibility from the ISO filename.

### 2.2 Download and verify

1. Open the official RDE download directory: <http://files.trop.in/rde/>.
2. Select the documented x86_64 live image and any checksum/signature material published alongside it.
3. Verify the downloaded image against an independently obtained official checksum. If no trustworthy checksum or signature is published for the selected file, record verification as **NOT VERIFIED**; do not invent or reuse a checksum.
4. Preserve the ISO filename, download date, source URL, file size, checksum algorithm, computed digest and verification result in the test record.

Example local verification (replace the filename only with the exact downloaded file):

```sh
sha256sum rde-live-0.6.0-x86_64.iso
```

A computed digest is useful only when compared with a trusted digest obtained from the official source. A checksum does not establish publisher authenticity unless the checksum source itself is authenticated.

### 2.3 Write the USB safely

Identify the USB device by model, capacity and device path before writing. The RDE manual gives a GNU/Linux `dd` example, but the target device must be positively identified first.

```sh
lsblk -o NAME,PATH,SIZE,MODEL,TRAN,TYPE,MOUNTPOINTS
```

After unmounting any mounted partitions on the intended USB device, write the ISO using the official manual's method, substituting the verified whole-device path (for example, `/dev/sdX` — never a partition such as `/dev/sdX1`):

```sh
sudo dd if=rde-live-0.6.0-x86_64.iso of=/dev/sdX bs=32M status=progress oflag=sync
sync
```

**Destructive operation:** `dd` overwrites the selected device. Re-check the device identity immediately before execution. Never copy the example device path blindly. Confirm the write completed without I/O errors and safely eject the USB.

### 2.4 Boot and hardware evaluation

Boot the live medium without starting an installation. Record PASS / FAIL / NOT TESTED, observed behaviour, hardware identifiers and relevant logs.

- [ ] Firmware detects USB and boots in the intended UEFI/legacy mode
- [ ] Display, resolution, brightness and external monitor
- [ ] Keyboard, layout, modifiers and pointer/touchpad
- [ ] Storage devices visible and SMART/health status where available
- [ ] Ethernet and Wi-Fi connectivity; reconnect after suspend if applicable
- [ ] Audio output and microphone
- [ ] Suspend/resume and thermal behaviour
- [ ] USB ports and other required peripherals
- [ ] Sway session starts and remains usable
- [ ] TTY/recovery access works
- [ ] Required workflows operate without WAN where expected

Capture logs and exact errors. Do not mark a component PASS based on detection alone; test the actual required function.

### 2.5 Pre-install decision gate

Choose and document one outcome:

- **GO:** hardware and recovery requirements pass; installation plan and verified backup are ready.
- **CONDITIONAL:** known gaps have an explicit workaround or a decision to defer the affected feature.
- **NO-GO:** storage, boot, network, display, input, backup or recovery risks remain unresolved.

Do not proceed to disk installation until the target disk, partition plan, backup and encryption/recovery plan are explicit.

## 3. Installation planning — Guix System + RDE

RDE is a declarative environment built on GNU Guix. Keep the layers distinct:

1. **GNU Guix System:** boot, kernel, filesystems, users, Shepherd services and system packages.
2. **RDE:** declarative user environment and selected system/home integration.
3. **WARENA configuration:** this repository owns WARENA policy, pins, host records, profiles and recovery documentation.
4. **Desktop profile:** Sway is the upstream live-image baseline; WARENA's DWL-Guile and X11/Gershwin tracks are separate qualification work.

Before installation, prepare and review:

- [ ] Target disk and partition map, confirmed against the actual machine
- [ ] UEFI/EFI system partition requirements for the target firmware
- [ ] Btrfs subvolume and mount design, if Btrfs is selected
- [ ] LUKS encryption design, passphrase handling and recovery procedure, if encryption is selected
- [ ] Bootloader and rollback/recovery strategy
- [ ] Hostname, locale, timezone, keyboard and network requirements
- [ ] Initial administrator account and least-privilege user plan
- [ ] Offline installation constraints, Guix substitutes and required source/cache availability
- [ ] Guix channel list, exact revisions and channel introduction fingerprints
- [ ] RDE configuration source and the exact commit to be deployed

**No generic partitioning or formatting command is supplied here.** Device names, partition sizes, firmware mode and existing data vary by host. Destructive storage commands must be generated only from the reviewed target-specific plan.

Use the official [RDE manual](https://trop.in/rde/manual) and [GNU Guix System documentation](https://guix.gnu.org/manual/1.5.0/) for the selected installation method. Do not infer that the live ISO itself contains a WARENA installer.

## 4. Post-install — first boot and baseline verification

After the Guix System installation and first reboot, capture the host identity and installed state before adding the full RDE profile.

### 4.1 First-boot checks

- [ ] Machine boots from the installed disk without the live USB
- [ ] Firmware and bootloader entries are correct
- [ ] Encrypted volumes unlock as designed; recovery method is available
- [ ] Expected Btrfs filesystems/subvolumes mount correctly, if selected
- [ ] Root and intended user accounts work; no unintended default credentials remain
- [ ] GNU Shepherd reaches the expected service state
- [ ] Network interfaces and DNS work
- [ ] Timezone, locale, keyboard and time synchronisation are correct
- [ ] TTY and documented recovery path work
- [ ] System logs contain no unresolved critical boot/storage/service errors

Record command output and observations. Example read-only inspection:

```sh
uname -a
guix --version
lsblk -f
findmnt
herd status
ip address
ip route
```

Run only the commands available on the installed system; missing commands are a recorded gap, not a reason to assume success.

### 4.2 Channel and configuration pinning

Keep channel declarations under version control. Preserve the channel introduction data and pin exact commits for reproducible reconstruction. Do not use an unrecorded moving channel state as the deployment reference.

- [ ] Record Guix version and system generation
- [ ] Record every channel name, URL, introduction fingerprint and resolved commit
- [ ] Record RDE upstream revision and any WARENA fork revisions
- [ ] Keep system and home declarations in the WARENA configuration repository or a clearly referenced versioned source
- [ ] Record package origins and any local package definitions/overlays
- [ ] Keep secrets and private keys out of Git; document their secure provisioning separately

RDE remains an upstream dependency; WARENA configuration belongs in `donfelohke/WARENA`. The compositor and Guix Home service forks remain separate repositories.

### 4.3 Apply and validate declarations

Apply reviewed Guix System and Guix Home/RDE declarations using the appropriate Guix commands for the installed Guix version. Do not run a reconfigure against an unreviewed or unpinned configuration.

After applying:

- [ ] Confirm the expected system generation was created
- [ ] Reboot and confirm the new generation starts
- [ ] Confirm Shepherd services and network operation
- [ ] Confirm encrypted storage and filesystem mounts
- [ ] Confirm user environment and essential applications
- [ ] Confirm the selected desktop session starts
- [ ] Confirm fallback TTY/session and rollback path
- [ ] Compare observed state with the declared configuration

A successful `guix system reconfigure` is not proof that every service or desktop function is operational.

## 5. Post-install — backup, Git and recovery

### 5.1 Configuration history

- [ ] Commit reviewed system/home declarations and channel pins
- [ ] Record the deployed commit and system generation in the host record
- [ ] Keep hardware-specific values and secrets appropriately separated
- [ ] Confirm the repository can reconstruct the declared configuration from a clean checkout

### 5.2 Restic backup and restore test

- [ ] Define backup scope: user data, configuration, important service data and recovery metadata
- [ ] Exclude transient caches and reproducible build outputs unless there is a specific reason to retain them
- [ ] Configure repository credentials and encryption-key recovery securely
- [ ] Complete an initial backup
- [ ] Verify the snapshot
- [ ] Restore a representative file or directory to a separate temporary location
- [ ] Record restore result, duration, repository location and recovery dependencies

A backup is not considered validated until a restore has been tested. Never store Restic passwords, LUKS passphrases or private keys in the public repository.

## 6. WARENA desktop integration gates

These are distinct from the upstream RDE live-image test:

| Track | Current role | Promotion requirement |
|---|---|---|
| RDE + Sway | Upstream live-image baseline | Host-specific install and session validation |
| RDE + Niri / Noctalia | Practical candidate evaluation | Guix package/build evidence, portals, services and recovery tests |
| RDE + DWL-Guile | Guile-native research | WARENA fork pins, Guix package/Home-service integration, runtime safeguards and hardware tests |
| Gershwin + GNUstep | Separate X11 desktop research | Gershwin packaging, GNUstep dependencies, session/greeter integration and lifecycle tests |
| Guile-GNUstep / GOOPS | Integration research | Library/API compatibility, bindings, packaging and reproducible test evidence |

Do not combine X11 and Wayland into one assumed session. Do not claim the RDE ISO includes these experimental tracks unless a separately built and verified image demonstrates that fact.

## 7. Host evidence record

Create one dated record per machine. Use `UNKNOWN` when evidence is absent.

| Field | Value |
|---|---|
| Host identifier (non-sensitive) | UNKNOWN |
| Hardware model / CPU architecture | UNKNOWN |
| Firmware mode | UNKNOWN |
| Install date | UNKNOWN |
| ISO filename / source / digest | UNKNOWN |
| Guix version / system generation | UNKNOWN |
| RDE channel commit | UNKNOWN |
| WARENA configuration commit | UNKNOWN |
| Storage / encryption / filesystem layout | UNKNOWN |
| Desktop session and version | UNKNOWN |
| Shepherd / network validation | UNKNOWN |
| Backup snapshot and restore test | UNKNOWN |
| Recovery test and outcome | UNKNOWN |
| Maturity | RESEARCH until evidence supports a higher status |

## 8. Completion criteria

The workstation may be recorded as **PROTOTYPE** only after installation and controlled operation on a named host are evidenced. **LIVE** requires the WARENA evidence contract: named host, resolved configuration, dated operational observations and a demonstrated recovery path.

Until those records exist, this document remains a runbook and the RDE ISO remains a pre-install evaluation medium — not proof of a completed WARENA deployment.

## References

- [RDE manual — Trying it / Live Image / Installation](https://trop.in/rde/manual)
- [RDE upstream source mirror](https://github.com/abcdw/rde)
- [RDE official download directory](http://files.trop.in/rde/)
- [GNU Guix 1.5.0 manual](https://guix.gnu.org/manual/1.5.0/)
- [WARENA stack register](STACK-REGISTER.md)
- [WARENA desktop architecture](DESKTOP-ARCHITECTURE.md)
- [WARENA fork and configuration architecture](FORK-AND-CONFIGURATION-ARCHITECTURE-2026-11.md)
- [WARENA technology constitution](TECHNOLOGY-CONSTITUTION-2026-11-17.md)
