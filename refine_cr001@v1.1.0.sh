# CR-001 Refinement: Centralized Version Scanning & Rich Types
echo "🚀 Starting CR-001 Refinement Execution..."

# 1. Update Skill Interface
apply_payload "src/cli/types.ts" "refined_skill_type@v1.1.0" "export interface Skill {" "refined_skill_type@v1.1.0.pl" "replace_block" "}"

# 2. Refine discoverSkills (VFS Part)
apply_payload "src/cli/skill-source.ts" "refined_vfs_discovery@v1.1.0" "        const descMatch = skillMd.match(/description:\s*(.+)/);" "refined_vfs_discovery@v1.1.0.pl" "replace_block" "          ...(hiddenMatch ? { hidden: true } : {}),"

# 3. Refine discoverSkills (FS Part)
apply_payload "src/cli/skill-source.ts" "refined_fs_discovery@v1.1.0" "      const content = await Bun.file(skillMdPath).text();" "refined_fs_discovery@v1.1.0.pl" "replace_block" "        path: dir,"

# 4. Refine itgo Dashboard
ITGO_PATH="$TARGET_PATH/src/cli/commands/itgo.ts"
# Note: we use replace_block to clean up the dashboard logic
apply_payload "src/cli/commands/itgo.ts" "refined_itgo_dashboard@v1.1.0" "      // ── Unified Dashboard Mode ───────────────────────────────────────────" "refined_itgo_dashboard@v1.1.0.pl" "replace_block" "      console.log('Total: ' + totalSkills + ' skills across ' + targetAgents.length + ' agent(s) | it-skill-cli v' + version + '\n');"

echo "✅ CR-001 Refinement Applied."
