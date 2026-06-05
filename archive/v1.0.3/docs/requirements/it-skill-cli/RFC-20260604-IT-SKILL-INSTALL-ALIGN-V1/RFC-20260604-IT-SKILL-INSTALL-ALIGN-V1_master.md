<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# RFC Master Specification: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1

## 1. Document Control
- **Project**: it-skill-cli
- **RFC ID**: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1
- **Priority**: P1 (High)
- **Requester**: Human
- **Approver**: Human (cherdchu2mieng)
- **Responsible Agent**: Gemini CLI
- **Patch Workspace**: `/home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill`
- **Target Repo**: `cherdchu2mieng/itinfosv-skill-cli`
- **Structure**: Folder-based RFC in `ψ/writing/it-skill-cli/`
- **Stability Impact**: High
- **Security Level**: Standard
- **Target Version**: v1.0.1
- **Status**: Approved (Tested from human = Sacred)

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
Align the `it-skill-cli` installation process with the `itinfosv` standard. This involves transitioning from a heavy binary-based distribution (98MB ELF) to a lightweight, `bunx`-driven Bash wrapper. The goal is to standardize the command as `it-skill` and the installation path as `~/.it-skill/bin`.

### 2.2 Human Supplemental Input
- Reported discrepancy: User expects `it-skill` command to be a Bash wrapper similar to `oracle-skills`.
- Path hygiene: Ensure clean removal of existing large binaries.
- Workspace: Use `/home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill` for implementation.

### 2.3 Information Gathering (Research)
- **IG-1 (Technical Baseline)**: `package.json` currently uses legacy bin keys; `install.sh` has legacy binary download functions.
- **IG-2 (Operational Constraints)**: `bunx` resolution requires precise `bin` and `repository` fields in `package.json`.

## 3. Requirement & Change Request Portfolio

### 3.1 Functional Requirements (FR)
| FR ID | Functional Intent | Detail File |
| :--- | :--- | :--- |
| **FR-INSTALL-STD-V1** | Standardize `it-skill` command and `~/.it-skill/bin` path. | [FR-INSTALL-STD-V1.md](./FR-INSTALL-STD-V1.md) |
| **FR-WRAPPER-ONLY-V1** | Replace 98MB binary with lightweight Bash wrapper. | [FR-WRAPPER-ONLY-V1.md](./FR-WRAPPER-ONLY-V1.md) |

### 3.2 Technical Change Requests (CR)
| CR ID | Technical Objective | Detail File | Execution Skill |
| :--- | :--- | :--- | :--- |
| **CR-001** | Update `package.json` metadata (name, bin, repo). | [CR-001_detail.md](./CR-001_detail.md) | `build-patch` |
| **CR-002** | Re-engineer `install.sh` for wrapper generation & cleanup. | [CR-002_detail.md](./CR-002_detail.md) | `build-patch` |
| **CR-003** | Align `README.md` examples and URLs. | [CR-003_detail.md](./CR-003_detail.md) | `build-patch` |

## 4. RFC-Level Summary (Post-Closure)
- **Total Duration**: TBD
- **Total Token Cost**: TBD
- **Implementation Status**: Pending Phase 4 Confirm
