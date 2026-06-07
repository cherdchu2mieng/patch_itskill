<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-004 - Advanced Governance Logic (Stats & Backups)

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/installer, cli/commands/itgo)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Feature Implementation
- **Affected Components**:
    - `src/cli/commands/itgo.ts`: เพิ่มระบบ Mining session logs (`.jsonl`).
    - `src/cli/installer.ts`: ปรับปรุง `installSkills` ให้ทำ Auto-backup (`.bak`).
- **Logic Description**:
    1. วนลูปสแกนไฟล์ log ในทุก Agent project
    2. นับจำนวนการเรียกใช้ Governance slash commands
    3. ในขั้นตอนการติดตั้ง/อัปเดต ให้ใช้ `mv` เพื่อทำ backup ไฟล์เดิมก่อนเสมอ

## 3. Impact Assessment
- **Integration Impact**: เพิ่มความสามารถในการตรวจสอบ (Audit) และความทนทานของข้อมูล
- **Regression Risk**: ปานกลาง (การ mining ไฟล์จำนวนมากอาจมีผลต่อ performance เล็กน้อย)

## 4. Acceptance Criteria
- [ ] Dashboard แสดงตัวเลขการใช้งาน (Usage count) ที่ถูกต้อง
- [ ] ตรวจพบไฟล์ `.bak` ในกรณีที่มีการอัปเดตทักษะเดิม

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
- **Genesis Result**: Usage Analytics (Session-based) and Auto-backups finalized.
