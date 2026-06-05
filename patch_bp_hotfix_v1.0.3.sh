#!/bin/bash
# it-skill-cli Build-Patch Governance Update v1.0.3

export TARGET_PATH=$(realpath "$1")
export SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export PAYLOADS_DIR="$SCRIPT_DIR/payloads"

function apply_payload() {
  local target_file="$1"
  local feature="$2"
  local anchor_start="$3"
  local payload_name="$4"
  local mode="${5:-insert}"
  local anchor_end="$6"

  echo "🛠️  Checking $feature in $target_file..."
  
  export T_FILE="$target_file"
  export T_TAG="$feature"
  export T_START="$anchor_start"
  export T_PAYLOAD="$payload_name"
  export T_MODE="$mode"
  export T_END="$anchor_end"

  python3 - <<'PY_EOF'
import os, sys

target_repo_path = os.environ.get("TARGET_PATH")
payloads_dir = os.environ.get("PAYLOADS_DIR")
target_file = os.environ.get("T_FILE")
tag = os.environ.get("T_TAG")
start = os.environ.get("T_START")
payload_name = os.environ.get("T_PAYLOAD")
mode = os.environ.get("T_MODE")

path = os.path.join(target_repo_path, target_file)
payload_path = os.path.join(payloads_dir, payload_name)

if mode == "create_file":
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(payload_path, "r") as f: payload = f.read()
    with open(path, "w") as f: f.write(payload)
    print(f"  ✨ Created file {target_file}")
    sys.exit(0)

if not os.path.exists(path):
    print(f"  ⚠️ Skipping: {path} not found")
    sys.exit(0)

with open(path, "r") as f: content = f.read()

if not os.path.exists(payload_path):
    print(f"  ❌ Error: Payload not found: {payload_path}")
    sys.exit(1)

with open(payload_path, "r") as f: payload = f.read().strip()

new_content = content
if mode == "replace_line":
    if start in content:
        new_content = content.replace(start, payload)
    else:
        print(f"  ❌ Error: Line anchor not found: {start}")
        sys.exit(1)

with open(path, "w") as f: f.write(new_content)
print(f"  ✨ Applied {tag}")
PY_EOF
  if [ $? -ne 0 ]; then exit 1; fi
}

echo "🚀 Starting Patch Execution (v1.0.3)..."

cd "$TARGET_PATH" && git restore src/skills/build-patch/SKILL.md

apply_payload "src/skills/build-patch/SKILL.md" "hotfix_version_bump@v1.0.3" "# [itinfosv] 🌊 Build Patch Skill (v2.8)" "hotfix_version_bump@v1.0.3.pl" "replace_line"
apply_payload "src/skills/build-patch/SKILL.md" "hotfix_rule_append@v1.0.3" "16. **Ironclad Archive Principle (v2.8)**: Upon final verification, the AI MUST archive the fully patched source files as versioned snapshots. This provides an immutable reference for the release and serves as the baseline for future forge cycles." "hotfix_rule_append@v1.0.3.pl" "replace_line"
apply_payload "src/skills/build-patch/references/Ref-002_hotfix_phase_jump_violation.md" "ref_002_hotfix@v1.0.3" "" "ref_002_hotfix.md.pl" "create_file"

echo "🏁 Patching Complete (v1.0.3)."
