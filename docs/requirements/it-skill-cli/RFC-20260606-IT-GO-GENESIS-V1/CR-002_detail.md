<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-002 - Unified Scanner & Manager Identification

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/installer, cli/commands/itgo)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Logic Enhancement
- **Affected Components**:
    - `src/cli/installer.ts`: เพิ่ม Helper `getManager(skillPath: string)` เพื่อระบุ Manager จาก `installer:` field.
    - `src/cli/commands/itgo.ts`: พัฒนาตรรกะการสแกน Directory และจัดกลุ่มทักษะ
- **Logic Description**:
    1. พัฒนาฟังก์ชันอ่าน `SKILL.md` เพื่อดึงค่า `installer:` signature
    2. Map ลายเซ็นที่พบเข้ากับ Manager ID: `[IT]`, `[A]`, `[P]`
    3. บังคับใช้ตรรกะ **Sacred Lock** โดยการตรวจสอบ Signature ก่อนดำเนินการแก้ไขไฟล์ใดๆ ในขั้นตอน cleanup

## 3. Impact Assessment
- **Integration Impact**: ทำให้ระบบรู้จักขอบเขตอธิปไตยของทั้ง 2 CLI
- **Regression Risk**: ปานกลาง (ต้องตรวจสอบว่าไม่ไปขัดขวางการทำงานของ Arra เดิม)

## 4. Acceptance Criteria
- [ ] Dashboard แสดงเครื่องหมาย `[IT]` สำหรับทักษะของทีม IT
- [ ] ขั้นตอน Cleanup ข้ามทักษะที่มีลายเซ็นต่างค่ายอย่างถูกต้อง

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
- **Genesis Result**: Unified Scanner with [IT]/[A] identification consolidated.
