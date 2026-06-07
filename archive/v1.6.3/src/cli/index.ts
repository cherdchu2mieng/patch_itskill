#!/usr/bin/env bun
// @it-skill-patch: itgo_registration_import@v1.1.0 itgo_registration_call@v1.1.0 itgo_default_command@v1.1.0

// Build-time define for compiled binaries
declare const IS_COMPILED: boolean;

// Bun runtime check - skip in compiled mode (binary embeds Bun)
try {
  if (!(typeof IS_COMPILED !== 'undefined' && IS_COMPILED) && typeof Bun === 'undefined') {
    console.error(`
❌ it-skill requires Bun runtime

You're running with Node.js, but this CLI uses Bun-specific features.

To fix:
  1. Install Bun: curl -fsSL https://bun.sh/install | bash
  2. Run with: bunx it-skill install -g -y

Or install the compiled binary (no Bun needed):
  curl -fsSL https://raw.githubusercontent.com/Soul-Brews-Studio/it-skill-cli/main/install.sh | bash

More info: https://bun.sh
`);
    process.exit(1);
  }
} catch {
  // IS_COMPILED not defined — running in dev mode, check passed
}

import { program } from 'commander';
import pkg from '../../package.json' with { type: 'json' };

import { registerInstall } from './commands/install.js';
import { registerInit } from './commands/init.js';
import { registerUninstall } from './commands/uninstall.js';
import { registerSelect } from './commands/select.js';
import { registerAgents } from './commands/agents.js';
import { registerList } from './commands/list.js';
import { registerProfiles } from './commands/profiles.js';
import { registerItgo } from './commands/itgo.js';
import { registerAbout } from './commands/about.js';
import { registerAwaken } from './commands/awaken.js';
import { registerXray } from './commands/xray.js';
import { registerShortcut } from './commands/shortcut.js';
import { registerContacts } from './commands/contacts.js';

const VERSION = pkg.version;

program
  .name('it-skill')
  .description('Install Oracle skills to Claude Code, OpenCode, Cursor, and 11+ AI coding agents')
  .version(VERSION);

// Register all commands (agents first — most useful for discovery)
registerAgents(program);
registerInstall(program, VERSION);
registerInit(program, VERSION);
registerUninstall(program, VERSION);
registerSelect(program, VERSION);
registerList(program);
registerProfiles(program);
registerItgo(program, VERSION);
registerAbout(program, VERSION);
registerAwaken(program, VERSION);
registerXray(program, VERSION);
registerShortcut(program);
registerContacts(program);

program.parse();
