# Unified Scanner & Manager Identification (CR-002)
echo "🚀 Starting CR-002 Execution (Unified Scanner)..."

# 1. Update Types
apply_payload "src/cli/types.ts" "manager_type_extension@v1.2.0" "export interface Skill {" "manager_type_extension@v1.2.0.pl" "replace_block" "}"

# 2. Unified Discovery (VFS)
apply_payload "src/cli/skill-source.ts" "unified_vfs_discovery@v1.2.0" "const descMatch = skillMd.match(/description:\s*(.+)/);" "unified_vfs_discovery@v1.2.0.pl" "replace_block" "          ...(hiddenMatch ? { hidden: true } : {}),"

# 3. Unified Discovery (FS)
# Note: Indentation is 0 for this line due to previous patch behavior
apply_payload "src/cli/skill-source.ts" "unified_fs_discovery@v1.2.0" "const content = await Bun.file(skillMdPath).text();" "unified_fs_discovery@v1.2.0.pl" "replace_block" "        path: dir,"

echo "✅ CR-002 Logic Applied."
