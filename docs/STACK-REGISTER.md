# WARENA stack register

**Status:** RESEARCH / REGISTER CONTRACT · updated 2026-10-30  
**Rule:** A version that exists upstream is **not** evidence of deployment.

Public GitHub under @donfelohke documents architecture and intent. It does **not**, by itself, prove a production fleet.

Related: [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) · [PINS-RDE-GUIX-DWL-GUILE-2026-10-30.md](./PINS-RDE-GUIX-DWL-GUILE-2026-10-30.md) · [VALIDATION.md](./VALIDATION.md) · [feloh-corpus](https://github.com/donfelohke/feloh-corpus)

---

## Evidence vocabulary

| Maturity | Meaning |
|----------|--------|
| **LIVE** | Named host + resolved config + date + operational observation + recovery path |
| **PROTOTYPE** | Built/run in a controlled environment; not production |
| **RESEARCH** | Documented experiment or study |
| **CONCEPT** | Specified only |
| **UNKNOWN** | Insufficient evidence |

| Field | Required meaning |
|-------|------------------|
| Component | Exact software or service name |
| Claimed version | Version asserted by inventory |
| Upstream evidence | Official release/tag + verification date |
| Guix evidence | Package, channel revision, availability result — or UNKNOWN |
| Host evidence | Named host or **UNKNOWN** |
| Configuration evidence | Manifest / system.scm / lock file ref — or UNKNOWN |
| Maturity | LIVE · PROTOTYPE · RESEARCH · CONCEPT · UNKNOWN |
| Verification | Observation, date, outcome — or UNKNOWN |
| Recovery | Backup/restore or rollback note — or UNKNOWN |
| Evidence link | Commit, release URL, or redacted deploy record |

**Guix package available ≠ installed. Installed ≠ service operational.**

Do **not** use a single ambiguous **CANON** label to mean “production-deployed.”

---

## Desktop / RDE pins (2026-10-30 research)

Full detail: [PINS-RDE-GUIX-DWL-GUILE-2026-10-30.md](./PINS-RDE-GUIX-DWL-GUILE-2026-10-30.md).

| Component | Claimed | Upstream | Guix | Host | Config | Maturity | Verification | Recovery | Evidence link |
|-----------|---------|----------|------|------|--------|----------|--------------|----------|---------------|
| GNU Guix | 1.5.0 | Exists (2026-01-23) | UNKNOWN (rolling commit) | UNKNOWN | UNKNOWN | RESEARCH | Version existence | UNKNOWN | https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/ |
| RDE | 0.6.0 | Manual + ISO name documented | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | Doc/ISO filename | UNKNOWN | https://trop.in/rde/manual |
| RDE Live ISO | rde-live-0.6.0-x86_64.iso | Documented download path | N/A | UNKNOWN | UNKNOWN | RESEARCH | Filename only; Sway desktop | UNKNOWN | http://files.trop.in/rde/ |
| RDE channel intro | 257cebd587b66e4d865b3537a9a88cccd7107c95 | Published intro | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | Channel snippet | UNKNOWN | https://github.com/abcdw/rde |
| dwl-guile | v2.0.2 / c671e3d17996040447765976f7be58819e9181ec | Tag exists | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | Release page | UNKNOWN | https://github.com/engstrand-config/dwl-guile/releases/tag/v2.0.2 |
| dwl + wlroots (claimed) | dwl 0.4 / wlroots 0.16.x | README claim | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | README only | UNKNOWN | https://github.com/engstrand-config/dwl-guile |
| home-service-dwl-guile | intro 314453a87634d67e914cfdf51d357638902dd9fe | Channel published | UNKNOWN | UNKNOWN | UNKNOWN | RESEARCH | README channel block | UNKNOWN | https://github.com/engstrand-config/home-service-dwl-guile |

Official **RDE live ISO ≠ dwl-guile session**. No combined official live ISO established.

---

## Upstream existence checks (selected other pins)

Verified as *version exists upstream* on 2026-10-26 unless noted. Deployment remains **UNKNOWN**.

| Component | Claimed | Upstream | Guix | Host | Config | Maturity | Verification | Recovery | Evidence link |
|-----------|---------|----------|------|------|--------|----------|--------------|----------|---------------|
| GNU Shepherd | 1.0.7 | Exists (2025-09-03); 1.0.8+ also exist | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://lists.gnu.org/archive/html/info-gnu/2025-09/msg00001.html |
| GNU Guile | 3.0.10 | Exists (2024-06-24); 3.0.11 also exists | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://www.gnu.org/software/guile/news/gnu-guile-3010-released.html |
| restic | 0.19.1 | Exists (2026-07-05) | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://github.com/restic/restic/releases/tag/v0.19.1 |
| Yggdrasil | 0.5.13 | Exists (2026-02-24); 0.5.14/0.5.15 also exist | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://github.com/yggdrasil-network/yggdrasil-go/releases/tag/v0.5.13 |
| linux (nonguix) | 6.18 LTS claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| SQLite | 3.47.x claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| nftables | (unpinned) | Generic component | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| nginx | 1.30.5 claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| Cage | 0.3.0 claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| OpenSSH | 9.x claim | Generic series | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| MagicMirror² | 2.37.0 claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| ungoogled-chromium | (unpinned) | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| Emacs | 29.x / WMOL claim | Not verified this pass | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| WARENA Pay Core | v1.0 | No public deploy evidence in @donfelohke GitHub | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| M-Pesa Daraja | 3.0 | External API; integration not evidenced here | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| KRA eTIMS | — | External; integration not evidenced here | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| H68K (RK3568) | hardware | Hardware claim; no host log in public repos | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |
| “32 Mashakura apps” | inventory claim | Not evidenced as public repos/releases | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | — |

---

## Profile stack (desktop — architecture only)

| Component | Role | Maturity (docs) |
|-----------|------|-----------------|
| Sway | Wayland stable profile candidate | RESEARCH / policy |
| dwl-guile | Wayland Scheme research profile | RESEARCH (pinned v2.0.2 upstream) |
| Gershwin | X11 GNUstep DE study | RESEARCH |
| Window Maker | X11 minimal comparator | RESEARCH |

See [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md). Not LIVE unless qualification gate is completed.

---

## How to promote a row to LIVE

1. Named host (or equivalent durable identity)  
2. Resolved configuration (manifest / system config / channel lock)  
3. Verification date and outcome  
4. Recovery procedure tested or documented  
5. Evidence link retained in-repo or securely referenced  

Until then: keep **UNKNOWN** or **RESEARCH** / **CONCEPT**.

---

## Stewardship

- Prefer updating this register over inventing parallel “CANON lists” in chat.  
- Cross-link FELOH Corpus claim/source registers when claims enter the corpus.  
- Never commit secrets, customer payment data, or private host credentials.  
