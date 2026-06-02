// ── Version detection ───────────────────────────────────────

if [ -z "$IT_SKILL_VERSION" ]; then
  echo "🔍 Fetching latest version..."
  IT_SKILL_VERSION=$(curl -s https://api.github.com/repos/itinfosv/it-skill-cli/releases/latest 2>/dev/null | grep '"tag_name"' | cut -d'"' -f4)
fi

if [ -z "$IT_SKILL_VERSION" ]; then
  echo "⚠️  Could not detect latest version, using v1.0.0"
  IT_SKILL_VERSION="v1.0.0"
fi

echo "📦 Version: $IT_SKILL_VERSION"
