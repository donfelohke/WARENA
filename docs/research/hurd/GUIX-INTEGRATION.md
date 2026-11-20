# GNU Guix / GNU Hurd integration

**Status:** RESEARCH · reviewed 2026-11-20  
**Scope:** Guix System targets `i586-gnu` and `x86_64-gnu`, ChildHurd, cross-building, package coverage and operational qualification.

## 1. Executive assessment

GNU Hurd support is integrated into GNU Guix rather than maintained solely as an external overlay. The 64-bit Hurd path is included in Guix 1.5.0, and Guix master continues to receive Hurd-specific boot, syscall, toolchain and package fixes.

For WARENA, the most useful near-term route is:

**GNU/Linux + Guix host → QEMU/KVM → Guix ChildHurd → repeatable target builds and tests.**

Do not start with bare-metal installation or a Hurd desktop. The ChildHurd route offers an inspectable, disposable target while retaining the established GNU/Linux host as the recovery and build environment.

## 2. Target and build model

| Target | Meaning | Assessment |
|---|---|---|
| `i586-gnu` | 32-bit GNU/Hurd target | Integrated target; legacy architecture path |
| `x86_64-gnu` | 64-bit GNU/Hurd target | Supported in Guix 1.5.0; continuing fixes required |
| `x86_64-linux` | Practical Guix host target | WARENA baseline |
| `hurd-qcow2` | 32-bit ChildHurd image flavour | Experiment candidate |
| `hurd64-qcow2` | 64-bit ChildHurd image flavour | Preferred first experiment |

Cross-building to `x86_64-gnu` is documented as supported on Guix master. This does not mean all packages cross-build, nor that every built package runs correctly.

## 3. ChildHurd operating model

The Guix `hurd-vm-service-type` exposes a ChildHurd as a Shepherd-managed virtual machine service. The documented controls include:

```sh
herd start hurd-vm
herd stop childhurd
```

The documented default VM configuration provides a console through VNC and SSH access forwarded to host port 10022. The default ChildHurd is described as volatile/stateless, starting with a fresh root filesystem on restart. Validate these details against the exact Guix revision and service configuration before relying on them.

A minimal configuration sketch (illustrative; verify field names against the current Guix manual and module source before use):

```scheme
(use-modules (gnu)
             (gnu services virtualization))

(operating-system
  ;; Host operating-system fields omitted.
  (services
   (cons (service hurd-vm-service-type
                  (hurd-vm-configuration
                   (type 'hurd64-qcow2)))
         %base-services)))
```

**Important:** the above is a research sketch, not a tested WARENA configuration. Do not copy it into a host configuration without checking the current `hurd-vm-configuration` record and service defaults.

## 4. Upstream Guix activity — verified snapshot

The following changes are visible in upstream commit notifications around this review date. The branch column matters: a change on a topic branch is not automatically part of Guix `master`.

| Date observed | Commit / change | Branch evidence | Significance |
|---|---|---|---|
| 2026-11-14 | `e1ab5c54e9d1` — Hurd boot detects passive translators through extended attributes | Guix `master` update | Improves translator detection by using file-descriptor xattr access with `O_NOTRANS`; removes a separate `showtrans` subprocess path |
| 2026-11-08 | `ee99aeb9125c` — fix GCC 11 x86_64-gnu patch application | Guix `master` update | Repairs a target-specific compiler patch phase |
| 2026-11-12 notification | `4ff420dd794f` — glibc cross-compilation for Hurd targets uses `cross-mig` | `core-packages-team` topic branch | Relevant to cross-toolchain correctness; verify merge status before treating as master |
| 2026-11-12 notification | `8ced5126bbf8` — Hurd `setgroups` fix | `core-packages-team` topic branch | Corrects effective UID/GID preservation while changing supplementary groups; verify merge status |
| 2026-11-12 notification | `b31aa893133b` — re-enable Guile JIT on Hurd | `core-packages-team` topic branch | Important for Guile runtime performance; verify merge status and target build |
| 2026-11-12 notification | `7910b741ed50` — glibc 2.43 update and Hurd patch refresh | `core-packages-team` topic branch | Removes obsolete Hurd patches and adds current unsupported-ioctl handling; verify merge status |
| 2026-11-12 notification | `480fe869de37` — Hurd package build phase avoids Bash label assumption | `core-packages-team` topic branch | Improves package build portability |

The November 14 master update also included syscall-layer support for ports and file descriptors in `getxattr`/`setxattr`, plus xattr flags and tests. These are broader Guix syscall changes that directly support the passive-translator boot change.

### Interpretation

The recent Guix work is not merely packaging metadata. It touches:
- Hurd boot semantics and passive translator discovery;
- xattr syscall interfaces and file-descriptor handling;
- GCC target-specific patch application;
- glibc and MIG cross-compilation;
- Guile runtime capabilities;
- package build-system portability.

This is meaningful integration progress, but it does not remove the package-coverage and desktop-availability constraints.

## 5. Package coverage and ecosystem limitations

The GNU Hurd running guide currently reports an older package-coverage snapshot of approximately:
- 1.7% for `i586-gnu`;
- 0.9% for `x86_64-gnu`.

Treat these as historical reference figures, not current measurements. The guide explicitly recommends measuring current availability with:

```sh
guix weather --system=i586-gnu
guix weather --system=x86_64-gnu
```

Record the Guix commit, timestamp, total package count and available package count with each measurement. Do not quote the percentages as current until refreshed.

The same guide notes that X.Org is not available in its Guix/Hurd package snapshot and points to Debian GNU/Hurd for X.Org. This makes a WARENA X11 desktop an explicit feasibility question, not an assumed consequence of a working Hurd system.

## 6. WARENA validation plan

### Gate A — source and channel
- [ ] Record Guix checkout commit and branch.
- [ ] Confirm Hurd target definitions and image generation modules.
- [ ] Refresh both `guix weather` measurements.
- [ ] Confirm which topic-branch fixes have landed on master.

### Gate B — image and boot
- [ ] Obtain the official 64-bit Guix/Hurd QEMU image.
- [ ] Verify checksum/provenance where published.
- [ ] Boot under QEMU/KVM on GNU/Linux.
- [ ] Record CPU, RAM, disk, firmware and QEMU arguments.
- [ ] Capture console output and boot result.

### Gate C — ChildHurd
- [ ] Build a version-controlled host OS definition with `hurd-vm-service-type`.
- [ ] Confirm Shepherd start/stop/restart behaviour.
- [ ] Validate VNC console and SSH forwarding.
- [ ] Confirm whether the root filesystem is volatile in the selected configuration.
- [ ] Test clean shutdown, restart and state-loss/recovery expectations.

### Gate D — package matrix
Test packages by class rather than assuming all Guix packages work:
- bootstrap/toolchain: binutils, GCC, MIG, glibc;
- runtime: Guile, Shepherd;
- base userland: coreutils, grep, sed, findutils, tar, gzip;
- access/network: OpenSSH, Git;
- persistence/data: SQLite;
- WARENA dependencies: add only after package availability and runtime behaviour are checked.

For each package, record definition present, build succeeds, tests pass, runs on Hurd, and any known limitation as separate fields.

### Gate E — desktop and hardware
- [ ] Determine current X.Org and graphics stack availability.
- [ ] Evaluate GNUstep/Gershwin feasibility independently of the Hurd kernel.
- [ ] Audit graphics, input, network and storage drivers.
- [ ] Track GNU Mach SMP and architecture limitations separately.
- [ ] Only then consider physical hardware.

## 7. Architecture decision

| Layer | WARENA decision |
|---|---|
| Production host | GNU/Linux + Guix |
| Hurd experimentation | Guix ChildHurd under QEMU/KVM |
| Target architecture | Start with `x86_64-gnu`; retain `i586-gnu` as comparator |
| Build strategy | Cross-build from Guix/Linux; validate native runtime separately |
| Desktop | Not selected; X.Org/GNUstep availability must be demonstrated |
| Bare metal | Deferred until hardware, driver, installer and recovery gates pass |

## 8. Primary sources

- [GNU Hurd: running Guix](https://hurd.ion.nu/hurd/running/Guix.html)
- [Guix manual: Virtualization Services](https://guix.gnu.org/manual/en/html_node/Virtualization-Services.html)
- [Guix 1.5.0 released](https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/)
- [The 64-bit Hurd in Guix](https://guix.gnu.org/en/blog/2026/the-64-bit-hurd/)
- [Guix master update, 2026-11-14](https://www.mail-archive.com/guix-commits%40gnu.org/msg405642.html)
- [Hurd passive-translator xattr change](https://www.mail-archive.com/guix-commits%40gnu.org/msg405640.html)
- [GCC 11 x86_64-gnu patch fix](https://www.mail-archive.com/guix-commits%40gnu.org/msg404356.html)
- [glibc Hurd cross-compilation fix — topic branch](https://mail-archive.com/guix-commits%40gnu.org/msg405125.html)
- [glibc Hurd setgroups fix — topic branch](https://mail-archive.com/guix-commits%40gnu.org/msg405109.html)
- [Guile JIT re-enabled on Hurd — topic branch](https://mail-archive.com/guix-commits%40gnu.org/msg405148.html)

---

**Maturity:** RESEARCH. No Guix/Hurd host build, ChildHurd instance, package matrix or WARENA deployment is claimed by this document.
