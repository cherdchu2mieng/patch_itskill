        const descMatch = skillMd.match(/description:\s*(.+)/);
        const hiddenMatch = skillMd.match(/hidden:\s*(true|yes)/i);
        const secretMatch = skillMd.match(/secret:\s*(true|yes)/i);
        const zombieMatch = skillMd.match(/zombie:\s*(true|yes)/i);

        let version = 'v0.0.0';
        let manager: '[IT]' | '[A]' | 'External' = 'External';
        if (skillMd.includes('installer: it-skill-cli')) manager = '[IT]';
        else if (skillMd.includes('installer: oracle-skills-cli') || skillMd.includes('installer: arra-oracle-skills-cli')) manager = '[A]';

        // Robust Version Extraction
        const headerMatch = skillMd.match(/^# .+\(v(\d+\.\d+)\)\s*$/m);
        if (headerMatch) {
            version = 'v' + headerMatch[1];
        } else {
            const descVM = skillMd.match(/description:.*\[\w+\]\s+v(\d+\.\d+\.\d+)/);
            if (descVM) version = 'v' + descVM[1];
            else {
                const genericV = skillMd.match(/(?<!installer:\s+[\w-]+\s+)v(\d+\.\d+\.\d+)/);
                if (genericV) version = 'v' + genericV[1];
            }
        }

        skills.push({
          name,
          description: descMatch?.[1]?.trim() || '',
          version,
          manager,
          path: 'vfs://' + name,
          ...(hiddenMatch ? { hidden: true } : {}),