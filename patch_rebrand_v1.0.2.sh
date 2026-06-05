#!/bin/bash
# it-skill-cli Rebranding Orchestrator v1.0.2
# Goal: Identity Separation and Private Repo Alignment

if [ -z "$1" ]; then
  echo "Usage: $0 <target-repo-path>"
  exit 1
fi

export TARGET_PATH=$(realpath "$1")
export SCRIPT_DIR="$(realpath "$(dirname "$0")")"
export PAYLOADS_DIR="$SCRIPT_DIR/payloads"

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

# Tag check
if f"// @it-skill-patch: {tag}" in content:
    print(f"  ✅ {tag} already present.")
    sys.exit(0)

if not os.path.exists(payload_path):
    print(f"  ❌ Error: Payload file not found: {payload_path}")
    sys.exit(1)

with open(payload_path, "r") as f:
    payload = f.read().strip()

new_content = content
if mode == "replace_block":
    if start in content and end in content:
        idx_start = content.find(start)
        idx_end = content.find(end, idx_start + len(start))
        if idx_start != -1 and idx_end != -1:
             new_content = content[:idx_start] + payload + content[idx_end + len(end):]
        else:
             print(f"  ❌ Error: Block anchors found but overlap or logic failure")
             sys.exit(1)
    else:
        print(f"  ❌ Error: Block start or end anchor not found")
        sys.exit(1)
elif mode == "replace_line":
    if start in content:
        new_content = content.replace(start, payload)
    else:
        print(f"  ❌ Error: Line anchor not found: {start}")
        sys.exit(1)
else:
    if start in content:
        new_content = content.replace(start, payload + "\n" + start)
    else:
        print(f"  ❌ Error: Anchor not found: {start}")
        sys.exit(1)

# Add patch tag
if not is_json:
    lines = new_content.split("\n")
    insert_pos = 0
    if len(lines) > 0 and lines[0].startswith("#!"):
        insert_pos = 1
    
    tag_line = f"// @it-skill-patch: {tag}"
    lines.insert(insert_pos, tag_line)
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

echo "🚀 Starting Patch Execution (v1.0.2)..."

# CR-001: Identity String Transformation
apply_payload "src/cli/installer.ts" "it_identity_codex@v1.0.2" 'description = "Oracle skills for Codex by Soul Brews Studio"' "codex_desc@v1.0.2.pl" "replace_line"
apply_payload "src/cli/installer.ts" "it_identity_origin@v1.0.2" '`---\ninstaller: it-skill-cli v${pkg.version}\norigin: Nat Weerawan' "skill_header_origin@v1.0.2.pl" "replace_block" 'Brews Studio\n`'
apply_payload "src/cli/installer.ts" "it_identity_author@v1.0.2" "author: { name: 'Nat Weerawan', organization: 'Soul Brews Studio' }," "author_metadata@v1.0.2.pl" "replace_line"
apply_payload "src/cli/installer.ts" "it_identity_vfs_banner@v1.0.2" "\`*🧬 Nat Weerawan × Oracle" "vfs_banner@v1.0.2.pl" "replace_block" "captured as code*\`"
apply_payload "src/cli/commands/about.ts" "it_identity_about@v1.0.2" "console.log(\`  Digitized from Nat Weerawan's brain — Soul Brews Studio\n\`);" "about_msg@v1.0.2.pl" "replace_line"
apply_payload "scripts/compile.ts" "it_identity_compile_banner@v1.0.2" "\`*🧬 Nat Weerawan × Oracle" "vfs_banner@v1.0.2.pl" "replace_block" "captured as code*\`"

# CR-002: Private Repo Fix
apply_payload "install.sh" "pkg_spec_fix@v1.0.2" 'PKG_SPEC="it-skill@github:itinfosv/it-skill-cli#master"' "pkg_spec_fix@v1.0.2.pl" "replace_line"
apply_payload "install.sh" "wrapper_fix@v1.0.2" "#!/bin/bash\n# IT-Skill CLI — bunx wrapper (v1.0.1)" "wrapper_fix@v1.0.2.pl" "replace_block" "WRAPPER"

# CR-003: Metadata Update
apply_payload "package.json" "pkg_json_metadata@v1.0.2" '  "author": "itinfosv",' "pkg_json_metadata@v1.0.2.pl" "replace_block" '"homepage": "https://github.com/cherdchu2mieng/itinfosv-skill-cli#readme",'
apply_payload "LICENSE" "license_rebrand@v1.0.2" "Copyright (c) 2025-2026 Nat Weerawan" "license_rebrand@v1.0.2.pl" "replace_line"

# CR-004: Test Suite Alignment
echo "🧪 Aligning Test Suite..."
cd "$TARGET_PATH"
python3 "$PAYLOADS_DIR/test_alignment@v1.0.2.py"
echo "✅ Test suite aligned."

echo "🏁 Patching Complete (v1.0.2)."
