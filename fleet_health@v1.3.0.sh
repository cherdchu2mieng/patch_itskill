# Fleet Health & Shell Integration (CR-003 - Refined with Shell Injection)
echo "🚀 Starting CR-003 Execution (Fleet Health & Shell Injection)..."

# 1. Total Refactor of fs-utils.ts (Clean Sweep + Shell Injection Helper)
FS_UTILS_PATH="$TARGET_PATH/src/cli/fs-utils.ts"
echo "// @it-skill-patch: fs_utils_complete@v1.5.0" > "$FS_UTILS_PATH"
cat "$PAYLOADS_DIR/fs_utils_complete@v1.5.0.pl" >> "$FS_UTILS_PATH"
echo "✅ Consolidated $FS_UTILS_PATH with Shell Injection"

# 2. Update itgo Dashboard with Shell Integration (v1.5.1)
ITGO_PATH="$TARGET_PATH/src/cli/commands/itgo.ts"
echo "// @it-skill-patch: itgo_complete@v1.5.1" > "$ITGO_PATH"
cat "$PAYLOADS_DIR/refined_itgo_complete@v1.5.1.pl" >> "$ITGO_PATH"
echo "✅ Consolidated $ITGO_PATH with Shell Alignment"

echo "✅ CR-003 Refinement Applied."
