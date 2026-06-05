# Multi-Module Governance Standard

## 1. Hierarchy (L1 -> L4)
- **L1 Project**: Overall container (e.g. gemi-oracle).
- **L2 RFC**: Business/Functional intent (The "What").
- **L3 Module**: The physical codebase unit (e.g. pulse-cli).
- **L4 CR**: The technical execution unit (The "How").

## 2. Rule of Execution
- Every RFC MUST be broken down into at least one CR per affected Module.
- A CR maps 1:1 to a /robust-patching feature branch.
- RFC Status cannot be "Closed" until all its child CRs are "Verified" and "Archived" in Phase 6.

## 3. Atomic Identity
RFC IDs should reflect the requirement number (e.g., RFC-REQ-5) to maintain alignment with the historical roadmap.
