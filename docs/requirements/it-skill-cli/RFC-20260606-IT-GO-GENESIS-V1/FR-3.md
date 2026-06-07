<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Sacred Lock (FR-3)

## 1. Overview
กลไกการปกป้องทักษะระดับ Governance (Sacred Tools) เพื่อป้องกันไม่ให้ Manager จากค่ายอื่น (เช่น Arra) เข้ามาลบหรือเขียนทับข้อมูลสำคัญของทีม IT

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ล็อคทักษะที่มี `installer: it-skill-cli` ให้อยู่ในสถานะ "Immutable" ต่อระบบอื่น
- แจ้งเตือนและยกเลิกการทำงาน (Abort) หากตรวจพบความพยายามในการเข้าถึงที่ผิดเงื่อนไข

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ใช้ตรรกะ Domain Filtering ในขั้นตอน `cleanup` เพื่อข้ามไฟล์ที่มีลายเซ็นต่างค่าย
- **IG-2 (Operational)**: สร้างความเชื่อมั่นว่า RFC และ Patch ที่สำคัญจะไม่สูญหายจากการอัปเดตทั่วไป

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.3 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. เมื่อเริ่มกระบวนการ Cleanup/Update ให้อ่านลายเซ็นของทุก Skill
2. หากพบ `installer: it-skill-cli` ให้ทำเครื่องหมายเป็น `🛡️ Sacred`
3. ในกระบวนการลบไฟล์ (rm/mv) ให้ข้ามโฟลเดอร์ Sacred ทั้งหมด
4. รายงานในขั้นตอนสรุปว่า "X skills skipped (Sacred Governance)"

## 4. มาตรฐานการแสดงผล (Output Standard)
- ข้อความแจ้งเตือนใน Log: "Skipping Sacred Skill: [name]"
- สถานะใน Dashboard: `🛡️ Sacred`
