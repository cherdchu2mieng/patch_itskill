import sys
import os

target_path = sys.argv[1]
profiles_file_path = os.path.join(target_path, "src", "profiles.ts")

content = r'''/** Minimal profile — essential lifecycle */
export const MINIMAL_SKILLS = [] as const;

/** Standard profile — daily driver skills (always installed) */
export const STANDARD_SKILLS = [
  'build-patch', 'build-rfc', 'close-rfc', 'patch-forge',
] as const;

/** Lab-only skills — experimental */
export const LAB_SKILLS = [] as const;

/** Minimal-only — DEPRECATED */
export const MINIMAL_ONLY_SKILLS = [] as const;

/** Zombie skills — dormant */
export const ZOMBIE_SKILLS = [] as const;

// Compatibility Aliases
export const labOnly = [...LAB_SKILLS];
export const minimalOnly = [...MINIMAL_ONLY_SKILLS];

/** Return the source directory for a skill by name */
export function skillDirFor(name: string, skillsRoot: string): string {
  const isZombie = (ZOMBIE_SKILLS as readonly string[]).includes(name);
  const sep = skillsRoot.endsWith('/') || skillsRoot.endsWith('\\') ? '' : '/';
  return isZombie
    ? `${skillsRoot}${sep}.archive/${name}`
    : `${skillsRoot}${sep}${name}`;
}

export const profiles = {
  minimal: {
    description: "Newcomer essentials",
    include: MINIMAL_SKILLS,
  },
  standard: {
    description: "Daily driver",
    include: STANDARD_SKILLS,
  },
  full: {
    description: "All stable skills",
    exclude: [],
  },
  lab: {
    description: "Everything including experimental",
    exclude: [],
  },
} as const;

export type ProfileName = keyof typeof profiles;

export function resolveProfile(
  name: string,
  allSkillNames: string[]
): string[] | null {
  const profile = profiles[name as ProfileName];
  if (!profile) return null;

  if ('include' in profile) {
    return [...profile.include];
  }

  // Full/Lab: return everything minus zombies
  const excluded = new Set<string>(ZOMBIE_SKILLS);
  return allSkillNames.filter((s) => !excluded.has(s));
}
'''

with open(profiles_file_path, "w") as f:
    f.write("// @it-skill-patch: minimal_it_skill_profile@v1.2\n")
    f.write(content)

print("✅ src/profiles.ts fully overwritten and aligned (Governance Only).")
