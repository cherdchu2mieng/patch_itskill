<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-ITSKILL-002

## 1. CR Information
- **Parent RFC**: RFC-20260602-IT-SKILL-CLI-V1
- **Target Module**: skill-integration
- **Target Branch**: main
- **Worktree Required**: Yes - To isolate the skill porting and VFS configuration.
- **Execution Skill**: build-patch
- **Status**: Sacred 🛡️

## 2. Technical Scope
- **Nature of Change**: Core Skill Embedding (Governance Only)
- **Affected Components**:
    - `src/skills/` (New directories: `build-rfc`, `build-patch`, `close-rfc`, `patch-forge`)
    - `src/profiles.ts`
    - `__tests__/profiles.test.ts`
- **Logic Description**:
    1. Port the following skills from `/home/a2it49072/.gemini/skills/` to `src/skills/`:
        - `build-rfc`, `build-patch`, `close-rfc`, `patch-forge`.
    2. Update each skill's `SKILL.md`:
        - Set `installer: it-skill-cli`.
        - Add `[itinfosv]` tag to the description.
    3. Perform **Strict Cleanup**: Remove ALL other skills originating from `arra-oracle-skills` (including `go`, `recap`, `trace`, etc.) to isolate the IT-Skill fleet.
    4. Modify `src/profiles.ts`: Set `STANDARD_SKILLS` to only include the 4 integrated skills.
    5. Align Tests: Rewrite `__tests__/profiles.test.ts` to reflect the new 4-skill standard.

## 3. Impact Assessment
- **Integration Impact**: Enables the primary functionality of the `it-skill-cli` as a governance tool.
- **Regression Risk**: High (due to cleanup). Legacy tests will fail if not aligned with the new minimal skill set.

## 4. Acceptance Criteria
- [x] Governance skills physically exist in `src/skills/`.
- [x] `SKILL.md` files updated with correct installer signature and `[itinfosv]` tags.
- [x] `src/profiles.ts` includes the new skills in the `standard` profile.
- [x] Legacy skills (`go`, `recap`, etc.) removed from source.
- [x] `it-skill list` command shows the new skills as available.

## 5. Post-Implementation Report (Append after Phase 6)
- **Actual Files Modified**: `src/skills/*`, `src/profiles.ts`, `__tests__/profiles.test.ts`
- **Actual Duration**: 60 Minutes
- **Actual Token Cost**: ~100k (Including 3 refinement loops for test alignment)
- **Changes Done**: Ported governance skills and performed a total cleanup of legacy skills. Aligned the profile configuration and unit tests for 100% pass rate in governance-only mode.
