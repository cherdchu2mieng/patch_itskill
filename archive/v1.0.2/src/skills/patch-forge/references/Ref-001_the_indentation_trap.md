# Ref-001: The Indentation Trap & Clean-Sweep Strategy 🛡️🏗️🌊

## Overview
เอกสารอ้างอิงชุดนี้รวบรวมแนวทางปฏิบัติเพื่อป้องกันความล้มเหลวในการทำ **Surgical Patching** ที่เกิดจากความซับซ้อนของภาษาที่ซ้อนทับกัน (Nested Languages) และความเปราะบางของจุดยึด (Anchor Fragility)

## 1. The Indentation Trap (กับดักการย่อหน้า)
**ปัญหา**: การเขียนโค้ด Python (Heredoc) ลงใน Shell Script ผ่านเครื่องมือ AI มักทำให้การจัดย่อหน้า (Indentation) ผิดเพี้ยน ซึ่ง Python ซีเรียสมากเรื่องพื้นที่ว่าง (Whitespace)

**แนวทางป้องกัน**:
- **Prefer Python for Complex Strings**: ย้ายลอจิกที่มีข้อความหลายบรรทัดออกจาก Shell Orchestrator ไปอยู่ใน Python Script เฉพาะทาง
- **Literal String Block**: ใช้ Python Raw Strings (`r'''...'''`) เพื่อรักษาสภาพโค้ดดั้งเดิม 100% โดยไม่ต้องกังวลเรื่องการ Escape

## 2. Anchor Fragility (ความเปราะบางของจุดยึด)
**ปัญหา**: จุดยึดที่เลือกในไฟล์เป้าหมาย (เช่น `install.sh`) อาจมีช่องว่างไม่สม่ำเสมอ หรือมีข้อความคล้ายกันหลายจุด ทำให้ AI หาจุดแทนที่ผิดพลาด

**แนวทางป้องกัน**:
- **cat -n Verification**: ตรวจสอบช่องว่างและเลขบรรทัดจริงด้วย `cat -n` ก่อนกำหนดจุดยึด
- **Unique Anchors**: ใช้จุดยึดที่มีความยาวและความเฉพาะตัวสูง (Unique) เพื่อลดความกำกวม

## 3. The Clean-Sweep Strategy (กลยุทธ์กวาดล้าง)
**แนวทาง**: เมื่อการแก้ทีละบรรทัดมีความเสี่ยงสูง ให้เปลี่ยนมาใช้การ **"กวาดล้างทั้งบล็อก" (Block Replacement)**:
- **Centralized Rebranding**: ใช้สคริปต์ Python ตัวเดียวรับผิดชอบการแก้ไขไฟล์นั้นๆ ทั้งหมด
- **Index-Based Slicing**: ใช้ฟังก์ชัน `find()` เพื่อระบุตำแหน่งจุดเริ่มต้นและจุดสิ้นสุดของฟังก์ชัน แล้วทำการหั่น (Slice) ข้อความเดิมออกเพื่อฉีดโค้ดใหม่ลงไปแทนที่ทั้งบล็อก

## 4. Binary Hygiene
- **Delete First**: หากมีการเปลี่ยนรูปแบบจาก Binary มาเป็น Script ต้องสั่ง `rm -f` ไฟล์เดิมทิ้งเสมอ เพื่อป้องกันการรันโค้ดเก่าโดยไม่ตั้งใจ

---
**Learning Source**: [ψ/memory/learnings/2026-06-04_indentation_trap_and_clean_sweep_patching.md](../../ψ/memory/learnings/2026-06-04_indentation_trap_and_clean_sweep_patching.md)
