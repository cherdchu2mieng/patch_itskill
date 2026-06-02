import os
import sys
import shutil

target_repo_path = sys.argv[1]
skills_to_keep = [
    "build-rfc", "build-patch", "close-rfc", "patch-forge"
]
skills_dir = os.path.join(target_repo_path, "src", "skills")

print("🧹 Cleaning up src/skills/ (Governance Only Mode)...")

for item in os.listdir(skills_dir):
    item_path = os.path.join(skills_dir, item)
    if os.path.isdir(item_path) and item not in skills_to_keep:
        print(f"  🗑️ Removing legacy skill: {item}...")
        shutil.rmtree(item_path)

# Also clear .archive if present
archive_dir = os.path.join(skills_dir, ".archive")
if os.path.exists(archive_dir):
    print("  🗑️ Removing .archive directory...")
    shutil.rmtree(archive_dir)

print("✅ Strict cleanup complete.")
