import sys
import os

target_path = sys.argv[1]
install_sh_path = os.path.join(target_path, "install.sh")

with open(install_sh_path, "r") as f:
    content = f.read()

# 1. Update Version Detection Repo URL
content = content.replace(
    "https://api.github.com/repos/Soul-Brews-Studio/oracle-skills-cli/releases/latest",
    "https://api.github.com/repos/itinfosv/it-skill-cli/releases/latest"
)

# 2. Update Environment Variable names from ORACLE_SKILLS to IT_SKILL
content = content.replace("ORACLE_SKILLS_VERSION", "IT_SKILL_VERSION")
content = content.replace("ORACLE_SKILLS_USE_BUNX", "IT_SKILL_USE_BUNX")

with open(install_sh_path, "w") as f:
    f.write(content)

print("✅ install.sh fully rebranded.")
