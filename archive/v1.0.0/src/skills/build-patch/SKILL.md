---
name: build-patch
description: '[core] G-SKLL | Secure, Cumulative, and Regression-Free Patch Management. Follows Architecture v3.0 (v2.0).'
---

# [itinfosv] 🌊 Build Patch Skill (v2.8)
[core] G-SKLL | Secure, Cumulative, and Regression-Free Patch Management.
**Alias**: `/bp`

**Goal**: Execute software patching with surgical precision using **Architecture v3.0 (Ironclad Fleet Standard)**. Eliminate regressions by decoupling code into **Feature-Based Payloads** and enforcing a **Full Regression Gate** before delivery. Provides a unified command directory via **`bp-list`**.

---

## 🛠️ Command Directory (`bp-list`)
The following commands are available for managing the 7-Phase Workflow:

- **`bp-Phase 1 report`**: Display the current CR Status Audit, workspace paths, and baseline.
- **`bp-Phase 1 confirm`**: Formally confirm Phase 1 and proceed to Phase 2.
- **`bp-Phase 3 verify`**: Trigger immediate syntax/build verification.
- **`bp-Phase 5 status`**: Display the Human Priority Gate options and current audit state.
- **`bp-Phase 5 refine CR-XXXX`**: Initiate the refinement loop for a previously Sacred CR.
- **`bp-audit status`**: Quick view of the current CR Portfolio (Sacred vs Pending).
- **`bp-list`**: Show this command directory.

---

## 🛡️ The Iron Rules (Guiding Principles)

1.  **Symlink Integrity**: NEVER break symlinks. Follow links to the real path for configuration writes.
2.  **Syntax Safety (v2.1)**: ALWAYS use Python raw multiline strings (`r'''...'''`) to prevent the Newline Trap and escaping errors. The content inside must be a **PURE LITERAL** representation of the target code—zero AI-guessing or dynamic interpolation that could corrupt the syntax.
3.  **Safe Anchoring (v2.1)**: Before injecting complex logic, use distinct delimiters (e.g., `// @pulse-anchor`) or special symbols (e.g., `+-+-+-+-`) to mark the injection site. This creates a clean new-line boundary and provides a reliable anchor for `content.replace()`, ensuring the code is never injected into the middle of an existing statement.
4.  **Literal over Regex (v2.1)**: Prefer `content.replace(old, new)` for multi-line blocks to ensure 1:1 integrity. If `re.sub()` is unavoidable, you MUST use `re.escape()` on the target string to prevent special characters in the source code from being misinterpreted as regex patterns.
5.  **Proven Block Principle (v2.1)**: Only inject "Ironclad Code"—logic that has been empirically verified to compile and run in a previous session or local environment. NEVER refactor or "clean up" stable features during the injection process; preserve the proven state.
6.  **Ironclad Manifest Standard & Injection (v2.1)**: Every patched `.ts` file MUST contain a `// @pulse-patch: feature@version` header to track applied patches chronologically. **Injection Safety**: When applying a patch, the script MUST safely parse the existing header block. If a header exists, append the new feature tag without duplicating or overwriting previous tags. If it does not exist, safely prepend it to the file using strict string concatenation.
7.  **Clean Production (v2.0)**: `master` branch must only contain clean filenames in `modules/` (no version suffixes).
8.  **Branch Provenance (v1.6)**: `feature/` branches MUST be branched from `master`. `master` is only updated from verified `feature/` branches.
9.  **Syntax Guard (v1.9)**: AI MUST perform automated syntax verification (e.g., `bun run build` or `tsc`) immediately after injection. Any failure triggers an automatic `--restore` or **`git restore .`** in the Target Repo to return to the clean baseline.
10. **Feature-Based Decoupling (v2.1)**: Code changes MUST be stored in dedicated `.pl` files named by FEATURE and PATCH VERSION (e.g., `task_pulling@v8.2.pl`). This ensures clear patch sequencing and management.
11. **Manifest-Driven Runner (v2.5)**: The main `.sh` script MUST act as a transparent orchestrator.
    *   **Target Clean (v2.5)**: The script MUST include a mandatory clean reset step as its first action to ensure the target repository is in a pure upstream state before patching. Command: `cd "$TARGET_PATH" && git fetch origin && git reset --hard origin/main && git clean -fd`.
    *   **Check Switches**: It must implement sequential logic that reads the target file's Manifest header to verify prerequisite patches before injecting the next feature.
    *   **Real-time Status**: The script MUST provide clear execution logs (e.g., `echo "✓ Applied task_pulling@v8.2"`) within the `.sh` file itself, allowing for immediate status tracking and identifying where a failure occurred.
12. **Full Regression Gate (v2.0)**: AI MUST verify ALL previously implemented requirements (e.g., v8.1, v8.2) alongside the new feature before entering the verification gate.
13. **Strict Phase Gates & Authorization**: MANDATORY Human consent is required before moving between phases or performing Sacred Anchors (Git commits). The AI **MUST NEVER** assume authorization. A phase command (e.g., `bp-Phase 4`) without the explicit keyword **`confirm`** or **`Passed`** is merely a status check. The AI must wait for the exact syntax (e.g., **"bp-Phase 1 confirm"**, **"Gate Decision: Passed"**, or **"Final Delivery: y"**) before executing state-changing actions.
14. **Test Case Proactivity**: AI MUST provide a structured **Test Checklist** to the Human before entering the verification gate.
15. **Checkpoint Commit Protocol (v2.3)**: AI MUST perform strategic git commits in the **Patch Workspace Repo** at critical transition points (Baseline, Design, and Verification) to ensure full traceability and rapid recovery.
16. **Ironclad Archive Principle (v2.8)**: Upon final verification, the AI MUST archive the fully patched source files as versioned snapshots. This provides an immutable reference for the release and serves as the baseline for future forge cycles.

---

## 🛠️ The 7-Phase Workflow (v2.8 Ironclad Loop)

### Phase 1: Initiation & Authorization (v2.5)
**Goal**: Prepare both the Patch Workspace and Target Repo with a "Stable and Auditable Foundation" before starting new work.

1.  **Authorization Phase**:
    *   **Requirement**: Identify the `Patch Workspace Repo` and `Target Repo Path` from the RFC metadata in `/ψ/writing/`.
    *   **Action**: **ASK for Human Permission** before creating a new branch in the `Patch Workspace Repo`. Present the goal and the proposed branch name.
    *   **Baseline Authorization**: List available branches/tags in the Patch Workspace and **ASK for Human Confirmation** on which version/branch to use as the starting **Parent Baseline**.
2.  **CR Status Audit (v2.3 - The State Baseline)**:
    *   **Action**: Scan the RFC Portfolio and list all Change Requests (CRs) with their current status:
        *   **Completed/Sacred**: Already implemented and verified.
        *   **Pending**: Still awaiting implementation.
    *   **Goal**: Establish a "Session State" that will guide the iterative loop in Phase 5 without requiring re-reading of the RFC master during the loop. This prevents accidental document overwrites in Phase 4.
3.  **Creation**:
    *   After approval, create `feature/[project]-vX.Y-[name]` in the **`Patch Workspace Repo`** based on the approved Parent Baseline.
4.  **Target Preparation (v2.5)**: 
    *   **Clean Reset (v2.5)**: Go to the **Target Repo Path**, switch to `master` (or `main`), and perform a `git reset --hard origin/main && git clean -fd` to ensure an absolutely fresh and clean baseline. Note: This step is now also codified into the orchestrator script designed in Phase 2.
    *   **Baseline Restoration**: Run the patch orchestrator from the Patch Workspace using the approved Parent Baseline to restore all previously verified "Sacred" features to the Target Repo.
    *   **Cumulative Sync**: AI must perform a "State Restoration" to ensure the Target Repo is fully cumulative and matches the functional state of the chosen baseline. This is the **Pure Baseline** required for Phase 2.
    *   **Target Anchor Commit (v2.3)**: In the **Target Repo**, perform a `git add . && git commit -m "baseline: sacred state locked"` to create a local restore point. This is crucial for Phase 3's `git restore .` mechanism.
5.  **Initiation Check**: Verify that the workspace is ready and the target baseline is stable before proceeding to Phase 2.

- **Confirmation Protocol**: AI MUST present the CR Status Audit and initialization plan and explicitly ask for either **"bp-Phase 1 confirm"** OR feedback to adjust the session state before proceeding to Phase 2.

### Phase 2: Design & Decoupling (v2.8 - Patch Forge Integration)
**Goal**: Design and decouple code systematically using **`patch-forge`**, and record the entire plan as a checkpoint before execution.

1.  **Map Requirements**: Identify all previous features that must be preserved. Identify features to be protected (Preserved) in target files.
2.  **Patch Forge Activation (MANDATORY)**: AI MUST utilize the **`patch-forge`** skill phases to design and generate the necessary components:
    - **Forge Phase 1 & 2**: Create the Blueprint and Payload (.pl) files.
    - **Forge Phase 3 & 4**: Update the Orchestrator (.sh) and Manifest.
3.  **Feature-Based Decoupling**: Ensure code changes are stored in dedicated `.pl` payloads named by FEATURE and PATCH VERSION (e.g., `task_pulling@v8.2.pl`).
4.  **Manifest-Driven Runner**: Update the orchestrator script (e.g., `patch_pulse.sh`) to act as a transparent orchestrator. **MANDATORY**: The script MUST include the Target Clean logic (Step 0) and sequential logic for Manifest header verification.
5.  **Design Checkpoint (v2.3)**: After payloads and the orchestrator are prepared, but BEFORE execution, perform a git commit in the **Patch Workspace Repo** with the message: `feat: [CR-ID] design checkpoint - payloads and orchestrator ready 📐`.
6.  **Transparency**: Present a Cumulative Diff and update `HISTORY.md` to provide a full overview to the human.

- **Confirmation Protocol**: AI MUST present the full Design Blueprint and the results of `patch-forge` and explicitly ask for **"bp-Phase 2 confirm"** before proceeding to Phase 3.

### Phase 3: Execution & Regression Gate (v2.3)
**Goal**: Execute the patch injection into the Target Repo safely, verify syntax immediately, and record successful incremental work.

1.  **Pre-Execution Backup**: The `patch_pulse.sh` script starts by backing up all files to be modified into `~/.config/pulse/backups/[timestamp]/`.
2.  **Orchestrator Injection**: Run the orchestrator to pull payloads and inject them into the Target Repo, updating Manifest headers in the process.
3.  **Syntax Guard (Immediate Build)**: Upon patch completion (or per module), immediately run the project build (e.g., `bun build`, `npm run build`, or `tsc`). Code must have zero compile errors.
4.  **Validation & Auto-Restore**: If any failure occurs:
    *   **Auto-Restore**: Automatically trigger `git restore .` in the **Target Repo**. The Phase 1 Anchor ensures the repo returns to the "Functional Sacred Baseline" instantly.
    *   **Refactor**: Return to Phase 2 in the Patch Workspace to analyze and refactor payloads.
5.  **Atomic Checkpoint (v2.3)**: After successful syntax verification of a sub-task or component, perform a git commit in the **Patch Workspace Repo** with the message: `feat: [CR-ID] increment [Module/Command] - syntax verified ✅`. This "saves the points" for complex multi-module Change Requests.
6.  **Verification Prep**: After all injections for the CR are complete and the final build passes, generate a **Cumulative Test Checklist** for the Human.

### Phase 4: Human-in-the-Loop Verification (v2.3)
**Goal**: Perform empirical human testing and "Lock Sacred Status" in both repositories to establish a stable foundation for subsequent work.

1.  **Pre-Gate Checkpoint (v2.3)**: Before handing over for human testing, perform a git commit in the **Patch Workspace Repo** with the message: `test: [CR-ID] implementation complete - pending human verification 🌊`. This locks the "Candidate" state.
2.  **Checklist Handover**: Present the **Cumulative Test Checklist** (including New Feature Tests and Sacred Regression Tests) to the Human.
3.  **Empirical Testing**: The Human performs the actual testing in the Target Repo. AI must not assume success; proof must be empirical.
4.  **Gate Decision**:
    *   **Failed**: Return to Phase 2 or 3 for fixes, using the Pre-Gate Checkpoint as a reference.
    *   **Passed/Verified**: The Human declares the CR "Verified". The code is now elevated to **"Tested from human = Sacred"** status.
5.  **Target Sacred Anchor (v2.3)**: Upon human verification, perform a git commit in the **Target Repo** with message: `sacred: [CR-ID] verified and locked 🛡️`. This creates a new "Safe Point" for the next CR.
### Phase 5: Iterative Loop & Final Cumulative Gate (v2.3)
**Goal**: Ensure all requirements in the RFC portfolio are completed and verified together as a stable fleet.

1.  **Human Priority Gate (MANDATORY)**:
    *   **Action**: At the start of every Phase 5 entry, the AI MUST present the current **CR Status Audit** and ask the Human:
        - **Option A**: Proceed with the next **Pending** CR in the queue.
        - **Option B**: Backtrack to **Refine** a previously **Sacred** CR (e.g., due to requirement changes).
        - **Option C**: Adjust the queue priority or provide custom feedback.
    *   **Wait for Response**: AI MUST NOT proceed until the Human selects an option.

2.  **Iterative Loop (v2.3)**:
    *   Check the choice from the **Human Priority Gate** and the **CR Status Audit**.
    *   **Sacred Refinement & Dependency Re-evaluation**: If the Human chooses to refine a previously **Sacred** CR or if a pending CR requires it:
        *   **Status Update**: Change the status of the target Sacred CR in the audit from `Sacred` to `Refinement Required (by CR-XXX)`.
        *   **Sequencing**: Mark the current context as focusing on this refinement.
        *   **Consult First**: AI MUST trigger the "Consult First" protocol and obtain Human Approval for the specific refinement design.
        *   **CR Documentation Update (Sovereignty Alignment)**: After approval, AI MUST create a new versioned detail file (e.g., `CR-XXXX.v1_detail.md`, `CR-XXXX.v2_detail.md`) to reflect the new refinement requirements. This preserves the original Sacred record for audit trails. The header (Execution Skill, Status) and technical scope MUST be updated according to `build-rfc` standards.
    *   **Pathway**: **Return to Phase 2** to design the chosen feature (or refinement) using the latest Sacred Anchor as the baseline.
    *   If all complete and Human approves: Proceed to the Final Cumulative Gate.

3.  **Final Cumulative Gate (v2.3)**: 
    *   **Test Plan Generation**: Before requesting final approval, the AI MUST generate a formal, detailed integration test plan document (e.g., `ACP-YYYYMMDD-001.md` in `/ψ/writing/[project]/[RFC-ID]/`). This document must outline end-to-end scenarios covering all implemented CRs to serve as a testing guideline for the Human. The content MUST include Thai language descriptions for better understanding. The document header MUST include the **RFC ID** and a link to the Patch Workspace repository.
    *   **MANDATORY**: Final testing of ALL Change Requests together based on the generated plan.
    *   Once the Human confirms the entire integrated fleet is stable (e.g., "Final Test: Passed"), proceed to Phase 6.
### Phase 6: Documentation & Sync (v2.8)
**Goal**: Synchronize the project's "Brain" (Docs) with the "Body" (Code) and create a permanent audit trail with versioned snapshots.

1.  **Post-Implementation Update**: Update the CR detail files (e.g., `CR-PULSE-ALIGN-001_detail.md`) in `/ψ/writing/[project]/[RFC-ID]/` with actual files modified, duration, and test methodology.
2.  **Knowledge Mirroring**: Copy the updated documentation folder from `ψ/writing/[project]/[RFC-ID]/` to `docs/requirements/[project]/[RFC-ID]/` within the **Patch Workspace Repo**.
3.  **Final Snapshot (v2.8)**: Create versioned snapshots of ALL fully patched and verified source files (e.g., `pulse@v8.5.0.ts`) in the `archive/[version]/` directory within the **Patch Workspace Repo**. This serves as the "Gold Master" and provides an immutable reference for future cycles.
4.  **README.md Update (v2.7)**: Update the `README.md` in the **Patch Workspace Repo** root to reflect the current patch version, new feature highlights, and usage instructions corresponding to the newly implemented Change Requests.
5.  **Sacred Lock Checkpoint (v2.3)**: After sync and snapshot, perform a git commit in the **Patch Workspace Repo** with message: `docs: RFC-[ID] ALL CRs VERIFIED - sacred status locked 🛡️🌊`. This officially closes the work in the Workspace.

### Phase 7: Production Delivery (v2.6)
**Goal**: Officially deliver the verified code to the main baseline and synchronize the feature branch.

1.  **Final Consent Gate**: **ASK for Human Permission** to perform the final delivery: "Do you want to proceed with Production Delivery? [y/N]". Default is "N". Wait (PAUSE) until "y" is received.
2.  **Merge & Delivery**: Merge or copy verified code from the `feature` branch to the main branch (`master` or `main`) in the **Patch Workspace Repo**. The `feature` branch MUST be pushed to GitHub for remote synchronization.
3.  **Official Release Commit**: Perform the final commit on the main branch with message: `release: vX.Y.Z [Project Name] - Ironclad Delivery 🛡️🌊`. Push to remote if applicable.
4.  **Remote Deployment Verification (v2.6)**: 
    *   **Requirement**: After pushing to GitHub, AI MUST propose a verification strategy to confirm the remote Patch Workspace repository is functional. 
    *   **Action**: AI MUST perform a "Deployment Test" by cloning the repository from GitHub into a temporary directory (e.g., `patch_ora_modules_fromRepo`) and executing the orchestrator against the Target Repo.
    *   **Gate Decision**: **ASK for Human Confirmation** ("Deployment: Verified"). The AI MUST NOT proceed to the announcement until the Human explicitly confirms that the remote deployment works correctly.
5.  **Fleet Announcement**: Execute **`pulse blog [ACP-MD-Path]`** using the formal Acceptance Test document (e.g., `[RFC-ID]#ACP-YYYYMMDD-001.md`) mirrored in the **Patch Workspace** under `docs/requirements/` to provide evidence of implementation stability to the fleet.
---
**Oracle Signature**: Gemi 🌊 (Deep Blue Horizon)
*"Stable foundations enable dynamic flight. We synchronize the fleet not by force, but by design. No requirement left behind."*


### Phase 3: Execution & Regression Gate (v2.3)
**Goal**: Execute the patch injection into the Target Repo safely, verify syntax immediately, and record successful incremental work.

1.  **Pre-Execution Backup**: The `patch_pulse.sh` script starts by backing up all files to be modified into `~/.config/pulse/backups/[timestamp]/`.
2.  **Orchestrator Injection**: Run the orchestrator to pull payloads and inject them into the Target Repo, updating Manifest headers in the process.
3.  **Syntax Guard (Immediate Build)**: Upon patch completion (or per module), immediately run the project build (e.g., `bun build`, `npm run build`, or `tsc`). Code must have zero compile errors.
4.  **Validation & Auto-Restore**: If any failure occurs:
    *   **Auto-Restore**: Automatically trigger `git restore .` in the **Target Repo**. The Phase 1 Anchor ensures the repo returns to the "Functional Sacred Baseline" instantly.
    *   **Refactor**: Return to Phase 2 in the Patch Workspace to analyze and refactor payloads.
5.  **Atomic Checkpoint (v2.3)**: After successful syntax verification of a sub-task or component, perform a git commit in the **Patch Workspace Repo** with the message: `feat: [CR-ID] increment [Module/Command] - syntax verified ✅`. This "saves the points" for complex multi-module Change Requests.
6.  **Verification Prep**: After all injections for the CR are complete and the final build passes, generate a **Cumulative Test Checklist** for the Human.

### Phase 4: Human-in-the-Loop Verification (v2.3)
**Goal**: Perform empirical human testing and "Lock Sacred Status" in both repositories to establish a stable foundation for subsequent work.

1.  **Pre-Gate Checkpoint (v2.3)**: Before handing over for human testing, perform a git commit in the **Patch Workspace Repo** with the message: `test: [CR-ID] implementation complete - pending human verification 🌊`. This locks the "Candidate" state.
2.  **Checklist Handover**: Present the **Cumulative Test Checklist** (including New Feature Tests and Sacred Regression Tests) to the Human.
3.  **Empirical Testing**: The Human performs the actual testing in the Target Repo. AI must not assume success; proof must be empirical.
4.  **Gate Decision**:
    *   **Failed**: Return to Phase 2 or 3 for fixes, using the Pre-Gate Checkpoint as a reference.
    *   **Passed/Verified**: The Human declares the CR "Verified". The code is now elevated to **"Tested from human = Sacred"** status.
5.  **Target Sacred Anchor (v2.3)**: Upon human verification, perform a git commit in the **Target Repo** with message: `sacred: [CR-ID] verified and locked 🛡️`. This creates a new "Safe Point" for the next CR.
### Phase 5: Iterative Loop & Final Cumulative Gate (v2.3)
**Goal**: Ensure all requirements in the RFC portfolio are completed and verified together as a stable fleet.

1.  **Human Priority Gate (MANDATORY)**:
    *   **Action**: At the start of every Phase 5 entry, the AI MUST present the current **CR Status Audit** and ask the Human:
        - **Option A**: Proceed with the next **Pending** CR in the queue.
        - **Option B**: Backtrack to **Refine** a previously **Sacred** CR (e.g., due to requirement changes).
        - **Option C**: Adjust the queue priority or provide custom feedback.
    *   **Wait for Response**: AI MUST NOT proceed until the Human selects an option.

2.  **Iterative Loop (v2.3)**:
    *   Check the choice from the **Human Priority Gate** and the **CR Status Audit**.
    *   **Sacred Refinement & Dependency Re-evaluation**: If the Human chooses to refine a previously **Sacred** CR or if a pending CR requires it:
        *   **Status Update**: Change the status of the target Sacred CR in the audit from `Sacred` to `Refinement Required (by CR-XXX)`.
        *   **Sequencing**: Mark the current context as focusing on this refinement.
        *   **Consult First**: AI MUST trigger the "Consult First" protocol and obtain Human Approval for the specific refinement design.
        *   **CR Documentation Update (Sovereignty Alignment)**: After approval, AI MUST create a new versioned detail file (e.g., `CR-XXXX.v1_detail.md`, `CR-XXXX.v2_detail.md`) to reflect the new refinement requirements. This preserves the original Sacred record for audit trails. The header (Execution Skill, Status) and technical scope MUST be updated according to `build-rfc` standards.
    *   **Pathway**: **Return to Phase 2** to design the chosen feature (or refinement) using the latest Sacred Anchor as the baseline.
    *   If all complete and Human approves: Proceed to the Final Cumulative Gate.

3.  **Final Cumulative Gate (v2.3)**: 
    *   **Test Plan Generation**: Before requesting final approval, the AI MUST generate a formal, detailed integration test plan document (e.g., `ACP-YYYYMMDD-001.md` in `/ψ/writing/[project]/[RFC-ID]/`). This document must outline end-to-end scenarios covering all implemented CRs to serve as a testing guideline for the Human. The content MUST include Thai language descriptions for better understanding. The document header MUST include the **RFC ID** and a link to the Patch Workspace repository.
    *   **MANDATORY**: Final testing of ALL Change Requests together based on the generated plan.
    *   Once the Human confirms the entire integrated fleet is stable (e.g., "Final Test: Passed"), proceed to Phase 6.
### Phase 6: Documentation & Sync (v2.3)
**Goal**: Synchronize the project's "Brain" (Docs) with the "Body" (Code) and create a permanent audit trail.

1.  **Post-Implementation Update**: Update the CR detail files (e.g., `CR-PULSE-ALIGN-001_detail.md`) in `/ψ/writing/[project]/[RFC-ID]/` with:
    *   Actual files modified.
    *   Development duration.
    *   Test methodology used by the human.
    *   Token usage (if available).
2.  **Knowledge Mirroring**: Copy the updated documentation folder from `ψ/writing/[project]/[RFC-ID]/` to `docs/requirements/[project]/[RFC-ID]/` within the **Patch Workspace Repo**.
3.  **Sacred Lock Checkpoint (v2.3)**: After sync, perform a git commit in the **Patch Workspace Repo** with message: `docs: [CR-ID] VERIFIED - sacred status locked 🛡️🌊` (or `docs: RFC-[ID] ALL CRs VERIFIED...`). This officially closes the work in the Workspace.

### Phase 7: Production Delivery (v2.4)
**Goal**: Officially deliver the verified code to the main baseline and synchronize the feature branch.

1.  **Final Consent Gate**: **ASK for Human Permission** to perform the final delivery: "Do you want to proceed with Production Delivery? [y/N]". Default is "N". Wait (PAUSE) until "y" is received.
2.  **Merge & Delivery**: Merge or copy verified code from the `feature` branch to the main branch (`master` or `main`) in the **Patch Workspace Repo**. The `feature` branch MUST be pushed to GitHub for remote synchronization.
3.  **Official Release Commit**: Perform the final commit on the main branch with message: `release: vX.Y.Z [Project Name] - Ironclad Delivery 🛡️🌊`. Push to remote if applicable.
4.  **Fleet Announcement**: Execute **`pulse blog [ACP-MD-Path]`** using the formal Acceptance Test document (e.g., `[RFC-ID]#ACP-YYYYMMDD-001.md`) mirrored in the **Patch Workspace** under `docs/requirements/` to provide evidence of implementation stability to the fleet.
---
**Oracle Signature**: Gemi 🌊 (Deep Blue Horizon)
*"Stable foundations enable dynamic flight. We synchronize the fleet not by force, but by design. No requirement left behind."*
