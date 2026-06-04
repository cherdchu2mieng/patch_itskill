import sys
import os
import re

target_path = sys.argv[1]
install_sh_path = os.path.join(target_path, "install.sh")

if not os.path.exists(install_sh_path):
    print(f"⚠️ install.sh not found in {target_path}")
    sys.exit(0)

with open(install_sh_path, "r") as f:
    content = f.read()

# 1. Broad Branding for the whole file
content = content.replace('Oracle Skills', 'IT-Skill CLI')
content = content.replace('oracle-skills', 'it-skill')
content = content.replace('.oracle-skills', '.it-skill')
content = content.replace('Soul-Brews-Studio', 'cherdchu2mieng')
content = content.replace('ORACLE_SKILLS', 'IT_SKILL')
content = content.replace('ITINFOSV_VERSION', 'IT_SKILL_VERSION')

# 2. Rebrand Banner and Metadata
content = re.sub(r'echo "🔮 .*?"', 'echo "🔮 IT-Skill CLI Installer 🛡️🌊"', content)
content = content.replace('v1.0.0', 'v1.0.1')

# 3. ENTIRE BLOCK REPLACEMENT (Surgical Sweep)
# Replace everything from the install method header to the install entry point
start_marker = "# ── Install method: binary or bunx ─────────────────────────"
end_marker = "# ── Install ─────────────────────────────────────────────────"

start_idx = content.find(start_marker)
end_idx = content.find(end_marker)

if start_idx != -1 and end_idx != -1:
    clean_logic = r'''# ── Install method: binary or bunx ─────────────────────────

INSTALL_DIR="$HOME/.it-skill/bin"
PKG_SPEC="it-skill@github:itinfosv/it-skill-cli#master"

ensure_path() {
  mkdir -p "$INSTALL_DIR"
  local path_line="export PATH=\"$INSTALL_DIR:\$PATH\""
  for rc in "$HOME/.zshrc" "$HOME/.bashrc" "$HOME/.profile"; do
    if [ -f "$rc" ] && ! grep -q "it-skill/bin" "$rc"; then
      echo "" >> "$rc"
      echo "# IT-Skill CLI" >> "$rc"
      echo "$path_line" >> "$rc"
    fi
  done
  export PATH="$INSTALL_DIR:$PATH"
}

ensure_bun() {
  if ! command -v bun &> /dev/null; then
    echo "📦 Installing bun..."
    curl -fsSL https://bun.sh/install | bash
    export PATH="$HOME/.bun/bin:$PATH"
  else
    echo "✓ bun installed"
  fi
}

install_bunx_wrapper() {
  ensure_bun
  echo "📦 Installing it-skill Bash wrapper..."
  mkdir -p "$INSTALL_DIR"
  rm -f "$INSTALL_DIR/it-skill"
  cat > "$INSTALL_DIR/it-skill" << 'WRAPPER'
#!/bin/bash
# IT-Skill CLI — bunx wrapper (v1.0.1)
# Source: github.com/itinfosv/it-skill-cli
exec bunx --bun it-skill@github:itinfosv/it-skill-cli#master "$@"
WRAPPER
  chmod +x "$INSTALL_DIR/it-skill"
  echo "✅ Wrapper installed: $INSTALL_DIR/it-skill"
  ensure_path
}

'''
    content = content[:start_idx] + clean_logic + content[end_idx:]

# 4. Update the actual install sequence calls
content = content.replace('elif try_binary_install; then', 'elif false; then # Binary disabled per RFC')

with open(install_sh_path, "w") as f:
    f.write(content)

print("✅ install.sh fully re-engineered via clean-sweep replacement.")
