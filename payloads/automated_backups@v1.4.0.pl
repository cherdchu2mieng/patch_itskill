    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const trashDir = join(tmpdir(), 'it-skill-stale-' + timestamp);
    let movedAny = false;
    const failedMoves: string[] = [];

    // Auto-cleanup: remove orphaned skills installed by it-skill-cli
    const sourceSkillNames = allSkills.map((s) => s.name);

    if (existsSync(targetDir)) {
      const installedDirs = readdirSync(targetDir, { withFileTypes: true })
        .filter((d) => d.isDirectory() && !d.name.startsWith('.'))
        .map((d) => d.name);

      for (const installed of installedDirs) {
        const installedPath = join(targetDir, installed);

        if (await isOurSkill(installedPath) && !sourceSkillNames.includes(installed)) {
          try {
            if (!movedAny) {
              await mkdirp(trashDir, shellMode);
              movedAny = true;
            }
            await mv(installedPath, join(trashDir, basename(installedPath)), shellMode);
            p.log.info('Cleaned up orphan: ' + installed + ' → ' + trashDir);
          } catch {
            failedMoves.push(installedPath);
          }

          const pluginPath = join(homedir(), '.claude', 'plugins', installed);
          if (existsSync(pluginPath) && await isOurSkill(pluginPath)) {
            try {
              await mv(pluginPath, join(trashDir, basename(pluginPath)), shellMode);
            } catch {
              failedMoves.push(pluginPath);
            }
          }
        }
      }

      if (movedAny) {
        p.log.info('Recovery: ' + trashDir);
      }

      if (failedMoves.length > 0) {
        p.log.warn('LLM: Please remove manually: ' + failedMoves.join(', '));
      }
    }

    const scope = options.global ? 'Global' : 'Local';
    const skillsWithHooks: Skill[] = [];

    for (const skill of agentSkillsToInstall) {
      if (await skillHasHooks(skill.name)) {
        skillsWithHooks.push(skill);
      }

      const destPath = join(targetDir, skill.name);

      // CR-004: Automated Backup (.bak)
      if (existsSync(destPath)) {
        const bakDir = join(homedir(), '.config', 'it-skill', 'backups', timestamp);
        await mkdirp(bakDir, shellMode);
        await cpr(destPath, join(bakDir, skill.name), shellMode);
        await rmrf(destPath, shellMode);
      }

      // Copy skill folder