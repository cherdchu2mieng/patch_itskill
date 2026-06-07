# Genesis Phase Closure (CR-005 + CR-004 Refinement)
echo "🚀 Starting Genesis Closure (v1.6.2)..."

# 1. Update itgo Master Command (v1.6.2)
ITGO_PATH="$TARGET_PATH/src/cli/commands/itgo.ts"
echo "// @it-skill-patch: itgo_complete@v1.6.2" > "$ITGO_PATH"
cat "$PAYLOADS_DIR/refined_itgo_complete@v1.6.2.pl" >> "$ITGO_PATH"
echo "✅ Consolidated $ITGO_PATH (Gold Master v1.6.2)"

echo "✅ Genesis Closure Logic Applied."
