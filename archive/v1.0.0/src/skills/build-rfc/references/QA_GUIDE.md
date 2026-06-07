# Requirement Gathering Q&A Guide

Use these questions to prompt the user for necessary information when forging a new requirement.

## 1. Metadata & Identity (Phase 1)
- "Who is the primary requester for this change (Request By)?"
- "What is the official Source of this request (Issue #, Prompt date, or Attached file)?"
- "What is the RFC Number for this project (e.g., RFC-YYYYMMDD-NAME)?"
- "How should the requirements be structured? (e.g., Folder-based RFC, Multi-module, or Single-file)"

## 2. Scope Consensus (Phase 2)
Before drafting the full spec, summarize the request into a list:
- "Here is my understanding of the requirements so far (Mapping): [Point 1], [Point 2]... Do you agree? (Reply OK or provide feedback)"
- "Are there any supplemental requirements from your side? (Human Supplemental Input)"

## 3. Information Gathering (Research)
- **IG-1: Technical Baseline**: "What is the current state of the relevant code/files?"
- **IG-2: Integration Points**: "How will this change affect other modules or systems?"
- **IG-3: Operational Constraints**: "Are there specific workflow or UI constraints to consider?"

## 4. Functional Drill-down
- "Can you list the step-by-step actions the system must perform?"
- "Are there any specific UI prompts or console outputs you expect?"
- **Rule**: Describe the logic in a clear, manual-like style. Avoid AI-only shorthand. Capture the "Functional Intent" for the RFC Master and "Detailed Step-by-Step Logic" for the CR Details.

## 5. Non-Functional Constraints
- "Are there any performance requirements (e.g., speed, memory usage)?"
- "Are there any specific security or authorization rules to enforce?"
- "Does this need to adhere to the Stability Protocol (Tested from human = Sacred)?"

## 6. Success Metrics
- "How will we know this task is complete?"
- "Can you provide a checklist of verifiable outcomes for the Acceptance Criteria?"
