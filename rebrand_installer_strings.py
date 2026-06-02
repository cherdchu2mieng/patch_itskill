import sys
import os

target_path = sys.argv[1]
installer_file = os.path.join(target_path, "src", "cli", "installer.ts")

with open(installer_file, "r") as f:
    content = f.read()

# Replace mentions of legacy managed skills
content = content.replace("will REMOVE arra-managed skills", "will REMOVE it-skill-managed skills")

with open(installer_file, "w") as f:
    f.write(content)

print("✅ installer.ts strings rebranded.")
