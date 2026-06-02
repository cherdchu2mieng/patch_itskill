import sys
import os

target_path = sys.argv[1]
readme_path = os.path.join(target_path, "README.md")

content = r'''# it-skill-cli 🛡️🌊

Enterprise-grade skill management and lifecycle governance for the `itinfosv` fleet.

## 🚀 Fleet Status & Announcements

### v1.0.0 (Genesis Release) — 2026-06-02
**"AUTHORITATIVE GOVERNANCE LOCKED"** 🛡️
- **Rebranding Complete**: Transitioned to `itinfosv` organization identity.
- **Core Integrated Skills**: `build-rfc`, `build-patch`, `close-rfc`, `patch-forge`.
- **Strict Mode Active**: All legacy `arra-oracle` skills removed for 100% precision.
- **Ironclad Standard**: Fully compliant with Architecture v3.0.

---

## 📦 Installation

### Global Install (Recommended)
Install the IT-Skill CLI to your system to manage governance skills across all projects.

```bash
curl -fsSL https://raw.githubusercontent.com/itinfosv/it-skill-cli/main/install.sh | bash
```

After installation, you can verify it by running:
```bash
it-skill --version
# Expected: 1.0.0
```

### Bootstrap Governance Skills
Once installed, use the CLI to bootstrap the core governance toolkit:
```bash
it-skill go standard
```

---

## 🛠️ Development & Cloning

For developers wishing to contribute or inspect the source:

```bash
ghq get itinfosv/it-skill-cli
cd $(ghq list -p itinfosv/it-skill-cli)
```

### Local Build
```bash
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
'''

with open(readme_path, "w") as f:
    f.write("// @it-skill-patch: rebrand_readme@v1.1\n")
    f.write(content)

print("✅ README.md fully updated and aligned with itinfosv standards.")
