import sys
import os

target_path = sys.argv[1]
test_file_path = os.path.join(target_path, "__tests__", "e2e-install.test.ts")

if not os.path.exists(test_file_path):
    print(f"  ⚠️ Skipping: {test_file_path} not found")
    sys.exit(0)

with open(test_file_path, "r") as f:
    content = f.read()

# 1. Update Installer Marker
content = content.replace('expect(content).toContain("installer: arra-oracle-skills-cli");', 'expect(content).toContain("installer: it-skill-cli");')

with open(test_file_path, "w") as f:
    f.write(content)

print("✅ __tests__/e2e-install.test.ts rebranded for it-skill-cli.")
