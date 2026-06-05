# Patch Forge Blueprint: Build-Patch Hotfix Rules (v1.0.3) 🛡️🏗️🌊

## 1. Goal
เพิ่มกฎเหล็ก (Iron Rule) เกี่ยวกับการจัดการ Hotfix เข้าไปในคู่มือของทักษะ `build-patch` เพื่อป้องกันปัญหาการกระโดดข้าม Phase 4 (Human Verification) ในสถานการณ์ฉุกเฉิน

## 2. Target Files & Inventory
| File | Features Affected | Target Lines/Blocks |
| :--- | :--- | :--- |
| `src/skills/build-patch/SKILL.md` | Hotfix Rule Injection | Line 2 (Version update), Line 47 (Append rule 17) |
| `src/skills/build-patch/references/Ref-002_hotfix_phase_jump_violation.md` | Reference Creation | New File |

## 3. Change Request Mapping (v3.0)

### CR-001: Update Build-Patch Documentation & References
- **Payload 1**: `hotfix_rule@v1.0.3.pl`
    - **Strategy**: `replace_line` และ `replace_block`
    - **Action**: เปลี่ยนเวอร์ชันของ `build-patch` จาก v2.8 เป็น v2.9 และแทรกกฎข้อ 17 และ 18 (Reference)
- **Payload 2**: `ref_002_hotfix.md.pl`
    - **Strategy**: `create_file` (via script)
    - **Action**: คัดลอกเนื้อหาจากไฟล์ learning มาวาง

## 4. Verification Plan
- **Syntax Check**: ทักษะไม่มีผลกระทบต่อ TypeScript compile, ตรวจสอบ Markdown rendering
- **Functional Check**: 
    - ไฟล์ `Ref-002_hotfix_phase_jump_violation.md` ถูกสร้างในโฟลเดอร์ที่ถูกต้อง
    - อ่าน `SKILL.md` ต้องพบกฎ "Hotfix != Bypass"

---
**Status**: Ready for `bp-Phase 2 confirm`
