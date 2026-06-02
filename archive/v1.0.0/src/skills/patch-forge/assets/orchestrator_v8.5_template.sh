#!/bin/bash
# Patch Orchestrator Template v8.5 (v2.5 Standard)
# Sequential, Manifest-Driven, Idempotent, Clean-First

if [ -z "$1" ]; then
  echo "Usage: $0 <target-repo-path> [--restore]"
  exit 1
fi

export TARGET_PATH=$(realpath "$1")
export PAYLOADS_DIR="$(realpath "$(dirname "$0")/payloads")"

# 0. TARGET CLEAN (v2.5 Mandate)
echo "🧹 Cleaning Target Repo: $TARGET_PATH..."
cd "$TARGET_PATH" || exit 1
git fetch origin > /dev/null 2>&1
git reset --hard origin/main > /dev/null 2>&1
git clean -fd > /dev/null 2>&1
echo "✅ Target is now Clean Baseline (Upstream)."

# 1. RUNTIME BACKUP
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.config/pulse/backups/patch_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
echo "📂 Backup: $BACKUP_DIR"

# List files to backup here
FILES=(
  "package.json"
)

for f in "${FILES[@]}"; do
  if [ -f "$TARGET_PATH/$f" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$f")"
    cp "$TARGET_PATH/$f" "$BACKUP_DIR/$f"
  fi
done

# 2. HELPER FUNCTIONS
function apply_payload() {
  local target_file="$1"
  local feature="$2"
  local anchor_start="$3"
  local payload_name="$4"
  local mode="${5:-insert}"
  local anchor_end="$6"

  echo "🛠️  Checking $feature in $(basename "$target_file")..."
  
  export T_FILE="$target_file"
  export T_TAG="$feature"
  export T_START="$anchor_start"
  export T_PAYLOAD="$payload_name"
  export T_MODE="$mode"
  export T_END="$anchor_end"

  python3 - <<'PY_EOF'
import os, sys, re

target_repo_path = os.environ.get("TARGET_PATH")
payloads_dir = os.environ.get("PAYLOADS_DIR")
target_file = os.environ.get("T_FILE")
tag = os.environ.get("T_TAG")
start = os.environ.get("T_START")
payload_name = os.environ.get("T_PAYLOAD")
mode = os.environ.get("T_MODE")
end = os.environ.get("T_END")

path = os.path.join(target_repo_path, target_file)
payload_path = os.path.join(payloads_dir, payload_name)

if not os.path.exists(path):
    print(f"  ⚠️ Skipping: {path} not found")
    sys.exit(0)

with open(path, "r") as f:
    content = f.read()

# Robust Manifest Check
manifest_match = re.search(r'// @pulse-patch:.*', content)
if manifest_match and tag in manifest_match.group(0).split():
    print(f"  ✅ {tag} already present.")
    sys.exit(0)

if not os.path.exists(payload_path):
    print(f"  ❌ Error: Payload file not found: {payload_path}")
    sys.exit(1)

with open(payload_path, "r") as f:
    payload = f.read().strip()

# Manifest Management
if "// @pulse-patch:" in content:
    lines = content.split("\n")
    for i, line in enumerate(lines):
        if line.startswith("// @pulse-patch:"):
            if tag not in line:
                lines[i] = line.rstrip() + f" {tag}"
            break
    content = "\n".join(lines)
else:
    lines = content.split("\n")
    if lines[0].startswith("#!"):
        content = lines[0] + "\n" + f"// @pulse-patch: {tag}" + "\n" + "\n".join(lines[1:])
    else:
        content = f"// @pulse-patch: {tag}\n" + content

# Injection
if mode == "replace_block":
    idx_start = content.find(start)
    if idx_start != -1:
        idx_end = content.find(end, idx_start + len(start))
        if idx_end != -1:
             content = content[:idx_start] + payload + content[idx_end + len(end):]
        else:
             print(f"  ❌ Error: Block end anchor not found in {target_file}")
             sys.exit(1)
    else:
        print(f"  ❌ Error: Block start anchor not found in {target_file}")
        sys.exit(1)
elif mode == "replace_line":
    if start in content:
        content = content.replace(start, payload)
    else:
        print(f"  ❌ Error: Line anchor not found in {target_file}")
        sys.exit(1)
else: # Default: insert before start
    if start in content:
        content = content.replace(start, payload + "\n" + start)
    else:
        print(f"  ❌ Error: Anchor not found in {target_file}")
        sys.exit(1)

with open(path, "w") as f:
    f.write(content)
print(f"  ✨ Applied {tag}")
PY_EOF

  if [ $? -ne 0 ]; then
    echo "❌ Patch FAILED on $feature."
    exit 1
  fi
}

# 3. PATCH SEQUENCES (Define your patches here)
# apply_payload "path/to/file.ts" "feature@v1.0.0" "anchor_text" "feature@v1.0.0.pl"

# 4. SYNTAX GUARD
echo "🛡️ Running Syntax Guard..."
# cd "$TARGET_PATH" && bun build ...

echo "🌊 Patch cycle complete."
