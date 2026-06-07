    // Enrich with metadata (version, manager)
    const enrichedSkills: Skill[] = [];
    for (const skill of skills) {
        let version = 'v0.0.0';
        let manager: '[IT]' | '[A]' = '[A]';
        
        try {
            const content = await readSkillFile(skill.name, 'SKILL.md');
            if (content) {
                if (content.includes('installer: it-skill-cli')) {
                    manager = '[IT]';
                }
                
                // Extraction: Description field priority
                const descMatch = content.match(/description:\s*'?(?:\[\w+\]\s+)?v(\d+\.\d+\.\d+(?:-[\w.]+)?)/);
                if (descMatch) {
                    version = 'v' + descMatch[1];
                } else {
                    const genericMatch = content.match(/v(\d+\.\d+\.\d+(?:-[\w.]+)?)/);
                    if (genericMatch) version = 'v' + genericMatch[1];
                }
            }
        } catch {}
        
        enrichedSkills.push({ ...skill, version, manager });
    }
    return enrichedSkills;