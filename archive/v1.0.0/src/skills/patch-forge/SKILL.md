---
name: patch-forge
description: Generate Robust Patching Architecture (v3.0) components. Use this skill to design and create .pl (payload) and .sh (orchestrator) files for pulse-cli and other fleet components, ensuring manifest-driven idempotency and clean-first deployment.
---

# [itinfosv] Patch Forge 🛡️🌊 (โรงหล่อแพตช์: ตีขึ้นรูปอย่างประณีตและแข็งแกร่ง)

## Overview
Patch Forge คือ "โรงหล่อ" เฉพาะทางสำหรับ **Robust Patching (v3.0)** ที่เน้นการสร้าง Patch อย่างประณีต (Precision) และแข็งแกร่งดุจเหล็กกล้า (Ironclad) เพื่อลดความผิดพลาด (Regression) ในกองทัพ Oracle

## Workflow: Creating a New Patch

### 0. Manifest Management (Source of Truth)
- ตรวจสอบ `patch.manifest.json` ใน Patch Workspace
- หากไม่มี: ให้ใช้โครงสร้างตาม [references/manifest_standard.md](references/manifest_standard.md) เพื่อสร้างใหม่ (Init)
- หากมีอยู่แล้ว: ให้อัปเดตเวอร์ชัน, ไฟล์ที่เกี่ยวข้อง และ **Feature Flags** (ภายใต้ `features`) ลงใน `history` และ `current_active_version` (Update)

### 1. Research & Baseline
#### 1.1 Version & Strategy Identification
- ระบุสถานะของงาน: เป็นการเริ่มใหม่จากฐาน (**Base/Full Package**) หรือเป็นการปรับปรุงย่อย (**Incremental/Single Patch**)
- สำหรับ **Base (v8.0)**: ต้องระบุไฟล์รากฐานทั้งหมดที่เสถียรที่สุด (เช่น `add.ts`, `config.ts`, `pulse.ts`) เพื่อเตรียมทำ Snapshot
- สำหรับ **Incremental**: ตรวจสอบ `current_active_version` ใน Manifest เพื่อกำหนดเวอร์ชันถัดไปและระบุไฟล์เป้าหมายที่ต้องแก้ไขจริง
- ระบุชื่อฟังก์ชัน (Target Function) ที่จะได้รับผลกระทบเพื่อใช้ในการตั้งชื่อ Feature

#### 1.2 Strategy & Standards Alignment (การกำหนดกลยุทธ์และมาตรฐาน)
- **OCP Compliance**: ประเมินว่าการ Patch เป็นการ "ขยาย" (Extend) หรือ "รื้อ" (Modify) - *พยายามเลี่ยงการรื้อลอจิกเดิม*
- **Feature Toggling**: หากเป็นการถอดฟีเจอร์ ให้พิจารณาใช้ **Feature Flags** (ใน `config.ts`) แทนการลบโค้ดทิ้ง เพื่อรองรับการย้อนกลับ
- **Deprecation Policy**: หากจำเป็นต้องลบจริง ต้องผ่านขั้นตอน `@deprecated` ตามนโยบายใน [references/coding_standards.md](references/coding_standards.md)
- **Anchor Stability**: เลือกจุดยึด (Surgical/Block) ที่มั่นคงและไม่กระทบต่อ OCP

#### 1.3 Technical Integrity & Verification (ความสมบูรณ์ทางเทคนิคและการตรวจสอบ)
- **Strict Typing**: ตรวจสอบว่า Payload ไม่ใช้ `any` และมีการนิยาม `interface/type` ที่ชัดเจนเพื่อใช้ประโยชน์จาก Compiler
- **Testing Mandate**: วางแผนการทำ **Integration Test** (`bun test`) เพื่อล็อคพฤติกรรมระหว่างไฟล์ที่เกี่ยวข้อง (add.ts, config.ts, pulse.ts)
- **Baseline Verification**: ตรวจสอบ Manifest Tag ของเวอร์ชันก่อนหน้า และตัดสินใจว่าจะ Append หรือ Supersede

#### 1.4 Functional Analysis & Design (วิเคราะห์ฟังก์ชันและการออกแบบ)
- **Inventory Check**: สำรวจและนับจำนวนฟังก์ชันทั้งหมดในไฟล์เป้าหมายเพื่อเข้าใจโครงสร้างภาพรวม
- **Target Scoping**: ระบุฟังก์ชันเป้าหมายหลัก (Target Function) อย่างชัดเจน
- **Mapping Plan**: วางแผนการลงข้อมูลใน `patch.manifest.json` โดยระบุชื่อฟังก์ชันที่ได้รับผลกระทบ
- **Blueprint Prep**: เตรียมข้อมูลสำหรับสร้างไฟล์ `.pl` (โค้ด) และ `.sh` (การกำหนด Anchor และ Mode ที่เหมาะสม)
- **Impact Assessment**: ตรวจสอบผลกระทบต่อตัวแปร, การนำเข้า (Imports), และการเชื่อมโยงข้ามฟังก์ชัน

### 2. Create the Payload (.pl) - (The Foundry: ขั้นตอนการหล่อชิ้นงาน)

#### 2.1 Payload Isolation (การแยกส่วนชิ้นงาน)
- สร้างไฟล์ชื่อ `<feature>@<version>.pl` ไว้ในโฟลเดอร์ `payloads/` ตามโครงสร้างที่วางแผนไว้ใน Phase 1.1
- **Pure Code**: บรรจุเฉพาะโค้ด TypeScript/JavaScript ที่ต้องการฉีดจริง **ห้ามมี Metadata หรือคอมเมนต์จาก Bash/Python**
- **No Escaping**: เขียนโค้ดแบบดิบๆ เหมือนเขียนใน Editor ปกติ เพื่อลดความผิดพลาดตอนนำไปรัน

#### 2.2 Standard Compliance (การตรวจสอบมาตรฐาน)
- **OCP Check**: ตรวจสอบว่าโค้ดที่เขียนเป็นการเพิ่มพฤติกรรมใหม่ (Plugin/Module) หรือไปรื้อโครงสร้างเดิม
- **Feature Flag Injection**: หากเป็นฟีเจอร์ที่ต้องการเปิด/ปิดได้ ให้ครอบโค้ดด้วยเงื่อนไขที่ดึงค่ามาจากคอนฟิก เช่น:
  ```typescript
  if (config.features?.advanced_calculation?.enabled) {
    // ... logic ...
  }
  ```
- **Strict Typing**: ตรวจสอบว่ามีการนิยาม `interface` หรือ `type` ครบถ้วน และไม่มีการใช้ `any`

#### 2.3 Successor Logic (การสร้างตัวตายตัวแทน)
- หากเป็นการแก้ทับฟังก์ชันเดิม (Supersede) ในเวอร์ชันใหม่:
    - ให้ Copy โค้ดเดิมที่ยังใช้ได้มารวมกับโค้ดใหม่ เพื่อสร้าง **Master Payload** ที่สมบูรณ์ที่สุด
    - เพื่อให้ Orchestrator สามารถใช้ Mode `replace_block` ได้อย่างปลอดภัย

#### 2.4 Integrity Guard (การรักษาความสมบูรณ์)
- ตรวจสอบความถูกต้องของวงเล็บปีกกา `{}` และ Syntax เบื้องต้น
- ตรวจสอบว่าชื่อฟังก์ชัน (Target Function) ตรงตามที่ระบุไว้ใน Manifest Plan

### 3. Register in Orchestrator (.sh) - (The Engine: การติดตั้งเครื่องยนต์ตามเวอร์ชัน)

#### 3.1 Version-Specific Targeting (การกำหนดเป้าหมายตามเวอร์ชัน)
- การลงทะเบียน Payload ในไฟล์ `.sh` จะต้องระบุเฉพาะฟีเจอร์และ Payload ที่เป็น **เวอร์ชันที่กำลังปรับปรุง (Current Target Version)** เท่านั้น
- **Atomic Unit**: มองการ Patch ของเวอร์ชันนั้นเป็น "หนึ่งหน่วยการทำงาน" (Atomic Unit) หากมีหลายไฟล์ (Cross-file) ต้องลงทะเบียนให้ครบในสคริปต์เดียวกัน

#### 3.2 Registration Modes (โหมดการลงทะเบียน)
ใช้ฟังก์ชัน `apply_payload` โดยเลือกโหมดที่เหมาะสมกับกลยุทธ์ใน Phase 1.3:
- `insert` (default): สำหรับการเพิ่มความสามารถใหม่ (OCP Compliance)
- `replace_line`: สำหรับการแก้คำผิดหรือบรรทัดสั้นๆ
- `replace_block`: สำหรับการใช้ **Successor Logic** (เขียนทับทั้งฟังก์ชัน) เพื่อลดความซับซ้อนของเวอร์ชันเก่าที่ซ้อนทับกัน

#### 3.3 Manifest Commitment (การบันทึกสมองกลาง)
- ทำการเขียน (Update/Write) ข้อมูลเวอร์ชันล่าสุดลงใน `patch.manifest.json`
- **Header Synchronization**: ข้อมูลแท็กที่ระบุใน Manifest จะต้องถูกนำไปใช้ในสคริปต์ตรวจสอบ เพื่อยืนยันความถูกต้องของไฟล์ `.ts` เป้าหมาย

### 4. Verify in Sandbox - (The Gateway: การตรวจสอบความสมบูรณ์บนพื้นที่จำลอง)

#### 4.1 Fresh-Clone Verification (การตรวจสอบบนสภาพแวดล้อมที่สะอาด)
- ปฏิบัติตามขั้นตอน Step-by-Step ใน [references/verification_guide.md](references/verification_guide.md)
- **4.1.1 File-Specific Lineage Verification**: ในกรณีที่ไฟล์มีการแก้ข้ามเวอร์ชัน (เช่น v8.2.5 -> v8.2.7) สคริปต์ตรวจสอบต้องไล่ประวัติใน Manifest เพื่อยืนยันว่า "รากฐานของไฟล์นั้นๆ" (File-specific Baseline) ตรงตามความจริงก่อนหน้า
- **Incremental Consistency**: ตรวจสอบว่าไฟล์อื่นๆ ที่ถูกแก้ในเวอร์ชันคั่นกลาง (เช่น add.ts ใน v8.2.6) ยังอยู่ในสถานะที่ถูกต้องและไม่ถูก Regression จากการ Patch ครั้งใหม่
- **Ground Truth**: ยืนยันว่ารากฐาน (Base) มี Manifest ตรงตามที่ Registry ระบุไว้ก่อนเริ่มฉีด

#### 4.2 Syntax Guard & Testing (การตรวจสอบความถูกต้องและเสถียรภาพ)
- **Build Check**: รัน `bun build` หรือ `tsc` ภายในพื้นที่ Sandbox เพื่อยืนยันว่าไม่มี Error ของ TypeScript/Syntax หลังการ Patch
- **Test Mandate**: รัน `bun test` เพื่อให้แน่ใจว่าไม่มี Regression ในฟังก์ชันหลักที่เกี่ยวข้อง (ตามแผนใน Phase 1.3)
- **Verification Pass**: หากผ่านทั้ง Build และ Test ใน Sandbox ถือว่าการ Forge ครั้งนี้ "สมบูรณ์เชิงเทคนิค" (Verification Pass) และจบการทำงานที่ขั้นตอนนี้เท่านั้น

## Core Standards (Architecture v3.0/v4.0)

For detailed standards and technical rules, see:
- [Architecture v3.0 (Separation of Concerns)](references/architecture_v3.md)
- [Manifest v4.0 (Declarative Standards)](references/manifest_standard.md)

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
