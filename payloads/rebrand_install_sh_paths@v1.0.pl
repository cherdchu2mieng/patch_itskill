INSTALL_DIR="$HOME/.it-skill/bin"
BINARY_NAME="it-skill"
BINARY_URL="https://github.com/cherdchu2mieng/itinfosv-skill-cli/releases/download/${ITINFOSV_VERSION}/${BINARY_NAME}"
PKG_SPEC="it-skill@github:cherdchu2mieng/itinfosv-skill-cli#main"

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
