            if (existsSync(skillMdPath)) {
                const content = readFileSync(skillMdPath, 'utf-8');
                if (content.includes('installer: it-skill-cli')) manager = '[IT]';
                else if (content.includes('installer: pulse-cli')) manager = '[P]';
                else if (content.includes('installer: oracle-skills-cli') || content.includes('installer: arra-oracle-skills-cli')) manager = '[A]';
                
                const vMatch = content.match(/\(v(\d+(?:\.\d+)+)\)/);
                if (vMatch) version = 'v' + vMatch[1];
                else {
                    const descVM = content.match(/^description:.*v(\d+(?:\.\d+)+)/m);
                    if (descVM) version = 'v' + descVM[1];
                }
            }