# WARENA Security Policy

## Scope

This repository may eventually contain operating-system configurations, network designs, deployment scripts, and operational runbooks. Security-sensitive findings should be reported privately rather than disclosed through a public issue.

## Reporting

Use the private contact method published on the maintainer's GitHub profile or repository owner page. Include the affected file or component, impact, reproduction steps, and any relevant version or commit. Do not include live credentials or private user data in the report.

## Safe handling

- Never commit passwords, access tokens, private keys, recovery codes, or production configuration secrets.
- Redact sensitive hostnames, IP details, logs, and personal data when publishing examples.
- Rotate/revoke any credential that may have been exposed and assess affected systems.
- Prefer scoped, short-lived credentials and least-privilege permissions.
- Treat security-sensitive deployment instructions as unverified until reviewed and tested.

## Current status

This policy documents an intended reporting process. It does not assert that automated secret scanning, push protection, code scanning, or branch rules are enabled. Verify these settings independently in GitHub.
