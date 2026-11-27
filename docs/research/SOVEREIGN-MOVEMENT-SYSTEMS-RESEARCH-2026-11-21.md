# Sovereign Movement Systems — Research Dossier

**Date:** 21 November 2026  
**Owner:** WARENA · CAPABILITY  
**Related domains:** NAKEBUSEN · ROOT; IKAI · MIRROR; GENJE · EXPRESSION; FELOH Corpus  
**Status:** RESEARCH / SYSTEMS LANDSCAPE  
**Implementation status:** No vehicle, charger, battery system, microgrid, V2X network or embedded controller is selected, built, installed or validated by this document.

## 1. Research proposition

**Sovereign Movement Systems** studies mobility, energy, computation and local infrastructure as one socio-technical system.

The working proposition — *EVs are compute boxes in motion* — is useful as a systems lens, but incomplete if it reduces a vehicle to software. An electric vehicle is simultaneously:

- a physical transport machine;
- an electrochemical energy-storage system;
- a power-electronics and motor-control system;
- a distributed embedded-computing system;
- a network of sensors, actuators and controllers;
- a safety-critical product;
- an asset embedded in a local transport economy and energy system.

The research objective is to identify where open software, interoperable interfaces, local energy and repairable infrastructure can increase user and operator control without confusing experimental software with safety-critical vehicle control.

## 2. System boundary

Study the system as seven connected layers.

| Layer | Components | Questions |
|---|---|---|
| Energy supply | Grid, solar PV, generator backup, microgrid | Availability, tariff, reliability, local generation |
| Storage and conversion | Battery packs, BMS, inverter, DC/DC, charger | Chemistry, safety, degradation, serviceability |
| Vehicle | Motor, controller, drivetrain, chassis, thermal system | Duty cycle, payload, terrain, maintainability |
| Embedded control | MCU, RTOS, ECUs, diagnostics, CAN | Timing, fault handling, interface ownership |
| Application compute | Linux, HMI, navigation, media, fleet applications | Isolation, updates, data sovereignty |
| Network and services | CAN, Ethernet, cellular, Wi-Fi, V2X, charging protocols | Interoperability, connectivity loss, cybersecurity |
| Governance and lifecycle | Operator, driver, owner, technician, county, regulator | Safety, repair rights, cost, accountability, recycling |

Do not assume all layers need one operating system. A Linux infotainment or edge-compute node is not a replacement for a qualified motor controller or battery-management system.

## 3. Open-source vehicle software landscape

The following are candidate upstream projects, not a selected stack.

| Project / technology | Role to investigate | Boundary |
|---|---|---|
| Automotive Grade Linux (AGL) | Linux-based automotive platform and vehicle software integration | Primarily application/platform environment; not automatic safety certification |
| AGL SoDeV | Software-defined vehicle reference architecture and integration approach | Reference platform, not a turnkey vehicle |
| Eclipse OpenBSW | Embedded automotive basic-software components in C++ | Does not provide the full AUTOSAR BSW/RTE stack |
| Zephyr | Open-source RTOS for resource-constrained embedded devices | Qualification depends on target, configuration and safety requirements |
| EVerest | EV charging software, protocol modules, hardware interfaces and energy-management integration | Charger/EVSE scope; not a universal vehicle control stack |
| Linux SocketCAN | Linux CAN networking and diagnostics interfaces | Requires correct physical transceivers, bus design and protocol knowledge |
| QEMU | Virtual machine and system emulation | Virtual tests do not prove real hardware timing or electrical safety |
| Renode | Embedded-system simulation and testing | Model fidelity and target support must be established |
| GCC / LLVM, Zephyr SDK, OpenOCD | Toolchain, compiler, debug and development tooling | Vendor MCU support, compiler versions and licensing vary |

There is no single universal, open “EV SDK” that covers every vehicle, battery, motor controller, charger and safety function. The practical SDK/IDE stack is target-specific: MCU vendor tooling, compiler and linker, RTOS or bare-metal framework, hardware abstraction, flashing/debugging tools, simulation, protocol definitions and test equipment.

**Research rule:** compare the project’s actual upstream source, release cadence, licence, supported boards, toolchain, protocol coverage, test suite, security process and maintenance community. Do not infer suitability from an “open source” label.

### 3.1 Virtual-first development

Before touching a vehicle, investigate a reproducible virtual test bench:

1. Linux host with SocketCAN and `vcan`.
2. QEMU or Renode for supported embedded targets.
3. Recorded, synthetic and explicitly licensed CAN traces.
4. Protocol decoders and deterministic test vectors.
5. Fault injection for timeout, invalid frames, bus-off and loss of connectivity.
6. Hardware-in-the-loop only after a documented electrical and safety plan.

Virtualisation is useful for application, protocol and integration tests. It cannot establish real motor response, battery safety, electromagnetic compatibility, thermal behaviour, braking performance or roadworthiness.

## 4. Kenyan mobility context

Kenya launched its National Electric Mobility Policy on 3 February 2026. The policy establishes a national framework for EV uptake, infrastructure, standards, skills and local industry. The Ministry of Roads and Transport subsequently described county-level implementation work, including a proposed model County Electric Mobility Bill and identification of model counties. Treat those proposals as implementation activity, not as proof that a county law has already been enacted.

**Local research questions:**

- How do national policy and charging rules translate into Uasin Gishu County and Eldoret?
- Which charging, electrical installation, inspection and business permits apply to a proposed site?
- What are the actual operating patterns of nduthi/boda-boda and matatu operators?
- What daily distance, payload, route, gradient, dwell time and availability requirements determine battery sizing?
- How do purchase price, finance, charging cost, battery replacement, downtime and residual value affect total cost of ownership?
- What local repair skills, spare parts and battery end-of-life systems exist?

Do not infer EV adoption, fleet size or market share in Eldoret from national totals or Nairobi-focused observations.

### 4.1 Matwana and nduthi as operating environments

Treat matatu and nduthi cultures as living transport systems, not merely vehicle categories. They have distinct ownership, labour, route, revenue, passenger, maintenance and cultural patterns.

Candidate use cases:

- **Nduthi:** high daily utilisation, short stops, battery swapping or opportunity charging, payload variability, repair turnaround and driver income.
- **Matatu:** route-specific energy demand, passenger capacity, depot dwell time, charging-site availability, fleet finance, route scheduling and vehicle uptime.
- **Shared energy hub:** charging, battery health checks, maintenance, solar/grid supply, secure storage, payment records and locally governed operations.
- **Portable power:** support for tools, communications, lighting and temporary operations, subject to inverter output, battery chemistry, protection and load limits.

These are research hypotheses. Field interviews and measured duty cycles are required before selecting a business model or vehicle architecture.

## 5. Energy, off-grid spaces and portable power

An off-grid or weak-grid mobility site may combine:

- grid connection where available;
- solar PV generation;
- stationary battery storage;
- EV charging;
- portable power stations;
- critical-load circuits;
- local compute and network equipment;
- monitoring and maintenance.

A portable power station such as an EcoFlow unit is a commercial product category and useful market comparator, not an open standard or a sovereign infrastructure foundation. Evaluate its interface openness, battery replacement, warranty, repair options, inverter limits, charge inputs, telemetry requirements and service availability. Do not assume it supports vehicle-to-home (V2H), vehicle-to-grid (V2G), bidirectional charging or safe direct battery integration.

**Critical distinctions:**

- EV battery ≠ stationary storage system by default.
- DC connector compatibility ≠ charging-protocol interoperability.
- Battery capacity ≠ usable energy at the required power.
- A solar panel rating ≠ delivered energy under local conditions.
- Portable power station ≠ certified building electrical installation.
- V2G/V2H capability must be supported by the vehicle, EVSE, inverter, communications and applicable grid rules.

Battery installation, charging infrastructure, high-voltage work and grid connection require qualified personnel, applicable standards, inspections and protective systems. This document is not an electrical installation design.

## 6. East African evidence and energy justice

Two useful research sources connect the energy and mobility questions:

1. Kakande, Philipo and Krauter (2024), *Optimized E-Mobility and Portable Storage Integration in an Isolated Rural Solar Microgrid in Uganda*, analyses electric two-wheelers and portable storage in an East African solar microgrid. It is a modelling/research case, not a measured forecast for Kenya or Eldoret. DOI: https://doi.org/10.3390/solar4040033
2. Kasper (2025), *Nairobi’s batteryscape: everyday electricity storage, energy justice, and infrastructural heterogeneity in urban Africa*, studies household battery practices, energy infrastructure and unequal access in Nairobi. It is a valuable urban Kenyan comparison, not a direct description of Eldoret. DOI: https://doi.org/10.1007/s11625-025-01645-3

The research implication is that battery infrastructure must be assessed through ownership, access, repair, waste, safety, cost and the distribution of benefits—not only energy efficiency.

## 7. Kenyan policy and regulatory source set

- Ministry of Roads and Transport, National Electric Mobility Policy launch: https://transport.go.ke/kenya-launches-national-electric-mobility-policy-drive-cleaner-efficient-and-sustainable-transport
- National Electric Mobility Policy PDF: https://e-mobilitykenya.org/wp-content/uploads/2026/02/Emobility_Policy.pdf
- County implementation update: https://www.transport.go.ke/index.php/node/792
- EPRA, Electric Vehicle Charging and Battery Swapping Infrastructure Guidelines: https://www.energy.go.ke/sites/default/files/KAWI/Other%20Downloads/EPRA-E-Mobility-Guidelines.pdf

Read the current versions and confirm amendments before any installation, procurement or public claim. Also identify relevant KEBS standards, electrical codes, county planning/building requirements, environmental rules and battery-waste obligations before designing a real site.

## 8. Sovereignty and design requirements

A candidate system should be evaluated against:

- **Operational sovereignty:** can it continue basic operation when WAN/cloud services are unavailable?
- **Data sovereignty:** who can access location, route, driver, vehicle and battery records?
- **Repair sovereignty:** can local technicians diagnose and repair it with available tools and documentation?
- **Software sovereignty:** can software and firmware dependencies be inspected, updated and rolled back?
- **Energy sovereignty:** can the operator understand energy flows, tariffs, storage limits and failure modes?
- **Supply-chain transparency:** are battery cells, controllers, chargers and software dependencies traceable?
- **Cultural accountability:** are operator and community practices reflected in system design rather than imposed by a generic fleet model?
- **Safety:** are safety-critical functions isolated and validated through appropriate engineering processes?

## 9. Proposed research method and measurements

Do not select hardware before gathering:

1. Operator interviews and consented route observations.
2. Vehicle duty-cycle records: distance, speed profile, stops, load and terrain.
3. Energy measurements: kWh/km, charging losses, peak power and dwell time.
4. Battery data: usable capacity, temperature, cycle history, degradation and warranty.
5. Charging data: connector, protocol, power, uptime, utilisation and queueing.
6. Economics: purchase/lease, finance, energy, maintenance, downtime and replacement.
7. Infrastructure: grid capacity, solar resource, land, security, ventilation and access.
8. Lifecycle: repair, reuse, second-life suitability, collection and recycling.

Every field study requires informed consent, data minimisation and clear limits on recording drivers, passengers and location histories.

## 10. Decision gates

| Gate | Required evidence | No-go condition |
|---|---|---|
| G0 — Use case | Named operator group, route/duty-cycle questions and research consent | Generic “EV market” assumption |
| G1 — Policy | Current national, county, electrical and environmental requirements | Unverified installation or licensing assumptions |
| G2 — Energy | Load profile, grid/solar/storage model and protection concept | Nameplate-only sizing |
| G3 — Vehicle | Target platform, service data, parts and warranty | Untraceable battery/controller or unsupported modification |
| G4 — Software | Upstream review, licence, target support and virtual tests | Treating app Linux as safety controller |
| G5 — Safety | Qualified review, isolation, fault handling and applicable certification | Unqualified high-voltage or road testing |
| G6 — Pilot | Budget, operator agreement, baseline metrics and rollback | No maintenance, battery end-of-life or accountability plan |

## 11. Source and upstream register

- Automotive Grade Linux: https://www.automotivelinux.org/
- AGL SoDeV source discovery: the previously recorded GitHub URL (https://github.com/AGLExport/SoDeV) returned 404 during the 2026-11-27 link audit. Repository identity, current source and maintainer remain unverified; treat this as an unresolved research lead, not a reusable dependency, until a primary source is located.
- Eclipse OpenBSW: https://github.com/eclipse-openbsw/openbsw
- Zephyr Project: https://www.zephyrproject.org/
- EVerest: https://github.com/EVerest/everest
- Linux SocketCAN documentation: https://docs.kernel.org/networking/can.html
- QEMU system emulation: https://www.qemu.org/docs/master/system/index.html
- Renode: https://renode.io/
- OpenOCD: https://openocd.org/
- Uganda microgrid and e-mobility study: https://doi.org/10.3390/solar4040033
- Nairobi batteryscape study: https://doi.org/10.1007/s11625-025-01645-3

Accessed/reviewed for this research update: 21 November 2026. Upstream links are discovery entry points; review exact releases, licences and source trees before adopting any component.

---

**Maturity statement:** RESEARCH. No EV conversion, charging station, microgrid, portable-power integration, embedded controller, SDK stack or road test is claimed as implemented or validated.

**WARENA enables. Freedom Is a System.**
