<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Multi-CLI Health (FR-2)

## 1. Overview
ระบบตรวจสอบสุขภาพและความพร้อมของเครื่องมือ Command Line Interface (CLI) ทั้งหมดในกองเรือ เพื่อให้แน่ใจว่าทั้ง `it-skill` และ `arra-oracle-skills` พร้อมทำงาน

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ตรวจสอบการมีอยู่ของ Binary ใน PATH
- ตรวจสอบความถูกต้องของ Symlink ใน `~/.it-skill/bin` และ `~/.oracle-skills/bin`
- รายงานเวอร์ชันปัจจุบันของ CLI แต่ละตัว

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ใช้คำสั่ง `command -v` และ `ls -l` ในการตรวจสอบสถานะไฟล์
- **IG-2 (Operational)**: ช่วยลดปัญหา "command not found" และแจ้งเตือนเมื่อระบบไม่ได้ตั้งค่า PATH อย่างถูกต้อง

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.2 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. ระบุรายการ Binary ที่ต้องตรวจสอบ (`it-skill`, `arra-oracle-skills`)
2. ใช้ Shell command ตรวจสอบพาธที่ติดตั้งจริง
3. เปรียบเทียบกับพาธมาตรฐาน (Standard Paths)
4. แสดงผลเป็นเครื่องหมาย ✅ หรือ ❌ ใน Dashboard

## 4. มาตรฐานการแสดงผล (Output Standard)
- หมวดหมู่ "📡 Fleet Environment" ใน Dashboard
- แสดงสถานะแยกราย CLI พร้อมระบุ Version และ Path
