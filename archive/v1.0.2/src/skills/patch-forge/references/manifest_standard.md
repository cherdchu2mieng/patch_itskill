# Patch Manifest Standard (v4.0 Declarative) 📜

## 1. Overview
`patch.manifest.json` คือ "สมองกลาง" ของ Patch Workspace ทำหน้าที่เก็บประวัติเวอร์ชัน (Timeline), ประเภทการแพตช์ (Full vs Single), และแผนผังการเชื่อมโยงไฟล์ (File Mapping) เพื่อให้ Orchestrator ทำงานได้อย่างอัตโนมัติ

## 2. Manifest Schema & Template
รูปแบบและโครงสร้างทั้งหมดของ `patch.manifest.json` สามารถดูได้จากไฟล์ Template สองตัวนี้:
- [patch.manifest.example.json](patch.manifest.example.json): ตัวอย่างโครงสร้างหลักที่เก็บประวัติและไฟล์ที่เปลี่ยนแปลง
- [feature_config.example.json](feature_config.example.json): ตัวอย่างโครงสร้างการเก็บข้อมูล Feature Flags และ Data Parameters

**ข้อสังเกตสำคัญใน Schema:**
- **timestamp**: ใช้ระบุเวลาที่มีการอัปเดตล่าสุด
- **features**: (อยู่ภายใต้แต่ละเวอร์ชัน หรือเป็น Config แยก) ใช้กำหนดพฤติกรรมการเปิด/ปิด (Feature Toggle) เพื่อให้สอดคล้องกับหลักการ Open-Closed Principle (OCP)
- **data**: เก็บค่าพารามิเตอร์เริ่มต้นที่ผูกติดมากับ Patch

## 3. Workflow: Init vs. Update

### A. Initialization (เมื่อไม่มี Manifest)
หากใน Patch Workspace ยังไม่มีไฟล์นี้ ให้ใช้ Skill `patch-forge` สร้างขึ้นมาใหม่เป็นอันดับแรก:
1.  **Analyze Current State**: กวาดดูประวัติใน `HISTORY.md` และโฟลเดอร์ `payloads/` เพื่อดึงข้อมูลเวอร์ชันล่าสุด
2.  **Define Base Version**: กำหนดเวอร์ชันที่เสถียรที่สุดเป็น `v8.0` (Full Package)
3.  **Create File**: ใช้คำสั่ง `write_file` สร้าง `patch.manifest.json` ที่ Root ของ Workspace

### B. Update (เมื่อมีการสร้าง Patch ใหม่)
ทุกครั้งที่สร้าง `.pl` ใหม่ผ่าน `patch-forge`:
1.  **Check Manifest**: อ่าน `patch.manifest.json` เดิม
2.  **Append History**: เพิ่ม Object เวอร์ชันใหม่เข้าไปใน `history`
3.  **Update Current**: เปลี่ยนฟิลด์ `current_active_version` ให้เป็นเวอร์ชันล่าสุด
4.  **Sync Header**: ตรวจสอบว่า `description` และ `files_mapping` ตรงกับความตั้งใจของ RFC

## 4. Orchestrator Integration
ในอนาคต สคริปต์ `.sh` จะต้องเปลี่ยนจาก "Hardcoded Loops" มาเป็นการอ่าน `history[current_active_version].files_mapping` จาก Manifest นี้โดยตรงเพื่อดำเนินการฉีดโค้ด
