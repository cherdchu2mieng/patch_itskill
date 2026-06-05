# Functional Requirement: Lightweight Bash Wrapper Implementation (FR-WRAPPER-ONLY-V1)

## 1. Overview
เอกสารฉบับนี้กำหนดให้เปลี่ยนรูปแบบการกระจายซอฟต์แวร์จากการดาวน์โหลด Binary ขนาดใหญ่ (98MB) เป็นการสร้าง Bash Wrapper ขนาดเล็กที่เรียกใช้งานผ่าน `bunx` เพื่อความรวดเร็วและความคล่องตัวในการอัปเดต

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ยกเลิกการดาวน์โหลดไฟล์ Binary (ELF) ในสคริปต์ติดตั้ง
- สร้างไฟล์ Bash script ขนาดเล็กชื่อ `it-skill` ในไดเรกทอรีติดตั้งแทน
- ใช้คำสั่ง `exec bunx --bun it-skill@github:...` ภายในสคริปต์ Wrapper

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ตรวจสอบความพร้อมของ `bun` ในเครื่องผู้ใช้ก่อนสร้าง Wrapper
- **IG-2 (Operational)**: การใช้ Wrapper จะทำให้การรันครั้งแรกอาจช้ากว่า Binary เล็กน้อยเนื่องจากต้องดาวน์โหลดแพ็กเกจ แต่จะง่ายต่อการแก้ไข Bug แบบ Hot-fix

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 2 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1.  **Force Cleanup**: ลบไฟล์ `it-skill` เดิมที่อาจเป็น Binary ขนาดใหญ่ออกก่อน
2.  **Wrapper Generation**: เขียนเนื้อหา Bash script ลงในไฟล์ `it-skill`
3.  **Permission Setting**: กำหนดสิทธิ์ให้ไฟล์สามารถรันได้ (`chmod +x`)

## 4. รายละเอียดคำสั่งและ Option (Command Reference)
### 4.1 เนื้อหา Wrapper Script
```bash
#!/bin/bash
# IT-Skill CLI — bunx wrapper (v1.0.1)
exec bunx --bun it-skill@github:cherdchu2mieng/itinfosv-skill-cli#v1.0.1 "$@"
```

## 5. มาตรฐานการแสดงผล (Output Standard)
- ยืนยันการสร้าง Wrapper: `✅ Wrapper installed: ~/.it-skill/bin/it-skill`
- ขนาดไฟล์ต้อง < 1KB
