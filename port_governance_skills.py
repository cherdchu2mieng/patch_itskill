import os
import sys
import shutil
import re

target_repo_path = sys.argv[1]
skills_to_port = ["build-rfc", "build-patch", "close-rfc", "patch-forge"]
source_skills_root = "/home/a2it49072/.gemini/skills/"

for skill in skills_to_port:
    src_dir = os.path.join(source_skills_root, skill)
    dest_dir = os.path.join(target_repo_path, "src", "skills", skill)
    
    print(f"🚚 Porting {skill}...")
    if os.path.exists(dest_dir):
        shutil.rmtree(dest_dir)
    shutil.copytree(src_dir, dest_dir)
    
    skill_md_path = os.path.join(dest_dir, "SKILL.md")
    if os.path.exists(skill_md_path):
        with open(skill_md_path, "r") as f:
            content = f.read()
        
        # 1. Force installer signature
        if "installer:" in content:
             content = re.sub(r'installer: .*', 'installer: it-skill-cli', content)
        else:
             # Prepend to frontmatter if exists, or just to top
             if content.startswith("---"):
                 content = content.replace("---\n", "---\ninstaller: it-skill-cli\n", 1)
             else:
                 content = "---\ninstaller: it-skill-cli\n---\n\n" + content

        # 2. Add [itinfosv] tag
        if "[itinfosv]" not in content:
             content = content.replace("# ", "# [itinfosv] ", 1)
        
        with open(skill_md_path, "w") as f:
            f.write(content)
        print(f"  ✨ Updated {skill}/SKILL.md metadata.")

print("✅ Governance skills ported and initialized.")
