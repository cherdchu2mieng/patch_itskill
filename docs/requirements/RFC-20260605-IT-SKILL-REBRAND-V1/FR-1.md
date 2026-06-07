<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Identity Rebranding & Private Repo Alignment

## 1. Description
ปรับปรุงตัวตน (Branding) ของ `it-skill-cli` ให้แยกออกจาก `arra-oracle-skills` อย่างชัดเจน โดยการเปลี่ยนข้อความอ้างอิงถึงบุคคลและองค์กรเดิม และแก้ไขปัญหาการแจกจ่าย (Distribution) ใน Private Repository

## 2. Requirements
### 2.1 Identity Transformation
- เปลี่ยนคำว่า "Nat Weerawan's brain" เป็น "IT TEAM Standard" ในทุกจุด
- เปลี่ยนชื่อองค์กรจาก "Soul Brews Studio" เป็น "itinfosv" หรือ "IT TEAM"
- ปรับปรุง Header ใน `SKILL.md` ที่ถูกฉีดโดย Installer ให้ระบุที่มาเป็น "IT TEAM"

### 2.2 Distribution Fix (Private Repo Support)
- แก้ไขปัญหา `bunx` 404 เมื่อพยายามดึงโค้ดจาก Private Repo `itinfosv/it-skill-cli`
- ปรับปรุง Wrapper script (`it-skill`) ให้สามารถทำงานได้จริงแม้จะเป็น Private Repo

### 2.3 Visual & Logic Separation
- ตรวจสอบว่าไม่มี Logic หรือข้อความใดๆ ที่ทำให้ผู้ใช้สับสนกับ `arra-oracle-skills`
- ตรวจสอบ `package.json` และ `LICENSE` ให้มีความเป็นเอกเทศ

## 3. Acceptance Criteria
- [ ] เมื่อรัน `it-skill about` หรือดูไฟล์ที่ติดตั้ง จะไม่เห็นชื่อ "Nat Weerawan" หรือ "Soul Brews Studio"
- [ ] คำสั่ง `it-skill` สามารถติดตั้งและอัปเดตได้ผ่าน Private Repo ขององค์กร
- [ ] Installer ฉีด Header ที่ระบุที่มาเป็น "IT TEAM" สำเร็จ
