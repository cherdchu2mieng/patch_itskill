<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# RFC Master Specification: RFC-20260604-PULSE-DYNAMIC-IDENTITY-V1

## 1. Document Control
- **Project**: pulse-cli
- **RFC ID**: RFC-20260604-PULSE-DYNAMIC-IDENTITY-V1
- **Priority**: P1
- **Requester**: Human
- **Approver**: Human (cherdchu2mieng)
- **Responsible Agent**: Gemi 🌊
- **Patch Workspace**: /home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill
- **Target Repo**: itinfosv/pulse-cli
- **Structure**: ψ/writing/pulse-cli/RFC-20260604-PULSE-DYNAMIC-IDENTITY-V1/
- **Stability Impact**: Medium
- **Security Level**: Standard
- **Target Version**: v8.5.1
- **Status**: Open

## 2. Scope Consensus (The 3-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
- กำจัดค่า Hardcoded "gemi" ในระบบตรวจสอบสิทธิ์และคำสั่งต่างๆ ของ pulse-cli เพื่อให้รองรับ Oracle ชื่ออื่นๆ และการใช้งานข้ามสภาพแวดล้อมได้แบบ Dynamic

### 2.2 Human Supplemental Input
- เน้นการดึงค่าจาก Configuration (`pulse.config.json`) และ Environment แทนการใช้ค่าคงที่

### 2.3 Information Gathering (Research)
- **IG-1 (Technical Baseline)**: ตรวจพบ "gemi" ใน `config.ts`, `init.ts`, และ `chb.ts`
- **IG-2 (Integration Points)**: ฟังก์ชัน `enforceAuth` ถูกเรียกใช้ใน `set`, `triage`, และ `blog`
- **IG-3 (Operational Constraints)**: ต้องรักษาความปลอดภัย (Authority Gate) ไว้สำหรับคำสั่งที่มีการแก้ไขบอร์ด (Write operations) แต่ผ่อนปรนสำหรับ Read operations

## 3. Change Request (CR) Portfolio
| CR ID | Module | Technical Objective | Detail File | Status |
| :--- | :--- | :--- | :--- | :--- |
| CR-001 | pulse-cli | Refactor Authority Gate & Config Logic | CR-001_detail.md | Pending |
| CR-002 | pulse-cli | Triage Command Liberation | CR-002_detail.md | Pending |
| CR-003 | pulse-cli | Dynamic Handover & Init Defaults | CR-003_detail.md | Pending |

## 4. RFC-Level Summary (Post-Closure)
- **Total Duration**: ---
- **Total Token Cost**: ---
