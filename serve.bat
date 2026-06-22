@echo off
REM Double-click this file on Windows to preview the lander.
REM Requires Python 3 (pre-installed on Windows 11; otherwise winget install Python.Python.3).

setlocal
cd /d "%~dp0"

set PORT=5577

REM Try to open the browser ~1s after the server is up
start "" /b cmd /c "timeout /t 1 >nul & start http://localhost:%PORT%/"

echo.
echo  Elevates Lander — local preview
echo  --------------------------------
echo  Serving on http://localhost:%PORT%/
echo  Press Ctrl+C to stop.
echo.

python -m http.server %PORT% 2>nul || py -3 -m http.server %PORT% 2>nul || (
  echo Python not found. Install Python 3 or run:
  echo   npx serve .
  pause
)
