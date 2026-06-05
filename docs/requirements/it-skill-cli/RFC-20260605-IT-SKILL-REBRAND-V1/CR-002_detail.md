<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-002 - Private Repo Distribution Alignment

## 1. CR Information
- **Parent RFC**: RFC-20260605-IT-SKILL-REBRAND-V1
- **Target Module**: it-skill-cli (install.sh, wrapper)
- **Status**: Approved (Tested from human = Sacred)

## 2. Technical Scope
- **Nature of Change**: Distribution Logic Fix
- **Affected Components**:
    - `install.sh`
    - `~/.it-skill/bin/it-skill` (Generated Wrapper)
- **Logic Description**:
    1. ปรับปรุงรูปแบบการเรียก `bunx` ใน Wrapper script ให้รองรับ Private Repo
    2. แทนที่จะใช้ `it-skill@github:itinfosv/it-skill-cli#master` (ซึ่งทำให้เกิด 404 ใน Private Repo) ให้เปลี่ยนไปใช้รูปแบบ URL เต็ม หรือตรวจสอบการใช้งานผ่าน Local Link หากเป็นไปได้
    3. เพิ่มการตรวจสอบการเข้าถึง (Authentication check) หรือแจ้งเตือนผู้ใช้หากไม่มีสิทธิ์ดึงโค้ดจาก Private Repo

## 3. Impact Assessment
- **Integration Impact**: แก้ไขปัญหาหลักที่ทำให้ไม่สามารถรันคำสั่ง `it-skill` ได้
- **Regression Risk**: ปานกลาง (ต้องทดสอบการเรียกใช้งานในสภาพแวดล้อมต่างๆ)

## 4. Acceptance Criteria
- [ ] คำสั่ง `it-skill --version` หรือ `it-skill --help` สามารถทำงานได้โดยไม่ติด Error 404
- [ ] `install.sh` สร้าง Wrapper ที่มีรูปแบบการเรียกใช้งานที่ถูกต้องสำหรับ Private Repo
ort
- **Actual Files Modified**: `install.sh`
- **Methodology**: Replaced the `PKG_SPEC` to use `git+https://` to support accessing the private repository via Git. Also updated the wrapper generation script block.
- **Verification**: Human verified the fix manually by running `it-skill --version` successfully from the system.
- **Status**: Sacred 🛡️
