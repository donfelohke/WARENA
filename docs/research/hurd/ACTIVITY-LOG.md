# GNU Hurd and Guix upstream activity log

**Last reviewed:** 2026-11-20  
**Coverage:** upstream Hurd, GNU Mach and Guix/Hurd integration  
**Rule:** newest verified activity first; branch provenance is mandatory.

## 2026-11-20 — review snapshot

### GNU Mach

| Date | Commit | Subsystem | Change | Assessment |
|---|---|---|---|---|
| 2026-11-14 | `90199be69e58` | i386 BIOS memory map | Correct heap determination when memory regions are empty or unavailable | Boot-time memory-map robustness |

Source: [GNU Mach master update, 2026-11-14](https://www.mail-archive.com/commit-hurd@gnu.org/msg15722.html).

### GNU Hurd

| Date | Commit | Subsystem | Change | Assessment |
|---|---|---|---|---|
| 2026-11-09 | `a5e58fa1806d` | libports / storeio | Add checks for `ports_create_bucket`; add bucket destruction support | Resource lifecycle and error-path robustness |
| 2026-11-03 | `2d67397b231d` | libnetfs | Harmonize `dir-lookup.c` with libdiskfs | Filesystem-server consistency |
| 2026-11-02 | `1c4b16ac4633` | libports | Add checks for `ports_create_class` and `ports_create_bucket` return values | Defensive error handling |

Source records:
- [Hurd master update, 2026-11-09](https://www.mail-archive.com/commit-hurd@gnu.org/msg15718.html)
- [Hurd master update, 2026-11-03](https://www.mail-archive.com/commit-hurd@gnu.org/msg15708.html)
- [Hurd master update, 2026-11-02](https://www.mail-archive.com/commit-hurd@gnu.org/msg15695.html)

### GNU Guix — changes visible on master

| Date observed | Commit | Area | Change | Assessment |
|---|---|---|---|---|
| 2026-11-14 | `e1ab5c54e9d1` | Hurd boot | Detect passive translators using xattrs and file-descriptor access with `O_NOTRANS` | Direct Hurd boot integration |
| 2026-11-08 | `ee99aeb9125c` | GCC | Fix GCC 11 x86_64-gnu patch application | 64-bit target toolchain maintenance |

Sources:
- [Guix master update, 2026-11-14](https://www.mail-archive.com/guix-commits@gnu.org/msg405642.html)
- [Passive-translator change](https://www.mail-archive.com/guix-commits@gnu.org/msg405640.html)
- [GCC 11 target patch fix](https://www.mail-archive.com/guix-commits@gnu.org/msg404356.html)

The November 14 Guix master update also contains supporting syscall work: ports/file descriptors in `getxattr`/`setxattr`, xattr flags and associated tests.

### GNU Guix — topic-branch notifications (not assumed merged)

| Date observed | Commit | Area | Change | Branch qualification |
|---|---|---|---|---|
| 2026-11-12 | `4ff420dd794f` | glibc / MIG | Use `cross-mig` when cross-compiling Hurd targets | `core-packages-team`; verify merge |
| 2026-11-12 | `8ced5126bbf8` | glibc / credentials | Fix Hurd `setgroups` while preserving effective UID/GID | `core-packages-team`; verify merge |
| 2026-11-12 | `b31aa893133b` | Guile | Re-enable JIT on Hurd | `core-packages-team`; verify merge |
| 2026-11-12 | `7910b741ed50` | glibc | Update to 2.43 and refresh Hurd patches | `core-packages-team`; verify merge |
| 2026-11-12 | `480fe869de37` | Hurd package | Avoid Bash label assumption in package phases | `core-packages-team`; verify merge |

Sources:
- [glibc cross-compilation fix](https://mail-archive.com/guix-commits@gnu.org/msg405125.html)
- [glibc setgroups fix](https://mail-archive.com/guix-commits@gnu.org/msg405109.html)
- [Guile JIT change](https://mail-archive.com/guix-commits@gnu.org/msg405148.html)
- [glibc 2.43 update](https://www.mail-archive.com/guix-commits@gnu.org/msg405183.html)
- [Hurd package phase fix](https://www.mail-archive.com/guix-commits@gnu.org/msg405177.html)

## Baseline facts to refresh

- Guix 1.5.0 includes support for 64-bit GNU/Hurd.
- Guix documents cross-building to `x86_64-gnu` on master.
- ChildHurd is exposed as a Shepherd-managed virtualization service.
- The Hurd running guide's package availability figures (about 1.7% i586-gnu and 0.9% x86_64-gnu) are historical and must not be presented as a fresh 2026-11-20 measurement.
- Current availability must be measured using `guix weather --system=i586-gnu` and `guix weather --system=x86_64-gnu` and recorded with the Guix commit.

Sources:
- [Guix/Hurd running guide](https://hurd.ion.nu/hurd/running/Guix.html)
- [Guix 1.5.0 release](https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/)
- [64-bit Hurd in Guix](https://guix.gnu.org/en/blog/2026/the-64-bit-hurd/)

## Next review checklist

- [ ] Check new Hurd master commits and GNU Mach activity.
- [ ] Check Guix master commits mentioning Hurd, GNU, `x86_64-gnu`, `i586-gnu`, MIG, glibc, GCC, Guile and ChildHurd.
- [ ] Confirm whether topic-branch changes landed on master.
- [ ] Refresh package availability for both Hurd targets.
- [ ] Record QEMU image freshness and ChildHurd service changes.
- [ ] Update [Guix/Hurd integration](./GUIX-INTEGRATION.md) when architecture or feasibility changes.
- [ ] Keep WARENA host and deployment status UNKNOWN until directly tested.

## Change-log policy

Append entries rather than rewriting history. Each entry must include observation date, upstream commit, branch, subsystem, concise technical effect, source URL and WARENA implication. Distinguish authored date from merge/notification date where they differ.
