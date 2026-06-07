<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# Functional Requirement: Sovereign Precedence (FR-8)

## 1. Overview
กฎลำดับความสำคัญของอธิปไตย (Sovereign Precedence) เพื่อตัดสินปัญหาในกรณีที่เกิดทักษะชื่อซ้ำกันระหว่างฝั่ง Arra และ IT-SKILL โดยให้สิทธิ์เครื่องมือของทีม IT เป็นอันดับหนึ่งเสมอ

## 2. Scope Consensus (The 4-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- พัฒนาตรรกะการจัดการข้อขัดแย้ง (Conflict Resolution)
- เมื่อตรวจพบทักษะชื่อเดียวกัน ให้เลือกใช้เวอร์ชันของ `[IT]` ในการประมวลผลหลัก

### 2.2 Information Gathering (Research)
- **IG-1 (Technical)**: ใช้ลำดับการโหลด (Loading Order) หรือการสร้าง Wrapper เพื่อครอบทับทักษะเดิม
- **IG-2 (Operational)**: มั่นใจว่านโยบายและกฎขององค์กรจะถูกบังคับใช้ก่อนเครื่องมือทั่วไปเสมอ

### 2.3 Implementation Governance (Layer 4)
- **Execution Skill**: `build-patch`

### 2.4 Pathway (Confirmation)
- **Confirm Command**: **`brfc-Phase 3.8 confirm`**

## 3. ตรรกะการทำงานหลัก (Core Logic)
1. ในขั้นตอนการรันคำสั่ง ให้ค้นหาทักษะจากทุก Directory
2. หากพบชื่อซ้ำ ให้ตรวจสอบลายเซ็น `installer:`
3. หากมีตัวหนึ่งเป็น `it-skill-cli` ให้เลือกตัวนั้นเป็นตัวทำงานหลัก
4. ทำการย้ายตัวที่เหลือไปเป็นสถานะ "Shadowed" และแจ้งผู้ใช้ทราบ

## 4. มาตรฐานการแสดงผล (Output Standard)
- รายงานใน Log: "Conflict detected for [name]. Prioritizing IT-SKILL version."
- ใน Dashboard จะแสดงสถานะพิเศษให้เห็นว่ามีการ Shadow เกิดขึ้น
