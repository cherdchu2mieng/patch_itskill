        if (existsSync(skillMdPath)) {
          let content = await Bun.file(skillMdPath).text();
          if (content.startsWith('---')) {
            content = content.replace(
              /^---\n/,
              '---\ninstaller: it-skill-cli v' + pkg.version + '\norigin: Nat Weerawan\'s brain, digitized — how one human works with AI, captured as code — Soul Brews Studio\n'
            );
            const scopeChar = scope === 'Global' ? 'G' : 'L';
            const tierTag = (STANDARD_SKILLS as readonly string[]).includes(skill.name) ? '[standard]'
              : (LAB_SKILLS as readonly string[]).includes(skill.name) ? '[lab]'
              : (MINIMAL_ONLY_SKILLS as readonly string[]).includes(skill.name) ? '[minimal]'
              : (ZOMBIE_SKILLS as readonly string[]).includes(skill.name) ? '[zombie]'
              : '[core]';
            content = content.replace(
              /^(description:\s*)'?(.+?)'?(\n)/m,
              (_, p1, p2, p3) => {
                const desc = tierTag + ' v' + pkg.version + ' ' + scopeChar + '-SKLL | ' + p2;
                return p1 + yamlQuote(desc) + p3;
              }
            );
            await Bun.write(skillMdPath, content);
            // skill.version remains what was detected from source by discoverSkills()
          }
        }
      }

      // Generate Rich Manifest with Source-Aware versions
      const skillListWithVersions = agentSkillsToInstall.map(s => ({
        name: s.name,
        version: s.version || 'v0.0.0'
      }));

      const manifest = {
        version: pkg.version,
        installedAt: new Date().toISOString(),
        skills: skillListWithVersions,
        agent: agentName,
      };
      await Bun.write(join(targetDir, '.it-skill.json'), JSON.stringify(manifest, null, 2));