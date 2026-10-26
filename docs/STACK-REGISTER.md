# WARENA stack register

**Status:** RESEARCH / REGISTER CONTRACT · 2026-10-26  
**Rule:** A version that exists upstream is **not** evidence of deployment.

Public GitHub under @donfelohke documents architecture and intent. It does **not**, by itself, prove a 40-tool production fleet.

Related: [DESKTOP-ARCHITECTURE.md](./DESKTOP-ARCHITECTURE.md) · [VALIDATION.md](./VALIDATION.md) · [feloh-corpus source register](https://github.com/donfelohke/feloh-corpus/blob/main/docs/source-register.md)

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

## Upstream existence checks (selected pins)

Verified as *version exists upstream* on 2026-10-26. Deployment remains **UNKNOWN** unless host evidence is added later.

| Component | Claimed | Upstream | Guix | Host | Config | Maturity | Verification | Recovery | Evidence link |
|-----------|---------|----------|------|------|--------|----------|--------------|----------|---------------|
| GNU Guix | 1.5.0 | Exists (released 2026-01-23) | UNKNOWN | UNKNOWN | UNKNOWN | UNKNOWN | Version existence only | UNKNOWN | https://guix.gnu.org/blog/2026/gnu-guix-1.5.0-released/ |
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
| dwl-guile | Wayland Scheme research profile | RESEARCH |
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
