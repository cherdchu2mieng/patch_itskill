<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# RFC Master Specification: RFC-20260605-IT-SKILL-REBRAND-V1

## 1. Document Control
- **Project**: it-skill-cli
- **RFC ID**: RFC-20260605-IT-SKILL-REBRAND-V1
- **Priority**: P1 (High)
- **Requester**: Human
- **Approver**: Human (cherdchu2mieng)
- **Responsible Agent**: Gemi 🌊
- **Patch Workspace**: /home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill
- **Target Repo**: itinfosv/it-skill-cli
- **Structure**: ψ/writing/it-skill-cli/RFC-20260605-IT-SKILL-REBRAND-V1/
- **Stability Impact**: Medium
- **Security Level**: Standard
- **Target Version**: v1.0.2
- **Status**: Closed (Implementation Verified)

## 2. Scope Consensus (The 3-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
เป้าหมายของ RFC นี้คือการทำ Rebranding โปรเจกต์ `it-skill-cli` ให้เป็นเอกเทศจาก `arra-oracle-skills` อย่างสมบูรณ์ เพื่อลดความสับสนของผู้ใช้งาน และแก้ไขปัญหาทางเทคนิคในการแจกจ่าย (Distribution) ผ่าน Private Repository ของทีม IT Board

### 2.2 Human Supplemental Input
- เปลี่ยน "Nat Weerawan's brain" เป็น "IT TEAM Standard"
- เปลี่ยนชื่อองค์กรจาก "Soul Brews Studio" เป็น "itinfosv" หรือ "IT TEAM"
- แก้ไขปัญหา `bunx` 404 เมื่อเรียกใช้งานผ่าน Private Repo ของ itinfosv

### 2.3 Information Gathering (Research)
- **IG-1 (Technical Baseline)**: ตรวจพบ Branding เดิมในไฟล์ `installer.ts`, `compile.ts`, `about.ts`, และ `LICENSE`
- **IG-2 (Operational Constraints)**: `bunx` ต้องการสิทธิ์เข้าถึงหรือรูปแบบ URL เฉพาะสำหรับ Private Repo เพื่อหลีกเลี่ยง Error 404
- **IG-3 (Governance)**: ต้องรักษามาตรฐานการทำงานแบบ Governance-only สำหรับทีม IT Board

## 3. Functional Requirements (FR) Portfolio
| FR ID | Title | Detail File | Status |
| :--- | :--- | :--- | :--- |
| FR-1 | Identity Rebranding & Private Repo Alignment | FR-1.md | Confirmed |

## 4. Change Request (CR) Portfolio
| CR ID | Module | Technical Objective | Detail File | Status |
| :--- | :--- | :--- | :--- | :--- |
| CR-001 | src, scripts | Identity String Transformation | CR-001_detail.md | Confirmed |
| CR-002 | install.sh | Private Repo Distribution Alignment | CR-002_detail.md | Confirmed |
| CR-003 | root | Package & Legal Identity Update | CR-003_detail.md | Confirmed |
| CR-004 | __tests__ | Test Suite Alignment (Governance Focus) | CR-004_detail.md | Confirmed |

## 5. Risk & Mitigation
- **Risk**: ผู้ใช้งานไม่สามารถอัปเดตคำสั่งได้เนื่องจากติดสิทธิ์ Private Repo
- **Mitigation**: ปรับปรุงคำแนะนำใน `install.sh` และใช้รูปแบบ URL ที่รองรับการ Authentication (เช่น git+ssh หรือ Personal Access Token หากจำเป็น)
## 6. RFC-Level Summary (Post-Closure)
- **Total Duration**: ~2 hours
- **Closure Status**: All CRs (CR-001, CR-002, CR-003, CR-004) successfully implemented, verified by Human, and locked as Sacred. Code delivered to `itinfosv/it-skill-cli` under tag `v1.0.2`.
- **Note**: This RFC effectively decoupled the IT Board distribution logic from the Soul Brews Studio upstream, establishing a clean, independent identity and an aligned test suite.
