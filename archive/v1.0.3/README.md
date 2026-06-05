// @it-skill-patch: rebrand_readme@v1.1
# it-skill-cli 🛡️🌊

Enterprise-grade skill management and lifecycle governance for the `itinfosv` fleet.

## 🚀 Fleet Status & Announcements

### v1.0.1 (Alignment Release) — 2026-06-04
**"INSTALLATION ALIGNED"** 🛡️
- **Command Standardized**: Primary command is now `it-skill`.
- **Lightweight Distribution**: Switched to Bash wrapper (bunx-based) to replace large binaries.
- **Path Aligned**: Installation directory moved to `~/.it-skill/bin`.

---

## 📦 Installation (ghq)

Install the IT-Skill CLI to your system using `ghq` to ensure high-integrity source management and automated updates.

```bash
ghq get -u itinfosv/it-skill-cli
cd $(ghq list -p itinfosv/it-skill-cli)
./install.sh
```

After installation, you can verify it by running:
```bash
it-skill --version
# Expected: 1.0.1
```

### Bootstrap Governance Skills
Once installed, use the CLI to bootstrap the core governance toolkit:
```bash
it-skill go standard
```

---

## 🛠️ Development & Contribution

For developers wishing to contribute or inspect the source:

```bash
ghq get itinfosv/it-skill-cli
cd $(ghq list -p itinfosv/it-skill-cli)
bun install
bun run build
```

---

## 📚 Governance Skills

IT-Skill CLI comes pre-equipped with 4 mandatory governance skills:

| Skill | Description |
|---|---|
| **build-rfc** | Requirement specification and phase-gate management. |
| **build-patch** | Surgical code injection and regression-free verification. |
| **close-rfc** | Lifecycle management and workspace hygiene closure. |
| **patch-forge** | Automated generation of patch components and blueprints. |

---

## 🛡️ Standards
- **Architecture**: v3.0 (Ironclad Fleet Standard)
- **Protocol**: itinfosv Unified Protocol V1
- **Philosophy**: Patterns over intentions. Tested from human = Sacred.

---
[itinfosv](https://github.com/itinfosv) · MIT License
