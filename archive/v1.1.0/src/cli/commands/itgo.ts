// @it-skill-patch: itgo_sovereign_manager@v1.1.0
import type { Command } from 'commander';
import { agents, detectInstalledAgents } from '../agents.js';
import { installSkills } from '../installer.js';
import { profiles } from '../../profiles.js';

export function registerItgo(program: Command, version: string) {
  program
    .command('itgo [profile]')
    .description('🛡️ IT TEAM Sovereign Fleet Manager')
    .option('-g, --global', 'Show/Install global skills')
    .option('-a, --agent <agents...>', 'Target specific agents')
    .option('-y, --yes', 'Skip confirmation prompts')
    .action(async (profile, options) => {
      const { readdirSync, existsSync, readFileSync } = await import('fs');
      const { join } = await import('path');

      // ── Sovereign Installation Mode ───────────────────────────────────────
      if (profile) {
        if (!profiles[profile as keyof typeof profiles]) {
          console.log(`\n❌ Unknown profile: ${profile}`);
          console.log(`Available profiles: ${Object.keys(profiles).join(', ')}\n`);
          return;
        }

        let targetAgents: string[] = options.agent || detectInstalledAgents();
        if (targetAgents.length === 0) {
            console.log('\nNo agents detected. Use --agent to specify.\n');
            return;
        }

        await installSkills(targetAgents, {
          global: options.global,
          profile: profile,
          profileExplicit: true,
          yes: options.yes,
          shellMode: 'auto',
        });
        return;
      }

      // ── Unified Dashboard Mode ───────────────────────────────────────────
      let targetAgents: string[] = options.agent || [];

      if (targetAgents.length === 0) {
        targetAgents = detectInstalledAgents();
      }

      if (targetAgents.length === 0) {
        console.log('\nNo agents detected. Use --agent to specify.\n');
        return;
      }

      console.log('\n🛡️  IT TEAM Sovereign Fleet Dashboard\n');

      let totalSkills = 0;

      for (const agentName of targetAgents) {
        const agent = agents[agentName as keyof typeof agents];
        if (!agent) continue;

        const skillsDir = options.global
          ? agent.globalSkillsDir
          : join(process.cwd(), agent.skillsDir);

        const scope = options.global ? '(global)' : '(local)';

        if (!existsSync(skillsDir)) {
          console.log('  ' + agent.displayName + ' ' + scope + ': (no skills directory)');
          continue;
        }

        // Load Manifests
        const manifestPath = join(skillsDir, '.it-skill.json');
        const legacyManifestPath = join(skillsDir, '.oracle-skills.json');
        
        let itSkills: any[] = [];
        let arraSkills: any[] = [];

        if (existsSync(manifestPath)) {
          try {
            const data = JSON.parse(readFileSync(manifestPath, 'utf-8'));
            if (Array.isArray(data.skills)) {
               itSkills = data.skills.map((s: any) => ({
                 name: typeof s === 'string' ? s : s.name,
                 version: typeof s === 'string' ? 'v0.0.0' : s.version,
                 manager: '[IT]',
                 status: 'Active'
               }));
            }
          } catch {}
        }

        if (existsSync(legacyManifestPath)) {
          try {
            const data = JSON.parse(readFileSync(legacyManifestPath, 'utf-8'));
            if (Array.isArray(data.skills)) {
               arraSkills = data.skills.map((s: any) => ({
                 name: typeof s === 'string' ? s : s.name,
                 version: typeof s === 'string' ? 'v0.0.0' : s.version,
                 manager: '[A]',
                 status: 'Active'
               }));
            }
          } catch {}
        }

        // Merge and deduplicate (Prioritize IT)
        const skillMap = new Map<string, any>();
        arraSkills.forEach(s => skillMap.set(s.name, s));
        itSkills.forEach(s => skillMap.set(s.name, s));

        const skillData = Array.from(skillMap.values());

        if (skillData.length === 0) {
          console.log('  ' + agent.displayName + ' ' + scope + ': (empty)');
        } else {
          console.log('  ' + agent.displayName + ' ' + scope + ': ' + skillData.length + ' skills');
          
          console.log('  ' + '-'.repeat(70));
          console.log('  ' + '#'.padEnd(4) + 'Skill'.padEnd(30) + 'Manager'.padEnd(15) + 'Version'.padEnd(10) + 'Status');
          console.log('  ' + '-'.repeat(70));

          // Last-chance version extraction for v0.0.0 skills (Legacy)
          for (const s of skillData) {
            if (s.version === 'v0.0.0') {
               const skillMdPath = join(skillsDir, s.name, 'SKILL.md');
               if (existsSync(skillMdPath)) {
                 try {
                    const content = readFileSync(skillMdPath, 'utf-8');
                    const vMatch = content.match(/v(\d+\.\d+\.\d+(?:-[\w.]+)?)/);
                    if (vMatch) s.version = 'v' + vMatch[1];
                 } catch {}
               }
            }
          }

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
