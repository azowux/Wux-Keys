; Prime Tunes

	#SingleInstance Force
	#UseHook
	; #InstallKeybdHook
	; #InstallMouseHook
	; #WinActivateForce
	; #MaxHotkeysPerInterval 333
	; Process, Priority, , High
	Menu, Tray, Icon, %A_ScriptDir%\'.ico ; Tray Icon
	SetCapsLockState, AlwaysOff
	SetNumLockState, AlwaysOff
	SetScrollLockState, AlwaysOff
	SetTitleMatchMode 2
	; DetectHiddenWindows 1
	; SetKeyDelay, -1, 5
	FileEncoding, UTF-8
	CoordMode, Mouse, Screen
	CoordMode, ToolTip, Screen

; App Groups
	GroupAdd, Browsers, Google Chrome
	GroupAdd, Browsers, Firefox
	GroupAdd, Browsers, Tor
	GroupAdd, Browsers, Brave
	
	GroupAdd, Code, ahk_exe powershell.exe
	GroupAdd, Code, ahk_exe cmd.exe
	
	GroupAdd, DialogSkip, Shortcut ahk_class #32768
	
	GroupAdd, Desktop, Program Manager ahk_class Progman
	GroupAdd, Desktop, ahk_class WorkerW

; Global Vars
	global Language
	global NowWinActive
	global NowAppID
	global LastAppID
	global notchdown
	global notchup
	VolumeIncrement:=3
	WordJump:=77
	TabSwitchDelay:=88
	DesktopSwitchDelay:=222
	AppSwitchDelay:=188
	searchTagTimer:=111
	searchTagToolTip№:=5
	TimeVarRec := A_Now
	border_thickness := 5
	border_color := FF0000
; Timers
	; SetTimer, Scroller, 11
	; SetTimer, ScrollConsumer, 11
	SetTimer, NowWinActive, 33
	; SetTimer, ModifierPressShift, 33
	; SetTimer, ModifierPressAlt, 33
	SetTimer, DialogResponse, 111
	; SetTimer, WindowResponse, 111
	SetTimer, WindowStyle, 111
	; SetTimer, ModifierRelease, On
	; SetTimer, CheckTime, 60000 ; updates every 1 minute
	; SetTimer, AcrossReloader, 1000
	; SetTimer, AltApp, 55
	; SetTimer, FolderSizeCalc, On
; Launchers
	Run %A_ScriptDir%\E.ahk
	Run %A_ScriptDir%\Spotify\Spotify.ahk

; Auto-start
	; If !FileExist("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\•.ahk")
	FileDelete, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\•.lnk
	FileCreateShortcut, %A_ScriptDir%\•.ahk, %A_ProgramsCommon%\Startup\•.lnk, %A_ScriptDir%, , , %A_ScriptDir%\'.ico, F7
	; FileCopy, %A_ScriptDir%\•.lnk, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\•.lnk
	
; Clipboard
	If !FileExist("C:\Clipboard\")
		FileCreateDir, C:\Clipboard\
	Loop C:\Clipboard\clip*.txt {
		clipindex += 1
		FileRead, clip%A_Index%, %A_LoopFileFullPath%
	}
	maxindex:=clipindex

; GoSub, TaskbarNarrow
; GoSub, TaskbarDisable
 
HotkeySuspender(1000)