<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# RFC Master Specification: itinfosv/it-skill-cli V1

## 1. Document Control
- **Project**: itinfosv/it-skill-cli
- **RFC ID**: RFC-20260602-IT-SKILL-CLI-V1
- **Priority**: P1
- **Requester**: Human
- **Approver**: Human (cherdchu2mieng)
- **Responsible Agent**: Gemi Oracle 🌊
- **Stability Impact**: High
- **Security Level**: Standard
- **Target Version**: v1.0.0
- **Status**: Approved (Tested from human = Sacred)

## 2. Scope Consensus (The 3-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
The objective is to establish the authoritative `it-skill-cli` for the `itinfosv` organization by migrating the existing `itinfosv-skill-cli` codebase and embedding four core governance skills (`build-rfc`, `build-patch`, `close-rfc`, `patch-forge`) as built-in components. This includes a full rebranding and updating the installation/bootstrapping mechanism.

### 2.2 Functional Requirements (Consolidated from Phase 3)

#### FR-1: Repository Structural Setup & Rebranding (Consensus 3.1)
- **Repo Initialization**: Create `itinfosv/it-skill-cli` based on the Bun/TypeScript baseline of `arra-oracle-skills-cli`.
- **Global Rebrand**: Update all internal references from `arra-oracle-skills` to `it-skill-cli`.
- **Ownership Identity**: Update `package.json` with `itinfosv` metadata, update binary name to `it-skill`, and set `skillTag` to `[itinfosv]`.

#### FR-2: Core Skill Integration (Consensus 3.2)
- **Skill Embedding**: Port `build-rfc`, `build-patch`, `close-rfc`, and `patch-forge` into `src/skills/`.
- **VFS Bundling**: Ensure all skills (including scripts/assets) are correctly captured by `generate-vfs.ts` during the build process.
- **Profile Alignment**: Add integrated skills to `STANDARD_SKILLS` and `FULL_SKILLS` profiles in `src/profiles.ts`.

#### FR-3: Bootstrapping & Distribution (Consensus 3.3)
- **Installation Logic**: Update `install.sh` to point to the new repository and standardize the installation path to `~/.it-skill/bin/`.
- **Ownership Signature**: Update `installer.ts` to use the `installer: it-skill-cli` signature for skill tracking.
- **Distribution Method**: Deploy via GitHub Releases as pre-built binaries.

### 2.3 Information Gathering (Research)
- **IG-1 (Technical Baseline)**: Source codebase uses Bun/TypeScript with a VFS (Virtual File System) for skill bundling. Existing structure is found in `ψ/learn/Soul-Brews-Studio/arra-oracle-skills-cli/`.
- **IG-2 (Integration Points)**: Skills are registered via `installer.ts` and grouped in `profiles.ts`. Registration relies on an `installer: [string]` signature in `SKILL.md`.
- **IG-3 (Operational Constraints)**: Rebranding requires updating `package.json`, `install.sh`, and binary names. Skills with external scripts (Python/Bash) must have correct path references within their bundled state.

## 3. Change Request (CR) Portfolio
| FR Ref | CR ID | Module | Technical Objective | Detail File | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| FR-1 | CR-ITSKILL-001 | repo-setup | Repository Initialization & Global Rebranding | CR-ITSKILL-001_detail.md | Approved |
| FR-2 | CR-ITSKILL-002 | skill-integration | Core Skill Embedding (PRD, Patch, Close, Forge) | CR-ITSKILL-002_detail.md | Approved |
| FR-3 | CR-ITSKILL-003 | boot-distro | Bootstrapping & Distribution Configuration | CR-ITSKILL-003_detail.md | Approved |

## 4. RFC-Level Summary (Post-Closure)
- **Total Duration**: TBD
- **Total Token Cost**: TBD
