/** Minimal profile — essential lifecycle + trace */
export const MINIMAL_SKILLS = [
  'go', 'recap',
] as const;

/** Standard profile — daily driver skills (always installed) */
export const STANDARD_SKILLS = [
  'build-patch', 'build-rfc', 'close-rfc', 'go', 'patch-forge', 'recap',
] as const;

/** Lab-only skills — experimental, not in standard or full */
export const LAB_SKILLS = [] as const;

/** Minimal-only — DEPRECATED */
export const MINIMAL_ONLY_SKILLS = [] as const;

/** Zombie skills — Excluded from ALL profiles. */
export const ZOMBIE_SKILLS = [] as const;
