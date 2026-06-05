#!/bin/bash
# IT-Skill CLI Installer — specialized distribution for IT BOARD Team
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/itinfosv/it-skill-cli/master/install.sh | bash

set -e

echo "🔮 IT-Skill CLI Installer 🛡️🌊"
echo ""

# ── Platform detection ──────────────────────────────────────

detect_platform() {
  local os arch
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  arch=$(uname -m)

  case "$arch" in
    x86_64) arch="x64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) return 1 ;;
  esac

  case "$os" in
    darwin|linux) echo "${os}-${arch}" ;;
    *) return 1 ;;
  esac
}

PLATFORM=$(detect_platform)

# ── Dependency check ────────────────────────────────────────

if ! command -v node &> /dev/null; then
  echo "❌ Node.js is required. Please install it first."
  exit 1
fi

if ! command -v git &> /dev/null; then
  echo "❌ git is required. Please install it first."
  exit 1
fi

echo "✓ Node.js installed"
echo "✓ git installed"

# ── Install method: binary or bunx ─────────────────────────

INSTALL_DIR="$HOME/.it-skill/bin"
PKG_SPEC="it-skill@git+https://github.com/itinfosv/it-skill-cli.git#master"

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
# IT-Skill CLI — bunx wrapper (v1.0.2)
# Source: github.com/itinfosv/it-skill-cli
exec bunx --bun it-skill@git+https://github.com/itinfosv/it-skill-cli.git#master "$@"
WRAPPER
  chmod +x "$INSTALL_DIR/it-skill"
  echo "✅ Wrapper installed: $INSTALL_DIR/it-skill"
  ensure_path
}

# ── Install ─────────────────────────────────────────────────

INSTALL_MODE="bunx"
install_bunx_wrapper

echo ""
echo "✨ Done! (bunx wrapper installed)"
echo ""
echo "Installed: IT BOARD Governance toolkit"
echo ""
echo "Next steps:"
echo ""
echo "  1. Restart your AI agent (Claude Code, Gemini CLI, etc.)"
echo "  2. Run: /skills reload"
echo "  3. Try: /skills list"
echo ""
echo "Run 'it-skill --version' to verify."
echo "Visit: https://github.com/itinfosv/it-skill-cli"
