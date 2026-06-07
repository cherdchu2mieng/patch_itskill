---
name: build-rfc
description: Requirement gathering and formal specification forging with 4-layered granular logic and explicit metadata definition.
---

# [itinfosv] ⚒️ Build RFC (/build-rfc)
**Alias**: `/brfc`

**Goal**: Transform requests into enterprise-grade specifications using a folder-based hierarchy, explicit metadata identity, and 4-layered confirmation logic for total clarity. Provides a unified command directory via **`brfc-list`**.

---

## 🛠️ Command Directory (`brfc-list`)
The following commands are available for managing the 6-Phase RFC Workflow:

- **`brfc-Phase 1 confirm`**: Confirm Metadata & Identity Definition.
- **`brfc-Phase 2 confirm`**: Confirm User Requirement Intake.
- **`brfc-Phase 3.[x] confirm`**: Confirm specific sub-process scope (Layer 4 included).
- **`brfc-Phase 4 confirm`**: Confirm Master RFC Draft.
- **`brfc-Phase 5 confirm`**: Confirm specific CR Detail Draft.
- **`brfc-backtrack`**: Return to Phase 2 to adjust core requirements.
- **`brfc-report`**: Display the current RFC Metadata and Phase status.
- **`brfc-report [RFC-ID]`**: Display full details of a specific Master RFC.
- **`brfc-report [CR-ID]`**: Display full details of a specific Change Request.
- **`brfc-list`**: Show this command directory.

---

## 🚀 Workflow
### Phase 1: Metadata & Identity Definition
Define the foundational properties of the requirement before analyzing scope:
- **Properties**: `Request By`, `Approver` (MUST be Human), `Priority` (P0-P3), `Stability Impact` (Low/High), `Security Level`, `Date Time`, `Source` (Issue #, Prompt, File), `RFC Number`, `Target Version`, `Patch Workspace Repo`, `Target Repo Path`.
- **Structural Blueprint**: Define the `Requirements Structure` (e.g., Folder-based RFC, Multi-module, or Single-file spec).

- **Confirmation Protocol**: AI MUST present Phase 1 metadata and explicitly ask for either **"rfc-Phase 1 confirm"** OR feedback to adjust the information before proceeding to Phase 2.

### Phase 2: User Requirement Intake
Human provides the primary scope and specific needs for the request.
- **Action**: Human describes the functional requirements, constraints, and desired outcomes. AI may pull preliminary details from a linked **Issue** (if provided in Phase 1) to form the base draft.
- **Confirmation Protocol**: AI MUST present the gathered requirements and explicitly ask for either **"rfc-Phase 2 confirm"** OR feedback to adjust the requirements before proceeding to Phase 3. No technical analysis or research starts until this phase is confirmed.

### Phase 3: Granular Scope Consensus
Break down the intake into specific sub-processes and establish consensus for each using the 4-layer logic.
- **Iterative Breakdown**: Analyze requirements by process (e.g., 3.1: Command A, 3.2: Command B).
- **4-Layer Execution per Process**:
    1. **Requirement Mapping**: AI's synthesis of the specific process.
    2. **Information Gathering**: Technical research (IG-1), Integration (IG-2), and Operational (IG-3) checks.
    3. **Implementation Governance (Layer 4)**: Explicitly ask the Human to specify the mandatory skill required for the execution of the CR (e.g., `build-patch`, `N` for manual, or custom Feedback).
    4. **Confirmation & Pathway**: Present results and explicitly ask for:
        - **Option A: "rfc-Phase 3.[x] confirm"** -> Proceed to next sub-process or Phase 4.
        - **Option B: "rfc-Backtrack to Phase 2"** -> Return to Requirement Intake to adjust the core scope.
        - **Option C: rfc-Feedback** -> Adjust the mapping or research findings for the current sub-process.
- **Phase Gate**: Phase 4 (Master Drafting) and Phase 5 (CR Scoping) are STRICTLY BLOCKED until ALL sub-processes in Phase 3 are confirmed by Human.

### Phase 4: RFC Folder & Master Drafting
Create `/ψ/writing/[project]/[RFC-ID]/` and generate `[RFC-ID]_master.md` using the updated PRD_TEMPLATE.md.
- **CR Mapping**: Explicitly define the total number of CRs required to fulfill the RFC based on Phase 3 analysis.
- **Confirmation Protocol**: AI MUST present the drafted Master RFC and explicitly ask for either **"rfc-Phase 4 confirm"** OR feedback to adjust the draft before proceeding.

### Phase 5: CR Scoping & Detail Drafting
For each module, generate `[CR-ID]_detail.md` using CR_TEMPLATE.md.
- **Execution Skill Header**: Every CR MUST include the `Execution Skill` field in its header, as defined in Phase 3 Layer 4.
- **Worktree Requirement**: For each CR, specify if a dedicated **Git Worktree** is required for isolation during implementation.
- **Robust-Patching Readiness**: Ensure each CR contains enough detail (Step-by-Step Logic, Acceptance Criteria) to be consumed by the `/robust-patching` skill.
- **Confirmation Protocol**: AI MUST present each CR Detail and explicitly ask for either **"rfc-Phase 5 confirm"** (Status: `Approved (Tested from human = Sacred)`) OR feedback to adjust the CR details.

### Phase 6: Implementation & Post-Mortem
After Phase 6 of /build-patch:
- **Report**: Append the Post-Implementation Report to the CR file.
- **Announcement**: Announce the successful implementation to the gateway repo using `pulse gw` (to synchronize keywords and metadata across the fleet and inform the team).
## 🛡️ Iron Rules
0. **Methodological Sovereignty**: Every RFC file MUST start with the following header: `<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->`.
1. **Identity First**: No scope analysis until Metadata (Phase 1) is clearly defined AND confirmed by Human via **"rfc-Phase 1 confirm"**.
2. **Phase Gates**: Each Phase must be explicitly confirmed by Human using the **"rfc-Phase X confirm"** syntax before proceeding to the next.
3. **Four-Layer Consensus**: No RFC can be created without explicit OK on Mapping, Supplemental, Information Gathering, and Implementation Governance (Layer 4) layers.
4. **Iterative Flexibility**: Phase 3 MUST support backtracking to Phase 2 via **"rfc-Backtrack to Phase 2"** if requirements are refined.
5. **Human-Readable Clarity**: RFC Master MUST capture "Functional Intent"; CR Details MUST describe "Step-by-Step Logic".
6. **Traceability**: All requirements MUST point back to their source (Metadata or Human Input).
7. **Zero-Assumption Confirmation**: The AI is strictly forbidden from advancing a phase or locking an RFC status based on implicit context. The exact string **`confirm`** MUST be present in the user's prompt (e.g., `brfc-Phase X confirm`) to trigger the transition.
