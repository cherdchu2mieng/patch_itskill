export interface Skill {
  name: string;
  description: string;
  version: string;
  manager: '[IT]' | '[A]';
  path: string;
  hidden?: boolean; // If true, install SKILL.md but skip command stub (hidden from autocomplete)
  secret?: boolean; // If true, excluded from ALL profiles — install only by name (-s flag)
  zombie?: boolean; // If true, excluded from ALL profiles — internal development candidates, not for users
}
