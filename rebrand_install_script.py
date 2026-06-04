import sys
import os
import re

target_path = sys.argv[1]
install_sh_path = os.path.join(target_path, "install.sh")

with open(install_sh_path, "r") as f:
    content = f.read()

# 1. Update Version Detection and Paths
content = content.replace(
    'ITINFOSV_VERSION=$(curl -s https://api.github.com/repos/cherdchu2mieng/itinfosv-skill-cli/releases/latest 2>/dev/null | grep \'"tag_name"\' | cut -d\'"\' -f4)',
    'ITINFOSV_VERSION="v1.0.1" # Locked for Alignment Phase'
)
content = content.replace(
    'INSTALL_DIR="$HOME/.itinfosv-skills/bin"',
    'INSTALL_DIR="$HOME/.it-skill/bin"'
)
content = content.replace(
    'BINARY_NAME="itinfosv-skills-${PLATFORM}"',
    'BINARY_NAME="it-skill"'
)
content = content.replace(
    'PKG_SPEC="itinfosv-skills@github:cherdchu2mieng/itinfosv-skill-cli#main"',
    'PKG_SPEC="it-skill@github:cherdchu2mieng/itinfosv-skill-cli#main"'
)

# 2. Re-engineer Wrapper Logic to be clean and simple
wrapper_logic = r'''install_bunx_wrapper() {
  ensure_bun

  echo "📦 Installing it-skill Bash wrapper..."
  mkdir -p "$INSTALL_DIR"
  rm -f "$INSTALL_DIR/it-skill" # Force cleanup of 98MB binary

  # Create a wrapper script that delegates to bunx
  cat > "$INSTALL_DIR/it-skill" << WRAPPER
#!/bin/bash
# IT-Skill CLI — bunx wrapper (v1.0.1)
# Source: github.com/cherdchu2mieng/itinfosv-skill-cli
exec bunx --bun ${PKG_SPEC} "\$@"
WRAPPER
  chmod +x "$INSTALL_DIR/it-skill"
  echo "✅ Wrapper installed: $INSTALL_DIR/it-skill"
  ensure_path
}'''

# Replace the entire install_bunx_wrapper function
content = re.sub(r'install_bunx_wrapper\(\) \{.*?\}', wrapper_logic, content, flags=re.DOTALL)

# 3. Disable Binary install to enforce wrapper
content = content.replace("elif try_binary_install; then", "elif false; then # Binary disabled per RFC")

with open(install_sh_path, "w") as f:
    f.write(content)

print("✅ install.sh fully rebranded.")
