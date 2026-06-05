# Requirement Detail: FR-2 (Installer Script Refinement)

## 1. CR Information
- **Parent RFC**: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1
- **Target Module**: install.sh
- **Target Branch**: master
- **Worktree Required**: No
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Core logic modification.
- **Affected Components**: `install.sh` and its rebranding logic in `patch_itskill/rebrand_install_script.py`.
- **Logic Description**:
    1. Update `INSTALL_DIR` to `"$HOME/.it-skill/bin"`.
    2. Disable/Remove `try_binary_install` logic.
    3. Modify `install_bunx_wrapper` to generate a concise Bash script instead of a large binary.
    4. Implement "Force Cleanup" to remove any existing 98MB binary at the target path before writing the wrapper.
    5. Ensure `PATH` injection targets the new `.it-skill/bin` directory.

## 3. Impact Assessment
- **Integration Impact**: Fixes the 98MB binary discrepancy. Aligns with `oracle-skills` distribution pattern.
- **Regression Risk**: Users who previously added `.itinfosv-skills/bin` to their PATH will have duplicate entries or stale paths.

## 4. Acceptance Criteria
- [ ] `install.sh` creates a small Bash wrapper (< 1KB) named `it-skill`.
- [ ] The large 98MB binary is removed during installation if present.
- [ ] `~/.it-skill/bin` is added to shell profiles.
