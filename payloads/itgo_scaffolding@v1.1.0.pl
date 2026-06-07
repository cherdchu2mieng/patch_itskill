import type { Command } from 'commander';
import { agents, detectInstalledAgents } from '../agents.js';

export function registerItgo(program: Command, version: string) {
  program
    .command('itgo')
    .description('🛡️ IT TEAM Sovereign Fleet Dashboard')
    .option('-g, --global', 'Show global (user-level) skills')
    .option('-a, --agent <agents...>', 'Show skills for specific agents')
    .action(async (options) => {
      const { readdirSync, existsSync, readFileSync } = await import('fs');
      const { join } = await import('path');

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

        const skillDirs = readdirSync(skillsDir, { withFileTypes: true })
          .filter((d) => d.isDirectory() && !d.name.startsWith('.'))
          .map((d) => d.name);

        if (skillDirs.length === 0) {
          console.log('  ' + agent.displayName + ' ' + scope + ': (empty)');
        } else {
          console.log('  ' + agent.displayName + ' ' + scope + ': ' + skillDirs.length + ' skills');
          
          console.log('  ' + '-'.repeat(70));
          console.log('  ' + '#'.padEnd(4) + 'Skill'.padEnd(30) + 'Manager'.padEnd(15) + 'Version'.padEnd(10) + 'Status');
          console.log('  ' + '-'.repeat(70));

          const skillData = [];

          for (const skill of skillDirs) {
            let versionStr = 'v0.0.0';
            let manager = '[A]';
            let status = 'Active';
            const skillMdPath = join(skillsDir, skill, 'SKILL.md');
            if (existsSync(skillMdPath)) {
              try {
                const content = readFileSync(skillMdPath, 'utf-8');
                
                // 1. Precise Manager & Version Check
                const itMatch = content.match(/installer: it-skill-cli v(\d+\.\d+\.\d+)/);
                if (itMatch) {
                    manager = '[IT]';
                    versionStr = 'v' + itMatch[1];
                } else if (content.includes('installer: it-skill-cli')) {
                    manager = '[IT]';
                    // Fallback to [core] tag version if it exists
                    const coreMatch = content.match(/\[core\] v(\d+\.\d+\.\d+)/);
                    if (coreMatch) versionStr = 'v' + coreMatch[1];
                } else {
                    // 2. [A] Fleet Version Extraction (Look for v26.x or similar in description)
                    const descVersionMatch = content.match(/description:\s*'?(?:\[\w+\]\s+)?v(\d+\.\d+\.\d+(?:-[\w.]+)?)/);
                    if (descVersionMatch) {
                        versionStr = 'v' + descVersionMatch[1];
                    } else {
                        // Global search for any version tag that isn't the installer signature
                        const allVersions = [...content.matchAll(/v(\d+\.\d+\.\d+(?:-[\w.]+)?)/g)];
                        if (allVersions.length > 0) {
                           // Pick the one that doesn't follow 'installer: ...'
                           for (const m of allVersions) {
                               const idx = m.index;
                               const preContext = content.substring(Math.max(0, idx - 40), idx);
                               if (!preContext.includes('installer:')) {
                                   versionStr = 'v' + m[1];
                                   break;
                               }
                           }
                        }
                    }
                }
                
                if (content.includes('hidden: true') || content.includes('secret: true')) {
                   status = 'Hidden';
                }
              } catch {}
            }
            skillData.push({ name: skill, manager, version: versionStr, status });
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
          totalSkills += skillDirs.length;
        }
        console.log('');
      }

      console.log('Total: ' + totalSkills + ' skills across ' + targetAgents.length + ' agent(s) | it-skill-cli v' + version + '\n');
    });
}
