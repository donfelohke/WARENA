# Computer Science Foundations — WARENA Learning Reference

**Date:** 2026-11-09  
**Status:** RESEARCH / LEARNING FRAMEWORK  
**Canonical source map:** [FELOH Corpus — Foundational Reference Map](https://github.com/donfelohke/feloh-corpus/blob/main/docs/foundational-reference-map-2026-11.md)

## Primary reference

[Teach Yourself Computer Science](https://teachyourselfcs.com/) is a structured self-study guide covering nine foundational subjects. Its site states that the guide was extensively updated in May 2020; use it as a durable syllabus scaffold, not a live guarantee that every linked course or edition remains current.

| Sequence | Subject | WARENA application |
|---|---|---|
| 1 | Programming | C, Scheme/Guile, abstraction, recursion, program design |
| 2 | Computer architecture | CPU, memory hierarchy, instruction sets, performance and profiling |
| 3 | Algorithms and data structures | Complexity, graphs, trees, searching, sorting and problem solving |
| 4 | Mathematics for CS | Discrete mathematics, logic, proofs, probability and linear algebra as needed |
| 5 | Operating systems | Processes, scheduling, virtual memory, filesystems, concurrency and isolation |
| 6 | Computer networking | TCP/IP, routing, DNS, Ethernet, wireless, protocols and network security |
| 7 | Databases | Relational modelling, SQL, transactions, indexes, storage and recovery |
| 8 | Languages and compilers | Parsing, interpreters, compilers, type systems and runtime design |
| 9 | Distributed systems | Replication, consistency, fault tolerance, coordination and observability |

## Language and systems alignment

This is a WARENA learning map, not a language ranking or a declaration that any language is universally best.

- **C:** machine model, systems interfaces, memory, ABI and performance.
- **Scheme / GNU Guile:** interpreters, metaprogramming, DSLs, configuration and composable system automation. SICP is a strong conceptual companion.
- **Haskell:** functional programming, types, algebraic data types, purity and reasoning about effects.
- **Rust:** ownership, borrowing, memory safety and systems programming.
- **Zig:** explicit allocation, low-level control and systems integration.
- **Go:** concurrency, network services and operationally simple deployment.
- **V:** comparative language study; evaluate maturity, ecosystem, compiler behaviour and interoperability rather than assuming parity with established toolchains.

The initial practical pairing is **C + Scheme/Guile**, with Haskell as a deeper functional/type-theory comparator. Rust, Zig, Go and V remain comparative study tracks. This is a proposed sequencing choice, not a claim that all tracks are equally mature or required.

## Method: study through evidence

For each subject, maintain:
- learning objective and prerequisite;
- selected book/course edition and source URL;
- chapter/lecture range;
- exercises attempted and completed;
- code repository and commit;
- test, benchmark or experiment environment;
- explanation of the result in the learner's own words;
- gaps, failed attempts and next review.

Prefer small, reproducible labs over passive course accumulation. Examples include a C memory-layout and profiling lab, a Guile interpreter or DSL, a graph-algorithm benchmark, a process/filesystem experiment, a TCP client/server, a SQLite transaction/recovery test, a small compiler, and a fault-injection exercise for a replicated service.

## Evidence and boundaries

- A syllabus is not a qualification.
- Reading a book is not proof of mastery.
- A benchmark without hardware, compiler, flags, workload and repetitions is not comparable evidence.
- A build is not a deployment; a deployment is not a recovery test.
- Keep source revisions, licences, commands, results and limitations traceable.
- Do not represent the proposed curriculum as completed training.

## Links

- [Teach Yourself Computer Science](https://teachyourselfcs.com/)
- [FELOH Corpus foundational reference map](https://github.com/donfelohke/feloh-corpus/blob/main/docs/foundational-reference-map-2026-11.md)
- [WARENA stack register](STACK-REGISTER.md)
- [WARENA technical knowledge base](knowledge-base-index.md)
