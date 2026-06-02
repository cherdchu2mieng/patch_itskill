  it("minimal includes go for upgrade path", () => {
    expect(MINIMAL_SKILLS).toContain("go");
  });

  it("standard has 6 skills", () => {
    expect(STANDARD_SKILLS).toHaveLength(6);
  });
