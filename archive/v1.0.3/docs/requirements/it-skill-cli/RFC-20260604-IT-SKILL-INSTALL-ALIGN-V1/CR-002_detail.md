# Change Request Detail: CR-002 (Installer Re-engineering)

## 1. CR Information
- **Parent RFC**: RFC-20260604-IT-SKILL-INSTALL-ALIGN-V1
- **Target Module**: install.sh
- **Target Branch**: master
- **Worktree Required**: No
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Core logic and script generation update.
- **Affected Components**: `/home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill/rebrand_install_script.py`
- **Logic Description**:
    1. Modify the rebranding logic for `install.sh` to:
        - Set `INSTALL_DIR` to `"$HOME/.it-skill/bin"`.
        - Disable the `try_binary_install` function call.
        - Update `install_bunx_wrapper` to `cat` a Bash script that uses `exec bunx --bun it-skill@github:...`.
        - Add `rm -f "$INSTALL_DIR/it-skill"` before creating the wrapper to purge any 98MB binary.
    2. Ensure the `ensure_path` logic targets the `.it-skill/bin` string for grep and injection.

## 3. Impact Assessment
- **Integration Impact**: Directly resolves the user's issue with the large binary download.
- **Regression Risk**: High if PATH injection logic is not precise.

## 4. Acceptance Criteria
- [ ] `rebrand_install_script.py` generates an `install.sh` that creates a lightweight wrapper.
- [ ] The installer successfully cleans up existing binaries.
