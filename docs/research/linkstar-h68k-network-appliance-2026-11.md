# LinkStar-H68K as a WARENA Network-Appliance Candidate

**Status: RESEARCH.** This is an evaluation record, not a procurement decision, deployment guide, compatibility claim, or endorsement. No LinkStar-H68K is currently evidenced as owned, installed, or tested by WARENA.

## Source record

- Article: [LinkStar-H68K – The Mini Computer Positioned as a Router](https://www.electronics-lab.com/linkstar-h68k-the-mini-computer-positioned-as-a-router/)
- Publisher: Electronics-Lab
- Article date: 2023-01-19
- Vendor product page: [Seeed Studio LinkStar-H68K](https://www.seeedstudio.com/LinkStar-H68K-1432-p-5501.html)
- Source class: secondary review / historical product description
- Limitations: article-era specifications and software-support statements; not a current vendor datasheet, firmware release matrix, independent security audit, or WARENA bench test.

Preserve this source as historical evidence. Reconfirm board revision, exact SKU, current vendor documentation, software images, wireless-module variant, price, availability, and warranty before procurement.

## Article-reported hardware

The following values are reported by the 2023 article, not independently verified measurements by WARENA.

| Component | Article-reported specification |
|---|---|
| SoC | Rockchip RK3568, quad-core Cortex-A55, up to 2.0 GHz |
| GPU | Arm Mali-G52 2EE |
| NPU | Up to 0.8 TOPS |
| Memory | 4 GB LPDDR4X (article also mentions a 2 GB variant) |
| On-board storage | 32 GB eMMC |
| Expansion | microSD, USB 3.0 Type-C, USB 3.0 Type-A, 2 × USB 2.0 Type-A |
| Ethernet | 2 × 2.5GbE via RTL8125B; 2 × 1GbE via RTL8211F |
| Wireless | Optional Wi-Fi 6; Bluetooth 5.2 via optional MediaTek MT7921 PCIe module |
| Display / media | HDMI 2.1, claimed up to 4Kp60; 3.5 mm audio |
| Power | 5–24 V DC barrel input or 5 V USB-C; article reports 8 W |
| Physical | 80 × 60 × 40 mm metal enclosure |
| Software named in article | Ubuntu, Debian, OpenWrt, Android 11, Armbian, Buildroot |

The detailed interface list and marketing highlights do not guarantee that every SKU exposes every interface or that every named OS image supports every optional module.

## WARENA fit

### Plausible roles to investigate

1. **Multi-port edge router / firewall** — WAN, trusted LAN, guest and management segmentation, subject to driver, offload and throughput testing.
2. **Local-services node** — DNS/DHCP, local package or documentation cache, monitoring, small internal services and controlled file transfer.
3. **Portable network lab** — reproducible demonstrations of VLANs, routing, firewall policy and offline-first services.
4. **Low-power edge gateway** — protocol bridging and telemetry only where data collection is explicit and locally governed.

### Not established by the article

- Stateful firewall throughput, packet-per-second performance, latency under load, or simultaneous bidirectional throughput.
- VLAN, bridge, bonding, hardware-offload, nftables, WireGuard, IPv6 and QoS behaviour on a chosen image/kernel.
- Stability and upstream support of RTL8125B / RTL8211F drivers under sustained multi-port load.
- Wi-Fi 6 support for the exact optional module and selected OS image.
- Secure boot, firmware update provenance, signed releases, recovery procedure, SBOM, CVE response or update lifecycle.
- eMMC endurance, thermal throttling, power-loss behaviour, measured wall power, or sustained operation in a hot enclosure.
- Availability, current price, shipping, warranty or local repairability in Kenya.

## Evaluation against WARENA requirements

| Requirement | Initial assessment | Evidence needed |
|---|---|---|
| Multi-gigabit wired interfaces | Promising port mix | Exact board/SKU inspection; ethtool; sustained iperf3 in both directions |
| Segmentation and firewalling | Candidate only | VLAN trunk/access tests, nftables policy tests, isolation and negative-flow tests |
| Local-first services | Plausible | Service dependency map; disconnect-WAN test; local DNS and service validation |
| Reproducible GNU/Linux | Unknown | Supported kernel/device tree, firmware provenance, package availability and reproducible image/build path |
| Guix compatibility | Unknown / high risk | Confirm architecture support, kernel/device-tree path, boot chain and required firmware before attempting a system image |
| Wi-Fi | SKU- and image-dependent | Identify exact module; verify firmware, regulatory domain and driver support |
| Storage / NAS | Limited until tested | USB bridge compatibility, filesystem support, SMART visibility, sustained I/O and backup/restore tests |
| Low-power operation | Article claims 8 W | Measure idle, typical and peak wall power with selected image and peripherals |
| Maintainability | Unknown | Update policy, recovery media, console access, board documentation and replacement availability |

## Test plan before any purchase or deployment

### Gate 0 — identity and procurement

- Obtain the current vendor datasheet and identify exact board revision and SKU.
- Confirm whether Wi-Fi / Bluetooth module is installed and supported by the intended OS.
- Confirm power-supply voltage, polarity, current rating and connector.
- Confirm bootloader, recovery method, image checksums/signatures and firmware update procedure.
- Obtain current landed cost, warranty and return terms for Kenya.

**Pass condition:** exact hardware and software variant are documented, with a credible recovery path.

### Gate 1 — operating-system and driver qualification

- Boot a vendor-supported, checksum-verified image from removable media where possible.
- Record kernel, device tree, bootloader, firmware packages and interface mapping.
- Verify all four Ethernet ports individually and under simultaneous traffic.
- Verify Wi-Fi and Bluetooth only if the optional module is present.
- Test reboot, cold boot, power interruption recovery and factory reset in a controlled environment.

**Pass condition:** every required interface is identified and stable; no undocumented binary or remote service is required for the core router function.

### Gate 2 — network performance and security

- Measure each port separately and in realistic combinations using iperf3.
- Record throughput, packet loss, latency, CPU load and temperature.
- Test routing, NAT, IPv4/IPv6, DHCP, DNS, VLAN isolation, firewall allow/deny rules and management-plane isolation.
- Test WireGuard only after kernel/module support and cryptographic performance are verified.
- Test WAN-disconnected operation and ensure local services remain available.
- Do not expose management interfaces to WAN during qualification.

**Pass condition:** measured results meet a written workload target; segmentation and denied-flow tests pass; no performance figure is inferred from link speed.

### Gate 3 — reliability and operations

- Run a sustained mixed network workload and monitor thermal behaviour.
- Measure wall power at idle and representative load.
- Test storage I/O, filesystem recovery and backup/restore using non-critical data.
- Document update cadence, rollback, configuration backup and physical recovery.
- Record all commands, versions, test duration, results and failures.

**Pass condition:** repeatable test evidence and an operator-usable recovery procedure exist.

## Recommended WARENA position

Keep the LinkStar-H68K on the **RESEARCH / candidate** list. Do not make it the default WARENA router, NAS, production gateway or IKAI compute platform based on this article alone.

For an initial network-appliance comparison, evaluate it against:
- a supported x86-64 mini-PC with Intel/AMD NICs;
- a purpose-built OpenWrt router with a documented support lifecycle;
- a low-power ARM board with upstream-supported Ethernet and a clear boot/recovery chain.

Compare total cost, driver maturity, update lifecycle, recovery, power, sustained throughput and local availability—not port count or TOPS alone.

## Evidence record template

For any physical evaluation, create a separate host inventory record and attach:
- exact SKU, board revision and photographs;
- purchase and warranty evidence;
- OS image URL, checksum/signature, kernel and device-tree revision;
- bootloader and firmware versions;
- network topology and test configuration;
- raw benchmark outputs and temperature/power measurements;
- security test results, recovery steps and known limitations;
- operator, test date and repository commit.

Never publish serial numbers, Wi-Fi credentials, private keys, customer traffic or sensitive network topology.

## Decision log

| Decision | State |
|---|---|
| Add H68K to WARENA research corpus | DOCUMENTED |
| Approve purchase | NOT DECIDED |
| Approve production deployment | NOT APPROVED |
| Claim Guix compatibility | NOT VERIFIED |
| Claim OpenWrt / Debian / Ubuntu support for the exact current SKU | NOT VERIFIED |
| Treat as an IKAI product | NO — IKAI remains a separate research identity |

---

**Review trigger:** revisit this note when current vendor documentation, exact SKU evidence, or a physical test unit becomes available.
