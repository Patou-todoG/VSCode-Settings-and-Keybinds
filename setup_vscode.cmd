@echo off

set dir=%1
set vscode_path=%2

set WAIT_TIME=1
set DEFAULT_DIR=.
set DEFAULT_VSCODE_PATH=%AppData%\Code\User\


if [%dir%] == [] (
	echo no directory path providded, defaulting to `%DEFAULT_DIR%`
	set dir=%DEFAULT_DIR%
)

if [%vscode_path%] == [] (
	echo no vscode config path providded, defaulting to `%DEFAULT_VSCODE_PATH%`
	set vscode_path=%DEFAULT_VSCODE_PATH%
)


REM Wait for dir to exist.

:wait_site
if exist %dir% (
    echo Input directory exists.
) else (
	echo Input directory does not exist, waiting %WAIT_TIME% second for it to appear...
	echo Press `ctrl + C` to terminate this program
    timeout /t %WAIT_TIME%
    goto wait_site
)


copy "%dir%/settings.json" "%vscode_path%/settings.json"
copy "%dir%/keybindings.json" "%vscode_path%/keybindings.json"


if exist vscode.lnk (
	echo Starting vscode.
	start vscode.lnk | REM Note: The pipe is here to keep VSCode from blocking the cmd thread.
) else (
	echo To start VSCode automatically after setup, add a windows shortcut called `vscode.lnk` next to this .cmd file
)


echo Done
pause