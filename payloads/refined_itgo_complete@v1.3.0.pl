import type { Command } from 'commander';
import { agents, detectInstalledAgents } from '../agents.js';
import { installSkills, refreshSkill } from '../installer.js';
import { profiles } from '../../profiles.js';
import { which, getBinVersion } from '../fs-utils.js';

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

      // ── Unified Dashboard Mode ───────────────────────────────────────────
      let targetAgents: string[] = options.agent || detectInstalledAgents();
      if (targetAgents.length === 0) {
        console.log('\nNo agents detected. Use --agent to specify.\n');
        return;
      }

      console.log('\n🛡️  IT TEAM Sovereign Fleet Dashboard\n');

      // ── Fleet Environment Block ──────────────────────────────────────────
      console.log('  📡 Fleet Environment');
      const bins = [
        { name: 'it-skill', label: 'IT-SKILL CLI' },
        { name: 'arra-oracle-skills', label: 'Legacy Arra' }
      ];
      
      console.log('  ' + '-'.repeat(70));
      for (const bin of bins) {
        const path = await which(bin.name);
        const v = path ? await getBinVersion(bin.name) : null;
        const status = path ? '✅ Ready' : '❌ Not in PATH';
        const displayPath = path ? `(${path})` : '';
        console.log(`  ${bin.label.padEnd(20)} ${status.padEnd(15)} ${v || '—'} ${displayPath}`);
      }
      console.log('  ' + '-'.repeat(70));
      console.log('');

      let totalSkills = 0;

      for (const agentName of targetAgents) {
        const agent = agents[agentName as keyof typeof agents];
        if (!agent) continue;

        const skillsDir = options.global ? agent.globalSkillsDir : join(process.cwd(), agent.skillsDir);
        const scope = options.global ? '(global)' : '(local)';

        if (!existsSync(skillsDir)) {
          console.log('  ' + agent.displayName + ' ' + scope + ': (no skills directory)');
          continue;
        }

        const manifestPath = join(skillsDir, '.it-skill.json');
        const legacyManifestPath = join(skillsDir, '.oracle-skills.json');
        const skillMap = new Map<string, any>();

        if (existsSync(legacyManifestPath)) {
          try {
            const data = JSON.parse(readFileSync(legacyManifestPath, 'utf-8'));
            if (Array.isArray(data.skills)) {
              data.skills.forEach((s: any) => {
                const name = typeof s === 'string' ? s : s.name;
                skillMap.set(name, { name, manager: '[A]', version: 'v0.0.0', status: 'Active' });
              });
            }
          } catch {}
        }

        if (existsSync(manifestPath)) {
          try {
            const data = JSON.parse(readFileSync(manifestPath, 'utf-8'));
            if (Array.isArray(data.skills)) {
              data.skills.forEach((s: any) => {
                const name = typeof s === 'string' ? s : s.name;
                const version = typeof s === 'string' ? 'v0.0.0' : s.version;
                skillMap.set(name, { name, manager: '[IT]', version, status: 'Active' });
              });
            }
          } catch {}
        }

        const skillData = Array.from(skillMap.values());

        // Last-chance scan for accurate versions
        for (const s of skillData) {
          if (s.version === 'v0.0.0') {
            const skillMdPath = join(skillsDir, s.name, 'SKILL.md');
            if (existsSync(skillMdPath)) {
              try {
                const content = readFileSync(skillMdPath, 'utf-8');
                const hMatch = content.match(/^# .+\(v(\d+\.\d+)\)\s*$/m);
                if (hMatch) {
                  s.version = 'v' + hMatch[1];
                } else {
                  const dMatch = content.match(/description:.*v(\d+(?:\.\d+)+)/);
                  if (dMatch) {
                    s.version = 'v' + dMatch[1];
                  } else {
                    const vMatch = content.match(/v(\d+(?:\.\d+)+)/);
                    if (vMatch) s.version = 'v' + vMatch[1];
                  }
                }
              } catch {}
            }
          }
        }

        if (skillData.length === 0) {
          console.log('  ' + agent.displayName + ' ' + scope + ': (empty)');
        } else {
          console.log('  ' + agent.displayName + ' ' + scope + ': ' + skillData.length + ' skills');
          console.log('  ' + '-'.repeat(70));
          console.log('  ' + '#'.padEnd(4) + 'Skill'.padEnd(30) + 'Manager'.padEnd(15) + 'Version'.padEnd(10) + 'Status');
          console.log('  ' + '-'.repeat(70));

          skillData.sort((a, b) => {
             if (a.manager === '[IT]' && b.manager !== '[IT]') return -1;
             if (a.manager !== '[IT]' && b.manager === '[IT]') return 1;
             return a.name.localeCompare(b.name);
          });

          let i = 1;
          for (const s of skillData) {
            console.log('  ' + String(i).padEnd(4) + s.name.padEnd(30) + s.manager.padEnd(15) + s.version.padEnd(10) + s.status);
            i++;
          }
          console.log('  ' + '-'.repeat(70));
          totalSkills += skillData.length;
        }
        console.log('');
      }

      console.log('Total: ' + totalSkills + ' skills across ' + targetAgents.length + ' agent(s) | it-skill-cli v' + version + '\n');
    });
}