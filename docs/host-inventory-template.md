# Host Inventory Record

**Status: TEMPLATE.** Copy this file for a specific host; do not fill it with guessed values. Store sensitive inventory separately when publication would expose a system.

## Record metadata

- Record ID:
- Date collected (ISO 8601):
- Maintainer / operator:
- Evidence links or attachment references:
- Status: `UNKNOWN` until observed

## Purpose and ownership

- Host/system name or safe alias:
- Purpose and users:
- Owner / approval contact:
- Physical or virtual:
- Location description (omit sensitive details in public records):

## Hardware and firmware

- Manufacturer/model:
- CPU / architecture:
- RAM:
- Storage devices and capacity:
- Firmware/UEFI version:
- Secure Boot state (observed):
- NICs / Wi-Fi / other interfaces:
- Connected peripherals:
- Known hardware constraints:

## Software baseline

- OS/distribution and version:
- Kernel:
- Boot method:
- Package manager / channels:
- Configuration repository and commit:
- RDE/Guix profile or manifest (if applicable):
- Critical services and versions:
- Time synchronisation:
- Encryption configuration (describe only; never include keys):

## Network and trust boundaries

- Interface names and roles:
- Addressing method (DHCP/static; avoid publishing sensitive addresses):
- VLAN/zone:
- Firewall policy reference:
- Exposed services and ports:
- DNS and gateway dependencies:
- Remote access method:
- Dependencies on external connectivity:
- Threats and trust assumptions:

## Recovery readiness

- Known-good boot/recovery method:
- Backup scope and location reference:
- Last backup result and date:
- Last restoration test result and date:
- Rollback procedure:
- Required access or dependencies (no credentials):
- Recovery limitations:

## Validation and evidence

| Check | Command/procedure | Expected result | Observed result | Date | Evidence |
|---|---|---|---|---|---|
| Hardware inventory | | | NOT RUN | | |
| OS/version | | | NOT RUN | | |
| Storage health | | | NOT RUN | | |
| Network reachability | | | NOT RUN | | |
| Service status | | | NOT RUN | | |
| Backup integrity | | | NOT RUN | | |
| Restore test | | | NOT RUN | | |

## Changes and open risks

- Last reviewed:
- Known issues:
- Pending changes:
- Rollback owner:
- Retirement/disposal requirements:


## Software provenance fields

For each installed upstream component, record canonical source, full revision or release, package/channel origin, channel introduction authentication and configuration reference. If unknown, record UNKNOWN; never infer from a project default branch. See [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md).
