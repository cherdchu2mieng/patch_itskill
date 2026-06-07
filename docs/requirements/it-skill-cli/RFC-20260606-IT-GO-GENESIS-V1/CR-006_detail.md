<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-006 - Rich Manifest & itgo Sovereign Manager

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/installer, cli/commands)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Core Logic Update & Command Expansion
- **Step-by-Step Logic**:
    1. **Installer Modification**: ปรับปรุง `src/cli/installer.ts` ให้ฟังก์ชัน `installSkills` ทำการสแกนหา Version จาก `SKILL.md` และสร้าง Manifest JSON แบบละเอียด (Objects instead of strings)
    2. **itgo Expansion**: แก้ไข `src/cli/commands/itgo.ts` ให้รองรับ Argument (profile) และเรียกใช้ `installSkills` หากมีการส่ง Argument มา
    3. **Dashboard Optimization**: ปรับปรุง `itgo.ts` ให้อ่านเวอร์ชันจาก Rich Manifest โดยตรง
    4. **Legacy Removal**: แก้ไข `src/cli/index.ts` หรือ `install.ts` เพื่อนำ `{ isDefault: true }` ออก เพื่อยุติคำสั่ง `go`

## 3. Impact Assessment
- **Integration Impact**: เปลี่ยนวิธีการจัดการทักษะหลักของระบบ
- **Regression Risk**: ปานกลาง (ต้องทดสอบการอ่าน/เขียน Manifest ให้แม่นยำเพื่อไม่ให้ Dashboard พัง)

## 4. Acceptance Criteria
- [ ] คำสั่ง `it-skill go` ไม่ทำงานอีกต่อไป
- [ ] คำสั่ง `it-skill itgo standard` ทำงานได้เหมือนการรัน install
- [ ] Dashboard แสดงเลขเวอร์ชันรายทักษะได้ถูกต้อง 100% ดึงจาก JSON

## 5. Post-Implementation Report
- **Implementation Date**: 2026-06-07
- **Actual Files Modified**: 
    - src/cli/installer.ts (Rich Manifest Logic)
    - src/cli/commands/itgo.ts (Sovereign Manager & Dashboard)
    - src/cli/index.ts (Entry Point Alignment)
    - src/cli/commands/install.ts (Legacy Decommissioning)
    - src/skills/itgo/SKILL.md (Metadata Stamping)
- **Status**: Verified by Human (Gate Decision: Passed)
- **Notes**: itgo is now the central command. "go" is officially deprecated.
