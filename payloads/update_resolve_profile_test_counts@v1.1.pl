  it("standard returns 6 skills", () => {
    const result = resolveProfile("standard", ALL_SKILLS);
    expect(result).toHaveLength(6);
  });

  it("full returns all minus lab-only, minimal-only, and zombies", () => {
