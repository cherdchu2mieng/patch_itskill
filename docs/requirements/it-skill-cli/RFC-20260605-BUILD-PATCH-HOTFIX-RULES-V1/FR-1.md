<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Integrate Hotfix Rules into Build-Patch Governance

## 1. Description
ปรับปรุงคู่มือ (Documentation) ของทักษะ `/build-patch` ภายในโปรเจกต์ `it-skill-cli` โดยผนวกบทเรียนที่ได้รับจากเหตุการณ์ "Hotfix Phase Jump Violation" เข้าไปเป็นกฎข้อบังคับ (Iron Rules) เพื่อป้องกันการละเมิดกระบวนการในอนาคต

## 2. Requirements
### 2.1 Rule Addition (Hotfix != Bypass)
- เพิ่มกฎเหล็กใหม่ (Iron Rule) ใน `src/skills/build-patch/SKILL.md` ที่ระบุอย่างชัดเจนว่า "ความเร่งด่วนของ Hotfix ไม่สามารถใช้เป็นข้ออ้างในการข้าม Phase Gates ได้"
- ระบุให้ชัดเจนว่า Hotfix เป็นเพียง Change Request ที่มีความสำคัญสูง (P0) ซึ่งยังคงต้องผ่านกระบวนการ Empirical Human Verification (Phase 4) และ Final Cumulative Gate (Phase 5) เสมอ

### 2.2 Zero-Assumption Validation Mandate
- ขยายความในส่วนการตรวจสอบ (Verification) ว่า AI ห้ามทึกทักเอาเองว่าโค้ดทำงานได้จริง เพียงเพราะผ่านการทดสอบ Syntax (`bun test` หรือ `tsc`)
- ต้องระบุให้ AI หยุดรอ (Stop and Wait) และส่งมอบ Acceptance Test Plan (ACP) ให้มนุษย์ทดสอบหน้างานเสมอ

### 2.3 Reference Linking
- สร้างไฟล์ Reference อ้างอิงเหตุการณ์ (เช่น `Ref-002_hotfix_phase_violation.md` ในโฟลเดอร์ `references/` ของ skill) หรือคัดลอกเนื้อหาจากไฟล์ learning ต้นฉบับมาไว้เป็นกรณีศึกษา (Case Study) ให้กับทีม

## 3. Acceptance Criteria
- [ ] ไฟล์ `src/skills/build-patch/SKILL.md` มีการระบุกฎเกณฑ์เรื่อง Hotfix อย่างชัดเจน
- [ ] เมื่ออัปเดตและรัน `it-skill` ทีมงานที่ติดตั้งจะได้อ่านกฎใหม่นี้ผ่านคำสั่งเรียกดูข้อมูล Skill
- [ ] มีไฟล์อ้างอิงถึงเหตุการณ์เก็บไว้ใน Repository ของ `it-skill-cli`
