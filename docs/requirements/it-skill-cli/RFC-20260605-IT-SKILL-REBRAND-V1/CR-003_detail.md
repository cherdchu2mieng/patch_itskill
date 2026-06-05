<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-003 - Package & Legal Identity Update

## 1. CR Information
- **Parent RFC**: RFC-20260605-IT-SKILL-REBRAND-V1
- **Target Module**: it-skill-cli (root)
- **Status**: Approved (Tested from human = Sacred)

## 2. Technical Scope
- **Nature of Change**: Metadata Update
- **Affected Components**:
    - `package.json`
    - `LICENSE`
- **Logic Description**:
    1. อัปเดตฟิลด์ `author` ใน `package.json` ให้เป็น `itinfosv`
    2. แก้ไข `repository`, `bugs`, `homepage` ใน `package.json` ให้ชี้ไปยัง repo ขององค์กรอย่างถูกต้อง
    3. เปลี่ยนชื่อผู้ถือลิขสิทธิ์ใน `LICENSE` จาก `Nat Weerawan` เป็น `IT TEAM (itinfosv)`

## 3. Impact Assessment
- **Integration Impact**: ทำให้ข้อมูล metadata ของโปรเจกต์ถูกต้องตามกฎหมายและองค์กร
- **Regression Risk**: ต่ำมาก

## 4. Acceptance Criteria
- [ ] `package.json` ไม่มีข้อมูลอ้างอิงถึง Soul Brews Studio
- [ ] `LICENSE` ระบุผู้ถือลิขสิทธิ์เป็นทีม IT Board
ort
- **Actual Files Modified**: `package.json`, `LICENSE`
- **Methodology**: Used `replace_block` in `package.json` to change the `author`, `repository`, `bugs`, and `homepage` metadata. Replaced `Nat Weerawan` with `IT TEAM (itinfosv)` in `LICENSE`.
- **Verification**: Verified via test suite and confirmed visual alignment.
- **Status**: Sacred 🛡️
