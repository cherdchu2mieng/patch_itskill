/** Detect the manager of a skill based on its signature in SKILL.md */
export async function getManager(skillPath: string): Promise<'[IT]' | '[A]' | '[P]' | 'External'> {
  const skillMdPath = join(skillPath, 'SKILL.md');
  if (!existsSync(skillMdPath)) return 'External';
  try {
    const content = await Bun.file(skillMdPath).text();
    if (content.includes('installer: it-skill-cli')) return '[IT]';
    if (content.includes('installer: pulse-cli')) return '[P]';
    if (content.includes('installer: oracle-skills-cli') || content.includes('installer: arra-oracle-skills-cli')) return '[A]';
    return 'External';
  } catch {
    return 'External';
  }
}

async function isOurSkill(skillPath: string): Promise<boolean> {
  const manager = await getManager(skillPath);
  return manager === '[IT]';
}