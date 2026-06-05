# Requirement Detail: FR-3 (Documentation Alignment)

## 1. CR Information
- **Parent RFC**: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1
- **Target Module**: README.md
- **Target Branch**: master
- **Worktree Required**: No
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Documentation update.
- **Affected Components**: `README.md` and rebranding logic in `patch_itskill/rebrand_final_readme.py`.
- **Logic Description**:
    1. Update installation command examples to use `it-skill`.
    2. Update version verification example to `it-skill --version`.
    3. Sync installation URL with the correct fork path.
    4. Ensure all organization mentions are consistent with `itinfosv`.

## 3. Impact Assessment
- **Integration Impact**: Ensures users have correct instructions for the new command name.
- **Regression Risk**: None.

## 4. Acceptance Criteria
- [ ] `README.md` installation section uses `it-skill`.
- [ ] No mentions of `itinfosv-skills` or `arra-itinfosv-skills` remain in usage examples.
