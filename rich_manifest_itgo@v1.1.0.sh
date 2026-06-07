# Rich Manifest & itgo Sovereign Manager (CR-006)
echo "🚀 Starting CR-006 Execution (Rich Manifest & itgo Manager)..."

# 1. itgo Sovereign Manager Expansion
ITGO_PATH="$TARGET_PATH/src/cli/commands/itgo.ts"
echo "// @it-skill-patch: itgo_sovereign_manager@v1.1.0" > "$ITGO_PATH"
cat "$PAYLOADS_DIR/itgo_sovereign_manager@v1.1.0.pl" >> "$ITGO_PATH"
echo "✅ Expanded $ITGO_PATH to Sovereign Manager"

# 2. Rich Manifest Implementation (Installer Update)
# Replacing the entire simple manifest block with our rich one
apply_payload "src/cli/installer.ts" "rich_manifest_write@v1.1.0" "    const manifest = {" "rich_manifest_write@v1.1.0.pl" "replace_block" "await Bun.write(join(targetDir, '.it-skill.json'), JSON.stringify(manifest, null, 2));"

# 3. Fix Already Installed Check (Local vs Global) in install.ts
apply_payload "src/cli/commands/install.ts" "fix_already_installed_check@v1.1.0" "              const alreadyInstalled = detected.filter((a) => {" "fix_already_installed_check@v1.1.0.pl" "replace_block" "              });"

# 4. Entry Point Alignment (Remove legacy isDefault)
apply_payload "src/cli/index.ts" "itgo_default_command@v1.1.0" "registerInstall(program, VERSION);" "remove_install_default@v1.1.0.pl" "replace_line"
# Also need to modify registerInstall definition in commands/install.ts
apply_payload "src/cli/commands/install.ts" "remove_install_default_logic@v1.1.0" ".command('install', { isDefault: true })" "remove_install_default_logic@v1.1.0.pl" "replace_line"

echo "✅ CR-006 Logic Applied."
