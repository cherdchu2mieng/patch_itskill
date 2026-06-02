<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-ITSKILL-003

## 1. CR Information
- **Parent RFC**: RFC-20260602-IT-SKILL-CLI-V1
- **Target Module**: boot-distro
- **Target Branch**: main
- **Worktree Required**: Yes - To isolate the distribution and installation script changes.
- **Execution Skill**: build-patch
- **Status**: Approved (Tested from human = Sacred)

## 2. Technical Scope
- **Nature of Change**: Bootstrapping & Distribution Configuration
- **Affected Components**:
    - `install.sh`
    - `src/cli/installer.ts`
    - `package.json` (Distribution fields)
- **Logic Description**:
    1. Update `install.sh`:
        - Change repository owner from `Soul-Brews-Studio` to `itinfosv`.
        - Change repository name from `oracle-skills-cli` to `it-skill-cli`.
        - Update the installation directory from `~/.oracle-skills/bin` to `~/.it-skill/bin`.
        - Update the binary name references from `oracle-skills` to `it-skill`.
        - Update environment variable names (e.g., `IT_SKILL_VERSION` instead of `ORACLE_SKILLS_VERSION`).
    2. Update `src/cli/installer.ts`:
        - Update `isOurSkill` function to check for the string `installer: it-skill-cli` in `SKILL.md` files.
    3. Update `package.json`:
        - Ensure `repository` and `bugs` fields point to the new `itinfosv` URLs.
        - Verify that the `bin` field correctly points to the entry script under the new name.
    4. Verify the `PATH` injection logic in `install.sh` correctly points to `~/.it-skill/bin`.

## 3. Impact Assessment
- **Integration Impact**: Finalizes the user-facing installation and update experience.
- **Regression Risk**: Low. Incorrect `PATH` injection or repo URL could break the installer for end-users.

## 4. Acceptance Criteria
- [ ] `install.sh` points to `itinfosv/it-skill-cli`.
- [ ] Installation path changed to `~/.it-skill/bin`.
- [ ] `installer.ts` correctly identifies skills with the `it-skill-cli` signature.
- [ ] `it-skill` command is available on the `PATH` after installation.
- [ ] `package.json` metadata is fully aligned with the `itinfosv` organization.

## 5. Post-Implementation Report (Append after Phase 6)
*To be filled by the patch engineer.*
