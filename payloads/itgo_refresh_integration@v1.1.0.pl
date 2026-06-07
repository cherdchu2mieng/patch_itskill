import type { Command } from 'commander';
import { agents, detectInstalledAgents } from '../agents.js';
import { installSkills, refreshSkill } from '../installer.js';
import { profiles } from '../../profiles.js';

export function registerItgo(program: Command, version: string) {
  program
    .command('itgo [actionOrProfile] [skillName]')
    .description('🛡️ IT TEAM Sovereign Fleet Manager')
    .option('-g, --global', 'Show/Install global skills')
    .option('-a, --agent <agents...>', 'Target specific agents')
    .option('-y, --yes', 'Skip confirmation prompts')
    .action(async (actionOrProfile, skillName, options) => {
      const { readdirSync, existsSync, readFileSync } = await import('fs');
      const { join } = await import('path');

      // ── Refresh Mode ───────────────────────────────────────────────────
      if (actionOrProfile === 'refresh') {
        if (!skillName) {
            console.log('\n❌ Error: Please specify a skill name to refresh.');
            console.log('Usage: it-skill itgo refresh <skill-name>\n');
            return;
        }
        let targetAgents: string[] = options.agent || detectInstalledAgents();
        await refreshSkill(skillName, targetAgents, {
            global: options.global,
            yes: options.yes,
            shellMode: 'auto'
        });
        return;
      }

      // ── Sovereign Installation Mode ───────────────────────────────────────
      if (actionOrProfile && profiles[actionOrProfile as keyof typeof profiles]) {
        let targetAgents: string[] = options.agent || detectInstalledAgents();
        if (targetAgents.length === 0) {
            console.log('\nNo agents detected. Use --agent to specify.\n');
            return;
        }

        await installSkills(targetAgents, {
          global: options.global,
          profile: actionOrProfile,
          profileExplicit: true,
          yes: options.yes,
          shellMode: 'auto',
        });
        return;
      } else if (actionOrProfile && actionOrProfile !== 'refresh') {
          console.log('\n❌ Unknown profile or action: ' + actionOrProfile);
          console.log('Available profiles: ' + Object.keys(profiles).join(', '));
          console.log('Available actions: refresh\n');
          return;
      }