<!-- MANDATORY: All updates and additions to this document MUST strictly follow the /build-rfc skill methodology. -->
# RFC Master Specification: RFC-20260605-BUILD-PATCH-HOTFIX-RULES-V1

## 1. Document Control
- **Project**: it-skill-cli
- **RFC ID**: RFC-20260605-BUILD-PATCH-HOTFIX-RULES-V1
- **Priority**: P1 (High)
- **Requester**: Human
- **Approver**: Human (cherdchu2mieng)
- **Responsible Agent**: Gemi 🌊
- **Patch Workspace**: /home/a2it49072/ghq/github.com/cherdchu2mieng/patch_itskill
- **Target Repo**: itinfosv/it-skill-cli
- **Structure**: ψ/writing/it-skill-cli/RFC-20260605-BUILD-PATCH-HOTFIX-RULES-V1/
- **Stability Impact**: Low (Governance Documentation)
- **Security Level**: Standard
- **Target Version**: v1.0.3
- **Status**: Draft (Pending Phase 4 Confirm)

## 2. Scope Consensus (The 3-Layer Logic)

### 2.1 Requirement Mapping (AI Synthesis)
เป้าหมายของ RFC นี้คือการผนวกบทเรียนที่ได้จากเหตุการณ์ละเมิดกระบวนการ (Phase Jump Violation) ในระหว่างการทำ Hotfix เข้าไปเป็นกฎข้อบังคับ (Iron Rules) ของทักษะ `/build-patch` ภายในโปรเจกต์ `it-skill-cli` เพื่อกระจายความรู้นี้ให้กับทีมงานทั้งหมด

### 2.2 Human Supplemental Input
- ใช้บทเรียนจากไฟล์ `2026-06-05_hotfix_phase_jump_violation.md` เป็นพื้นฐาน
- ต้องให้ทักษะระบุชัดเจนว่า "ความเร่งด่วนไม่ได้แปลว่าสามารถข้าม Gate ได้ (Hotfix != Bypass)"

### 2.3 Information Gathering (Research)
- **IG-1 (Technical Baseline)**: ทักษะ `/build-patch` ถูกเก็บไว้ที่ `src/skills/build-patch/SKILL.md` และใช้ไฟล์อ้างอิงจากโฟลเดอร์ `references/`
- **IG-2 (Operational Constraints)**: การอัปเดตไฟล์ Markdown ในโครงสร้างนี้ไม่มีผลกระทบต่อลอจิกการทำงานของ TypeScript แต่มีผลต่อ System Prompt ของ Agent 
- **IG-3 (Governance)**: สอดคล้องกับเป้าหมายขององค์กรในการพัฒนาระบบที่มีความทนทานและตรวจสอบได้ (Robustness and Traceability)

## 3. Functional Requirements (FR) Portfolio
| FR ID | Title | Detail File | Status |
| :--- | :--- | :--- | :--- |
| FR-1 | Integrate Hotfix Rules into Build-Patch Governance | FR-1.md | Confirmed |

## 4. Change Request (CR) Portfolio
| CR ID | Module | Technical Objective | Detail File | Status |
| :--- | :--- | :--- | :--- | :--- |
| CR-001 | src/skills/build-patch | Update Build-Patch Documentation & References | CR-001_detail.md | Confirmed |

## 5. Risk & Mitigation
- **Risk**: ไม่มี
- **Mitigation**: การอัปเดตเนื้อหาเอกสารจะส่งผลเชิงบวกต่อการควบคุม Agent โดยไม่มีผลข้างเคียงต่อระบบประมวลผลหลัก
