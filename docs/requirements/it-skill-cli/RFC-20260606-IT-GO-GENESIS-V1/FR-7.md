<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Shell Integration (FR-7)

## 1. Overview
การเชื่อมโยงเครื่องมือของทีม IT เข้ากับ Shell ของระบบโดยอัตโนมัติ เพื่อให้ผู้ใช้สามารถเรียกใช้คำสั่ง `it-skill` และ `itgo` ได้สะดวกผ่าน alias และ PATH ที่ถูกต้อง

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ฉีดการตั้งค่า `export PATH` ลงใน `.bashrc` หรือ `.zshrc`
- สร้างคำสั่งย่อ (Aliases) สำหรับคำสั่งที่ใช้บ่อย
- ป้องกันการฉีดข้อมูลซ้ำซ้อน (Idempotency)

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ตรวจสอบ `$SHELL` เพื่อเลือกไฟล์คอนฟิกที่ถูกต้อง
- **IG-2 (Operational)**: ทำให้เครื่องมือพร้อมใช้งานทันทีหลังติดตั้งโดยไม่ต้องทำ manual setup

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.7 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. ตรวจสอบประเภท Shell ที่ผู้ใช้ใช้งาน
2. ค้นหาไฟล์คอนฟิกที่เกี่ยวข้อง (`.zshrc`, `.bashrc`, `.profile`)
3. ตรวจสอบว่ามีการฉีดบรรทัด "IT-SKILL Config Block" ไว้หรือยัง
4. หากยังไม่มี ให้ทำการต่อท้าย (Append) บล็อกการตั้งค่ามาตรฐาน

## 4. มาตรฐานการแสดงผล (Output Standard)
- ข้อความแจ้งเตือน: "Shell configuration updated. Please restart terminal."
- การแสดงสถานะใน Dashboard: "Shell Integration: ✅"
