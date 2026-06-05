<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-004 - Test Suite Alignment (Governance Focus)

## 1. CR Information
- **Parent RFC**: RFC-20260605-IT-SKILL-REBRAND-V1
- **Target Module**: it-skill-cli (__tests__)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Test Cleanup & Refactoring
- **Affected Components**:
    - `__tests__/*.test.ts`
- **Logic Description**:
    1. ลบไฟล์ทดสอบที่อ้างอิงถึง Skill ที่ไม่มีในโปรเจกต์ (เช่น `dig-skill.test.ts`)
    2. ในไฟล์ทดสอบประเภท E2E หรือ Installer ให้เปลี่ยนการ Assert จากเดิมที่ตรวจหา `recap`, `trace` ให้เปลี่ยนเป็นตรวจหา `build-rfc`, `build-patch`, `close-rfc`, หรือ `patch-forge` แทน
    3. ปรับปรุงค่าคงที่ใน Test เช่น `MINIMAL_SKILLS` หรือ `STANDARD_SKILLS` ให้ตรงกับ `src/profiles.ts` ปัจจุบันของ it-skill-cli

## 3. Impact Assessment
- **Integration Impact**: ทำให้การรัน `bun test` กลับมาเป็นสีเขียว (Pass) และทดสอบเฉพาะฟีเจอร์ที่มีอยู่จริง
- **Regression Risk**: ปานกลาง (ต้องระวังไม่ให้ลบการทดสอบที่เป็นลอจิกหลักของตัว Installer)

## 4. Acceptance Criteria
- [ ] รัน `bun test` ใน `it-skill-cli` แล้วผ่านทั้งหมด
- [ ] ไม่มีการกล่าวถึง `recap`, `trace`, `dig` หรือชื่อ Skill อื่นๆ ของ Arra ในไฟล์ทดสอบ
