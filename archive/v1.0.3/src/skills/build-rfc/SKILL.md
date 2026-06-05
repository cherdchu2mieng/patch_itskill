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
Define the foundational properties of the requirement before analyzing scope. **The following identity fields are MANDATORY**:
- **Identity Fields**: `Patch Workspace` (Local path), `Target Repo` (Org/Repo name), `Structure` (RFC folder path).
- **Other Properties**: `Request By`, `Approver` (MUST be Human), `Priority` (P0-P3), `Stability Impact` (Low/High), `Security Level`, `Date Time`, `Source` (Issue #, Prompt, File), `RFC Number`, `Target Version`.
- **Structural Blueprint**: Define the `Requirements Structure` (e.g., Folder-based RFC, Multi-module, or Single-file spec).

- **Confirmation Protocol**: AI MUST present Phase 1 metadata (including all mandatory identity fields) and explicitly ask for either **"rfc-Phase 1 confirm"** OR feedback to adjust the information before proceeding to Phase 2.

### Phase 2: Functional Requirement Intake & FR Generation
Human provides the primary scope and specific needs for the request.
- **Action**: Human describes the functional requirements, constraints, and desired outcomes. AI pulls details to form the functional base.
- **4-Layer Logic (Functional)**: 
    1. **Requirement Mapping**: AI's synthesis of the functional needs.
    2. **Information Gathering**: Operational (IG-2) and high-level technical (IG-1) feasibility checks.
    3. **Implementation Governance**: Determine the primary skill for the project.
- **Confirmation Protocol**: AI MUST present the synthesis and generated **`[FR-ID].md`** (using **FR_TEMPLATE.md**) and explicitly ask for **"rfc-Phase 2 confirm"**.
- **Phase Gate**: Phase 3 is BLOCKED until the Functional Requirements (FR) are confirmed and "Sacred".

### Phase 3: Technical Analysis & CR Generation
Break down the confirmed FRs into technical implementation components (CRs).
- **Action**: For each technical sub-process (e.g., 3.1: Config Update, 3.2: Logic Change):
    1. **Implementation Mapping**: How the FR translates to code.
    2. **Technical IG (IG-1)**: Deep dive into specific files and code paths.
    3. **Governance (Layer 4)**: Confirm the specific implementation skill (e.g., `build-patch`).
- **Confirmation Protocol**: AI MUST present the generated **`[CR-ID]_detail.md`** (using **CR_TEMPLATE.md**) for each component and ask for **"rfc-Phase 3.[x] confirm"**.
- **Phase Gate**: Phase 4 is BLOCKED until all technical Change Requests (CRs) are confirmed.

### Phase 4: RFC Master Drafting
Create `/ψ/writing/[project]/[RFC-ID]/` and generate `[RFC-ID]_master.md` using the updated PRD_TEMPLATE.md.
- **Portfolio Aggregation**: Aggregates all confirmed FRs and CRs into a single authoritative master specification.
- **Confirmation Protocol**: AI MUST present the drafted Master RFC and explicitly ask for **"rfc-Phase 4 confirm"**.

### Phase 5: implementation Detail Review (Sacred Anchor)
Final review of the full RFC portfolio (Master + FRs + CRs) before moving to implementation.
- **Action**: Ensure all documents are cross-referenced and the "Sacred Memory" status is applied to the folder.
- **Confirmation Protocol**: User provides a final **"rfc-Phase 5 confirm"** to lock the RFC for execution.

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
