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
    
    // 1. Try running --version (Fast Path)
    try {
        const result = await $`${binPath} --version`.text();
        const match = result.match(/(\d+\.\d+\.\d+(-[\w.]+)?)/);
        if (match) return 'v' + match[1];
    } catch {}

    // 2. Try parsing file content (for shell wrappers)
    const content = await Bun.file(binPath).text();
    const wrapperMatch = content.match(/v(\d+\.\d+\.\d+(-[\w.]+)?)/);
    return wrapperMatch ? 'v' + wrapperMatch[1] : null;
  } catch {
    return null;
  }
}