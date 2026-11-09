# Foundational Reference Framework

**Repository:** WARENA  
**Date:** 9 November 2026  
**Status:** RESEARCH / CURRICULUM AND REFERENCE REGISTER

## Purpose

This register connects three complementary foundations to WARENA's systems practice and the wider FELOH ecosystem. They are not equivalent sources:

- computer science provides technical concepts and a study sequence;
- African historical scholarship provides historical context, historiography and source-critical methods;
- live-coding community guidelines provide a situated model for creative computation, participation and performance practice.

Use these references to guide study and research questions. Do not treat a reading list as proof of competence, an institutional synthesis as the final word on African history, or community guidelines as universal law.

## 1. Computer science foundations

**Primary guide:** [Teach Yourself Computer Science](https://teachyourselfcs.com/)

The guide recommends nine subject areas, in a suggested progression:

1. Programming
2. Computer architecture
3. Algorithms and data structures
4. Mathematics for computer science
5. Operating systems
6. Computer networking
7. Databases
8. Languages and compilers
9. Distributed systems

It suggests substantial study per topic and identifies books and lecture series. The website states that its guide was extensively updated in May 2020. Treat its recommendations as a curated syllabus snapshot, not a live ranking of current courses or editions.

### WARENA study adaptation

Use the nine subjects as the backbone, then connect each to practical systems work:

| Subject | WARENA laboratory connection |
|---|---|
| Programming | C, GNU Guile/Scheme, Rust, Zig, Go, V and Haskell comparative exercises |
| Architecture | x86-64 and ARM, memory hierarchy, CPU profiling, instruction sets |
| Algorithms | data structures, complexity, graph/network algorithms |
| CS mathematics | discrete mathematics, logic, probability, numerical reasoning |
| Operating systems | GNU/Linux, process model, filesystems, kernel interfaces, Shepherd |
| Networking | Ethernet, TCP/IP, DNS, routing, VLANs, WireGuard and network services |
| Databases | SQLite, transactions, indexes, schema evolution and backup |
| Languages/compilers | interpreters, compilers, GCC, language implementation and toolchains |
| Distributed systems | replication, consistency, failure models, offline-first synchronisation |

Guix, RDE, Emacs, GCC and Guile are practical ecosystems and laboratory subjects; they do not replace the underlying disciplines. Add current primary documentation and version-specific sources before implementation.

### Learning record

For each subject, maintain: learning objectives, prerequisites, selected edition/version, lecture/book sources, exercises, original code, test evidence, unresolved questions and review date. Separate reading completion from demonstrated capability.

## 2. African history, knowledge and historiography

**Institutional corpus:** [UNESCO — General History of Africa](https://www.unesco.org/en/general-history-africa)

UNESCO describes this as a continent-wide historical corpus initiated in 1964, prepared through collaboration among historians and specialists and overseen by an International Scientific Committee with a two-thirds African membership. The collection now includes eleven volumes, including newer volumes on historiographical revision, diasporas and Global Africa.

### WARENA research use

This is a foundational scholarly entry point for studying the histories of knowledge, technology, trade, institutions, education and intellectual life in African contexts. It should be read alongside specialist research, archaeological and linguistic evidence, local scholarship, oral histories and community-held knowledge.

Do not turn the series into a single authoritative voice or assume that a continent-wide synthesis resolves every local question. For each claim, record period, region, community, source author, evidence type, interpretation, uncertainty and counter-evidence.

**Cross-repository source of record:** the FELOH Corpus maintains the shared historical research dossier and source/provenance method. WARENA may draw technical research questions from it but must not rewrite historical interpretation as engineering fact.

## 3. Creative computation and live coding

**Community reference:** [Algorave — General Guidelines](https://github.com/Algorave/guidelines/blob/master/README_en.md)

The guidelines are community-sourced participation advice, not a formal technical specification or universal event standard. They encourage visible algorithmic processes in music and visuals, openness to different artistic approaches, care around institutional sponsorship and self-promotion, less hierarchical lineups, diversity, affordability, safe spaces and active local/online community building.

### WARENA interface

Treat creative computation as a legitimate systems domain: code, algorithms, sound, visuals, timing, hardware and networks can be studied as one performance system. WARENA's role is to support reliable, inspectable and reproducible infrastructure; GENJE owns the creative-practice context, authorship and performance documentation.

A performance is not automatically reproducible because code was projected. Record exact source revision, runtime, dependencies, routing, devices, timing assumptions, performer choices and observed differences.

## 4. Source hierarchy and provenance

Use this working hierarchy, adapted to the question rather than applied mechanically:

1. Primary evidence and official technical documentation for claims about a specific system, text, event or artefact.
2. Peer-reviewed scholarship, critical editions and specialist research for interpretation.
3. Institutional collections and curated educational resources for discovery and broad orientation.
4. Community guidelines and practitioner accounts for situated practice and norms.
5. Secondary summaries and media articles as leads that must be independently checked.

For every source, record title, author/organisation, canonical URL, publication/update date where known, access date, source type, relevant section, claim supported, limitations and any licence/reuse terms. Do not copy substantial text, images, recordings, code or teaching materials into WARENA merely because they are publicly accessible.

## 5. Portfolio boundaries

- **WARENA:** technical foundations, systems engineering, infrastructure, reproducibility and computer-science labs.
- **FELOH Corpus:** shared canon, African historical research, evidence standards and cross-domain source records.
- **GENJE:** Genge-rooted creative practice, live coding, sound, movement, performance and creative authorship.
- **IKAI:** reflective-compute research; do not infer product readiness from these references.

## 6. Status and next work

All three references are classified as **FOUNDATIONAL REFERENCES / RESEARCH**. This classification does not mean their contents have been exhaustively reviewed or that any curriculum has been completed.

Next work:
- map the nine CS subjects to a sequenced, hands-on WARENA curriculum;
- build a bibliography from the UNESCO volumes and specialist East African/Turkana sources;
- translate the Algorave principles into a GENJE performance/workshop checklist without copying or claiming community endorsement;
- record concrete labs, source revisions and evidence before promoting any result to PROTOTYPE or LIVE.

## Source snapshots

- Teach Yourself Computer Science page states an extensive update in May 2020; accessed 9 November 2026.
- UNESCO General History of Africa page accessed 9 November 2026; page lists Volumes I–XI and the 1964 initiative.
- Algorave English guidelines page accessed 9 November 2026; community-sourced guidance, current master-branch content at access time.

No external source text is reproduced here beyond brief descriptive summaries and subject labels.
