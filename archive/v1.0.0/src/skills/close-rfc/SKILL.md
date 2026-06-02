---
name: close-rfc
description: Automate the closure and synchronization of RFCs. Use when an RFC and its associated Change Requests (CRs) are fully implemented and verified, and you need to update the master status and sync documentation to the Patch Workspace.
---

# [itinfosv] 🏁 RFC Closure Skill (v2.2)
**Alias**: `/crfc`

**Goal**: Finalize the RFC lifecycle by validating implementation results, updating documentation status, and synchronizing with the Patch Workspace. Provides a unified command directory via **`crfc-list`**.

---

## 🛠️ Command Directory (`crfc-list`)
The following commands are available for managing the RFC Closure process:

- **`crfc-Phase 1 confirm`**: Identify target RFC and initiate the closure audit.
- **`crfc-Phase 2 confirm`**: Validate implementation results and Sacred status across all CRs.
- **`crfc-Phase 3 confirm`**: Formally close the Master RFC and update metrics.
- **`crfc-report`**: Display the closure status and any validation blockers.
- **`crfc-list`**: Show this command directory.

---

## 🚀 Workflow

### Phase 1: Target Identification & Audit
- **Action**: Identify the RFC directory in `ψ/writing/[project]/[RFC-ID]/`.
- **Audit**: Locate the Master RFC file and all Change Request files. Scan for the presence of Post-Implementation Reports in each CR.
- **Confirmation Protocol**: AI MUST present the identified RFC structure and ask for **"crfc-Phase 1 confirm"**.

### Phase 2: Implementation Validation
- **Action**: Scan each CR Detail file for:
    - **Status**: Must be `Approved (Tested from human = Sacred)`.
    - **Metrics**: Validate that Duration, Token Cost (if available), and Files Modified are recorded.
- **Failure**: If any CR is missing the report or is not approved, PAUSE and notify the human.
- **Confirmation Protocol**: Present the validation results and ask for **"crfc-Phase 2 confirm"**.

### Phase 3: Master Finalization
- **Action**: Update the Master RFC file:
    - Change `Status` to **`Closed`**.
    - Aggregate `Actual Duration` and `Actual Token Cost` from all CR reports and update the `RFC-Level Summary`.
- **Confirmation Protocol**: Present the finalized Master RFC content and ask for **"crfc-Phase 3 confirm"**.

### Phase 4: Patch Workspace Synchronization
- **Action**: Identify the `Patch Workspace Repo` path from the Master RFC metadata.
- **Action**: Copy the entire RFC documentation folder to the `docs/requirements/` directory within the **Patch Workspace Repo**.
- **Requirement**: Ensure the destination directory exists (create it if missing).

### Phase 5: Fleet Announcement & Cleanup
- **Action**: Execute **`pulse blog [ACP-MD-Path]`** to announce the feature delivery to the fleet. This publication MUST use the finalized Acceptance Test document (e.g., `[RFC-ID]#ACP-YYYYMMDD-001.md`) as the primary content.
- **Runtime Backup Cleanup (v2.1)**: Formally remove temporary runtime backups created during the implementation phases.
    - **Command**: `rm -rf ~/.config/pulse/backups/patch_*`
- **Temporary Session Cleanup (v2.2)**: Remove temporary staging files (.pl, .ts) and session-specific logs created in the project's temporary directory during the RFC process.
    - **Command**: `rm -f /home/a2it49072/.gemini/tmp/gemi-oracle/*.pl /home/a2it49072/.gemini/tmp/gemi-oracle/*.ts`
    - **Note**: Do NOT remove common folders like `logs/` or `chats/` unless explicitly instructed.
- **Condition**: Only execute cleanup steps after Master RFC is status: `Closed` and Final Snapshots are verified.
- **Action**: (Optional) Close the associated GitHub issue if the RFC was linked to one.

## 🛡️ Iron Rules
1. **Validation First**: No RFC can be closed if any of its CRs are not in `Sacred Status`.
2. **Metadata Integrity**: Always preserve the original metadata while updating status and metrics.
3. **Sync Accuracy**: The documentation in the Patch Workspace MUST be a mirror of the finalized `ψ/writing/` version.
4. **Strict Phase Gates & Authorization**: The AI **MUST NEVER** assume authorization. Each Phase transition and status update must be explicitly triggered by the Human using the exact syntax containing the **`confirm`** keyword (e.g., **`crfc-Phase X confirm`**).
5. **Hygiene Mandate (v2.2)**: Every successfully closed RFC cycle MUST conclude with the removal of temporary runtime backups and session-specific staging files to prevent clutter and ensure workspace integrity.
