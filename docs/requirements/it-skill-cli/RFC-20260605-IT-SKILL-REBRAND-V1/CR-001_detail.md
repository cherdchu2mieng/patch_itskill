<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-001 - Identity String Transformation

## 1. CR Information
- **Parent RFC**: RFC-20260605-IT-SKILL-REBRAND-V1
- **Target Module**: it-skill-cli (src, scripts)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: String Replacement & Metadata Update
- **Affected Components**:
    - `src/cli/installer.ts`
    - `src/cli/commands/about.ts`
    - `scripts/compile.ts`
- **Logic Description**:
    1. เปลี่ยน `Nat Weerawan's brain` เป็น `IT TEAM Standard`
    2. เปลี่ยน `Soul Brews Studio` เป็น `itinfosv`
    3. ปรับปรุงข้อความ `origin` ใน Header ที่ Installer ฉีดเข้า `SKILL.md` ให้ระบุเป็นศูนย์กลางของทีม IT Board

## 3. Impact Assessment
- **Integration Impact**: เปลี่ยนแปลงข้อความที่แสดงผลและ Metadata ในไฟล์ที่ติดตั้ง
- **Regression Risk**: ต่ำมาก (เป็นการเปลี่ยน String เท่านั้น)

## 4. Acceptance Criteria
- [ ] ข้อความ "Nat Weerawan" และ "Soul Brews Studio" หายไปจาก Source Code และไฟล์ที่ถูก Compile
- [ ] เมื่อติดตั้ง Skill ใหม่ Header ใน `SKILL.md` จะต้องระบุว่ามาจาก `IT TEAM`
