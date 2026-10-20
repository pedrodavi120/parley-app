# Security Policy

The Parley team and Void Studio take the security and privacy of our users, contributors, and systems very seriously.

---

## Supported Versions

| Version | Supported |
| ------- | --------- |
| 1.0.x   | Yes       |
| < 1.0   | No        |

---

## Reporting a Vulnerability

If you discover a security vulnerability, sensitive data exposure, or potential exploit in Parley, **please do not disclose it publicly via GitHub issues or discussions.**

### Contact
Please send a private security report to:
- **Email:** `contato@voidstudio.com.br` (or the project maintainer's direct contact)
- **Subject:** `[SECURITY] Parley Vulnerability Report`

### What to Include in Your Report
To help us triage and resolve the issue quickly, please provide:
1. Description of the vulnerability.
2. Steps to reproduce the vulnerability (proof of concept, scripts, or screenshots).
3. The affected platform (Android, iOS, macOS, Windows, Linux, Web).
4. Potential impact or risk assessment.

### Our Response Timeline
- **Initial Response:** Within 48 hours acknowledging receipt of your report.
- **Triage & Assessment:** Regular updates regarding validation and fix progress.
- **Resolution & Release:** A patched version will be tagged and released, followed by public acknowledgment (unless anonymity is preferred).

---

## Secrets Management & Open Source Safety

- **No Hardcoded Credentials:** Never hardcode API keys, signing certificates, keystore passwords, or tokens in source code.
- **Environment Isolation:** All sensitive configuration keys must reside exclusively in `.env` (which is excluded by `.gitignore`).
- **Secret Scanning:** We encourage contributors to run tools such as `git-secrets` or `gitleaks` prior to opening pull requests.
