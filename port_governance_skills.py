import os
import sys
import shutil

target_repo_path = sys.argv[1]
skills_to_port = ["build-rfc", "build-patch", "close-rfc", "patch-forge"]
source_skills_root = "/home/a2it49072/.gemini/skills/"

for skill in skills_to_port:
    src_dir = os.path.join(source_skills_root, skill)
    dest_dir = os.path.join(target_repo_path, "src", "skills", skill)
    
    print(f"🚚 Porting {skill}...")
    
    # Remove existing if any (to be clean)
    if os.path.exists(dest_dir):
        shutil.rmtree(dest_dir)
    
    shutil.copytree(src_dir, dest_dir)
    
    # Update SKILL.md metadata
    skill_md_path = os.path.join(dest_dir, "SKILL.md")
    if os.path.exists(skill_md_path):
        with open(skill_md_path, "r") as f:
            content = f.read()
        
        # 1. Update installer signature
        if "installer:" in content:
             content = content.replace("installer: arra-oracle-skills-cli", "installer: it-skill-cli")
             # Catch-all if it was different
             import re
             content = re.sub(r'installer: .*', 'installer: it-skill-cli', content)
        else:
             # Prepend if missing? Arra expects it in a specific block or frontmatter.
             # Let's assume it has a header.
             pass

        # 2. Add [itinfosv] tag to first Heading or description
        if "[itinfosv]" not in content:
             content = content.replace("# ", "# [itinfosv] ", 1)
        
        with open(skill_md_path, "w") as f:
            f.write(content)
        print(f"  ✨ Updated {skill}/SKILL.md metadata.")

print("✅ Governance skills ported and initialized.")
