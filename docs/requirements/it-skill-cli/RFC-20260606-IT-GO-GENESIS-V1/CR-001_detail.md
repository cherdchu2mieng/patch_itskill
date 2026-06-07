<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-001 - itgo Command Registration & Scaffolding

## 1. CR Information
- **Parent RFC**: RFC-20260606-IT-GO-GENESIS-V1
- **Target Module**: it-skill-cli (cli/commands)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: New Command Implementation
- **Affected Components**:
    - `src/cli/index.ts`: Register the new `itgo` command.
    - `src/cli/commands/itgo.ts`: (New File) Implement the `registerItgo` function.
    - `src/profiles.ts`: Add `itgo` to `STANDARD_SKILLS`.
- **Logic Description**:
    1. สร้างไฟล์ `itgo.ts` เพื่อรับผิดชอบการแสดงผล Dashboard และการจัดการ Fleet
    2. นำเข้าตรรกะการรันคำสั่งจาก `list.ts` และ `install.ts` มาเป็นต้นแบบ
    3. ลงทะเบียนคำสั่ง `itgo` ใน entry point หลักของ CLI

## 3. Impact Assessment
- **Integration Impact**: เพิ่ม entry point ใหม่ให้กับเครื่องมือ `it-skill`
- **Regression Risk**: ต่ำมาก (เป็นฟีเจอร์ใหม่)

## 4. Acceptance Criteria
- [ ] คำสั่ง `it-skill itgo` สามารถเรียกใช้งานได้
- [ ] ทักษะ `itgo` ปรากฏในรายชื่อทักษะมาตรฐาน (`it-skill list -g`)


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
- **Genesis Result**: itgo Registration and Scaffold established.
