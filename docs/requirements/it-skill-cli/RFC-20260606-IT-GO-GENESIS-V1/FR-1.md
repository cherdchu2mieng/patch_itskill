<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Unified Dashboard (FR-1)

## 1. Overview
สร้างระบบแสดงผลรวมศูนย์ (Unified Dashboard) ที่สามารถแสดงรายการทักษะ (Skills) ทั้งหมดจากทั้งฝั่ง Arra และ IT-SKILL ได้ในตารางเดียวกัน โดยมีการแยกหมวดหมู่และระบุผู้จัดการ (Manager) ชัดเจน

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- พัฒนาระบบสแกน Directory `~/.gemini/skills/`
- อ่าน `installer:` จาก `SKILL.md` เพื่อแยกแยะ `[IT]` vs `[A]`
- จัดกลุ่มแสดงผลตามหมวดหมู่ Governance, Infrastructure, และ Productivity

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ตรรกะเดิมใน `/go` สามารถนำมา Fork และขยายความสามารถในการอ่าน Metadata ได้
- **IG-2 (Operational)**: ผู้ใช้จะเห็นภาพรวมของเครื่องมือทุกลำดับใน Fleet ผ่านคำสั่งเดียว (`/itgo`)

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.1 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. สแกนทุก sub-directory ใน `~/.gemini/skills/`
2. ดึงค่า `name`, `installer`, `version` และสถิติการใช้งาน
3. กรองข้อมูลตาม `installer` signature
4. จัดเรียงลำดับโดยให้ Governance [IT] อยู่ลำดับบนสุด

## 4. มาตรฐานการแสดงผล (Output Standard)
- ตาราง Markdown ที่มีคอลัมน์: #, Skill, Manager, Version, Status, Usage
- Banner หัวข้อ: "🛡️ IT TEAM Sovereign Fleet Dashboard"
