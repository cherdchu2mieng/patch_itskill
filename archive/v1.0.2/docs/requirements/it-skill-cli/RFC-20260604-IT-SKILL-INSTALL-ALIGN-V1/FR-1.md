# Requirement Detail: FR-1 (Package Metadata Update)

## 1. CR Information
- **Parent RFC**: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1
- **Target Module**: package.json
- **Target Branch**: master
- **Worktree Required**: No
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Modification of package metadata.
- **Affected Components**: `package.json` rebranding logic in `patch_itskill/rebrand_package_json.py`.
- **Logic Description**:
    1. Update the `name` field to `it-skill-cli`.
    2. Update the `bin` object to use `"it-skill": "./src/cli/index.ts"`.
    3. Ensure repository URLs point to `cherdchu2mieng/itinfosv-skill-cli` for correct `bunx` resolution from the fork.

## 3. Impact Assessment
- **Integration Impact**: Enables `bunx it-skill@github:...` to correctly find the executable.
- **Regression Risk**: Low, but requires alignment with `install.sh`.

## 4. Acceptance Criteria
- [ ] `package.json` in the target repo has `"bin": { "it-skill": "./src/cli/index.ts" }`.
- [ ] `package.json` name is `it-skill-cli`.
