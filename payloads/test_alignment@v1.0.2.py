import os
import re

test_dir = "__tests__"

files_to_delete = [
    "dig-skill.test.ts",
    "calver.test.ts"
]

dirs_to_delete = [
    "rrr-evals",
    "learn-evals"
]

replacements = [
    (r"arra-oracle-skills-cli", "it-skill-cli"),
    (r"arra-oracle-skills", "it-skill"),
    (r"\.arra-oracle-skills\.json", ".it-skill.json"),
    (r"installer: arra-oracle-skills-cli", "installer: it-skill-cli"),
    (r"Nat Weerawan's brain", "IT TEAM Standard"),
    (r"Soul Brews Studio", "itinfosv"),
    # Skill name replacements in assertions
    (r"'recap'", "'build-patch'"),
    (r'"recap"', '"build-patch"'),
    (r"'trace'", "'build-rfc'"),
    (r'"trace"', '"build-rfc"'),
    (r"'retrospective'", "'close-rfc'"),
    (r'"retrospective"', '"close-rfc"'),
    (r"'dig'", "'patch-forge'"),
    (r'"dig"', '"patch-forge"'),
    # Temp dir prefix
    (r"arra-oracle-thclaws", "it-skill-thclaws"),
    (r"arra-oracle-skills-align", "it-skill-align"),
    (r"arra-install-cmds", "it-install-cmds"),
    (r"arra-uninstall", "it-uninstall"),
]

for filename in files_to_delete:
    path = os.path.join(test_dir, filename)
    if os.path.exists(path):
        os.remove(path)
        print(f"Deleted {path}")

import shutil
for dirname in dirs_to_delete:
    path = os.path.join(test_dir, dirname)
    if os.path.exists(path):
        shutil.rmtree(path)
        print(f"Deleted directory {path}")

for root, dirs, files in os.walk(test_dir):
    for file in files:
        if file.endswith(".ts"):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            new_content = content
            for pattern, replacement in replacements:
                new_content = re.sub(pattern, replacement, new_content)
            
            if new_content != content:
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f"Updated {path}")
