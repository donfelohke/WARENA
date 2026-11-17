# WARENA — Post-install GitHub Setup

**Document ID:** WARENA-GITHUB-POSTINSTALL-2026-11  
**Date:** 2026-11-18  
**Status:** OPERATOR RUNBOOK — NOT A HOST EXECUTION RECORD  
**Configuration home:** `donfelohke/WARENA`  
**Policy:** establish a verified GitHub workflow first; rebase is deferred.

This guide configures GitHub access after the Guix System/RDE workstation is installed and its network, user account and recovery path have passed first-boot checks. It does not claim that any workstation has been configured.

## 1. Preconditions

- [ ] Installed system boots reliably and the intended non-root user can log in.
- [ ] Network and DNS work.
- [ ] System clock is correct (TLS/SSH authentication depends on it).
- [ ] A secure user home exists and permissions are correct.
- [ ] A recovery/backup plan exists before changing the workstation configuration.

Do not configure GitHub from the root account. Run user-level commands as the intended operator.

## 2. Install or expose the required tools

Required tools:

- Git — version control.
- OpenSSH client — SSH transport and key management.
- GitHub CLI (`gh`) — optional but recommended for authenticated GitHub operations.

On Guix System, add packages declaratively to the appropriate system or home configuration and apply that reviewed configuration. Package names to verify against the selected Guix channel are `git`, `openssh` and `gh`. Avoid treating a one-off profile install as the canonical workstation declaration.

Verify availability:

```sh
git --version
ssh -V
gh --version
```

If `gh` is not installed, Git over SSH can still be used; do not block the basic Git workflow on the optional CLI.

## 3. Set Git identity

Use the name and email intended for public commit attribution. Confirm the email is verified on the GitHub account before using it for public commits.

```sh
git config --global user.name "Felix Lwova"
git config --global user.email "YOUR_VERIFIED_GITHUB_EMAIL"
git config --global init.defaultBranch main
git config --global pull.ff only
git config --global fetch.prune true
```

Replace the placeholder with the verified address; do not commit the placeholder. If a different public attribution is desired, set it deliberately. Inspect the result:

```sh
git config --global --list
```

Do not set `user.signingkey` or enable commit signing until the signing key and verification path have been deliberately provisioned.

## 4. Create an SSH key

Check for existing keys before generating anything:

```sh
ls -la ~/.ssh
```

If there is no suitable key, create a dedicated Ed25519 key. Use a strong passphrase and do not overwrite an existing key:

```sh
ssh-keygen -t ed25519 -C "YOUR_VERIFIED_GITHUB_EMAIL" -f ~/.ssh/id_ed25519
```

Start the agent for the current login session and add the key:

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

Display only the public key for registration:

```sh
cat ~/.ssh/id_ed25519.pub
```

Add that public key to the GitHub account under **Settings → SSH and GPG keys → New SSH key**. Never upload, paste, commit or share the private key (`~/.ssh/id_ed25519`). Do not put private keys, tokens, recovery codes or passphrases in this repository.

Test authentication:

```sh
ssh -T git@github.com
```

The first connection may ask you to verify GitHub's host key. Compare the presented fingerprint with GitHub's currently published SSH host-key fingerprints using a trusted channel before accepting it. A successful authentication message may state that shell access is not provided; that is expected.

## 5. Authenticate GitHub CLI (optional)

If `gh` is installed:

```sh
gh auth login
gh auth status
```

Choose GitHub.com, SSH as the Git protocol, and the browser-based authentication flow where available. Review requested scopes and grant only what is needed. Never place a personal access token directly in shell history or repository files.

## 6. Clone the canonical WARENA repository

The canonical configuration repository is `donfelohke/WARENA`. There is no separate `warena-rde` configuration repository.

```sh
mkdir -p ~/src
cd ~/src
git clone git@github.com:donfelohke/WARENA.git
cd WARENA
git remote -v
git status --short --branch
git log -5 --oneline --decorate
```

Expected origin:

```text
git@github.com:donfelohke/WARENA.git
```

If the repository already exists, inspect its path, remote, branch and working tree before cloning or changing anything. Do not overwrite an existing checkout.

## 7. First synchronisation — fast-forward only

Fetch remote references and inspect the current branch:

```sh
git fetch --prune origin
git status --short --branch
git branch --show-current
git rev-parse --short HEAD
git rev-parse --short origin/main
```

For the `main` branch, only fast-forward when the working tree is clean and Git confirms that the update is a fast-forward:

```sh
git switch main
git merge --ff-only origin/main
```

If the branch is not named `main`, if local commits exist, or if Git reports divergence, stop and inspect the graph. Do not force-push, reset, discard work or rewrite history as a shortcut.

## 8. Normal contribution workflow

Create a descriptive feature branch for a discrete change:

```sh
git switch -c docs/describe-the-change
```

Review before committing:

```sh
git status --short
git diff --check
git diff
```

Stage explicit paths rather than blindly staging secrets or generated files:

```sh
git add path/to/reviewed-file
git diff --cached --check
git diff --cached
git commit -m "docs: describe the change"
```

Publish the branch:

```sh
git push -u origin HEAD
```

Open a pull request for review (using the GitHub web interface or `gh pr create`). Do not push directly to `main` unless the repository's current contribution policy explicitly permits it.

## 9. Rebase policy — deferred

**Rebase is intentionally not part of initial post-install setup.**

Until a separate review:

- Do not run `git rebase`, `git pull --rebase`, interactive rebase or history-rewrite commands.
- Do not force-push or use `--force-with-lease`.
- Use `git fetch` and fast-forward-only updates for a clean, non-diverged `main`.
- If a feature branch diverges, preserve it and inspect `git log --graph --oneline --decorate --all`; decide later whether merge, rebase or a fresh branch is appropriate.
- Never rewrite shared branch history without an explicit decision and coordination with affected contributors.

Rebase can be evaluated after the initial workstation setup, repository state and branch protections have been audited.

## 10. Security and recovery checklist

- [ ] Private SSH key is passphrase-protected and readable only by its owner.
- [ ] Public key is registered on the intended GitHub account.
- [ ] GitHub SSH host key was verified before first trust.
- [ ] Git identity uses a verified, intended commit email.
- [ ] GitHub CLI authentication is scoped and verified, if used.
- [ ] No tokens, private keys, passphrases or recovery codes exist in Git history.
- [ ] Repository working tree is clean or all local work is documented.
- [ ] Remote points to the canonical WARENA repository.
- [ ] A test branch can be pushed and inspected, if write access is required.
- [ ] Configuration and key recovery procedures are documented without exposing secrets.

## 11. Host evidence record

Record only after the operator has actually performed the checks:

| Field | Value |
|---|---|
| Host identifier (non-sensitive) | UNKNOWN |
| Setup date | UNKNOWN |
| Guix version / generation | UNKNOWN |
| Git version | UNKNOWN |
| OpenSSH version | UNKNOWN |
| GitHub CLI version | UNKNOWN / NOT INSTALLED |
| GitHub SSH authentication | NOT TESTED |
| GitHub CLI authentication | NOT TESTED |
| Canonical remote verified | NOT TESTED |
| Test branch push | NOT TESTED |
| Rebase | DEFERRED |
| Operator notes | UNKNOWN |

This document is a procedure, not evidence of execution. Mark each check only from observed results.

## References

- [Git documentation](https://git-scm.com/docs)
- [GitHub — Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [GitHub — Testing your SSH connection](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection)
- [GitHub CLI manual](https://cli.github.com/manual/)
- [GNU Guix 1.5.0 manual](https://guix.gnu.org/manual/1.5.0/)
- [WARENA RDE pre-install and post-install runbook](RDE-PREINSTALL-POSTINSTALL-RUNBOOK.md)
