<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-003 - Fleet Health & Shell Integration

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/commands/itgo, cli/fs-utils)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Infrastructure Setup
- **Affected Components**:
    - `src/cli/commands/itgo.ts`: เพิ่มบล็อก "Fleet Environment" ใน Dashboard
    - `src/cli/fs-utils.ts`: เพิ่ม Helper สำหรับการตรวจสอบ Shell และการฉีด config
- **Logic Description**:
    1. ใช้ `which` หรือ `command -v` เพื่อเช็ค Binary ของทั้ง 2 ค่าย
    2. ตรวจสอบเวอร์ชันผ่าน flag `--version`
    3. พัฒนาระบบตรวจสอบเนื้อหาใน `.zshrc`/`.bashrc` และดำเนินการฉีด `export PATH` หากยังไม่มี

## 3. Impact Assessment
- **Integration Impact**: ปรับปรุงสภาพแวดล้อมของระบบให้พร้อมใช้งานเครื่องมือทีม IT
- **Regression Risk**: ต่ำ (ใช้กลไก Idempotency เพื่อป้องกันการฉีดซ้ำ)

## 4. Acceptance Criteria
- [ ] Dashboard แสดงสถานะ ✅ สำหรับ CLI ที่ติดตั้งถูกต้อง
- [ ] คำสั่ง `it-skill` สามารถเรียกใช้งานได้จาก Shell ทุกตัว

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
- **Genesis Result**: Fleet Health and Shell Injection implemented.
