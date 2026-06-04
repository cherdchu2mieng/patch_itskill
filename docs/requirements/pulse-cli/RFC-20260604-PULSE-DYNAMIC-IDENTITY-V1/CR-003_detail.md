<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-003

## 1. CR Information
- **Parent RFC**: RFC-20260604-PULSE-DYNAMIC-IDENTITY-V1
- **Target Module**: pulse-cli (cli)
- **Target Branch**: feature/dynamic-identity-v1
- **Worktree Required**: No
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Modification
- **Affected Components**: `packages/cli/src/commands/chb.ts`, `packages/cli/src/commands/init.ts`
- **Logic Description**:
    1. ใน `chb.ts`: เปลี่ยนการกำหนด `orchestratorName` ให้ลองดึงจาก `getCurrentOracle()` ก่อนจะ Fallback ไปที่ชื่ออื่น
    2. ใน `init.ts`: ปรับปรุง Prompt ให้แสดงตัวอย่างที่ยืดหยุ่นขึ้น และปรับปรุง `buildRouting` ไม่ให้ Hardcode "Gemi"

## 3. Impact Assessment
- **Integration Impact**: ส่งผลต่อกระบวนการ Handover (chb) และการสร้าง Config ใหม่
- **Regression Risk**: ต่ำ

## 4. Acceptance Criteria
- [ ] คำสั่ง `chb` ใช้ชื่อ Oracle ปัจจุบันเป็น Default ได้ถูกต้อง
- [ ] คำสั่ง `init` ไม่สร้าง Config ที่มีค่า "Gemi" ฝังไว้โดยไม่จำเป็น

## 5. Post-Implementation Report
- **Actual Files Modified**: `packages/cli/src/commands/chb.ts`, `packages/cli/src/commands/init.ts`
- **Methodology**: Line replacement of hardcoded strings with dynamic variables.
- **Status**: Sacred 🛡️

