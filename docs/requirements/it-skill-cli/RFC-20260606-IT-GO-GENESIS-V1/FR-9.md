<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Self-Healing (VFS) (FR-9)

## 1. Overview
ระบบกู้คืนตัวเองอัตโนมัติโดยใช้ Virtual File System (VFS) เพื่อให้ทักษะ `/itgo` และเครื่องมือ Governance สามารถซ่อมแซมไฟล์ที่เสียหายหรือสูญหายได้จากภายในตัว Binary เอง

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ฝังโค้ดและทรัพยากรของทักษะไว้ใน VFS ขณะ Compile
- พัฒนาระบบตรวจสอบความสมบูรณ์ (Integrity Check) ทุกครั้งที่รันคำสั่ง
- เขียนไฟล์ใหม่จาก VFS หากตรวจพบความเสียหาย

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ใช้ระบบ `IS_COMPILED` และ `generate-vfs.ts` ของ Bun ในการฝังทรัพยากร
- **IG-2 (Operational)**: ประกันว่าระบบการคุมกฎจะ "ไม่มีวันพัง" แม้ไฟล์ในเครื่องจะถูกลบทิ้งไป

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.9 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. ขณะรันคำสั่ง ให้ตรวจสอบไฟล์ `SKILL.md` ในดิสก์
2. หากไฟล์หายไปหรือว่างเปล่า ให้ดึงเนื้อหาต้นฉบับจาก VFS ในตัว Binary
3. เขียนไฟล์กลับลงไปยังตำแหน่งที่ถูกต้อง
4. แจ้งเตือนผู้ใช้ว่ามีการกู้คืนไฟล์เกิดขึ้น

## 4. มาตรฐานการแสดงผล (Output Standard)
- สถานะใน Log: "Restoring [name] from VFS..."
- ข้อความแจ้งเตือน: "System integrity restored."
