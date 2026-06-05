# Functional Requirement: Standardize Command and Installation Path (FR-INSTALL-STD-V1)

## 1. Overview
เอกสารฉบับนี้กำหนดมาตรฐานชื่อคำสั่งและเส้นทางการติดตั้งใหม่สำหรับ `it-skill-cli` เพื่อให้สอดคล้องกับแบรนด์ `itinfosv` และลดความซับซ้อนของผู้ใช้งาน

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- เปลี่ยนชื่อคำสั่งหลักจาก `itinfosv-skills` หรือ `arra-itinfosv-skills` เป็น **`it-skill`**
- เปลี่ยนไดเรกทอรีการติดตั้งจาก `~/.itinfosv-skills` เป็น **`~/.it-skill`**
- อัปเดตการตั้งค่า PATH ใน Shell Profile ให้ชี้ไปที่ไดเรกทอรีใหม่

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: การเปลี่ยนชื่อคำสั่งต้องแก้ไขทั้งใน `package.json` (bin field) และใน `install.sh` (INSTALL_DIR variable)
- **IG-2 (Operational)**: ผู้ใช้งานเดิมอาจมี PATH ของไดเรกทอรีเก่าค้างอยู่ ต้องมีการจัดการหรือแจ้งเตือน

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 2 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1.  กำหนดค่าตัวแปร `INSTALL_DIR` ในสคริปต์ติดตั้งเป็น `"$HOME/.it-skill/bin"`
2.  อัปเดตสคริปต์การเพิ่ม PATH ให้ตรวจสอบคำค้นหา `.it-skill/bin` แทนของเดิม
3.  ตรวจสอบและย้าย (Migrate) หรือล้างข้อมูลจากไดเรกทอรีเดิมหากจำเป็น

## 4. รายละเอียดคำสั่งและ Option (Command Reference)
### 4.1 `it-skill`
- **พฤติกรรม**: คำสั่งหลักสำหรับจัดการ Skills ภายใต้มาตรฐาน itinfosv
- **ความต้องการ**: ต้องสามารถรันได้ทันทีหลังจากรันสคริปต์ติดตั้งและ Restart Terminal

## 5. มาตรฐานการแสดงผล (Output Standard)
- ข้อความแจ้งเตือนการติดตั้ง: `✓ Path added to ~/.zshrc` (หรือไฟล์โปรไฟล์ที่เกี่ยวข้อง)
- ไดเรกทอรีการติดตั้งที่ถูกต้อง: `/home/a2it49072/.it-skill/bin`
