      const content = await Bun.file(skillMdPath).text();
      const descMatch = content.match(/description:\s*(.+)/);
      const hiddenMatch = content.match(/hidden:\s*(true|yes)/i);
      const secretMatch = content.match(/secret:\s*(true|yes)/i);
      const zombieMatch = content.match(/zombie:\s*(true|yes)/i);

      let version = 'v0.0.0';
      let manager: '[IT]' | '[A]' | 'External' = 'External';
      if (content.includes('installer: it-skill-cli')) manager = '[IT]';
      else if (content.includes('installer: oracle-skills-cli') || content.includes('installer: arra-oracle-skills-cli')) manager = '[A]';

      const headerMatch = content.match(/^# .+\(v(\d+\.\d+)\)\s*$/m);
      if (headerMatch) {
          version = 'v' + headerMatch[1];
      } else {
          const descVM = content.match(/description:.*\[\w+\]\s+v(\d+\.\d+\.\d+)/);
          if (descVM) version = 'v' + descVM[1];
          else {
              const genericV = content.match(/(?<!installer:\s+[\w-]+\s+)v(\d+\.\d+\.\d+)/);
              if (genericV) version = 'v' + genericV[1];
          }
      }

      skills.push({
        name,
        description: descMatch?.[1]?.trim() || '',
        version,
        manager,
        path: dir,