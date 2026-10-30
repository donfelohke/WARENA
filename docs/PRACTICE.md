# WARENA — Practice (operating notes)

## Engagement workflow

1. Capture problem, outcome, constraints (budget, offline, multi-user)  
2. Inspect current environment  
3. Propose scope, risks, price, support window  
4. Agree **before** work  
5. Implement with notes  
6. Handover: credentials path (never in git), recovery steps, what changed  

## Capability checklist (public)

- [ ] GNU/Linux install / admin / troubleshoot  
- [ ] Diagnostics / recovery / maintenance  
- [ ] Wi-Fi / LAN / router basics  
- [ ] Small-office shared services  
- [ ] Lab / classroom / cybercafé patterns  
- [ ] Local-first / offline-capable setups  
- [ ] Reproducible dev environments (when in scope)  

## Templates to add next

- `templates/engagement-brief.md`  
- `templates/handover.md`  
- Host-specific runbooks only when a real host is LIVE  

## Security

Never commit secrets, customer data, or private keys. Rotate anything that may have leaked.


## Upstream changes

When a practice depends on upstream software, pin the full source revision and relevant channel introductions, record licence obligations, and test on the named target. Do not describe research stacks as offered or deployed. See [UPSTREAM-SOURCE-REGISTER.md](./UPSTREAM-SOURCE-REGISTER.md).
