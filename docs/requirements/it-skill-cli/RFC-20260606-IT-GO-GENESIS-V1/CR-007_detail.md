<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-007 - itgo Refresh Command Implementation

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/commands, cli/installer)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: New Feature Implementation (Sub-command)
- **Step-by-Step Logic**:
    1. **Installer Extension**: เพิ่มฟังก์ชัน `refreshSkill(skillName, agent, options)` ใน `src/cli/installer.ts` สำหรับการจัดการทักษะเดียว
    2. **itgo Integration**: เพิ่ม Sub-command `refresh` ใน `src/cli/commands/itgo.ts`
    3. **Manifest Sync**: ปรับปรุงลอจิกการเขียน Manifest ให้รองรับการอัปเดตเฉพาะจุด (Partial Update) แทนการเขียนทับทั้งหมด (ถ้าเป็นไปได้) หรืออ่านตัวเดิมมาแก้แล้วเขียนใหม่

## 3. Impact Assessment
- **Integration Impact**: เพิ่มความยืดหยุ่นในการจัดการกองเรือ
- **Regression Risk**: ต่ำ (เนื่องจากทำงานแยกส่วนเป็นรายทักษะ)

## 4. Acceptance Criteria
- [ ] คำสั่ง `it-skill itgo refresh build-rfc` ทำงานถูกต้อง
- [ ] ไฟล์ใน Agent ถูกเปลี่ยนเป็นเวอร์ชันล่าสุดจริง
- [ ] Dashboard แสดงเลขเวอร์ชันใหม่ทันทีหลังจาก Refresh

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
- **Genesis Result**: Individual Skill Refresh command enabled.
