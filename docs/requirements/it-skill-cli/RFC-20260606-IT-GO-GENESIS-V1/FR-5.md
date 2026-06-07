<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Auto-Repair (FR-5)

## 1. Overview
ระบบซ่อมแซมโครงสร้างพื้นฐานอัตโนมัติ เพื่อแก้ไขปัญหาความเชื่อมโยงของระบบ (Broken Symlinks) หรือการตั้งค่าสภาพแวดล้อม (Environment) ที่ไม่ถูกต้องสำหรับทีม IT

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ตรวจสอบความสมบูรณ์ของไฟล์ใน `~/.it-skill/bin`
- ตรวจหา Symlinks ที่ขาด (Broken Links)
- ดำเนินการสร้างลิงก์ใหม่หรือแก้ไข PATH หากตรวจพบปัญหา

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ใช้คำสั่ง `ln -sf` และการตรวจสอบสิทธิ์ไฟล์ (File Permissions)
- **IG-2 (Operational)**: ลดภาระของผู้ใช้ในการซ่อมแซมระบบด้วยตนเองหลังการอัปเดต OS หรือย้ายโฟลเดอร์

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.5 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. สแกนรายการไฟล์มาตรฐานใน `bin/` directory
2. ตรวจสอบว่าแต่ละไฟล์ชี้ไปยังต้นทางที่ถูกต้องหรือไม่
3. หากพบปัญหา ให้แจ้งเตือนและขออนุมัติซ่อมแซม
4. รันคำสั่งซ่อมแซมและตรวจสอบผลลัพธ์อีกครั้ง

## 4. มาตรฐานการแสดงผล (Output Standard)
- สถานะ "Repairing..." พร้อมรายละเอียดไฟล์ที่ถูกแก้ไข
- สรุปผล: "Environment repaired successfully."
