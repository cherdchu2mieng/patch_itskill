# itgo Command Registration & Scaffolding (CR-001)
echo "🚀 Starting CR-001 Execution (itgo Genesis)..."

# 1. Comprehensive Rebranding (UI Strings & Logic)
python3 "$SCRIPT_DIR/rebrand_comprehensive.py" "$TARGET_PATH"

# 2. itgo Scaffolding (New File)
ITGO_PATH="$TARGET_PATH/src/cli/commands/itgo.ts"
echo "// @it-skill-patch: itgo_scaffolding@v1.1.0" > "$ITGO_PATH"
cat "$PAYLOADS_DIR/itgo_scaffolding@v1.1.0.pl" >> "$ITGO_PATH"
echo "✅ Created $ITGO_PATH"

# 3. Command Registration (index.ts)
apply_payload "src/cli/index.ts" "itgo_registration_import@v1.1.0" "import { registerAbout }" "itgo_registration_import@v1.1.0.pl" "insert"
apply_payload "src/cli/index.ts" "itgo_registration_call@v1.1.0" "registerAbout(program, VERSION);" "itgo_registration_call@v1.1.0.pl" "insert"

# 4. Profile Update (profiles.ts)
apply_payload "src/profiles.ts" "itgo_profile_update@v1.1.0" "'build-patch', 'build-rfc', 'close-rfc', 'patch-forge'," "itgo_profile_update@v1.1.0.pl" "replace_line"

# 5. Skill Scaffolding (itgo)
mkdir -p "$TARGET_PATH/src/skills/itgo"
cat <<'SKILL_EOF' > "$TARGET_PATH/src/skills/itgo/SKILL.md"
# /itgo — [itinfosv] IT TEAM Sovereign Fleet Dashboard
[core] v1.1.0 G-SKLL | Manage and audit the IT TEAM infrastructure fleet.

## Usage
/itgo           # Show the Unified Dashboard
/itgo --global  # Show global skills
/itgo --now     # (Planned) Real-time fleet health

---
installer: it-skill-cli
SKILL_EOF
echo "✅ Created src/skills/itgo/SKILL.md"

# 6. Test Alignment
python3 "$SCRIPT_DIR/rebrand_e2e_tests.py" "$TARGET_PATH"
