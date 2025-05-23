@echo off
:: 设置代码页为UTF-8
chcp 65001
:: 设置Python不显示警告
set PYTHONWARNINGS=ignore::SyntaxWarning:DrissionPage
echo [信息] 正在构建听泉CursorPro换号工具 Windows版本...

:: 检查虚拟环境是否存在
if not exist "venv" (
    echo [信息] 创建虚拟环境...
    python -m venv venv
    if errorlevel 1 (
        echo [错误] 创建虚拟环境失败!
        exit /b 1
    )
)

:: 激活虚拟环境并等待激活完成
call venv\Scripts\activate.bat
timeout /t 2 /nobreak > nul

:: 安装依赖
echo [信息] 安装依赖项...
python -m pip install --upgrade pip
pip install -r requirements.txt
pip install pyinstaller

:: 运行构建脚本
echo [信息] 开始构建过程...
echo [信息] 正在构建Windows版本...

:: 直接使用PyInstaller来构建
pyinstaller TingQuanChanger.spec --distpath dist/windows --workpath build/windows --noconfirm

:: 如果构建成功，打开输出目录
if errorlevel 0 (
    echo [成功] 构建完成！正在打开输出目录...
    start "" "dist\windows"
) else (
    echo [错误] 构建过程中出现错误。
)

:: 停用虚拟环境
deactivate

:: 保持窗口打开
echo [完成] 构建完成!
echo.
echo 按任意键退出...
pause > nul 