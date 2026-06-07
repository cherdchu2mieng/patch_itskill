      const content = await Bun.file(skillMdPath).text();
      const descMatch = content.match(/description:\s*(.+)/);
      const hiddenMatch = content.match(/hidden:\s*(true|yes)/i);
      const secretMatch = content.match(/secret:\s*(true|yes)/i);
      const zombieMatch = content.match(/zombie:\s*(true|yes)/i);

      let version = 'v0.0.0';
      let manager: '[IT]' | '[A]' = '[A]';
      if (content.includes('installer: it-skill-cli')) manager = '[IT]';

      // Robust Source-Aware Version Extraction
      const headerVM = content.match(/^# .*\(v(\d+(?:\.\d+)+)\)/m);
      if (headerVM) {
        version = 'v' + headerVM[1];
      } else {
        const descVM = content.match(/^description:.*v(\d+(?:\.\d+)+)/m);
        if (descVM) {
          version = 'v' + descVM[1];
        } else {
          const vMatches = [...content.matchAll(/v(\d+(?:\.\d+)+)/g)];
          for (const m of vMatches) {
            const idx = m.index;
            const pre = content.substring(Math.max(0, idx - 40), idx);
            if (!pre.includes('installer:')) {
              version = 'v' + m[1];
              break;
            }
          }
        }
      }

      skills.push({
        name,
        description: descMatch?.[1]?.trim() || '',
        version,
        manager,
        path: dir,