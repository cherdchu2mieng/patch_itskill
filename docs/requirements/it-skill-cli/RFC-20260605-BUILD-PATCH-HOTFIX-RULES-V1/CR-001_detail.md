<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Change Request Detail: CR-001 - Update Build-Patch Documentation & References

## 1. CR Information
- **Parent RFC**: RFC-20260605-BUILD-PATCH-HOTFIX-RULES-V1
- **Target Module**: it-skill-cli (src/skills/build-patch)
- **Status**: Pending

## 2. Technical Scope
- **Nature of Change**: Documentation Update
- **Affected Components**:
    - `src/skills/build-patch/SKILL.md`
    - `src/skills/build-patch/references/Ref-002_hotfix_phase_jump_violation.md` (New File)
- **Logic Description**:
    1. **Create Reference File**: คัดลอกเนื้อหาจาก `ψ/memory/learnings/2026-06-05_hotfix_phase_jump_violation.md` ไปสร้างเป็นไฟล์ `Ref-002_hotfix_phase_jump_violation.md` ในโฟลเดอร์ `references/` ของ skill
    2. **Update SKILL.md**:
        - อัปเดตเวอร์ชันของ Skill จาก `v2.8` เป็น `v2.9` (หรือเพิ่มข้อบ่งชี้เวอร์ชันใหม่)
        - เพิ่มข้อความในหมวด **The Iron Rules** (เพิ่มเป็นข้อ 17): "Hotfix != Bypass (v2.9): A hotfix is a Change Request with high priority. It MUST still traverse every single gate. Urgency does not justify suspending the Robust Patching protocol. Empirical human verification (Phase 4) is non-negotiable before merging to main."
        - เพิ่มชื่อไฟล์ `Ref-002_hotfix_phase_jump_violation.md` เข้าไปในหัวข้อ Available Resources หรือส่วนอ้างอิงของ `SKILL.md`

## 3. Impact Assessment
- **Integration Impact**: ข้อมูลกฎเกณฑ์ที่ถูกปรับปรุงจะถูกนำไปใช้งานโดย Agent ที่เรียกคำสั่ง `/build-patch` ทำให้ Agent มีความระมัดระวังมากขึ้นในกรณี Hotfix
- **Regression Risk**: ไม่มี (เป็นการแก้ไขเอกสาร/ข้อความเตือนใจเท่านั้น)

## 4. Acceptance Criteria
- [ ] มีไฟล์ `Ref-002_hotfix_phase_jump_violation.md` อยู่ใน `src/skills/build-patch/references/`
- [ ] ไฟล์ `SKILL.md` ของ `build-patch` มีกฎข้อที่ 17 ระบุถึง "Hotfix != Bypass" อย่างชัดเจน
