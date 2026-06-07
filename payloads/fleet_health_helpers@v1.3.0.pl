/** Get the full path of a command if it exists in PATH */
export async function which(command: string): Promise<string | null> {
  try {
    const result = await $`which ${command}`.text();
    return result.trim() || null;
  } catch {
    return null;
  }
}

/** Get the version of a command by running --version */
export async function getBinVersion(command: string): Promise<string | null> {
  try {
    const binPath = await which(command);
    if (!binPath) return null;
    const result = await $`${binPath} --version`.text();
    const match = result.match(/(\d+\.\d+\.\d+(-[\w.]+)?)/);
    return match ? 'v' + match[1] : null;
  } catch {
    return null;
  }
}