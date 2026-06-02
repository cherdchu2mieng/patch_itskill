# คู่มือการตรวจสอบระดับปฏิบัติการ (Phase 4.1: Verification Guide) 🛡️🌊

เพื่อให้การส่งมอบ Patch เป็นไปอย่าง "Ironclad" (แข็งแกร่งและไร้ข้อผิดพลาด) ให้ปฏิบัติตามขั้นตอน Step-by-Step ดังนี้:

---

### 1. การเตรียมพื้นที่ชั่วคราว (Setup Temporary Sandbox)
เราจะไม่รันการทดสอบในโฟลเดอร์ทำงานหลัก เพื่อป้องกันความสับสนของไฟล์และผลกระทบต่อ Worktree ปัจจุบัน
*   **Action**: สร้างโฟลเดอร์ใหม่ใน `/tmp` หรือพื้นที่นอกโปรเจกต์
*   **Command**: `mkdir -p /tmp/patch-verify && cd /tmp/patch-verify`

### 2. การตรวจสอบรากฐาน (Source Verification & Manifest Check)
ตรวจสอบให้แน่ใจว่าหัวไฟล์ (.ts) มีการระบุแท็กของ Patch เวอร์ชันก่อนหน้าไว้ครบถ้วน โดยใช้ข้อมูลจาก `patch.manifest.json` เป็นบรรทัดฐาน

#### 2.1 Version Chain Validation (การตรวจสอบสายลำดับเวอร์ชัน)
เครื่องมือตรวจสอบต้องใช้ `patch.manifest.json` ในการสร้าง **Expected Tag** สำหรับแต่ละไฟล์ดังนี้:

*   **กระบวนการหาความจริง (Audit Flow)**:
    1.  ไล่ดูข้อมูลในก้อน `history` ถอยหลังจากเวอร์ชันล่าสุด
    2.  ค้นหาเวอร์ชันล่าสุดที่มีการระบุชื่อไฟล์เป้าหมาย (เช่น `config.ts`) อยู่ใน `files_mapping`
    3.  นำชื่อ Feature จากฟิลด์ `src` และชื่อเวอร์ชัน (Key) มารวมกันเป็น **Expected Tag** (เช่น `feature_name@v8.x.x`)
*   **การเปรียบเทียบ**: หัวไฟล์จริงใน `.ts` ต้องมีแท็กที่ตรงตามที่ Audit Flow คำนวณได้ 100%
*   **Requirement**: สภาพแวดล้อมก่อนการ Forge ใหม่ต้องมีสถานะเท่ากับผลลัพธ์ของ Audit Flow เสมอ

### 3. การแก้ปัญหาเรื่องเส้นทาง (Absolute Path Resolution)
นี่คือจุดที่มักจะเกิด Error มากที่สุดในสคริปต์ Orchestrator เมื่อมีการเปลี่ยน Directory
*   **Action**: ในสคริปต์ `.sh` ต้องใช้ `realpath` เพื่อระบุตำแหน่งของ Payloads และ Target ให้เป็น Absolute Path
*   **Check**: ตรวจสอบตัวแปร `PAYLOADS_DIR=$(realpath "$(dirname "$0")/payloads")` และ `TARGET_PATH=$(realpath "$1")`

### 4. การรันการแพตช์ (Execution)
รันสคริปต์จากพื้นที่จริง (Patch Workspace) ไปยังพื้นที่จำลอง (Sandbox)
*   **Action**: รัน Orchestrator โดยส่ง Path ของ Sandbox ไปเป็น Argument
*   **Example**: `bash ~/patch_ora_modules/modules/pulse-cli/patch_pulse.sh /tmp/patch-verify/target-repo`

### 5. การตรวจสอบความสมบูรณ์ (Portability Audit)
*   **File Integrity**: ตรวจสอบว่าไฟล์ถูกแก้ไขจริงหรือไม่ผ่าน `git -C target-repo diff`
*   **Manifest Check**: ตรวจสอบว่าบรรทัด `// @pulse-patch:` ถูกอัปเดตข้อมูลเวอร์ชันล่าสุดครบถ้วน
*   **Orphan Check**: ตรวจสอบว่าไม่มีไฟล์ขยะ (เช่น `.bak`, `.tmp`, หรือไฟล์ Python ชั่วคราว) หลงเหลืออยู่ใน Repository

### 6. ประตูป้องกันความปลอดภัย (Safety Gate)
**"หากพังที่นี่ ต้องไม่ไปต่อ"**
*   **Action**: หากพบ Error ในขั้นตอนใดก็ตาม (หา Payload ไม่เจอ, Syntax พัง, หรือ Test ไม่ผ่าน) ให้หยุดการส่งมอบทันที
*   **Resolution**: กลับไปแก้ไขที่ Phase 2 หรือ 3 ใน Patch Workspace จนกว่าการรันใน Sandbox จะผ่าน 100%
