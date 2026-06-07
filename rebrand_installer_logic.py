import sys
import os

target_path = sys.argv[1]
installer_path = os.path.join(target_path, "src", "cli", "installer.ts")

with open(installer_path, "r") as f:
    content = f.read()

# 1. Update Ownership Signature
content = content.replace("installer: arra-oracle-skills-cli", "installer: it-skill-cli")

# 2. Update UI Strings
content = content.replace("will REMOVE arra-managed skills", "will REMOVE it-skill-managed skills")

with open(installer_path, "w") as f:
    f.write(content)

print("✅ src/cli/installer.ts logic rebranded.")
