# Robust Patching Architecture (v3.0) Technical Specification 🛡️

## 1. Core Philosophy: Separation of Concerns
Architecture v3.0 decouples the **what** (Payload) from the **how** (Orchestrator).

- **Payload (.pl)**: Contains the literal TypeScript/JavaScript code to be injected. It is "Dumb" and "Pure". No shell escaping is required.
- **Orchestrator (.sh)**: Contains the injection logic, file path resolution, and safety guards. It is the "Smart" glue.

## 2. Payload Standard (.pl)
- **Naming**: `<feature_name>@<version>.pl` (e.g., `add_imports@v8.4.0.pl`)
- **Content**: Literal code block. Do not include anchors or metadata inside the payload file.
- **Purity**: Avoid any shell-specific characters that might be expanded if not handled correctly by the orchestrator.

## 3. Orchestrator Standard (.sh)
The orchestrator must implement the **Iron Rules**:

### 3.1 Clean-First Mandate
Every execution must start by resetting the target to a known good state (Sacred Baseline).
```bash
git reset --hard origin/main
git clean -fd
```

### 3.2 Manifest-Driven Idempotency
Use a header tag to track applied patches.
- **Format**: `// @pulse-patch: <feature>@<version>`
- **Check**: Before applying, the orchestrator must grep the target file for this tag. If found, skip.

### 3.3 The `apply_payload` Function
A standardized function (usually Python-backed) to handle:
- **Manifest injection**: Adding/updating the `@pulse-patch` line.
- **Anchoring**: `insert_before`, `replace_line`, or `replace_block`.
- **Error Handling**: Non-zero exit on failure.

## 4. Stability Protocol Integration
- **Sacred Status**: Once a payload is verified by a Human, its `.pl` file is locked. Any changes require a new version tag (e.g., `v1` -> `v2`).
- **Auditability**: Every patch action must be logged with a timestamp and feature tag.
