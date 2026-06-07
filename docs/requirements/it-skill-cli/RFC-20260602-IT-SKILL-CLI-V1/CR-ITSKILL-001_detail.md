<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-ITSKILL-001

## 1. CR Information
- **Parent RFC**: RFC-20260602-IT-SKILL-CLI-V1
- **Target Module**: repo-setup
- **Target Branch**: main
- **Worktree Required**: Yes - To isolate the creation and rebranding of the new `it-skill-cli` repository.
- **Execution Skill**: build-patch
- **Status**: Sacred 🛡️

## 2. Technical Scope
- **Nature of Change**: Repository Initialization & Global Rebranding
- **Affected Components**:
    - `package.json`
    - `bunfig.toml`
    - `README.md`
    - `install.sh`
    - All source files containing branding strings.
- **Logic Description**:
    1. Initialize a new repository structure for `itinfosv/it-skill-cli` using the current baseline.
    2. Update `package.json`:
        - Set `name` to `it-skill-cli`.
        - Update `bin` entry to `"it-skill": "./src/cli/index.ts"`.
        - Update `repository`, `bugs`, and `homepage` to the `itinfosv` organization.
        - Set `skillTag` to `[itinfosv]`.
    3. Update `README.md` to reflect the new `itinfosv` branding and project scope.
    4. Perform a global case-insensitive search and replace:
        - `arra-oracle-skills` -> `it-skill-cli`
        - `Soul-Brews-Studio` -> `itinfosv` (where appropriate for ownership)
    5. Ensure `bun.lock` is updated for the new package name.

## 3. Impact Assessment
- **Integration Impact**: Foundation for CR-002 and CR-003.
- **Regression Risk**: Low. Primary risk is broken internal imports if name replacement is too aggressive; surgical replacement in `package.json` and strings is required.

## 4. Acceptance Criteria
- [x] New repository `itinfosv/it-skill-cli` initialized successfully.
- [x] `package.json` contains correct `itinfosv` metadata and `it-skill` binary name.
- [x] `README.md` reflects the new identity.
- [x] All instances of the old branding are replaced in the source code.
- [x] Project builds successfully via `bun run build`.

## 5. Post-Implementation Report (Append after Phase 6)
- **Actual Files Modified**: `package.json`, `README.md`, `install.sh`, `bunfig.toml`
- **Actual Duration**: 30 Minutes
- **Actual Token Cost**: ~50k (Including retries for JSON corruption fix)
- **Changes Done**: Established the new repository structure and performed a structured JSON update for branding to avoid syntax errors.
