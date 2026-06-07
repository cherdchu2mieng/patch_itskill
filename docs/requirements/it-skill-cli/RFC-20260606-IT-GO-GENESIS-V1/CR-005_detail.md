<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-005 - Cross-Agent Sync & Bootstrap Alignment

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/installer, profiles)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Distribution Refactoring
- **Affected Components**:
    - `src/cli/installer.ts`: ปรับปรุงลอจิกการกระจายทักษะไปยังทุก Agent targets.
    - `src/profiles.ts`: ตรวจสอบความถูกต้องของรายการทักษะใน `standard` profile.
- **Logic Description**:
    1. แก้ไข `installSkills` ให้วนลูปผ่านทุก Agent ที่ `detectInstalledAgents()` เจอเสมอ (เว้นแต่จะระบุเจาะจง)
    2. ประกันว่าเครื่องมือคุมกฎถูกฉีดเข้าไปทั้งใน Claude และ Gemini พร้อมกันในคำสั่งเดียว

## 3. Impact Assessment
- **Integration Impact**: สร้างความสอดคล้อง (Consistency) ของเครื่องมือในทุก AI Agents
- **Regression Risk**: ต่ำ

## 4. Acceptance Criteria
- [ ] รัน `it-skill itgo standard` ครั้งเดียว ทักษะจะถูกอัปเดตในทุก Agent target
- [ ] ไม่มีการตกหล่นของทักษะ Governance ใน Agent ใด Agent หนึ่ง

## 5. Post-Implementation Report (FINAL)
- **Implementation Date**: 2026-06-07
- **Version**: v1.6.3 (Gold Master)
- **Actual Files Modified**: 
    - src/cli/skill-source.ts (Unified Discovery & Version Extraction)
    - src/cli/installer.ts (Rich Manifest, Backups, Refresh Logic)
    - src/cli/commands/itgo.ts (Sovereign Manager, Health, Usage Stats)
    - src/cli/types.ts (Refined Metadata Types)
    - src/cli/fs-utils.ts (Shell Injection & Robust Health)
- **Status**: Verified by Human (Final Genesis Release: Passed)
- **Genesis Result**: Cross-Agent Sync and Bootstrap Alignment verified.
