import os
import re
import sys
import shutil

def get_psi_root():
    try:
        import subprocess
        root = subprocess.check_output(['git', 'rev-parse', '--show-toplevel'], text=True).strip()
        if os.path.exists(os.path.join(root, 'ψ')):
            return os.path.join(root, 'ψ')
    except:
        pass
    if os.path.exists('ψ'):
        return os.path.abspath('ψ')
    return None

def close_rfc(project, rfc_id):
    psi = get_psi_root()
    if not psi:
        print("❌ Error: Could not find ψ/ directory.")
        sys.exit(1)

    rfc_dir = os.path.join(psi, 'writing', project, rfc_id)
    if not os.path.exists(rfc_dir):
        print(f"❌ Error: RFC directory not found: {rfc_dir}")
        sys.exit(1)

    master_file = os.path.join(rfc_dir, f"{rfc_id}_master.md")
    if not os.path.exists(master_file):
        print(f"❌ Error: Master RFC file not found: {master_file}")
        sys.exit(1)

    # 1. Validate CRs
    cr_files = [f for f in os.listdir(rfc_dir) if f.startswith('CR-') and f.endswith('_detail.md')]
    total_duration = 0
    total_tokens = 0
    
    print(f"🔍 Validating {len(cr_files)} Change Requests...")
    
    for cr_file in cr_files:
        path = os.path.join(rfc_dir, cr_file)
        content = open(path).read()
        
        if 'Approved (Sacred Status granted)' not in content:
            print(f"❌ Validation Failed: {cr_file} is not approved.")
            sys.exit(1)
        
        if '## 5. Post-Implementation Report' not in content:
            print(f"❌ Validation Failed: {cr_file} missing Implementation Report.")
            sys.exit(1)
            
        # Extract metrics
        dur_match = re.search(r'- \*\*Actual Duration\*\*: ~?(\d+)', content)
        if dur_match: total_duration += int(dur_match.group(1))
        
        tok_match = re.search(r'- \*\*Actual Token Cost\*\*: ~?(\d+)[kK]?', content)
        if tok_match: 
            val = int(tok_match.group(1))
            if 'k' in tok_match.group(0).lower(): val *= 1000
            total_tokens += val

    print(f"✅ All CRs validated. Total Duration: {total_duration}m, Total Tokens: {total_tokens}")

    # 2. Update Master Status and Metrics
    master_content = open(master_file).read()
    master_content = re.sub(r'- \*\*Status\*\*: \w+', '- **Status**: Closed', master_content)
    
    master_content = re.sub(r'- \*\*Total Duration\*\*: TBD', f'- **Total Duration**: {total_duration} minutes', master_content)
    master_content = re.sub(r'- \*\*Total Token Cost\*\*: TBD', f'- **Total Token Cost**: {total_tokens // 1000}k', master_content)
    
    # 3. Find Patch Workspace Path
    workspace_match = re.search(r'- \*\*Patch Workspace Repo\*\*: (.*)', master_content)
    workspace_path = None
    if workspace_match:
        workspace_path = workspace_match.group(1).strip()
    else:
        # Fallback or ask
        print("⚠️ Warning: Patch Workspace Repo not found in Master RFC.")

    with open(master_file, 'w') as f:
        f.write(master_content)
    
    print(f"📝 Master RFC updated: {master_file}")
    
    if workspace_path and os.path.exists(workspace_path):
        target_doc_dir = os.path.join(workspace_path, 'docs', 'requirements', rfc_id)
        print(f"📂 Syncing to Workspace: {target_doc_dir}...")
        if os.path.exists(target_doc_dir):
            shutil.rmtree(target_doc_dir)
        shutil.copytree(rfc_dir, target_doc_dir)
        print("✅ Sync complete.")
    else:
        print("⚠️ Sync skipped: Patch Workspace path invalid or missing.")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 close_rfc.py <project> <rfc_id>")
        sys.exit(1)
    close_rfc(sys.argv[1], sys.argv[2])
