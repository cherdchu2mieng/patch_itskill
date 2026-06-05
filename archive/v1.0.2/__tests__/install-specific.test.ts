import { describe, it, expect, beforeAll, afterAll, beforeEach } from "bun:test";
import { readdir, readFile, rm, mkdir } from "fs/promises";
import { join } from "path";
import { existsSync } from "fs";
import { tmpdir } from "os";
import { agents } from "../src/cli/agents";
import { installSkills, discoverSkills } from "../src/cli/installer";
import type { AgentConfig } from "../src/cli/types";

const DEPRECATED_LITES = 3; // forward-lite, recap-lite, rrr-lite migrated away post-install

const TEST_DIR = join(tmpdir(), `arra-install-specific-${Date.now()}`);
const SKILLS_DIR = join(TEST_DIR, "skills");
const COMMANDS_DIR = join(TEST_DIR, "commands");
const TEST_AGENT = "test-specific" as any;

const testAgentConfig: AgentConfig = {
  name: "test-specific",
  displayName: "Test Specific",
  skillsDir: "test-skills",
  globalSkillsDir: SKILLS_DIR,
  commandsDir: "test-commands",
  globalCommandsDir: COMMANDS_DIR,
  useFlatFiles: true,
  detectInstalled: () => true,
};

async function listSkillDirs(dir: string): Promise<string[]> {
  if (!existsSync(dir)) return [];
  const entries = await readdir(dir, { withFileTypes: true });
  return entries.filter((d) => d.isDirectory() && !d.name.startsWith(".")).map((d) => d.name).sort();
}

async function cleanup() {
  if (existsSync(SKILLS_DIR)) await rm(SKILLS_DIR, { recursive: true });
  if (existsSync(COMMANDS_DIR)) await rm(COMMANDS_DIR, { recursive: true });
  await mkdir(SKILLS_DIR, { recursive: true });
  await mkdir(COMMANDS_DIR, { recursive: true });
}

beforeAll(async () => {
  await mkdir(TEST_DIR, { recursive: true });
  (agents as any)[TEST_AGENT] = testAgentConfig;
});

afterAll(async () => {
  delete (agents as any)[TEST_AGENT];
  if (existsSync(TEST_DIR)) await rm(TEST_DIR, { recursive: true });
});

describe("install specific skills (--skill)", () => {
  beforeEach(cleanup);

  it("installs only named skills", async () => {
    await installSkills([TEST_AGENT], {
      global: true,
      skills: ["build-patch", "close-rfc"],
      yes: true,
    });

    const installed = await listSkillDirs(SKILLS_DIR);
    expect(installed).toEqual(["build-patch", "close-rfc"]);
  });

  it("installs single skill", async () => {
    await installSkills([TEST_AGENT], {
      global: true,
      skills: ["build-rfc"],
      yes: true,
    });

    const installed = await listSkillDirs(SKILLS_DIR);
    expect(installed).toEqual(["build-rfc"]);
    const content = await readFile(join(SKILLS_DIR, "build-rfc", "SKILL.md"), "utf-8");
    expect(content).toContain("installer: it-skill-cli");
  });

  it("ignores unknown skill names gracefully", async () => {
    await installSkills([TEST_AGENT], {
      global: true,
      skills: ["build-patch", "nonexistent-skill"],
      yes: true,
    });

    const installed = await listSkillDirs(SKILLS_DIR);
    expect(installed).toEqual(["build-patch"]);
  });

  it("does not remove existing skills when adding specific ones", async () => {
    // Install all first
    await installSkills([TEST_AGENT], { global: true, yes: true });
    const allSkills = await discoverSkills();
    let installed = await listSkillDirs(SKILLS_DIR);
    expect(installed.length).toBe(allSkills.length);

    // Install specific — should NOT remove others
    await installSkills([TEST_AGENT], {
      global: true,
      skills: ["build-patch"],
      yes: true,
    });

    installed = await listSkillDirs(SKILLS_DIR);
    // Still has all skills (specific install is additive, not destructive)
    expect(installed.length).toBe(allSkills.length);
  });

  it("manifest lists only installed skills", async () => {
    await installSkills([TEST_AGENT], {
      global: true,
      skills: ["build-patch", "build-rfc", "close-rfc"],
      yes: true,
    });

    const manifest = JSON.parse(await readFile(join(SKILLS_DIR, ".it-skill.json"), "utf-8"));
    expect(manifest.skills.sort()).toEqual(["build-patch", "build-rfc", "close-rfc"]);
  });
});
