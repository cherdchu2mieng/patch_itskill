# Patch Forge Blueprint: IT-Skill CLI Rebranding (v1.0.2) 🛡️🏗️🌊

## 1. Goal
ถอนรากถอนโคน Branding "Soul Brews Studio" และ "Nat Weerawan" ออกจาก `it-skill-cli` และแก้ไขปัญหาการแจกจ่ายผ่าน Private Repo

## 2. Target Files & Inventory
| File | Features Affected | Target Lines/Blocks |
| :--- | :--- | :--- |
| `src/cli/installer.ts` | Identity Transformation | Lines 167, 596, 646, 754-755 |
| `src/cli/commands/about.ts` | Identity Transformation | Line 15 |
| `scripts/compile.ts` | Identity Transformation | Lines 73-74 |
| `install.sh` | Private Repo Fix | Wrapper generation block |
| `package.json` | Metadata Update | `author`, `repository`, `bugs`, `homepage` |
| `LICENSE` | Legal Rebrand | Copyright line |

## 3. Change Request Mapping (v3.0)

### CR-001: Identity String Transformation
- **Payload**: `it_team_identity@v1.0.2.pl`
- **Strategy**: `replace_line` และ `replace_block`
- **Anchors**: ค้นหา "Nat Weerawan" และ "Soul Brews Studio" โดยตรง

### CR-002: Private Repo Distribution Alignment
- **Payload**: `private_repo_fix@v1.0.2.pl`
- **Strategy**: `replace_block` ใน `install.sh`
- **New Logic**: เปลี่ยน `PKG_SPEC` ให้ใช้ URL ที่รองรับ Private Repo (git+ssh) และปรับปรุง Wrapper ให้ตรวจสอบสิทธิ์

### CR-003: Package & Legal Identity Update
- **Payload**: `metadata_rebrand@v1.0.2.pl`
- **Strategy**: `replace_block` ใน `package.json` และ `replace_line` ใน `LICENSE`

### CR-004: Test Suite Alignment (Governance Focus)
- **Payload**: `test_alignment@v1.0.2.pl`
- **Strategy**: `delete_file` (สำหรับไฟล์เจาะจง Arra) และ `replace_block` ในไฟล์ทดสอบที่เหลือ
- **Action**: เปลี่ยนการอ้างอิง `recap`, `trace` เป็น `build-rfc`, `patch-forge`


## 4. Verification Plan
- **Syntax Check**: `bun run compile` ใน Target Repo
- **Functional Check**: 
    - รัน `it-skill about` เพื่อดูผลลัพธ์
    - ตรวจสอบ `SKILL.md` ที่ถูกฉีดใหม่
    - ตรวจสอบเนื้อหาใน `~/.it-skill/bin/it-skill` (Wrapper)
- **Regression Check**: รัน `bun test` เพื่อให้แน่ใจว่าลอจิกการติดตั้งยังคงทำงานได้

---
**Status**: Ready for `bp-Phase 2 confirm`
