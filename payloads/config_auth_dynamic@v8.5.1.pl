export function enforceAuth() {
  const current = getCurrentOracle();
  const cfg = loadConfig();
  const orchestrator = cfg.orchestrator;
  
  // If no orchestrator is configured, we allow it to maintain compatibility
  if (!orchestrator) return;

  const orchName = (typeof orchestrator === "object" ? orchestrator.oracle : orchestrator);
  
  if (!current || current !== orchName.toLowerCase()) {
    console.error(`❌ Authority Error: Only Orchestrator "${orchName}" can perform this action.`);
    process.exit(1);
  }
}