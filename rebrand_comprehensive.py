import os
import sys

target_path = sys.argv[1]

replacements = [
    ("Arra Oracle Skills", "IT-Skill CLI Dashboard"),
    ("arra-oracle-skills-cli", "it-skill-cli"),
    ("arra-oracle-skills", "it-skill"),
    (".arra-oracle-skills.json", ".it-skill.json"),
    ("🔮 Oracle Skills Installer", "🛡️ IT-Skill Installer"),
    ("🔮 Oracle Skills", "🛡️ IT-Skill"),
    ("✨ Oracle skills installed!", "✅ IT-Skill suite installed!"),
    ("Oracle Skills v", "IT-Skill CLI v"),
    ("arra-managed skills", "it-skill-managed skills"),
    ("Oracle awakening ritual", "IT Team Infrastructure initialization"),
]

files_to_patch = [
    "src/cli/installer.ts",
    "src/cli/commands/install.ts",
    "src/cli/commands/about.ts",
    "src/cli/commands/init.ts",
    "src/cli/index.ts",
    "src/cli/agents.ts",
    "__tests__/e2e-install.test.ts"
]

for rel_path in files_to_patch:
    full_path = os.path.join(target_path, rel_path)
    if not os.path.exists(full_path):
        print(f"  ⚠️ Skipping: {rel_path} not found")
        continue
    
    with open(full_path, "r") as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements:
        new_content = new_content.replace(old, new)
    
    # Specific logic fixes
    if rel_path == "src/cli/commands/install.ts":
        # Default profile minimal -> standard
        new_content = new_content.replace("', 'minimal')", "', 'standard')")
        # Banner fix if replacements missed it
        new_content = new_content.replace("🔮 Oracle Skills", "🛡️ IT-Skill")

    if rel_path == "src/cli/index.ts":
        new_content = new_content.replace(".name('arra-oracle-skills')", ".name('it-skill')")
    
    if new_content != content:
        with open(full_path, "w") as f:
            f.write(new_content)
        print(f"  ✅ Rebranded {rel_path}")
    else:
        print(f"  ℹ️ No changes needed for {rel_path}")

print("✅ Comprehensive rebranding complete.")
