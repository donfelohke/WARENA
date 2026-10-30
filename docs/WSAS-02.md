# WSAS-02 — Repository and Upstream Integration Register

**Status:** RESEARCH REGISTER · 2026-10-30  
**Repository:** `donfelohke/WARENA`  
**Default branch:** `main`  
**Purpose:** reconcile actual repository state with the logical architecture. This is a dated snapshot, not a live inventory.

## 1. Repository boundary

WARENA is the primary systems-engineering repository. The other ecosystem repositories remain distinct:

| Repository | Logical responsibility | Relationship |
|---|---|---|
| `donfelohke/WARENA` | Systems engineering | This register |
| `donfelohke/Ikai` | Reflective-computing research | Separate identity; may consume infrastructure |
| `donfelohke/Genje` | Creative/cultural practice | Separate identity |
| `donfelohke/NAKEBUSEN` | Enterprise operations | Sole transacting enterprise |
| `donfelohke/feloh-corpus` | Shared terminology and evidence governance | Cross-domain reference |
| `donfelohke/donfelohke.github.io` | Public website | Public presentation |
| `donfelohke/Gallery` | Creative assets | Asset provenance |
| `donfelohke/donfelohke` | GitHub profile | Identity/navigation |

## 2. WARENA branch and PR snapshot

At the 2026-10-30 audit, WARENA had 18 branches including `main`, and four open pull requests were identified: #3, #12, #13 and #14. The account-wide inventory previously recorded approximately 40 open PRs across eight repositories. Recheck before any action because GitHub state changes continuously.

| Work | Branch / PR | Treatment |
|---|---|---|
| Agent contract | PR #3 | Reconcile against current main; preserve unique `AGENTS.md` |
| RDE + dwl-guile audit | PR #12 | Preserve and review; align with source register |
| USSD / GNU Taler / GNUnet feasibility | PR #13 | Preserve; review evidence and scope independently |
| GNU Guile ecosystem audit | PR #14 | Preserve; reconcile technology classifications |
| WM-NG reusable core | `docs/wm-ng-reusable-core-2026-10-28` | Preserve unique research document |
| Technical knowledge base | `docs/technical-knowledge-base` | Compare file content, not commit counts alone |

All three research PRs #12–#14 had a successful `documentation-baseline` check in the inspected snapshot. This is a documentation workflow result, not a technical build, security or deployment certification.

## 3. Branch reconciliation rules

Classify each branch as:

- **CURRENT:** no material divergence from canonical main.
- **AHEAD:** contains commits not in main.
- **BEHIND:** main contains commits absent from branch.
- **DIVERGED:** both refs contain unique commits.
- **CONTENT-SUPERSEDED:** relevant files are already identical to canonical main.
- **UNIQUE RESEARCH:** contains material not represented on main.
- **UNKNOWN:** comparison or history is incomplete.

Do not delete a branch solely because it is behind or because a selected file matches main. Inspect all changed paths, commits, PR references and unique research notes. Preserve open PR heads until their PRs are resolved by an explicit human decision.

## 4. Integration policy

- Keep PR #12, #13 and #14 independent for review and rollback.
- Do not combine unrelated research into one large consolidation PR.
- Reconcile PR #3 separately.
- Reuse existing research branches and documents; do not create duplicate audits.
- Integrate unique WM-NG and knowledge-base material through separate reviewable changes.
- Update README and index links only after canonical paths are established.
- No merge, PR closure, branch deletion, force-push or deployment is authorized by this register.

## 5. Upstream decision register

| Component | Treatment | Reason / gate |
|---|---|---|
| GNU Guix | ADOPT foundation; pin exact channel revision before build | Official source/channel pin must be recorded; no compatible lock is claimed here |
| Guile Scheme | PREFERRED implementation language | Validate per application/runtime |
| RDE | ADAPT selectively / TEST against chosen Guix channel set | Active development; API can change |
| dwl-guile | TEST FIRST; experimental only | Upstream README identifies dwl v0.4 and wlroots 0.16.x; source snapshot is old |
| dwl-guile Home service | TEST FIRST | Upstream describes work-in-progress behaviour; qualify service lifecycle |
| Sway | PREFERRED Wayland reference candidate | Mature comparator; still requires Guix package and target-hardware qualification |
| Engstrand Guix dotfiles | REFERENCE ONLY | Personal configuration example, not a WARENA dependency or default |
| Gershwin / Window Maker | RESEARCH | Separate X11 track; do not conflate with Wayland |

Exact source details and caveats are maintained in [UPSTREAM-SOURCE-REGISTER.md](UPSTREAM-SOURCE-REGISTER.md).

## 6. Verification plan

| ID | Verification | Evidence required |
|---|---|---|
| V01 | Authenticate/pin channel introductions | Channel URL, introduction commit and fingerprint |
| V02 | Lock Guix and RDE inputs | Full immutable revisions and resolved dependency graph |
| V03 | Evaluate RDE configuration | Evaluation output and environment |
| V04 | Evaluate dwl-guile package/service | Package evaluation, dependency closure and licence review |
| V05 | Build Sway profile | Build log and resulting derivation |
| V06 | Build dwl-guile profile | Build log and resulting derivation |
| V07 | Desktop runtime test | Named hardware, display/input behaviour and logs |
| V08 | Runtime Scheme/REPL boundary | Access-control and failure tests |
| V09 | Recovery test | Demonstrated return to known-good compositor/session |
| V10 | Backup/restore | Restore evidence on isolated target |
| V11 | Reproducibility | Independent or repeat build with same declared inputs |

All V01–V11 remain **NOT VERIFIED** until evidence is attached. No successful build or hardware deployment is claimed by this document.

## 7. Change-control status

This register records findings and proposed treatment. It does not merge PRs, close issues, delete branches, alter repository settings or deploy software.

**Governing rule:** repository hygiene is an engineering control; preserve provenance before reducing branch count.
