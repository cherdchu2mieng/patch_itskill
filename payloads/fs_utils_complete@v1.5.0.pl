import { existsSync, mkdirSync, rmSync, cpSync, renameSync, copyFileSync, appendFileSync, readFileSync } from 'fs';
import { join } from 'path';
import { homedir } from 'os';
import { $ } from 'bun';

export type ShellMode = 'auto' | 'shell' | 'no-shell';

const isWindows = process.platform === 'win32';

function useShell(mode: ShellMode): boolean {
  if (mode === 'shell') return true;
  if (mode === 'no-shell') return false;
  return !isWindows;
}

export async function mkdirp(dir: string, mode: ShellMode = 'auto'): Promise<void> {
  if (useShell(mode)) {
    await $`mkdir -p ${dir}`.quiet();
  } else {
    mkdirSync(dir, { recursive: true });
  }
}

export async function rmrf(path: string, mode: ShellMode = 'auto'): Promise<void> {
  if (!existsSync(path)) return;
  if (useShell(mode)) {
    await $`rm -rf ${path}`.quiet();
  } else {
    rmSync(path, { recursive: true, force: true });
  }
}

export async function cpr(src: string, dest: string, mode: ShellMode = 'auto'): Promise<void> {
  if (useShell(mode)) {
    await $`cp -r ${src} ${dest}`.quiet();
  } else {
    cpSync(src, dest, { recursive: true });
  }
}

export async function mv(src: string, dest: string, mode: ShellMode = 'auto'): Promise<void> {
  if (useShell(mode)) {
    await $`mv ${src} ${dest}`.quiet();
  } else {
    renameSync(src, dest);
  }
}

export async function rmf(path: string, mode: ShellMode = 'auto'): Promise<void> {
  if (!existsSync(path)) return;
  if (useShell(mode)) {
    await $`rm -f ${path}`.quiet();
  } else {
    rmSync(path, { force: true });
  }
}

export async function cp(src: string, dest: string, mode: ShellMode = 'auto'): Promise<void> {
  if (useShell(mode)) {
    await $`cp ${src} ${dest}`.quiet();
  } else {
    copyFileSync(src, dest);
  }
}

/** Get the full path of a command if it exists in PATH */
export async function which(command: string): Promise<string | null> {
  try {
    const result = await $`which ${command}`.text();
    return result.trim() || null;
  } catch {
    return null;
  }
}

/** Get the version of a command by running --version or parsing wrapper content */
export async function getBinVersion(command: string): Promise<string | null> {
  try {
    const binPath = await which(command);
    if (!binPath) return null;
    
    try {
        const result = await $`${binPath} --version`.text();
        const match = result.match(/(\d+\.\d+\.\d+(-[\w.]+)?)/);
        if (match) return 'v' + match[1];
    } catch {}

    const content = await Bun.file(binPath).text();
    const wrapperMatch = content.match(/v(\d+\.\d+\.\d+(-[\w.]+)?)/);
    return wrapperMatch ? 'v' + wrapperMatch[1] : null;
  } catch {
    return null;
  }
}

/** Inject a line into the user's shell profile if missing */
export async function injectShellConfig(line: string): Promise<string | null> {
  const home = homedir();
  const shellPath = process.env.SHELL || '';
  const profiles = [];
  
  if (shellPath.includes('zsh')) profiles.push(join(home, '.zshrc'));
  else if (shellPath.includes('bash')) profiles.push(join(home, '.bashrc'), join(home, '.bash_profile'));
  else profiles.push(join(home, '.zshrc'), join(home, '.bashrc'));

  for (const profile of profiles) {
    if (existsSync(profile)) {
      const content = readFileSync(profile, 'utf-8');
      if (!content.includes(line)) {
        appendFileSync(profile, '\n# IT-Skill CLI Alignment\n' + line + '\n');
        return profile;
      }
      return null;
    }
  }
  return null;
}