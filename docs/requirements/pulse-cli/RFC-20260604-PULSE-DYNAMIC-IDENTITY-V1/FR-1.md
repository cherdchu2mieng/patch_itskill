<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Dynamic Identity Alignment (FR-1)

## 1. Overview
ความต้องการนี้มีวัตถุประสงค์เพื่อเปลี่ยนระบบระบุตัวตนและตรวจสอบสิทธิ์ของ pulse-cli จากระบบที่ผูกติดกับชื่อ "gemi" ให้กลายเป็นระบบที่ยืดหยุ่น (Dynamic) ตามการตั้งค่าในโปรเจกต์จริง

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ระบบต้องสามารถระบุชื่อ Orchestrator จาก Config ได้
- คำสั่ง Read-only ไม่ควรถูกบล็อกโดยระบบตรวจสอบสิทธิ์
- ค่าเริ่มต้น (Defaults) ในการ Handover และการตั้งค่าต้องเปลี่ยนไปตามตัวตนของ Oracle ที่ใช้งานจริง

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: พบการใช้ค่า "gemi" เป็น Fallback เมื่อ Config เป็น undefined
- **IG-2 (Operational)**: ผู้ใช้อื่นที่ไม่ใช่ "gemi" ไม่สามารถใช้งานคำสั่งสำคัญได้เนื่องจากติด Error: Authority Error

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: build-patch

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.1 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. อ่านค่า `orchestrator` จากไฟล์ `pulse.config.json`
2. หากไม่ได้ระบุไว้ ให้ถือว่าไม่มีการจำกัดสิทธิ์ (Allow all authenticated users)
3. ใช้ชื่อ Oracle ปัจจุบัน (`getCurrentOracle()`) เป็นค่าเริ่มต้นในการทำธุรกรรม

## 4. รายละเอียดคำสั่งและ Option (Command Reference)
### 4.1 `pulse triage`
- **พฤติกรรม**: แสดงรายการที่ข้อมูลไม่ครบถ้วน
- **ความต้องการ**: ต้องรันได้โดย Oracle ทุกตัวใน Fleet

### 4.2 `pulse set`
- **พฤติกรรม**: แก้ไขฟิลด์ในบอร์ด
- **ความต้องการ**: จำกัดสิทธิ์เฉพาะ Orchestrator ที่ระบุใน Config (ถ้ามี)

## 5. มาตรฐานการแสดงผล (Output Standard)
- ข้อความแจ้งเตือนสิทธิ์ (Authority Error) ต้องระบุชื่อ Orchestrator ที่ถูกต้องตาม Config
