# Advanced Governance Logic (CR-004)
echo "🚀 Starting CR-004 Execution (Advanced Governance)..."

# 1. Update Health Helpers for Robustness (Clean Sweep in 1.5.0 already covers this)
# Logic: We don't need a partial patch for fs-utils anymore as it's fully refactored in CR-003 refine.
echo "✅ fs-utils robust health already integrated in master payload."

# 2. Automated Backups in installer.ts
apply_payload "src/cli/installer.ts" "automated_backups@v1.4.0" "    const sourceSkillNames = allSkills.map((s) => s.name);" "automated_backups@v1.4.0.pl" "replace_block" "// Copy skill folder"

echo "✅ CR-004 Logic Applied."
