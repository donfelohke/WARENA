# Network and Local Services Runbook

**Status: PROPOSAL.** Use this for planning and controlled validation. It is not evidence that any router, VLAN, hotspot, VPN, server, PXE lab, failover path, or local cache has been deployed.

## Scope

Use for LAN/Wi-Fi, router/firewall, VLAN, DNS/DHCP, VPN, local services, internet failover, and lab-network changes.

## 1. Define the change

- Service or problem:
- Owner and approval:
- Site/system alias:
- Current topology diagram/reference:
- Intended topology:
- Users and critical dependencies:
- Change window:
- Expected outage:
- Success criteria:
- Rollback trigger and decision owner:

## 2. Map trust boundaries

Record only the details necessary for the engineering task:
- WAN/ISP links and failover assumptions.
- LAN, guest, management, server, and lab zones.
- Addressing and DHCP/DNS responsibilities.
- Firewall zones, allowed flows, and denied flows.
- Administrative access path and MFA/key management approach.
- Exposed services, ports, and service owners.
- Logging/monitoring locations and retention.
- External dependencies and offline behaviour.

Apply least privilege. Do not publish credentials, VPN private keys, customer traffic, or sensitive internal topology in public examples.

## 3. Pre-change checks

- Export or otherwise preserve a known-good configuration securely.
- Confirm out-of-band or physical recovery access.
- Check storage, power, firmware, interface mapping, and dependency status.
- Verify the current route and management access.
- Identify non-destructive checks first.
- Confirm the rollback procedure is usable before applying changes.

## 4. Validation matrix

| Area | Example check | Expected result | Observed result |
|---|---|---|---|
| Management access | Approved admin path | Reachable only by authorised operator | NOT RUN |
| DHCP | Lease on intended zone | Correct scope and gateway | NOT RUN |
| DNS | Resolve approved local/external names | Intended resolver answers | NOT RUN |
| Segmentation | Test allowed and denied flows | Only documented flows pass | NOT RUN |
| Wi-Fi/guest | Join and isolation checks | Guest access matches policy | NOT RUN |
| WAN failover | Controlled link failure in test window | Recovery matches target | NOT RUN |
| VPN | Authenticated connection and denied unauthorised access | Only approved routes available | NOT RUN |
| Local services | Service health and dependency check | Expected service response | NOT RUN |
| Offline mode | Remove external dependency in test environment | Documented local functions remain available | NOT RUN |

Choose commands and test cases appropriate to the actual platform; these examples are not universal commands.

## 5. Apply and observe

Apply the smallest reversible change. Capture timestamps, relevant logs, configuration revision, and observed behaviour. Redact public logs and avoid retaining personal traffic data unnecessarily.

## 6. Rollback

Rollback if a stated trigger occurs, including loss of management access, unexpected exposure, broken critical service, or failed acceptance test. Restore the known-good configuration using the pre-agreed method, then verify management access, routing, DNS, and critical services.

## 7. Close-out

Record final configuration revision, tests run, failures, residual risks, outage, rollback outcome if applicable, owner acceptance, and next review date. A design diagram or successful ping alone does not establish secure segmentation or production readiness.
