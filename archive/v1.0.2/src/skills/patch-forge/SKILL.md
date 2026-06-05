---
name: patch-forge
description: Generate Robust Patching Architecture (v3.0) components. Use this skill to design and create .pl (payload) and .sh (orchestrator) files for pulse-cli and other fleet components, ensuring manifest-driven idempotency and clean-first deployment.
---

# [itinfosv] Patch Forge 🛡️🌊 (โรงหล่อแพตช์: ตีขึ้นรูปอย่างประณีตและแข็งแกร่ง)

## Overview
Patch Forge คือ "โรงหล่อ" เฉพาะทางสำหรับ **Robust Patching (v3.0)** ที่เน้นการสร้าง Patch อย่างประณีต (Precision) และแข็งแกร่งดุจเหล็กกล้า (Ironclad) เพื่อลดความผิดพลาด (Regression) ในกองทัพ Oracle

## Workflow: Creating a New Patch

### Phase 1: Manifest Management (The Brain: Source of Truth) 🧠
- ตรวจสอบ `patch.manifest.json` ใน Patch Workspace
- หากไม่มี: ให้ใช้โครงสร้างตาม [references/manifest_standard.md](references/manifest_standard.md) เพื่อสร้างใหม่ (Init)
- หากมีอยู่แล้ว: ให้อัปเดตเวอร์ชัน, ไฟล์ที่เกี่ยวข้อง และ **Feature Flags** (ภายใต้ `features`) ลงใน `history` และ `current_active_version` (Update)

### Phase 2: Research & Baseline (The Blueprint: การวางแผนและวิเคราะห์) 🔍
#### 2.1 Version & Strategy Identification
- ระบุสถานะของงาน: เป็นการเริ่มใหม่จากฐาน (**Base/Full Package**) หรือเป็นการปรับปรุงย่อย (**Incremental/Single Patch**)
- สำหรับ **Base (v8.0)**: ต้องระบุไฟล์รากฐานทั้งหมดที่เสถียรที่สุด (เช่น `add.ts`, `config.ts`, `pulse.ts`) เพื่อเตรียมทำ Snapshot
- สำหรับ **Incremental**: ตรวจสอบ `current_active_version` ใน Manifest เพื่อกำหนดเวอร์ชันถัดไปและระบุไฟล์เป้าหมายที่ต้องแก้ไขจริง
- ระบุชื่อฟังก์ชัน (Target Function) ที่จะได้รับผลกระทบเพื่อใช้ในการตั้งชื่อ Feature

#### 2.2 Strategy & Standards Alignment
- **OCP Compliance**: ประเมินว่าการ Patch เป็นการ "ขยาย" (Extend) หรือ "รื้อ" (Modify) - *พยายามเลี่ยงการรื้อลอจิกเดิม*
- **Feature Toggling**: หากเป็นการถอดฟีเจอร์ ให้พิจารณาใช้ **Feature Flags** แทนการลบโค้ดทิ้ง
- **Deprecation Policy**: หากจำเป็นต้องลบจริง ต้องผ่านขั้นตอน `@deprecated`
- **Anchor Stability**: เลือกจุดยึด (Surgical/Block) ที่มั่นคงและไม่กระทบต่อ OCP

#### 2.3 Technical Integrity & Verification
- **Strict Typing**: ตรวจสอบว่า Payload ไม่ใช้ `any` และมีการนิยาม `interface/type` ที่ชัดเจน
- **Testing Mandate**: วางแผนการทำ **Integration Test** (`bun test`) เพื่อล็อคพฤติกรรมระหว่างไฟล์ที่เกี่ยวข้อง
- **Baseline Verification**: ตรวจสอบ Manifest Tag ของเวอร์ชันก่อนหน้า

#### 2.4 Functional Analysis & Design
- **Inventory Check**: สำรวจและนับจำนวนฟังก์ชันทั้งหมดในไฟล์เป้าหมาย
- **Target Scoping**: ระบุฟังก์ชันเป้าหมายหลัก (Target Function) อย่างชัดเจน
- **Mapping Plan**: วางแผนการลงข้อมูลใน `patch.manifest.json`
- **Blueprint Prep**: เตรียมข้อมูลสำหรับสร้างไฟล์ `.pl` และ `.sh`
- **Impact Assessment**: ตรวจสอบผลกระทบต่อตัวแปร, การนำเข้า (Imports), และการเชื่อมโยงข้ามฟังก์ชัน

### Phase 3: Create the Payload (.pl) — (The Foundry: ขั้นตอนการหล่อชิ้นงาน) ⚒️

#### 3.1 Payload Isolation
- สร้างไฟล์ชื่อ `<feature>@<version>.pl` ไว้ในโฟลเดอร์ `payloads/`
- **Pure Code**: บรรจุเฉพาะโค้ด TypeScript/JavaScript ที่ต้องการฉีดจริง **ห้ามมี Metadata หรือคอมเมนต์จาก Bash/Python**
- **No Escaping**: เขียนโค้ดแบบดิบๆ เหมือนเขียนใน Editor ปกติ

#### 3.2 Standard Compliance
- **OCP Check**: ตรวจสอบว่าโค้ดที่เขียนเป็นการเพิ่มพฤติกรรมใหม่ หรือไปรื้อโครงสร้างเดิม
- **Feature Flag Injection**: หากเป็นฟีเจอร์ที่ต้องการเปิด/ปิดได้ ให้ครอบโค้ดด้วยเงื่อนไขที่ดึงค่ามาจากคอนฟิก
- **Strict Typing**: ตรวจสอบว่ามีการนิยาม `interface` หรือ `type` ครบถ้วน

#### 3.3 Successor Logic
- หากเป็นการแก้ทับฟังก์ชันเดิม (Supersede) ในเวอร์ชันใหม่:
    - ให้ Copy โค้ดเดิมที่ยังใช้ได้มารวมกับโค้ดใหม่ เพื่อสร้าง **Master Payload** ที่สมบูรณ์ที่สุด
    - เพื่อให้ Orchestrator สามารถใช้ Mode `replace_block` ได้อย่างปลอดภัย

#### 3.4 Integrity Guard
- ตรวจสอบความถูกต้องของวงเล็บปีกกา `{}` และ Syntax เบื้องต้น
- ตรวจสอบว่าชื่อฟังก์ชัน (Target Function) ตรงตามที่ระบุไว้ใน Manifest Plan

### Phase 4: Register in Orchestrator (.sh) — (The Engine: การติดตั้งเครื่องยนต์) ⚙️

#### 4.1 Version-Specific Targeting
- การลงทะเบียน Payload ในไฟล์ `.sh` จะต้องระบุเฉพาะฟีเจอร์และ Payload ที่เป็น **เวอร์ชันที่กำลังปรับปรุง (Current Target Version)** เท่านั้น
- **Atomic Unit**: มองการ Patch ของเวอร์ชันนั้นเป็น "หนึ่งหน่วยการทำงาน" (Atomic Unit)

#### 4.2 Registration Modes
ใช้ฟังก์ชัน `apply_payload` โดยเลือกโหมดที่เหมาะสม:
- `insert` (default): สำหรับการเพิ่มความสามารถใหม่ (OCP Compliance)
- `replace_line`: สำหรับการแก้คำผิดหรือบรรทัดสั้นๆ
- `replace_block`: สำหรับการใช้ **Successor Logic**

#### 4.3 Manifest Commitment
- ทำการเขียน (Update/Write) ข้อมูลเวอร์ชันล่าสุดลงใน `patch.manifest.json`
- **Header Synchronization**: ข้อมูลแท็กที่ระบุใน Manifest จะต้องถูกนำไปใช้ในสคริปต์ตรวจสอบ

### Phase 5: Verify in Sandbox — (The Gateway: การตรวจสอบความสมบูรณ์) 🛡️

#### 5.1 Fresh-Clone Verification
- ปฏิบัติตามขั้นตอน Step-by-Step ใน [references/verification_guide.md](references/verification_guide.md)
- **5.1.1 File-Specific Lineage Verification**: ตรวจสอบประวัติใน Manifest เพื่อยืนยันว่ารากฐานของไฟล์ตรงตามความจริงก่อนหน้า
- **Incremental Consistency**: ตรวจสอบว่าไฟล์อื่นๆ ที่ถูกแก้ในเวอร์ชันคั่นกลางยังอยู่ในสถานะที่ถูกต้อง
- **Ground Truth**: ยืนยันว่ารากฐาน (Base) มี Manifest ตรงตามที่ Registry ระบุไว้ก่อนเริ่มฉีด

#### 5.2 Syntax Guard & Testing
- **Build Check**: รัน `bun build` หรือ `tsc` ภายในพื้นที่ Sandbox
- **Test Mandate**: รัน `bun test` เพื่อให้แน่ใจว่าไม่มี Regression
- **Verification Pass**: หากผ่านทั้ง Build และ Test ใน Sandbox ถือว่าการ Forge ครั้งนี้ "สมบูรณ์เชิงเทคนิค" (Verification Pass) จบการทำงานที่ขั้นตอนนี้เท่านั้น

## Core Standards (Architecture v3.0/v4.0)

For detailed standards and technical rules, see:
- [Architecture v3.0 (Separation of Concerns)](references/architecture_v3.md)
- [Manifest v4.0 (Declarative Standards)](references/manifest_standard.md)
- [Ref-001 (Indentation Trap & Clean-Sweep)](references/Ref-001_the_indentation_trap.md) 🛡️🏗️🌊

### Iron Rules:
1. **Clean-First**: Target repo MUST be reset to `origin/main` before patching.
2. **Manifest Tagging**: Every patched file must have a `// @pulse-patch:` header.
3. **Idempotency**: Patching twice must have the same result as patching once.

## Templates

- **Orchestrator Template**: [assets/orchestrator_v8.5_template.sh](assets/orchestrator_v8.5_template.sh)

## Quick Examples

### Example: Adding an Import
```bash
apply_payload "packages/cli/src/pulse.ts" "add_imports@v8.4.0" "import { board" "add_imports@v8.4.0.pl" "replace_line"
```

### Example: Replacing a Switch Case
```bash
apply_payload "packages/cli/src/pulse.ts" "pulse_add_syntax@v8.4.0" '  case "add":' "pulse_add_syntax@v8.4.0.pl" "replace_block" '    break;\n  }'
```
