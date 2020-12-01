; Gestures & Pen

*F19:: ; 2•Clicks — Quick Note
	App("OneNote", "OneNote 10")
	Sleep 777
	ToolbarHeight:=133
	WinMove, A, , 0, -ToolbarHeight, A_ScreenWidth, A_ScreenHeight
	Return
*F20::Send +#s ; 1•Click — Screenshot
*F22:: ; 3 •
	; SetKeyDelay, 1, 33
	; KeyWait, LWin
	; KeyWait, Shift
	; KeyWait, Alt
	; KeyWait, Ctrl
	; If WinActive(".ahk •")
	; 	GoSub, TestScript
	; Else If WinActive("ahk_class CabinetWClass")
	; 	SendInput !{Up}
	; Else If WinActive("ahk_class OneNote::NavigationUIPopup")
	; 	Send {Esc}
	; Else If WinActive("- OneNote") { ; Menu
	; 	WinGetPos, MainX, MainY, MainW, MainH, - OneNote
	; 	Send ^g
	; 	WinWait, ahk_class OneNote::NavigationUIPopup
	; 	WinGetPos, NavX, NavY, NavW, NavH
	; 	WinMove, (MainX+MainW/2)-800, (MainY+MainH/2)-NavH/2
	; } Else If WinActive("Microsoft To Do") { ; Surf to task's OneNote entry
	; 	Click
	; 	MouseMove, 1555, A_ScreenHeight/2, 5
	; 	Send {WheelDown 10}
	; 	MouseClick, Left, 1700, 800, 1, 5
	; 	WinWaitActive, Did you mean to switch apps?
	; 	Send {Tab}{Enter}
	; } Else If WinActive("- Google Chrome")||WinActive("Firefox")||WinActive("Tor")		 {
	; 	Click, R
	; 	Sleep 11
	; 	Send v
	; 	WinWaitActive, ahk_class #32770
	; 	Send !s
	; 	WinWaitActive, Firefox
	; } Else If WinActive("Unigram") { ; Save Message
	; 	SetKeyDelay, 11, 55
	; 	Send {RButton}{Down}{Enter}
	; 	Sleep 55
	; 	Send {Tab 3}{Space}{Tab 3}{Space}
	; }
	If WinActive("ahk_group Desktop")
		GoSub, MouseKeyboardReload
	Else If WinExist("ahk_exe Magnify.exe") {
		MouseGetPos, PxX, PxY
		; PixelGetColor, searchPx, PxX, PxY
		ClipboardSend:=PxX . " " . PxY
		ClipboardAdd(ClipboardSend)
	} Else Loop 1 {
		Send +{RButton}
		WinUnderMouseClass:=MouseMotion(5, 55)
		Sleep 11
		; i+=1
	} ; Until (WinUnderMouseClass="#32768")||i>5
	; Click
	Sleep 333
	Return
*F24:: ; 4 • — Launchpad
	KeyWait, Alt
	KeyWait, Ctrl
	KeyWait, Shift
	KeyWait, LWin
	; SetKeyDelay, 1, 33
	; Send ^k
	; Launchpad
	; Send ^!+{Del}
	; Send {RCtrl Down}{RCtrl Up}
	; Sleep 111
	; Send {RCtrl Down}{RCtrl Up}
	Send !{Insert}
	WinWaitActive, XLaunchPad, , 1
	; MouseSteadyClick(0, 111)
	Return
ScrollLock::GoSub, MouseKeyboardReload ; 5 • — Remote Mouse & Keyboard Reload
Launch_App1::Send {MButton}
Volume_Mute::Send #{Tab}
; Space & F22::SendInput #{Tab}
+^Left:: ; 3 → — Next App/Move window to Next Desktop
		If WinActive("Task View") {
		Send {RButton}
		WinWaitActive, PopupHost ahk_class Xaml_WindowedPopupClass, , .11
		Send {Down 2}{Enter}
		}
		Send !{Escape}
	Sleep %AppSwitchDelay%
	Return
+^Right:: ; 3 ← — Previous App/Move window to Previous Desktop
		If WinActive("Task View") {
		Send {RButton}
		WinWaitActive, PopupHost ahk_class Xaml_WindowedPopupClass, , .11
		Send {Down 3}{Enter}
		}
		Send +!{Escape}
	Sleep %AppSwitchDelay%
	Return
+^Up:: ; 3 ↑
	Send #{Tab}
	; Send !^{Tab}
	; MouseMotion(5, 111)
	Sleep 333
	; Click
	Return
+^Down:: ; 3 ↓ — Close/Minimize Window
	MouseGetPos, x, y, NowWinID
	If GetKeyState("Space", "P")
		WinMinimize, ahk_id %NowWinID%
	Else
		WinClose, ahk_id %NowWinID%
	Sleep 333
	Return
WheelRight::
PgUp:: ; 2 → — Previous Tab
	BlockInput 1
	If WinActive("Xodo")||WinActive("OneNote")||WinActive("ahk_exe doublecmd.exe")||WinActive("ahk_exe WindowsTerminal.exe")||WinActive("ahk_class CabinetWClass")
		Send +^{Tab}
	Else If WinActive("ahk_exe Notion.exe")
		Send ^{Left}
	Else
		Send ^{PgUp}
	Sleep %TabSwitchDelay%
	BlockInput 0
	Return
WheelLeft::
PgDn:: ; 2 ←— Next Tab
	BlockInput 1
	If WinActive("Xodo")||WinActive("OneNote")||WinActive("ahk_exe doublecmd.exe")||WinActive("ahk_exe WindowsTerminal.exe")||WinActive("ahk_class CabinetWClass")
		Send ^{Tab}
	Else If WinActive("ahk_exe Notion.exe")
		Send ^{Right}
	Else
		Send ^{PgDn}
	Sleep %TabSwitchDelay%
	BlockInput 0
	Return
Space & WheelLeft:: ; Move Tab Right
	BlockInput 1
		If WinActive("ahk_exe OneNote.exe")||WinActive("Xodo")
			SendInput ^{Tab}
		Else
			SendInput +^{PgUp}
		Sleep %TabSwitchDelay%
		BlockInput 0
		Return
Space & WheelRight:: ; Move Tab Left
	BlockInput 1
		If WinActive("ahk_exe OneNote.exe")||WinActive("Xodo")
			SendInput ^{Tab}
		Else
			SendInput +^{PgDn}
		Sleep %TabSwitchDelay%
		BlockInput 0
		Return
Space & WheelUp:: ; Jump Forward
	BlockInput 1
	If WinActive("OneNote")
		Send ^{PgUp}
	Else
		Send +!-
	Sleep 111
	BlockInput 0
	Return
Space & WheelDown:: ; WheelDown Back
	BlockInput 1
	If WinActive("OneNote")
		Send ^{PgDn}
	Else
		Send !-
	Sleep 111
	BlockInput 0
	Return
!^Left:: ; 4 → — Previous Desk
	; BlockInput 1
	Send ^#{Left}
	Sleep %DesktopSwitchDelay%
	BlockInput 0
	Return
!^Right:: ; 4 ← — Next Desk
	; BlockInput 1
	Send ^#{Right}
	Sleep %DesktopSwitchDelay%
	BlockInput 0
	Return
+^x::Cut()		
+^c::Copy()
+^v::Paste()
+^b::GoSub, CopyPastetoLastWindow

<^WheelLeft::AltTab
