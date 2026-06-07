// @it-skill-patch: rebrand_readme@v1.0
# it-skill-cli 🛡️🌊

Enterprise-grade skill management and lifecycle governance for the `itinfosv` fleet.

## Install

```bash
# IT-Skill CLI — standard profile (default)
curl -fsSL https://raw.githubusercontent.com/itinfosv/it-skill-cli/main/install.sh | bash
```

# Full profile (all skills)
npx arra-oracle-skills@1.0.0 install -g -y -p full --agent claude-code

# Lab profile (full + experimental)
npx arra-oracle-skills@1.0.0 install -g -y -p lab --agent claude-code

# Specific skills only
npx arra-oracle-skills@1.0.0 install -g -y -s recap rrr trace --agent claude-code

# Other agents (skills + commands)
npx arra-oracle-skills@1.0.0 install -g -y --agent codex --with-commands
npx arra-oracle-skills@1.0.0 install -g -y --agent opencode --with-commands
npx arra-oracle-skills@1.0.0 install -g -y --agent cursor
npx arra-oracle-skills@1.0.0 install -g -y --agent gemini-cli --with-commands

# Multiple agents
npx arra-oracle-skills@1.0.0 install -g -y --agent claude-code codex opencode

# thClaws (federated agent — explicit opt-in)
bunx arra-oracle-skills@github:Soul-Brews-Studio/arra-oracle-skills-cli install -y -g --with-thclaws
# OR target thclaws directly:
bunx arra-oracle-skills@github:Soul-Brews-Studio/arra-oracle-skills-cli install -y -g -a thclaws
# Skills install to ~/.config/thclaws/skills/ when --with-thclaws is passed

# Install to ALL detected agents incl. federated (CI escape hatch)
bunx arra-oracle-skills@github:Soul-Brews-Studio/arra-oracle-skills-cli install -y -g --all-detected
```

> **#330 note**: as of v26.5.14+, federated agents (thClaws, OpenCode, GitHub Copilot, OpenClaw) are NOT auto-installed by default — they require explicit `-a <name>`, `--with-<name>`, or `--all-detected`. Host Anthropic agents (Claude Code, Codex) continue to auto-detect.

### Local project install

By default (no `-g` flag), skills install to the current project's `.claude/skills/` instead of `~/.claude/skills/`:

```bash
# Local install (current project)
npx arra-oracle-skills@1.0.0 install -a claude-code -s trace -y

# Same with explicit -l flag (symmetric to -g)
npx arra-oracle-skills@1.0.0 install -l -a claude-code -s trace -y
```

Use when:
- Testing skill changes before global rollout
- Different repos want different skill versions
- Committing project-specific skills to `.claude/skills/` in version control

The `L-SKLL` marker in the SKILL.md description distinguishes locally-installed skills from globally-installed ones (which get `G-SKLL`).

19 agents: Claude Code, Codex, OpenCode, Cursor, Gemini CLI, Amp, Kilo Code, Roo Code, Goose, Antigravity, GitHub Copilot, OpenClaw, Droid, Windsurf, Cline, Aider, Continue, Zed, thClaws

## Skills

<!-- skills:start -->

<details>
<summary>📚 <strong>4 skills installed</strong> — click to expand</summary>

| # | Skill | Type | Description |
|---|-------|------|-------------|
| - |  |  |  |
| - |  |  |  |
| 1 | **build-patch** | skill | '[core] G-SKLL | Secure, Cumulative |
| 2 | **build-rfc** | skill | Requirement gathering |
| 3 | **close-rfc** | skill | Automate the closure |
| 4 | **patch-forge** | skill | Generate Robust Patching Architecture (v3.0) |

</details>

<!-- skills:end -->

## Profiles

<!-- profiles:start -->

| Profile | Count | Skills |
|---------|-------|--------|
| **minimal** | 4 | all |
| **standard** | 4 | `build-patch`, `build-rfc`, `close-rfc`, `patch-forge` |
| **full** | 4 | all |
| **lab** | 4 | all |

Switch anytime: `/go standard`, `/go full`, `/go lab`

<!-- profiles:end -->

## CLI

```
install [options]       # install skills (default: standard)
uninstall [options]     # remove installed skills
select [options]        # interactive skill picker
list [options]          # show installed skills
profiles [name]         # list profiles
agents                  # list 18 supported agents
about                   # version + status
```

<!-- secret-skills:start -->

## Zombie Skills

0 skills excluded from all profiles. Install by name:

```bash
npx arra-oracle-skills install -g -y -s <name>
```

| Skill | What |
|-------|------|

<!-- secret-skills:end -->

## Team Agent Scripts

`/team-agents` includes zero-token bash scripts for tmux pane lifecycle:

```bash
team-ops panes [team]      # See agent panes (/proc cmdline extraction)
team-ops spawn <team> ...  # Create ephemeral /agent skills
team-ops archive <team> .. # Archive skills to /tmp on shutdown
team-ops sweep             # Kill idle panes (safe)
team-ops nuke              # Kill ALL non-lead panes
team-ops mailbox <cmd>     # Persistent agent memory
team-ops status            # Show everything
```

## Origin

[Nat Weerawan](https://github.com/nazt) — [Soul Brews Studio](https://github.com/Soul-Brews-Studio) · MIT
