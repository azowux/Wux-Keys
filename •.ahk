
; Azo Wux

#Include *i %A_ScriptDir%\A.ahk ; Auto-execute

#InputLevel 1
*Space:: ; Shift 
	SendLevel 0
	AppSwitchX(55)
	Send {Shift DownR}
	KeyWait, Space
	Send {Shift Up}
	If WinActive("Task Switching")
		Click
	Else If (A_TimeSinceThisHotkey<188)&&(A_PriorKey!="BackSpace")&&(A_PriorKey!="\")&&(A_PriorKey!="Enter") {
		SendLevel 1
		Send {Space}
	} Return
BackSpace::
	SendLevel 0
	KeyWait, BackSpace, T.15
	If GetKeyState("End", "P")
		GoSub, PasteLink
	Else If WinActive("- OneNote")&&ErrorLevel
		Send ^1 ; Task
 	Else If WinActive("ahk_exe doublecmd.exe")&&ErrorLevel {
 		Send {F4} ; Rename
	} Else If WinActive("Save ahk_class #32770")&&!ErrorLevel
		Send !s ; Save File
	Else If WinActive("ahk_class #32770")&&!ErrorLevel {
		Send {Enter}
	} Else If ErrorLevel&&(WinActive("Double Commander")||WinActive("ahk_exe Explorer.EXE"))
		Send {F2}{End} ; Explorer Rename
	Else If WinActive("Sublime Text")&&ErrorLevel { ; Unfold
		LanguageSwitch(0)
		If (Searching%NowAppID%)
			GoSub, FinishSearch
		Send {Home}+^]
	} Else If (Searching%NowAppID%) {
		GoSub, FinishSearch
	} Else If !GetKeyState("CapsLock", "P") {
		SendLevel 1
		Send {Enter}
	}
	If WinActive("Unigram")&&ErrorLevel { ; send & quit chat
		SendLevel 0
		Send {Escape}
	} Return
LButton & BackSpace:: ; Selected text powershell execution
	If GetKeyState("LButton", "P") {
		Send {LButton Up}
	}
	Send ^c
	Run "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
	WinWaitActive, ahk_exe PowerShell.exe
	Sleep 111
	Send ^v{Enter}
	Return

\::
	SendLevel 0
	ControlGet, renamestatus,Visible,,Edit1,A
	ControlGetFocus, focused, A
	If (A_TimeIdleMouse < 55)||(AppSwitchMode) {
		If WinActive("OneNote") {
			SetKeyDelay, -1, 11
			Send {RButton}{Down}{Enter}
		} Else
			Send ^w ; Close Tab
	} Else If GetKeyState("End", "P")
			ClearClipboardHistory()
	Else While GetKeyState("\", "P") {
		If WinActive("ahk_class CabinetWClass")&&renamestatus!=1&&(focused="DirectUIHWND3"||focused="SysTreeView321") {
			Send !{Up}
			Sleep 222
		} Else {
			SendLevel 1
			Send {BackSpace}
			Sleep 88
		}
	} Return
Enter::
	AppSwitchMode(111)
	If (AppSwitchMode) {
		WinClose, A
		Sleep 333
	} Else While GetKeyState("Enter", "P") {
		SendLevel 1
		Send {Delete}
		Sleep 88
	} Return
LButton & Enter::
	SendLevel 0
	Send {Click Up}{Click Right}d
	WinWaitActive, OneNote, delete, 3
	If !ErrorLevel
		Send y
	Return
Delete:: ; Escape, Stop & Save Search
	SendLevel 0
	KeyWait, Delete, T.13
	If (A_TimeIdleMouse < 177) {
		SetKeyDelay, 5, 11
		; SendInput +!^{Insert}
		; SendInput {PrintScreen}
		; WinWaitActive, Snip & Sketch
		; Sleep 888
		; Send {Space}
		Send {F6}
		WinWaitActive, Snip & Sketch
		Send ^n
		WinWaitActive, Screen Snipping
		Send {LButton Down}
		KeyWait, Delete
		Send {LButton Up}
		WinWaitClose, Screen Snipping
		WinWaitActive, Snip & Sketch
		Sleep 3333
		Send ^s
		WinWaitActive, Save As ahk_class #32770
		SendInput C:\•\%A_Now%{Enter}
	} Else If ErrorLevel {
		SendInput #{Tab}
	} Else If (Searching%NowAppID%) {
	 	Send ^a^c
	 	GoSub, SaveSearch
		GoSub, FinishSearch
	} Else {
		; SendLevel 1
		Send {Escape}
	} Return
<!Delete::
	SendLevel 0
	Send +{F10}d
	Return

<!LButton::
	SendLevel 0
	If WinActive("Visual Studio Code")
		Send ^k^o ; Open Folder
	Else
		Send ^o ; Open File
	Return


~LShift::
	SendLevel 0
	 If WinActive("ahk_group Browsers") {
	 	Send ^l ; Browser Address Bar
	 	If (A_PriorHotkey="Space & End")||(A_PriorHotkey="+^")||(A_PriorHotkey="+^c")
		Send %Clipboard%{Enter}
	} Else If WinActive("- OneNote")
		Send {LAlt}hzbpc ; Center Text OneNote
	Else If WinActive("Telegram")||WinActive("Unigram") {
		SetKeyDelay, -1, 55
		Send {Click, R}{Down}{Enter} ; Reply Telegram
	} Else If WinActive("ahk_exe Code.exe")
		Send ^k^0 ; Fold All
	Else If WinActive("Sublime Text")
		Send ^k^1 ; Fold All
	Else If WinActive("ahk_exe Explorer.EXE")
		Send !{Enter} ; Properties Explorer/Start Menu
	Return
; LShift & SC035:: ; Copy File Path
	If WinActive("ahk_class CabinetWClass") {
		Send +{RButton}
		WinWait, ahk_class #32768, , 1.5
		Send {a 2}{Enter}
	} Return
LButton & LShift::
Space & LShift:: ; Code Comment Out
	SendLevel 0
	Send ^{/}
	KeyWait, Space
	GoSub, TestScript
	Return

#InputLevel

; >^>+F8::
	SplashTextOn, •
	Sleep 333
	SplashTextOff
	Return

#If (A_ComputerName="X")
; scrollstep:=3
; WheelUp::notchup+=1
; WheelDown::notchdown+=1
; ScrollConsumer:
; 	SendMode InputThenPlay
; 	If (notchdown>=3) {
; 		Send {WheelDown %scrollstep%}
; 		notchdown=0
; 	}
; 	If (notchup>=3) {
; 		Send {WheelUp %scrollstep%}
; 		notchup=0
; 	}
; 	Return

#If


*LAlt::
	AppSwitchX(55)
	KeyWait, LAlt
	If WinActive("Task Switching")
		Click
	Else
		GoSub, ToggleLastWindow ; Toggle Last Window
	Return

; !^BackSpace::
	If WinActive("Firefox") {
		Send ^l+{Tab 2}+{F10}
		WinWait, ahk_class MozillaDropShadowWindowClass
		Send d
	}
	KeyWait, BackSpace, T.15
	If ErrorLevel&&WinActive("Firefox") {
		Sleep 555
		Send ^l+{Tab 2}+{F10}
		WinWait, ahk_class MozillaDropShadowWindowClass
		Send vw
	} Else {
		Send ^n
	} Return	

; Tab & BackSpace:: ; Tag Recent
	SendLevel 0
	Send +!^{F8}
	CenterWindow("ManicTime")
	Return
RShift:: ; Language Input
	KeyWait, RShift, T.11
	If ErrorLevel {
		Language:=1
		ToolTip ` ` •` ` `r` ` •` ` `r` ` •` ` 
	} Else {
		Language:=0
		ToolTip •
	}
	DestroyToolTip(111)
	LanguageSwitch(Language)
	Return
Space & RShift:: ; Transliterate
	SendLevel 0
	While GetKeyState("RShift", "P") {
		Send +^{Left}
		Sleep 222
	}
	Transliterate()
	Language:=!Language
	LanguageSwitch(Language)
	DestroyToolTip(777)
	Return


	; Scroll(intensity, delay) {
	; 	If (A_ComputerName="X") {
	; 		BlockInput 1
	; 		Loop %intensity% {
	; 			Sleep 1
	; 			Send {%A_ThisHotkey%}
	; 			Sleep %delay%
	; 		}
	; 		BlockInput 0
	; 	}
	; 	Return
	; }

; Scroller:
; 	If (ScrollDown>7) {
; 		;BlockInput 1
; 		Send {WheelDown}
; 		BlockInput 0
; 		ScrollDown:=0
; 	} Else If (ScrollUp>7) {
; 		;BlockInput 1
; 		Send {WheelUp}
; 		BlockInput 0
; 		ScrollUp:=0
; 		}
; 	Return
; WheelUp::ScrollDown+=1
; WheelDown::ScrollUp+=1
; Space & WheelUp::Scroll(7, 5)
; Space & WheelDown::Scroll(7, 5)

; Includes
	#Include *i %A_ScriptDir%\#.ahk ; Instances
	#Include *i %A_ScriptDir%\G.ahk ; Gestures
	#Include *i %A_ScriptDir%\&.ahk ; Clipboard
	#Include *i %A_ScriptDir%\§.ahk ; Language
	#Include *i %A_ScriptDir%\Z.ahk ; Text
	#Include *i %A_ScriptDir%\X.ahk ; Hotstrings
	#Include *i %A_ScriptDir%\%.ahk ; Utilities
	
~LButton:: ; Download Dialog, AHK Help Content Tab
	MouseGetPos, x0, y0
	If WinActive("Firefox") {
		WinWaitActive, ahk_class MozillaDialogClass, , 5
		; If !ErrorLevel
		; 	Send {Enter}
	} Else If WinActive("- Google Chrome") {
		WinWaitActive, Save As, , 5
		If !ErrorLevel
			SendInput {Left}C:\↓\!s
	} Else If WinActive("AutoHotkey Help")&&(x0<470)
		Click
	Return

Volume_Up::
	SendInput {Volume_Mute 2}
	SoundSet +%VolumeIncrement%
	Return
Volume_Down::
	SendInput {Volume_Mute 2}
	SoundSet -%VolumeIncrement%
	Return

#If WinActive(" - OneNote")
F10::
	If (A_TimeIdleMouse < 111) {
		Send {Click, R}
		KeyWait, F10
		Send {Click}
	} Else
		Send +{F10}
	Return
#If

Insert:: ; Accelerating Undo
	While GetKeyState("Insert", "P") {
		Send ^z
		Sleep A_TimeSinceThisHotkey < 333 ? 177 : 55
	} Return
Space & Insert:: ; Accelerating Redo
	While GetKeyState("Insert", "P") {
		If WinActive("- OneNote")
			Send ^y
		Else
			Send +^z
		Sleep A_TimeSinceThisHotkey < 333 ? 177 : 55
	} Return
Space & Delete:: ; [Remove Outlook Task][Insert Mode]
	If WinActive("- OneNote") ; Remove Outlook Task
		Send {LAlt}hztod
	Else
		SendPlay {Insert} ; Insert Mode
	Return
F1:: ; [Bold][Bookmarks Bar/History]
	KeyWait, F1, T.15
	If WinActive("- OneNote")&&!ErrorLevel
		Send ^b ; Bold
	Else If WinActive("ahk_class CabinetWClass") {
		Send +{Click, R}
		WinWaitActive, ahk_class #32768
		Send {a 2}{Enter}
		FileCreateShortcut, %Clipboard%, %Clipboard%
	} Else If WinActive("ahk_exe Code.exe") { ; Toggle Panel
		Send ^j
	} Else If !ErrorLevel {
		If WinActive("Chrome")
			Send +^b
		Else
			Send ^b
	} Else
		Send ^h
	Return	
F2:: ; [Highlight][Downloads/Flags]
	KeyWait, F2, T.15
	If WinActive("ahk_exe Code.exe")||WinActive("ahk_class ConsoleWindowClass") {
		; Send +^``
		Sleep 55
		Send SET client_encoding TO 'UTF8';{Enter}
	} Else If WinActive("Sublime Text") {
		Loop {
			SetKeyDelay, -1, 55
			x += 1
			Send %x%,{Space}{Down}{Home}
			} Until (x=23)
	} Else If WinActive("- OneNote")&&!ErrorLevel {
		If Highlight
			Send {LAlt}hzbfca
		Else
			Send {LAlt}hzbfc{Down}{Left 5}{Enter}
		Highlight:=!Highlight
	} Else If WinActive("ahk_exe Code.exe") { ; Toggle Vertical Activity Bar
		Send {LAlt}vaa
	} Else If !ErrorLevel {
		Send ^j
		CenterWindow("Library")
	} Else {
		Send ^t^l
		If WinActive("Google Chrome")
			Send chrome://flags{Enter}
		Else If WinActive("Brave")
			Send brave://flags{Enter}
		Else If WinActive("Firefox")
			Send about:config{Enter}
	} Return
 ; Transmission/VPN
F4:: ; Dark Mode: Toggle Current Site
	KeyWait, F4, T.15
	If (A_TimeIdleMouse < 111)
		Send +!g ; Theme Generation Mode
	Else If !ErrorLevel&&WinActive("Firefox")||WinActive("Tor")
		Send +!a ; Toggle Current Page
	Else If ErrorLevel&&WinActive("Firefox")||WinActive("Tor")
		Send +!d ; Toggle Extension
	Return
;F5:: ; Start/Run
	; KeyWait, F5, T.15
	; If !ErrorLevel
	; 	Run("ms-settings:")
	; Else
	; 	Run("Control Panel")
	; Return
	
F6:: ; Task/Device Manager
	KeyWait, F6, T.15
	If WinActive("ahk_exe doublecmd.exe") {
		If !ErrorLevel
			Send {F8} ; Menubar
		Else
			Send {F6} ; Settings
	} Else If !ErrorLevel {
		Run C:\Windows\System32\Taskmgr.exe
		CenterWindow("Task Manager")
	 } Else {
	 	If WinExist("Device Manager")
			WinClose Device Manager
		Else {
			Send ^{Escape}
			WinWait, Start, , .5
			Send Device Manager{Enter}
			; Sleep 111
			; Send {Enter}
			WinWaitActive, Device Manager
			WinMove, A,, 0, 0, 400, A_ScreenHeight
			Send {LAlt}vw ; show hidden devices
		}
	} Return
F8::
	If WinActive("HYDRA") {
		Send masterbeats{Tab}Azo135Wux097{Tab}
	} Else If WinActive("Brave") {
		Send +!n
		Sleep 111
		Send ^l
		Sleep 111
		Send hydraruzxpnew4af.onion{Enter}
	} Return
LButton & LWin:: ; Run selected in PowerShell
	If GetKeyState("LButton", "P")
		Send {LButton Up}
	Copy()
	Run powershell.exe
	WinWaitActive, PowerShell
	Paste()
	Send {Enter}
	Return
LButton & F8:: ; Sync config entry
	If WinActive("Mozilla Firefox") {
		SetKeyDelay, 11, 33
		KeyWait, LButton
		Send +{Home}
		Copy()
		Send {F6}{Tab 4}
		Send services.sync.prefs.
		Paste()
		Send {Tab 2}{Enter}+{Tab}
	} Return
F9:: ; Full Screen
	KeyWait, F9, T.15
	If !ErrorLevel {
		WinGetPos, , , w, h, A
		If (w<A_ScreenWidth)||(h<A_ScreenHeight) {
			Send #{Up}
			Send {F11}
		} Else
			Send #{Down}
		If WinActive("OneNote")&&(w<A_ScreenWidth)||(h<A_ScreenHeight) {
			Sleep 111
			ClickNoMove(1625, 32)
			Send {Down}{Enter}
		}
	} Else {
		WinGetPos, , , w, h, A
		If (w<A_ScreenWidth)||(h<A_ScreenHeight)
			Send #{Up}
		Else
			Send #{Down}
	}
	Return
F10:: ; Save/Save As
	KeyWait, F10, T.2
	If WinActive("Firefox")&&!ErrorLevel { ; Save Current Bookmark
		Send ^d
		Sleep 111
		Send {Tab}{Up}+{Tab}
	} Else If WinActive("Firefox")&&ErrorLevel { ; Bookmarks Bar. 
		Send +^b
	; } Else If WinActive(" - OneNote")&&!ErrorLevel { ; Tags
	; 	OneNoteKey("hg")
	; } Else If WinActive(" - OneNote")&&ErrorLevel { ; Recent Edits
	; 	OneNoteKey("snea")
	} Else If WinActive("ahk_exe ImageGlass.exe") {
		Send ^a2900{Tab}^a700{Tab}^a2600{Tab}^a5100{Tab 2}{Enter}
		WinWaitActive, ahk_class #32770
		Send !s
		Sleep 11
		Send y
	} Else If WinActive("- Word") { ; Resize Inserted Image
		SetKeyDelay, 1, 33
		Send {RButton}z
		WinWaitActive, ahk_class bosa_sdm_msword
		Send h44{Tab}{Enter}
	} Else If !ErrorLevel
		Send ^s
	Else
		Send +^s
	Return
Left:: ; Alt Click
	If (A_TimeIdleMouse<333) {
		Send {RButton}
		KeyWait, Left
		Sleep 55
		MouseGetPos, x, y, WinUnderMouse
		If (WinUnderMouse="ahk_class #32768")
			Click
	} Else If WinActive("Firefox") {
		Send {F6}{Tab 4}{Enter}
	} Else If WinActive("Brave")
		Send {F10}{Enter}
	Else 
		Send {LAlt}
	Return


#IfWinActive, Sublime Text
RCtrl::
	Send {RCtrl Down}{Click}
	KeyWait, RCtrl, T.15
	If ErrorLevel
		Click
	Send {RCtrl Up}
	Return
#If

RCtrl:: ; [Multiple Selection][Web open next tab][Web open next tab, switch]
	MouseGetPos, x0, y0, WinUnderMouse, CtrlUnderMouse
	If (CtrlUnderMouse="MSTaskSwWClass1")
		Send {MButton}
	Else {
		Send {RCtrl Down}{LButton Down}
		Loop {
			If (WinActive("Firefox")||WinActive("Brave")||WinActive("Tor"))&&(A_TimeSinceThisHotkey>111) {
				Send {Shift Down}{LButton Up}{Ctrl Up}{Shift Up}
			} Else If WinActive("Sublime Text") {
				Send {Click Up}{Click 2}
				Return
			}
		} Until !GetKeyState("RCtrl", "P")
			Send {Click Up}{RCtrl Up}
	} Return
	RCtrlHold:

RButton::
	SendLevel 0
	If WinActive("Task View") { ; Close Window
		Send {RButton}
		WinWaitActive, PopupHost ahk_class Xaml_WindowedPopupClass, , .11
		Send {Up}{Enter}
	; } Else If WinActive("Firefox")||WinActive("Brave")||WinActive("Tor")
	; 	Send ^w
	; Else If WinActive("Deezer") {
	; 	; CoordMode, Mouse, Window
	; 	; ClickNoMove(1777, 1010)
	; 	MouseGetPos, x0, y0
	; 	MouseClick, L, A_ScreenWidth*.93, A_ScreenHeight*.93
	; 	MouseMove, x0, y0
	; }
	} Else If WinActive("ahk_class CabinetWClass")
		SendInput !{Up} ; File Explorer Go Up
	Else If WinActive("Sublime Text") {
		LanguageSwitch(0)
		Sleep 55
		Send {Click}+^]
	} Else If WinActive("Gmail - Google Chrome") ; 
		Send {BackSpace}
	Else If WinActive("ahk_exe Code.exe") {
		MouseGetPos, x1, y1
		LanguageSwitch(0)
		Sleep 55
		Send % (x0!=x1)&&(y0!=y1) ? "+^{[}" : "+^{]}"
	} Else If WinActive("ahk_exe OneNote.exe") { ; Unfold
	 	Click
	 	Send +!{=}
	 } Else If WinActive("Outlook") ; Delete Task
	 	Send {Click R}d
	Else If WinActive("Unigram")||WinActive("Telegram")||WinActive("ahk_exe Notion.exe")||WinActive("WhatsApp")
		Send {Esc}
	Else
		Send ^w
	Return

LCtrl & LWin::GoSub, MouseKeyboardReload
LCtrl & LButton::MouseKeyboard(1) ; Across Enable
#SC029::
LCtrl & RButton::MouseKeyboard(0) ; Across Disable
LCtrl:: ; Quick Note/Start Menu
	If (A_TimeIdleMouse < 111) {
		SetKeyDelay, -1, 5
		Send #t{Tab}{Enter}
		WinWait, ahk_class Shell_TrayWnd, , 1.5
	} Else
		Send ^{Esc}
	Return

LWin:: ; Monitor Off, Reload [Script, OneNote]
	KeyWait, LWin
	SendLevel 0
	If (A_TimeIdleMouse < 111) {
		; SplashTextOn, 150, 50, , •••
		; Sleep 111
		; ReleaseModifiersX()
		; SplashTextOff
		; App("LWin", "Deezer", "Deez")
		Sleep 1111
		Run nircmd.exe monitor off
	} Else If WinActive(".ahk")&&!WinActive("AutoHotkey")
		GoSub, TestScript
	Else If WinActive(" - OneNote") {
		; OneNote Page Template Update
		OneNoteKey("ngt")
		WinWaitActive, ahk_class Framework::CFrame
		ControlFocus, REComboBox20W1, A
		Send •{Enter}{Esc}
		; OneNote Mark Notebook Read
		OneNoteKey("sr")
		Send {Down}{Enter}{Esc}
	} Else If WinActive("pgAdmin 4") {
		Send {F5}
		GoSub, ToggleLastWindow
		Send {F5}
		GoSub, ToggleLastWindow
	} Else
		Send {F5} ; Reload
	Return
LWIn Up::Return
#BackSpace::
	WinGetPos, x, y, w, h, A
	WinMove, OneNote, ,  x, y-100, w, h+100
	Return
#LButton:: ; [Mark Task Complete] Batch Save & Rename Images
	If WinActive("OneNote") {
		SendInput ^1` ✔ %A_DD%.%A_MM%` |` %A_Hour%•%A_Min% `
	} Else Loop {
		InputBox, PicTitle, , Rename, , , , 0, 0
		If ErrorLevel
			Break
		Else {
			Sleep 11	
			Send {Click, R}{Up 2}{Enter}
			WinWaitActive, Save
			Send %PicTitle%{Enter}
			WinWaitClose
			Send {Right}
		}
	} Return
#RButton:: ; Volume Slider
	SendLevel 0
	WinShow, ahk_class Shell_TrayWnd
	WinShow, Start ahk_class Button
	Send #b{Left}{Enter}
	WinHide, ahk_class Shell_TrayWnd
	WinHide, Start ahk_class Button
	Return

; Search
	Right:: ; Search
		GoSub, BeginSearch
		DestroyToolTip(1111)
		Return
	Space & Right::
		KeyWait, Right, T.15
		If ErrorLevel {
			Send !{F3} ; Find All
		} Else {
			Copy()
			GoSub, SaveSearch
			GoSub, BeginSearch
		} Return
	~Space & Tab::
		If WinActive("Sublime") {
			Send ^h
		} Return
 

	SearchTag:
	
		; ### ToolTip ###
		
		;WinGet, NowAppID, ID, A
		;If !Searching%NowAppID%
			;ToolTip, , , , %searchTagToolTip№%
		;Else {
			;MouseGetPos, x, y
			;ToolTip, ✯, x+10, y+20, %searchTagToolTip№%
			;WinGetPos, x, y
			;SplashTextOn, 50, , •••••
			;WinMove, x, y
			;SplashTextOn, •••••
			;Sleep 3000
			;SplashTextOff
		;}
		
		; ### GUI ###
		
		If !Searching%NowAppID%
			Gui, Hide
		Else {
		WinGetPos, x, y, w, h, A
		Gui, +Lastfound +AlwaysOnTop +Toolwindow
		iw:= w+4
		ih:= h+4
		w:=w+8
		h:=h+8
		x:= x - border_thickness
		y:= y - border_thickness
		Gui, Color, FF0077
		Gui, -Caption
		outerX:=0
	    outerY:=0
	    outerX2:=w-20+2*border_thickness
	    outerY2:=h-20+2*border_thickness
		innerX:=border_thickness
	    innerY:=border_thickness
	    innerX2:=border_thickness+w-20
	    innerY2:=border_thickness+h-20
	    newX:=x-border_thickness+10
	    newY:=y-border_thickness+10
	    newW:=w+2*border_thickness
	    newH:=h+2*border_thickness
		WinSet, Region, %outerX%-%outerY% %outerX2%-%outerY% %outerX2%-%outerY2% %outerX%-%outerY2% %outerX%-%outerY%    %innerX%-%innerY% %innerX2%-%innerY% %innerX2%-%innerY2% %innerX%-%innerY2% %innerX%-%innerY%
		Gui, Show, w%newW% h%newH% x%newX% y%newY% NoActivate, Table awaiting Action
		} Return
	SearchToolTip:
		nowsearch:=search%searchindex%
		ToolTip, %nowsearch%, x+10, y+20
		Return
	BeginSearch:
		If !WinActive("- OneNote") {
			Searching%NowAppID%:=1
			SetTimer, SearchTag, %searchtagtimer%
		}
		If WinActive("Sublime Text")
			Send ^i
		Else If WinActive("- OneNote") {
			Send ^e
		} Else
			Send ^f
		Sleep 77
		;Clipboard:=nowsearch
		;Sleep 11
		;Paste()
		SendInput % nowsearch
		Return
	FinishSearch:
		Send {Escape}
		Searching%NowAppID%:=0
		Return
	SaveSearch:
		ClipWait
		maxsearchindex+=1
		searchindex:=maxsearchindex
		nowsearch:=Clipboard
		search%searchindex%:=nowsearch
		Return



