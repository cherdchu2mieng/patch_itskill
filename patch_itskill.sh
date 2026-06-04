#!/bin/bash
# it-skill-cli Patch Orchestrator v1.4
# Migration and Rebranding for itinfosv

if [ -z "$1" ]; then
  echo "Usage: $0 <target-repo-path> [--restore]"
  exit 1
fi

export TARGET_PATH=$(realpath "$1")
export SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export PAYLOADS_DIR="$SCRIPT_DIR/payloads"
export BASELINE_PATH="/home/a2it49072/ghq/github.com/cherdchu2mieng/gemi-oracle/ψ/learn/Soul-Brews-Studio/arra-oracle-skills-cli/origin/"

# 0. TARGET CLEAN
echo "🧹 Cleaning Target Repo: $TARGET_PATH..."
cd "$TARGET_PATH" || exit 1
git fetch origin > /dev/null 2>&1 || echo "⚠️ Origin fetch failed, assuming local-only."
git reset --hard origin/main > /dev/null 2>&1 || git reset --hard master > /dev/null 2>&1
git clean -fd > /dev/null 2>&1
echo "✅ Target is now Clean Baseline."

# 1. INIT REPO (Copy from Baseline)
echo "🏗️  Initializing Repo Structure..."
cp -rv "$BASELINE_PATH"* "$TARGET_PATH/"
echo "✅ Repo structure initialized from baseline."

# 2. RUNTIME BACKUP
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.config/it-skill/backups/patch_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
echo "📂 Backup: $BACKUP_DIR"

FILES=(
  "package.json"
  "README.md"
  "install.sh"
)

for f in "${FILES[@]}"; do
  if [ -f "$TARGET_PATH/$f" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$f")"
    cp "$TARGET_PATH/$f" "$BACKUP_DIR/$f"
  fi
done

# 3. HELPER FUNCTIONS
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
import os, sys, re, json

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

is_json = target_file.lower().endswith(".json")
with open(path, "r") as f:
    content = f.read()

if content.startswith("// @it-skill-patch:"):
    l = content.split("\n")
    content = "\n".join(l[1:]) if is_json else content

if is_json:
    try:
        data = json.loads(content)
        manifest = data.get("it-skill-patch", "")
        if tag in manifest.split():
            print(f"  ✅ {tag} already present in JSON.")
            sys.exit(0)
    except:
        pass
else:
    manifest_match = re.search(r'// @it-skill-patch:.*', content)
    if manifest_match and tag in manifest_match.group(0).split():
        print(f"  ✅ {tag} already present.")
        sys.exit(0)

if not os.path.exists(payload_path):
    print(f"  ❌ Error: Payload file not found: {payload_path}")
    sys.exit(1)

with open(payload_path, "r") as f:
    payload = f.read().strip()

new_content = content
if mode == "replace_block":
    idx_start = content.find(start)
    if idx_start != -1:
        idx_end = content.find(end, idx_start + len(start))
        if idx_end != -1:
             new_content = content[:idx_start] + payload + content[idx_end + len(end):]
        else:
             print(f"  ❌ Error: Block end anchor not found")
             sys.exit(1)
    else:
        print(f"  ❌ Error: Block start anchor not found")
        sys.exit(1)
elif mode == "replace_line":
    if start in content:
        new_content = content.replace(start, payload)
    else:
        print(f"  ❌ Error: Line anchor not found")
        sys.exit(1)
else:
    if start in content:
        new_content = content.replace(start, payload + "\n" + start)
    else:
        print(f"  ❌ Error: Anchor not found")
        sys.exit(1)

if is_json:
    try:
        if new_content.strip().startswith("//"):
             new_content = "\n".join([l for l in new_content.split("\n") if not l.strip().startswith("//")])
        data = json.loads(new_content)
        current_tags = data.get("it-skill-patch", "")
        if tag not in current_tags.split():
            data["it-skill-patch"] = (current_tags + " " + tag).strip()
        new_content = json.dumps(data, indent=2) + "\n"
    except Exception as e:
        print(f"  ❌ Error updating JSON manifest: {e}")
        sys.exit(1)
else:
    lines = new_content.split("\n")
    has_shebang = len(lines) > 0 and lines[0].startswith("#!")
    patch_idx = -1
    for i, line in enumerate(lines):
        if line.startswith("// @it-skill-patch:"):
            patch_idx = i
            break
    if patch_idx != -1:
        if tag not in lines[patch_idx]:
            lines[patch_idx] = lines[patch_idx].rstrip() + f" {tag}"
    else:
        insert_pos = 1 if has_shebang else 0
        lines.insert(insert_pos, f"// @it-skill-patch: {tag}")
    new_content = "\n".join(lines)

with open(path, "w") as f:
    f.write(new_content)
print(f"  ✨ Applied {tag}")
PY_EOF

  if [ $? -ne 0 ]; then
    echo "❌ Execution failed for $feature"
    exit 1
  fi
}

# 4. EXECUTION GATE
echo "🚀 Starting CR-ITSKILL-001 Execution..."

# Package.json Rebranding (Specialized Script)
python3 "$SCRIPT_DIR/rebrand_package_json.py" "$TARGET_PATH"

# README Rebranding (High-Quality Final)
python3 "$SCRIPT_DIR/rebrand_final_readme.py" "$TARGET_PATH"

# Install.sh Rebranding (Strict Mode)


echo "🚀 Starting CR-ITSKILL-002 Execution..."

# Skill Porting
python3 "$SCRIPT_DIR/port_governance_skills.py" "$TARGET_PATH"

# Profile Configuration Update (Total Overwrite)
python3 "$SCRIPT_DIR/rebrand_profiles_config.py" "$TARGET_PATH"

# Skill Cleanup (Remove non-RFC skills)
python3 "$SCRIPT_DIR/cleanup_skills.py" "$TARGET_PATH"

# Test Alignment (Total Overwrite)
python3 "$SCRIPT_DIR/rebrand_profiles_test.py" "$TARGET_PATH"

echo "🚀 Starting CR-ITSKILL-003 Execution..."

# Install.sh Rebranding (Strict Mode)
python3 "$SCRIPT_DIR/rebrand_install_script.py" "$TARGET_PATH"

# Installer Logic Rebranding (Signature & Strings)
python3 "$SCRIPT_DIR/rebrand_installer_logic.py" "$TARGET_PATH"

echo "✅ All patches applied successfully."
