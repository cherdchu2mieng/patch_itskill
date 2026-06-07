<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-ITSKILL-003

## 1. CR Information
- **Parent RFC**: RFC-20260602-IT-SKILL-CLI-V1
- **Target Module**: boot-distro
- **Target Branch**: main
- **Worktree Required**: Yes - To isolate the distribution and installation script changes.
- **Execution Skill**: build-patch
- **Status**: Sacred 🛡️

## 2. Technical Scope
- **Nature of Change**: Bootstrapping & Distribution Configuration
- **Affected Components**:
    - `install.sh`
    - `src/cli/installer.ts`
- **Logic Description**:
    1. Update `install.sh`:
        - Update repository path to `itinfosv/it-skill-cli`.
        - Standardize all environment variables to `IT_SKILL_` prefix.
    2. Update `src/cli/installer.ts`:
        - Update `isOurSkill` signature to `it-skill-cli`.
        - Rebrand UI feedback strings (e.g., `it-skill-managed skills`).

## 3. Impact Assessment
- **Integration Impact**: Finalizes the user-facing installation and update experience.
- **Regression Risk**: Low. Ensures the tool correctly identifies and manages its own 'itinfosv' skills.

## 4. Acceptance Criteria
- [x] `install.sh` points to `itinfosv/it-skill-cli`.
- [x] Installation variables use `IT_SKILL` prefix.
- [x] `installer.ts` correctly identifies skills with the `it-skill-cli` signature.
- [x] Project passes full `bun run build`.

## 5. Post-Implementation Report (Append after Phase 6)
- **Actual Files Modified**: `install.sh`, `src/cli/installer.ts`
- **Actual Duration**: 20 Minutes
- **Actual Token Cost**: ~30k
- **Changes Done**: Completed the rebranding of the installation script and updated the internal installer logic to maintain ownership of 'itinfosv' skills. Ready for handover.
