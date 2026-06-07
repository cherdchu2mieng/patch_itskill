<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Usage Analytics (FR-4)

## 1. Overview
ระบบรวบรวมและวิเคราะห์สถิติการใช้งานทักษะ (Usage Statistics) โดยครอบคลุมทั้งทักษะสาย Governance และ Productivity เพื่อให้เห็นภาพรวมของกิจกรรมในกองเรือ

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- ขุดข้อมูล (Mining) จากไฟล์ `.jsonl` ในโฟลเดอร์โปรเจกต์ของ Agent
- นับจำนวนครั้งที่คำสั่งถูกเรียกใช้งานแยกรายทักษะ
- รวมสถิติเข้าด้วยกันและแสดงผลใน Dashboard

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ตรรกะเดิมใช้การ `grep` หาคำสำคัญในไฟล์ log session
- **IG-2 (Operational)**: ช่วยให้ Oracle และ Human ทราบว่าเครื่องมือตัวใดมีความสำคัญและถูกใช้งานบ่อยที่สุด

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.4 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. ระบุตำแหน่งจัดเก็บไฟล์ session log ของแต่ละ Agent
2. วนลูปอ่านไฟล์ทุกไฟล์และนับความถี่การใช้คำสั่ง (slash commands)
3. เก็บค่าสถิติลงในหน่วยความจำชั่วคราวขณะแสดงผล Dashboard
4. แสดงตัวเลขจำนวนครั้งการใช้งานในคอลัมน์ "Usage"

## 4. มาตรฐานการแสดงผล (Output Standard)
- คอลัมน์ "Usage" ในตาราง Dashboard แสดงตัวเลขจำนวนครั้ง
- รายงานสรุปจำนวน session ที่ถูกนำมาวิเคราะห์
