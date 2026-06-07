import sys
import os

target_path = sys.argv[1]
test_file_path = os.path.join(target_path, "__tests__", "profiles.test.ts")

content = r'''import { describe, it, expect } from "bun:test";
import { profiles, labOnly, minimalOnly, MINIMAL_SKILLS, STANDARD_SKILLS, LAB_SKILLS, MINIMAL_ONLY_SKILLS, ZOMBIE_SKILLS, resolveProfile } from "../src/profiles";

// IT-Skill CLI: Pure governance list
const ALL_SKILLS = [
  ...STANDARD_SKILLS,
  ...LAB_SKILLS,
  ...ZOMBIE_SKILLS,
  ...MINIMAL_ONLY_SKILLS,
].sort();

describe("profiles", () => {
  it("minimal is empty in governance-only mode", () => {
    expect(MINIMAL_SKILLS).toHaveLength(0);
    expect(profiles.minimal.include).toHaveLength(0);
  });

  it("standard has 5 skills", () => {
    expect(STANDARD_SKILLS).toHaveLength(5);
  });

  it("full excludes lab-only AND minimal-only skills", () => {
    expect(profiles.full.exclude).toEqual([...labOnly, ...minimalOnly]);
  });

  it("standard includes ONLY core governance", () => {
    expect(STANDARD_SKILLS).toContain("build-rfc");
    expect(STANDARD_SKILLS).toContain("build-patch");
    expect(STANDARD_SKILLS).toContain("close-rfc");
    expect(STANDARD_SKILLS).toContain("patch-forge");
    expect(STANDARD_SKILLS).not.toContain("go");
    expect(STANDARD_SKILLS).not.toContain("recap");
  });

  it("LAB_SKILLS is empty", () => {
    expect(LAB_SKILLS).toHaveLength(0);
  });

  it("ZOMBIE_SKILLS is empty", () => {
    expect(ZOMBIE_SKILLS).toHaveLength(0);
  });
});

describe("resolveProfile", () => {
  it("minimal returns 0 skills", () => {
    const result = resolveProfile("minimal", ALL_SKILLS);
    expect(result).toHaveLength(0);
  });

  it("standard returns 5 skills", () => {
    const result = resolveProfile("standard", ALL_SKILLS);
    expect(result).toHaveLength(5);
  });

  it("full returns everything minus zombies (5 skills)", () => {
    const result = resolveProfile("full", ALL_SKILLS);
    expect(result).toHaveLength(5);
  });
});
'''

with open(test_file_path, "w") as f:
    f.write("// @it-skill-patch: it_skill_profiles_test@v1.2\n")
    f.write(content)

print("✅ __tests__/profiles.test.ts fully overwritten (Governance Only).")
