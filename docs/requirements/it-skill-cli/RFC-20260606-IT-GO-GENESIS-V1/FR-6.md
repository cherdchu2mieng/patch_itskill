<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Cross-Agent Sync (FR-6)

## 1. Overview
ฟีเจอร์การกระจายทักษะคุมกฎ (Governance Skills) ไปยังทุก AI Agent ที่ตรวจพบในเครื่อง (Claude, Gemini, Codex) เพื่อให้มั่นใจว่ามาตรฐานการทำงานเป็นหนึ่งเดียวกันทั่วทั้งระบบ

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ตรวจหา Directory ของ Agent ต่างๆ (Auto-detection)
- คัดลอกและซิงโครไนซ์ทักษะกลุ่ม `[IT]` ไปยังทุก Agent target
- รักษาความสม่ำเสมอของเวอร์ชันในทุกช่องทาง

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ตรวจสอบพาธมาตรฐานของแต่ละ Agent (`~/.claude`, `~/.gemini`, `~/.codex`)
- **IG-2 (Operational)**: ผู้ใช้สามารถสลับไปทำงานใน Agent ใดก็ได้โดยมีเครื่องมือชุดเดิมรออยู่เสมอ

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.6 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. กำหนดรายการ Agent ที่รองรับและพาธมาตรฐาน
2. ตรวจสอบว่าในเครื่องมีการติดตั้ง Agent ตัวใดบ้าง
3. เมื่อมีการอัปเดตทักษะ `[IT]` ให้คัดลอกไฟล์ไปยังโฟลเดอร์ `skills/` ของทุก Agent
4. ตรวจสอบความสำเร็จในการเขียนไฟล์ (Write Verification)

## 4. มาตรฐานการแสดงผล (Output Standard)
- รายงานการซิงค์: "Syncing to Claude... Done", "Syncing to Gemini... Done"
- แจ้งเตือนหาก Agent ใดมีปัญหาในการเขียนไฟล์
