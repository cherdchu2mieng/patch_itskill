# Change Request Detail: CR-001 (Metadata Alignment)

## 1. CR Information
- **Parent RFC**: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1
- **Target Module**: package.json
- **Target Branch**: master
- **Worktree Required**: No
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Modification of rebranding script logic.
- **Affected Components**: `/home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill/rebrand_package_json.py`
- **Logic Description**:
    1. Update the script to set `name` to `it-skill-cli`.
    2. Update the `bin` field to exactly `{"it-skill": "./src/cli/index.ts"}`.
    3. Update the `repository`, `bugs`, and `homepage` URLs to point to `cherdchu2mieng/itinfosv-skill-cli` instead of the organization root to ensure correct `bunx` resolution during the fork phase.

## 3. Impact Assessment
- **Integration Impact**: Critical for `bunx` to identify the correct entry point under the name `it-skill`.
- **Regression Risk**: None for existing functionality.

## 4. Acceptance Criteria
- [ ] `rebrand_package_json.py` is updated.
- [ ] Executing the script results in a `package.json` with correct `bin` and repository fields.
