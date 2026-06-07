    // Generate Rich Manifest with Source-Aware versions
    const skillListWithVersions = agentSkillsToInstall.map(s => {
      let version = s.version || 'v0.0.0';
      // Fallback for newly stamped IT skills that had no source version
      if (version === 'v0.0.0' && s.manager === '[IT]') {
        version = 'v' + pkg.version;
      }
      return { name: s.name, version };
    });

    const manifest = {
      version: pkg.version,
      installedAt: new Date().toISOString(),
      skills: skillListWithVersions,
      agent: agentName,
    };
    await Bun.write(join(targetDir, '.it-skill.json'), JSON.stringify(manifest, null, 2));