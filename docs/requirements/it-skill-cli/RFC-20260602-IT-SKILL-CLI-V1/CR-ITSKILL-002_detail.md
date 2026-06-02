<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-ITSKILL-002

## 1. CR Information
- **Parent RFC**: RFC-20260602-IT-SKILL-CLI-V1
- **Target Module**: skill-integration
- **Target Branch**: main
- **Worktree Required**: Yes - To isolate the skill porting and VFS configuration.
- **Execution Skill**: build-patch
- **Status**: Approved (Tested from human = Sacred)

## 2. Technical Scope
- **Nature of Change**: Core Skill Embedding (PRD, Patch, Close, Forge)
- **Affected Components**:
    - `src/skills/` (New directories: `build-rfc`, `build-patch`, `close-rfc`, `patch-forge`)
    - `src/profiles.ts`
    - `src/cli/generated/skills-vfs.ts` (Build artifact)
- **Logic Description**:
    1. Port the following skills from `/home/a2it49072/.gemini/skills/` to `src/skills/`:
        - `build-rfc` (including `references/`)
        - `build-patch`
        - `close-rfc` (including `scripts/`)
        - `patch-forge` (including `assets/`, `references/`, `scripts/`)
    2. Update each skill's `SKILL.md`:
        - Set `installer: it-skill-cli`.
        - Add `[itinfosv]` tag to the description.
        - Ensure all script paths in `SKILL.md` are relative to the skill directory (e.g., `./scripts/pfrg_cli.py`).
    3. Modify `src/profiles.ts`:
        - Add `build-rfc`, `build-patch`, `close-rfc`, and `patch-forge` to the `STANDARD_SKILLS` array.
    4. Run `bun run compile` to trigger `generate-vfs.ts` and verify the new skills are included in the VFS bundle.

## 3. Impact Assessment
- **Integration Impact**: Enables the primary functionality of the `it-skill-cli` as a governance tool.
- **Regression Risk**: Medium. Incorrectly relative paths in `SKILL.md` or missing assets during VFS bundling could cause skills to fail at runtime.

## 4. Acceptance Criteria
- [ ] Governance skills physically exist in `src/skills/`.
- [ ] `SKILL.md` files updated with correct installer signature and `[itinfosv]` tags.
- [ ] `src/profiles.ts` includes the new skills in the `standard` profile.
- [ ] VFS bundle (`src/cli/generated/skills-vfs.ts`) successfully generated and contains the new skills.
- [ ] `it-skill list` command shows the new skills as available.

## 5. Post-Implementation Report (Append after Phase 6)
*To be filled by the patch engineer.*
