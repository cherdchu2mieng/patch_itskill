/** Refresh a single skill by re-copying from source and updating manifest */
export async function refreshSkill(
  skillName: string,
  targetAgents: string[],
  options: { global: boolean; yes?: boolean; shellMode?: ShellMode }
): Promise<void> {
  const allSkills = await discoverSkills();
  const skill = allSkills.find((s) => s.name === skillName);

  if (!skill) {
    p.log.error('Skill not found: ' + skillName);
    return;
  }

  const shellMode = options.shellMode || 'auto';

  for (const agentName of targetAgents) {
    const agent = agents[agentName as keyof typeof agents];
    if (!agent) continue;

    const targetDir = options.global ? agent.globalSkillsDir : join(process.cwd(), agent.skillsDir);
    const destPath = join(targetDir, skill.name);

    if (!options.yes) {
        const confirmed = await p.confirm({
            message: 'Refresh ' + skill.name + ' in ' + agent.displayName + '?',
        });
        if (p.isCancel(confirmed) || !confirmed) continue;
    }

    p.log.info('♻️  Refreshing ' + skill.name + ' in ' + agent.displayName + '...');

    // 1. Remove existing
    if (existsSync(destPath)) {
      await rmrf(destPath, shellMode);
    }

    // 2. Copy fresh from source
    if (isCompiled()) {
      await writeSkillToDir(skill.name, destPath);
    } else {
      await cpr(skill.path, destPath, shellMode);
    }

    // 3. Stamping (Sovereign Stamping)
    const skillMdPath = join(destPath, 'SKILL.md');
    if (existsSync(skillMdPath)) {
        let content = await Bun.file(skillMdPath).text();
        if (content.startsWith('---')) {
            content = content.replace(/^---\n/, '---\ninstaller: it-skill-cli v' + pkg.version + '\norigin: Nat Weerawan\'s brain, digitized — how one human works with AI, captured as code — Soul Brews Studio\n');
            const scopeChar = options.global ? 'G' : 'L';
            const tierTag = (STANDARD_SKILLS as readonly string[]).includes(skill.name) ? '[standard]'
              : (LAB_SKILLS as readonly string[]).includes(skill.name) ? '[lab]'
              : (MINIMAL_ONLY_SKILLS as readonly string[]).includes(skill.name) ? '[minimal]'
              : (ZOMBIE_SKILLS as readonly string[]).includes(skill.name) ? '[zombie]'
              : '[core]';
            content = content.replace(/^(description:\s*)'?(.+?)'?(\n)/m, (_, p1, p2, p3) => {
                return p1 + yamlQuote(tierTag + ' v' + pkg.version + ' ' + scopeChar + '-SKLL | ' + p2) + p3;
            });
            await Bun.write(skillMdPath, content);
            skill.version = 'v' + pkg.version;
        }
    }

    // 4. Update Manifest JSON (Partial Update)
    const manifestPath = join(targetDir, '.it-skill.json');
    if (existsSync(manifestPath)) {
        try {
            const data = JSON.parse(readFileSync(manifestPath, 'utf-8'));
            if (Array.isArray(data.skills)) {
                const existingIdx = data.skills.findIndex((s: any) => (typeof s === 'string' ? s : s.name) === skill.name);
                const skillEntry = { name: skill.name, version: skill.version };
                if (existingIdx !== -1) {
                    data.skills[existingIdx] = skillEntry;
                } else {
                    data.skills.push(skillEntry);
                }
                data.installedAt = new Date().toISOString();
                await Bun.write(manifestPath, JSON.stringify(data, null, 2));
            }
        } catch {}
    }
    
    p.log.success('✅ ' + skill.name + ' (' + skill.version + ') refreshed successfully.');
  }
}