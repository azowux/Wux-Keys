TestScript:
	SendLevel 0
	LanguageSwitch(0)
	Send % WinActive("Sublime") ? "^k^1" : "^ks"
	Send +!^s
	Sleep 11
	Reload
	Return

TimeStamp:
	Send ` %A_DD%.%A_MM%` |` %A_Hour%•%A_Min% `{End}
	Send {Shift DownR}
	KeyWait, Space
	Send {Shift Up}	
	Return


; 7+ Taskbar Tweaker Startup Minimum Width Bug 
TaskbarNarrow:
	taskbarWidthTuned:=84
	If (A_ComputerName="A")
		taskbarWidthTuned:=104
	WinGetPos, , , taskbarWidth, , ahk_class Shell_TrayWnd
	If (taskbarWidth>taskbarWidthTuned) {
		WinGet, NowAppID, ID, A
		Send #t
		MouseGetPos, x0, y0
		MouseClickDrag, L, taskbarWidth-1, A_ScreenHeight/2, taskbarWidthTuned-1, A_ScreenHeight/2
		MouseClick, L, x0, y0, 1
		; ControlSend, Button2, {Space}, ahk_class Shell_TrayWnd
	}
	Return

TaskbarDisable:
	; WinHide, Start ahk_class Button
	; WinHide, ahk_class Shell_TrayWnd
	; WinHide, ahk_class Shell_TrayWnd
	WinWaitClose, ahk_class Shell_TrayWnd
	WinSet, Disable, , ahk_class Shell_TrayWnd
	Return
TaskbarEnable:
	; WinShow, Start ahk_class Button
	; WinShow, ahk_class Shell_TrayWnd
	WinSet, Enable, , ahk_class Shell_TrayWnd
	; WinSet, Transparent, 255, ahk_class Shell_TrayWnd
	Return
MouseMotion(distance, timeout) {
	MouseGetPos, x0, y0
	Loop {
		Sleep 11
		MouseGetPos, x1, y1
	} Until (abs(x1-x0)>distance)||(abs(y1-y0)>distance)
	Loop {
		Sleep 11
		MouseGetPos, , , WinUnderMouseID
		WinGetClass, WinUnderMouseClass, ahk_id %WinUnderMouseID%
	} Until (A_TimeIdleMouse > timeout)
	Return % WinUnderMouseClass
}

MouseMotionSensor(distance, timeout, MotionTimeOut) {
	MouseGetPos, x0, y0
	Loop {
		Sleep 11
		MouseGetPos, x1, y1
		If (A_TimeSinceThisHotkey>MotionTimeOut)
			Return false
	} Until (abs(x1-x0)>distance)||(abs(y1-y0)>distance)
	Loop {
		Sleep 11
		MouseGetPos, , , WinUnderMouseID
		WinGetClass, WinUnderMouseClass, ahk_id %WinUnderMouseID%
	} Until (A_TimeIdleMouse > timeout)
	Return % WinUnderMouseClass
} 


WaitUnfold:
	SetTimer, WaitUnfold, Off
	If (WinActive("Sublime Text")&&!GetKeyState("F12", "P")&&!GetKeyState("RAlt", "P"))&&((A_PriorHotkey="F12")||(A_PriorHotkey="RAlt")) {
		Sleep 222
		Send +^]
	} Return

ClickOnKeyRelease(key) {
	SetTimer, WaitKeyRelease, 11
}
WaitKeyRelease:
	If !GetKeyState(key, "P") {
		Click
		SetTimer, WaitKeyRelease, Off
	} Return
GlobalOneNoteOpen:	
	x:=A_ScreenWidth*.25
	y:=0
	w:=A_ScreenWidth*.5
	h:=A_ScreenHeight*.5
	Send #n
	WinWaitActive, - OneNote
	KeyWait, LWin
	WinMove, , , x, y, w, h
	Send {LAlt}
	WinWait, ahk_class Net UI Tool Window
	Send wpcn
	SendInput ` %A_DD%.%A_MM%` |` %A_Hour%•%A_Min% `{End}
	Return
FolderSizeCalc:
	If (A_TimeIdleKeyboard>333)&&(WinActive("ahk_exe doublecmd.exe")) {
		Send {F5}
	 } Return
HotkeySuspender(mouseWait) {
	Loop {
		MouseGetPos, x, y, NowApp
		WinGetTitle, NowAppTitle, ahk_id %NowApp%
		If (NowAppTitle="AcrossCenter")||WinActive("- Remote Desktop Connection")||WinActive("ahk_class Afx:00180000:208")||WinActive("ahk_exe barriers.exe") {
			Menu, Tray, Icon, %A_ScriptDir%\....ico,, 1
			SetNumLockState, On
			Suspend 1
		} Else If (A_ThisHotkey!="*F7") {
			Menu, Tray, Icon, %A_ScriptDir%\'.ico,, 1
			SetNumLockState, Off
			Suspend 0
		}
		Sleep %mouseWait%
	}
	Return
}

MouseKeyboardReload:
	MouseGetPos, x0, y0
	; WinShow, ahk_class Shell_TrayWnd
	; WinShow, Start ahk_class Button
	;SetKeyDelay, -1, 33
	; ControlSend, Button2, {Space}, ahk_class Shell_TrayWnd
	; ControlSend, ToolbarWindow321, {Down}+{F10}, ahk_class NotifyIconOverflowWindow
	Send #b{Space}
	WinWaitActive, ahk_class Shell_TrayWnd
	Send {Down}+{F10}
	WinWait, ahk_class #32768 ahk_exe AcrossCenter.exe
	Send {Up 3}{Enter}
	Sleep 1888
	Click
	WinWait, ahk_class #32768 ahk_exe AcrossCenter.exe
	Send {Up 2}{Enter}
	; WinHide, ahk_class Shell_TrayWnd
	; WinHide, Start ahk_class Button
	MouseMove, x0, y0
	Return
	
MouseKeyboard(toggle) {
	MouseGetPos, x0, y0
	WinShow, ahk_class Shell_TrayWnd
	WinShow, Start ahk_class Button
	Send #b{Enter}
	WinWaitActive, ahk_class Shell_TrayWnd
	Send {Down}+{F10}
	WinWait, ahk_class #32768 ahk_exe AcrossCenter.exe
	Send p
	If toggle {
		Send e
		GoSub, MouseKeyboardReload
	} Else
		Send d
	; WinWaitClose, , , .5
	WinWaitClose
	MouseMove, x0, y0
	Return
}
MouseSteadyClick(delay, timeout) {
	If (delay>0) {
		Sleep % delay
	}
	Loop {
		Sleep 1
	} Until (A_TimeIdleMouse>=%timeout%)
	Click
	Return
}

OneNoteKey(pattern) {
	Send {LAlt}
	WinWaitActive, ahk_class Net UI Tool Window
	Send %pattern%
	Return
}

ModifierPressShift:
	If GetKeyState("Shift", "P") {
		SetWinDelay, -1
		ToolTip, ••••••••°•••••••••••••°•••••••••••, 0/2, 0/2, 11
	} Else {
		ToolTip, , , , 11
	} Return

ModifierPressAlt:
	If GetKeyState("Alt", "P") {
		SetWinDelay, -1
		ToolTip, \ `   /`n ` \/`n ` /\`n/ `   \, 0/2, 0/2, 10
	} Else {
		ToolTip, , , , 10
	} Return

ClickNoMove(ClkNMX, ClkNMY){
	CoordMode, Mouse
	MouseGetPos, x, y
	MouseClick, L, %ClkNMX%, %ClkNMY%
	MouseMove, x, y
	Return
}
DestroyToolTip(tipshowtime) {
	SetTimer, DestroyToolTip, %tipshowtime%
	Return
}
DestroyToolTip:
	i++
	If (i>2)  {
		SetTimer, DestroyToolTip, Off
		ToolTip
		i=0
	}
	Return


ReleaseModifiers() {
	SendLevel 0
	If GetKeyState("LShift") {
		;MsgBox •LShift
		Send {LShift Up}
	} Else If GetKeyState("RShift") {
		;MsgBox •RShift
		Send {RShift Up}
	} Else If GetKeyState("LAlt") {
		;MsgBox •LAlt
		Send {LAlt Up}
	} Else If GetKeyState("RAlt") {
		;MsgBox •RAlt
		Send {RAlt Up}
	} Else If GetKeyState("LCtrl") {
		;MsgBox •LCtrl
		Send {LCtrl Up}
	} Else If GetKeyState("RCtrl") {
		;MsgBox •RCtrl
		Send {RCtrl Up}
	;} Else If GetKeyState("LWin") {
		;;MsgBox •RCtrl
		;Send {LWin Up}
	} Else If GetKeyState("RWin") {
		;MsgBox •RCtrl
		Send {RWin Up}
	}
	Return
}

ModifierRelease:
	SendLevel 1
	If (A_TimeIdleMouse<500) {
		If GetKeyState("Shift")
			SendInput {Shift Up}
		If GetKeyState("Ctrl")
			SendInput {Ctrl Up}
		If GetKeyState("Alt")
			SendInput {Alt Up}
	} Return

Run(target) {
	Send #r
	CenterWindow("Run")
	SendInput %target%{Enter}
	Return
}

StudioCodeSidebarToggle: ; To Do	

#Include %A_ScriptDir%\!@#$.ahk ; Forms filling

Space & F8:: ; Debugging Utility
	; Active Window Title
	;	DetectHiddenWindows On
	;	WinGetActiveTitle, CuApp
	;	MsgBox, %CuApp%
	;MsgBox, %A_TimeIdleMouse%
	;WinGet, NowAppID, ID, A
	;If Searching%NowAppID%
	;	Message:="Yes"
	;Else
	;	Message:="No"
	;WinGet, Message, ID, A
	;If GetKeyState("LShift", "P")
	;	Message=LShift
	;If GetKeyState("RShift", "P")
	;	Message=%Message% + RShift
	;If GetKeyState("LCtrl", "P")
	;	Message=%Message% + LCtrl
	;If GetKeyState("RCtrl", "P")
	;	Message=%Message% + RCtrl
	;If GetKeyState("LAlt", "P")
	;	Message=%Message% + LAlt
	;If GetKeyState("RAlt", "P")
	;	Message=%Message% + RAlt
	;If GetKeyState("LWin", "P")
	;	Message=%Message% + LWin
	;If GetKeyState("RWin", "P")
	;	Message=%Message% + RWin
	;MouseGetPos, x, y, AppID
	;Message=%x%.%y%.%AppID%
	;HotkeyLastPartStart:=InStr(A_ThisHotkey, "_")
	;SplashTextOn, 300, 100, , % SubStr(A_ThisHotkey, InStr(A_ThisHotkey, "_")-1)
	; 	WinGet, WinID,, A
	; ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
	; InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	; If(!InputLocaleID){
	; 	WinActivate, ahk_class WorkerW
	; 	WinGet, WinID2,, ahk_class WorkerW
	; 	ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID2, "UInt", 0)
	; 	WinActivate, ahk_id %WinID%
	; 	InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	; }
	; Send % InputLocaleID
	If WinActive(" - Tor") {
		SendRaw masterbeats
		Send {Tab}
		SendRaw Azo135Wux097
		Send {Tab}
	} Return

Space & Left::FileCopyDir, C:\°\, F:\°\, 1 ; Sync App Directory
Space & Escape:: ; Backup Script Directory
	Send +!^s
	ThisBackup=` %A_DD%.%A_MM%.%A_YYYY%` ` %A_Hour%•%A_Min% `
	FileCreateDir, C:\OneDrive\•\X\%ThisBackup%
	FileCopy, C:\OneDrive\•\*.ahk, C:\OneDrive\•\X\%ThisBackup%\*.ahk
	Return

<!Space:: ; App Shortcut to Start Menu
	SetKeyDelay, -1, 11
	Send +{F10}
	Sleep 77
	Send s
	Sleep 555
	Send {Down}{F2}{End}+^{Left}{BackSpace}{Enter}
	Return

Escape:: ; Key History/Window Spy
	SendLevel 0
	KeyWait, Escape, T.11
	If (A_TimeIdleMouse < 111) {
		; Gui, Add, Text, w150 Center, % "Active Time: " FormatMinutes(ActiveTime) "`nIdle Time: " FormatMinutes(IdleTime) "`nTotal: " FormatMinutes(TotalTime)
		Gui, -SysMenu
		Gui, Show
		Keywait,Esc, D
		Keywait,Esc
		Gui, Destroy
	} Else If !ErrorLevel {
		If WinExist("•.ahk - AutoHotkey") {
			ControlSend, , {Escape}, •.ahk - AutoHotkey
		} Else {
			KeyHistory
			WinWait, •.ahk - AutoHotkey
			WinMove, •.ahk - AutoHotkey,, A_ScreenWidth-770, 0, 777, 900
			Send {F5}
		}
	} Else If WinExist("Window Spy")
		WinClose, Window Spy
	Else {
		Run C:\Program Files\AutoHotkey\WindowSpy.ahk
		WinWait, Window Spy
		WinMove, Window Spy,, 1420, 630
		WinActivate, Window Spy
		Send {Space}
		MouseGetPos, , , mouseWin
		WinActivate, ahk_id %mouseWin%
	} Return

*F7:: ; Suspend Hotkeys
	Suspend
	If A_IsSuspended {
		Menu, Tray, Icon, %A_ScriptDir%\....ico, , 1
		ToolTip, °
		DestroyToolTip(333)
		SetNumLockState, On
	} Else {
		Menu, Tray, Icon, %A_ScriptDir%\'.ico, , 1
		ToolTip, •
		DestroyToolTip(333)
		SetNumLockState, Off
		Reload
	} Return
F7 & Space::Pause
F7 & Delete::ExitApp
