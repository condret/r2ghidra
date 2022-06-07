set PKG_CONFIG_PATH=%CD%\radare2\lib\pkgconfig
set PATH=%CD%\radare2\bin;%PATH%
set VSARCH=x64

git submodule update --init

python -m wget https://github.com/radareorg/ghidra-native/releases/download/0.1.8/ghidra-native-0.1.8.zip

unzip -q ghidra-native-0.1.8.zip
if %ERRORLEVEL% NEQ 0 (
	powershell "Expand-Archive -LiteralPath ghidra-native-0.1.8.zip -DestinationPath ."
)
ren ghidra-native-0.1.8 ghidra-native

REM call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64
echo === Finding Visual Studio...
cl --help > NUL 2> NUL
if %ERRORLEVEL% == 0 (
  echo FOUND
) else (
  if EXIST "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community" (
    echo "Found community edition"
    call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" %VSARCH%
  ) else (
    if EXIST "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" (
      echo "Found Enterprise edition"
      call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" %VSARCH%
    ) else (
      if EXIST "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" (
        echo "Found Professional edition"
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" %VSARCH%
      ) else (
        if EXIST "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" (
          echo "Found BuildTools"
          call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" %VSARCH%
        ) else (
          echo "Not Found"
          exit /b 1
        )
      )
    )
  )
)
