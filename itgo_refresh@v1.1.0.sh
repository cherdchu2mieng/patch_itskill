# itgo Refresh Command Implementation (CR-007)
echo "🚀 Starting CR-007 Execution (itgo Refresh)..."

# 1. Add refreshSkill function to installer.ts
apply_payload "src/cli/installer.ts" "refresh_skill_function@v1.1.0" "export async function uninstallSkills(" "refresh_skill_function@v1.1.0.pl" "insert"

# 2. Total Refinement of itgo.ts (Combines CR-001, CR-006, and CR-007)
# This is the "Clean Sweep" approach to ensure tidiness.
ITGO_PATH="$TARGET_PATH/src/cli/commands/itgo.ts"
echo "// @it-skill-patch: itgo_complete@v1.1.0" > "$ITGO_PATH"
cat "$PAYLOADS_DIR/refined_itgo_complete@v1.1.0.pl" >> "$ITGO_PATH"
echo "✅ Consolidated $ITGO_PATH"

echo "✅ CR-007 Logic Applied."
