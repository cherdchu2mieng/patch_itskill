              const alreadyInstalled = detected.filter((a) => {
                const agent = agents[a as keyof typeof agents];
                if (!agent) return false;
                const dir = options.global ? agent.globalSkillsDir : join(process.cwd(), agent.skillsDir);
                const manifestPath = join(dir, '.it-skill.json');
                return existsSync(manifestPath);
              });