import { describe, it, expect } from "bun:test";
import { profiles, labOnly, minimalOnly, MINIMAL_SKILLS, STANDARD_SKILLS, LAB_SKILLS, MINIMAL_ONLY_SKILLS, ZOMBIE_SKILLS, resolveProfile } from "../src/profiles";

// IT-Skill CLI: Pure minimal list
const ALL_SKILLS = [
  ...STANDARD_SKILLS,
  ...LAB_SKILLS,
  ...ZOMBIE_SKILLS,
  ...MINIMAL_ONLY_SKILLS,
].sort();

describe("profiles", () => {
  it("minimal has 2 skills", () => {
    expect(MINIMAL_SKILLS).toHaveLength(2);
    expect(profiles.minimal.include).toHaveLength(2);
  });

  it("minimal includes go for upgrade path", () => {
    expect(MINIMAL_SKILLS).toContain("go");
  });

  it("standard has 6 skills", () => {
    expect(STANDARD_SKILLS).toHaveLength(6);
  });

  it("full excludes lab-only AND minimal-only skills", () => {
    expect(profiles.full.exclude).toEqual([...labOnly, ...minimalOnly]);
  });

  it("standard includes core governance", () => {
    expect(STANDARD_SKILLS).toContain("build-rfc");
    expect(STANDARD_SKILLS).toContain("build-patch");
    expect(STANDARD_SKILLS).toContain("close-rfc");
    expect(STANDARD_SKILLS).toContain("patch-forge");
  });

  it("LAB_SKILLS is empty in it-skill-cli", () => {
    expect(LAB_SKILLS).toHaveLength(0);
  });

  it("ZOMBIE_SKILLS is empty in it-skill-cli", () => {
    expect(ZOMBIE_SKILLS).toHaveLength(0);
  });
});

describe("resolveProfile", () => {
  it("minimal returns 2 skills", () => {
    const result = resolveProfile("minimal", ALL_SKILLS);
    expect(result).toHaveLength(2);
  });

  it("standard returns 6 skills", () => {
    const result = resolveProfile("standard", ALL_SKILLS);
    expect(result).toHaveLength(6);
  });

  it("full returns everything minus zombies", () => {
    const result = resolveProfile("full", ALL_SKILLS);
    expect(result).toHaveLength(6);
  });
});
