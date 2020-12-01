; Code Toggle
  code(key, Short, Long) {
	KeyWait, %key%, T.17
	If !ErrorLevel
		file=%A_ScriptDir%."%Short%.ahk"
	Else
		file=%A_ScriptDir%."%Long%.ahk"
	Run, %A_ProgramsCommon%\Text, %file%
	Sleep 1111
	WinActivate, ahk_exe sublime_text.exe
	Return
  }
  Right & 3::code("3", "#", "№")
  Right & 0::code("0", "•", "°")
  Right & x::
	KeyWait, x, T.15
	If !WinActive("X.ahk")
	  Run %A_ProgramsCommon%\Text.lnk %A_ScriptDir%\X.ahk
	Sleep 111
	WinActivate, Sublime Text
	If ErrorLevel
	  GoSub, BeginSearch
	Return

; #
	LWin & o::
	<!o::
		App("Deezer", "Spotify")
		SendMode, InputThenPlay
		WinWaitActive, Deezer
		Sleep 1111
		Send !{Space}
		WinWait, ahk_class #32768
		Send r
		WinWaitActive, Deezer
		Send !{Space}
		WinWait, ahk_class #32768
		Send x
		WinWaitActive, Deezer
		Return
	LWin & SC033::
	<!SC033::App("Brave", "Brave")
  ; LWin & SC035::
  ; <!SC035::
  ;   App("OneNote", "OneNote")
  ;   WinWaitActive, OneNote
  ;   Sleep 3333
  ;   WinGetPos, x, y, w, h, A
  ;   ToolbarHeight:=150
  ;   WinMove, A, , x, y-%ToolbarHeight%, w, h+%ToolbarHeight%
  ;   Return
  ; LCtrl & SC034::
	LWin & SC034::
	<!SC034::App("ahk_exe Code.exe", "Code")
	LWin & 6::
	<!6:: ; Launch WebDev
	KeyWait, 6, T.2
	If ErrorLevel {
	  Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
	  WinWaitActive, ahk_exe powershell.exe
	  Send cd C:\notebook\notebook{Enter}
	  Send npm start{Enter}
	  WinWaitActive, Chrome
	  WinClose
	  ; WinActivate, ahk_exe powershell.exe
	  WinClose
	} Return
	LWin & 7::
	<!7::App("Double Commander", "2cmd") ; Explorer
	LWin & 8::
	<!8::
	KeyWait, 8, T.11
	If !ErrorLevel
	  App("ahk_exe Code.exe", "Code")
	Else
	  App("Windows PowerShell", "Terminal")
	Return
	LWin & 9::
	<!9::
	KeyWait, 9, T.11
	If !ErrorLevel
	  App("Mozilla Firefox", "Firefox")
	Else
	  App("Tor", "Tor")
	Return
	<!0::App("Unigram", "Unigram")
	LWin & n::
	<!n::ChromeWG("n", "WhatsApp", "Messages")
App(appTitle, Shortcut) {
  ; If GetKeyState("LAlt")
  ;   Send {LAlt Up}
  If !WinActive(appTitle)&&WinExist(appTitle) {
	WinActivate, % appTitle
	; If (title="Deezer")
	;   Click, R
  } Else If WinActive(appTitle) {
	WinGetClass, ActiveClass, A
	WinActivateBottom, ahk_class %ActiveClass%
  } Else If !WinExist(appTitle) {
	Run %A_ProgramsCommon%\%Shortcut%.lnk
	If (Shortcut="Tor") {
	  WinWait, About Tor
	  WinActivate
	  Send ^l
	  Sleep 111
	  ; Send hydraru zxpnew4af.onion{Enter}
	}
	WinActivate, % appTitle
  }
  Return
}
; App Toggle While Mouse Motion or Go to Address in Explorer
NumberAppKey(appTitle, appAddress, xAddress) {
	ControlGet, renamestatus,Visible,,Edit1,A
	ControlGetFocus, focused, A
	AppSwitchMode(111)
	If AppSwitchMode
		App(appTitle, appAddress)
	If WinActive("ahk_class CabinetWClass")&&(renamestatus!=1)&&(focused="DirectUIHWND3"||focused="SysTreeView321") {
		SendLevel 0
		Send !d
		Sleep 11
		SendInput %xAddress%{Enter}
	} Else While GetKeyState(A_ThisHotkey, "P") {
		SendLevel 1
		Send %A_ThisHotkey%
		Sleep 111
	} Return
}
; Chrome Widgets Manager
ChromeWG(key, Short№, Long№) {
  app=
  KeyWait, %key%, T.22
  If !ErrorLevel
	app=%Short№%
  Else
	app=%Long№%
  If WinExist(app)
	WinActivate
  Else {
	Run %A_Programs%\Chrome Apps\%app%
	WinWaitActive, %app%
	Sleep 444
	Send {F11}
	Sleep 444
	Send !{Escape}
	Sleep 5000
	WinActivate, %app%
  } Return
}
<!Home:: ; Previous Tab
  While GetKeyState("Home", "P") {
	; SetKeyDelay, -1, 33
	Send ^{PgUp}
	Sleep 155
  } Return
<!F11:: ; Next Tab
  While GetKeyState("F11", "P") {
	; SetKeyDelay, -1, 33
	Send ^{PgDn}
	Sleep 155
  } Return
<!BackSpace:: ; New Tab/Window
  SetKeyDelay, -1, 5
  KeyWait, BackSpace, T.15
  If WinActive("Firefox")||WinActive("Brave") {
  	Send ^t
  	Sleep 555
  	If (A_TImeIdlePhysical>333) {
		Send ^w^l
		Send % !ErrorLevel ? "+{Enter}" : "!{Enter}"
		Sleep 555
		Send ^l
	}
  } Else If WinActive("ahk_exe Code.exe")
	Send % !ErrorLevel ? "^n" : "+^n" ; New File/Window
  Else
	Send ^n ; New Window
  Return
<!\:: ; Close/Restore Tab
  KeyWait, \, T.15
  If !ErrorLevel {
	Send ^w
  } Else
	Send ^+t
  Return
<!Enter:: ; Close/Restore Window
  KeyWait, Enter, T.15
  If !ErrorLevel {
	WinGet, NowProcess, ProcessName, A
	WinClose, A
	; If WinExist("ahk_exe" NowProcess)
	;   WinActivateBottom, ahk_exe %NowProcess%
  } Else {
	Send +^t
  } Return
; <!LButton::WinMinimize, A
<!RButton::Send ^+t ; Reopen Tab
<!=:: ; OneNote Expand Outline/Zoom In
  If WinActive("- OneNote")
	Send +!= ; Expand Outline
  Else
	Send ^{=} ; Zoom In
  Return
<!-:: ; OneNote Collapse Outline/Zoom Out
  If WinActive("- OneNote")
	Send +!- ; Collapse Outline
  Else
	Send ^{-} ; Zoom Out
  Return
<!RAlt::
  While GetKeyState("RAlt", "P") {
	Send ^{Home}
	Sleep 111
  }
  ; KeyWait, LAlt
  Return
<!F12::
  While GetKeyState("F12", "P") {
	Send ^{End}
	Sleep 111
  } Return

AltApp:
  MMT:=55
  MouseGetPos, x1, y1
  If GetKeyState("LAlt", "P")&&((abs(y1-y0)>MMT)||(abs(x1-x0)>MMT)) {
	SetTimer, AltApp, Off
	Send !^{Tab}
	KeyWait, LAlt
	Click
	SetTimer, AltApp, 11
  } Return



AppSwitchX(MMT) {
  global
  MouseGetPos, x0, y0
  MouseMoveThreshold:=MMT
  SetTimer, MouseWatcher, 11
  Return
}

MouseWatcher:
  MouseGetPos, x1, y1
  If (abs(y1-y0)>MouseMoveThreshold)||(abs(x1-x0)>MouseMoveThreshold) {
	SetTimer, MouseWatcher, Off
	If GetKeyState("Space", "P")||GetKeyState("LAlt", "P")
	  Send ^!{Tab}
	  ; AppSwitchMode:=1
  } Return

MouseMotionSensor:
  MouseGetPos, x1, y1
  If (A_TimeIdleMouse>111)&&((abs(y1-y0)>MouseMotionArea)||(abs(x1-x0)>MouseMotionArea)) {
	SetTimer, , Off
	Click
  } Return

MouseMoved(MMT, delay) {
  global
  MouseGetPos, x0, y0
  MouseMoveThreshold:=MMT
  Sleep % delay
  SetTimer, MouseWatcher, 11
  Return
}

AppSwitchMode(mouseIdle) {
  global
  If (A_TimeIdleMouse<mouseIdle) {
	AppSwitchMode:=1
	MouseGetPos, x0, y0
	ToolTip, •`n•`n•, x0-10, y0-5
	SetTimer, AppSwitchMouseMotion, 11
  } Return
}
AppSwitchMouseMotion:
  MouseGetPos, x1, y1
  MouseMoveCoef:=33
  If (abs(y1-y0)>MouseMoveCoef)||(abs(x1-x0)>MouseMoveCoef) {
	SetTimer, AppSwitchMouseMotion, Off
	global AppSwitchMode:=0
	; MouseGetPos, x1, y1 
	; ToolTip, •`n•`n•, x1, y1
	; ; SplashTextOn, 333, 111
	; Sleep 333
	ToolTip
	; SplashTextOff
  } Return
ToggleLastWindow:
  If (!WinExist("ahk_id " LastAppID)||(LastAppID=""))
	Send {LAlt Down}{Escape}{LAlt Up}
  Else
	WinActivate, ahk_id %LastAppID%
  Return
NowWinActive:
  WinGet, NowWinActive, ID, A
  If (NowWinActive!=NowAppID) {
	If (NowAppID=LastAppID)
	  LastAppID:=""
	Else
	  LastAppID:=NowAppID
	NowAppID:=NowWinActive
  } Return


DialogResponse:
  If WinActive("ahk_class #32770") {
	CenterWindow("ahk_class #32770")
  }
  If WinActive(".zip ahk_class CabinetWClass") {
	WinGetActiveTitle, NowAppTitle
	Send {LAlt}ft
	WinWaitClose, %NowAppTitle%
	WinWaitActive, Extract Compressed (Zipped) Folders
	Send {Enter}
  } Else If WinActive(" - Uninstall") ; ||WinActive("Replace")
	Send y
  Else If WinActive("Registry Editor ahk_class #32770 ahk_exe regedit.exe") {
	Send y
	Sleep 33
	Send {Enter}
  } Else If WinActive("Save Changes?")
	Send n
  Else If WinActive("ahk_class FM") {
	Send ^a{F5}
	WinWaitActive, Copy, , 1.5
	Send {Enter}
	WinClose, ahk_class FM
  } Return
WindowStyle:
  ; IfWinExist, ahk_class RadialMenuHostWindow
  ; WinGetPos, , , w, h
  ; WinMove, , , w*0.5, h*0.5
  If WinActive("ahk_class OperationStatusWindow") {
	WinGet, NowAppID, ID, A
	WinGetPos, , y, w, , A
	If (y>0)
	  WinMove, A, , A_ScreenWidth-w, 0
  } Else If WinActive("ahk_exe cmd.exe")&&!cmdWindowStyled%NowAppID% {
	WinGet, NowAppID, ID, A
	WinMove, A, , , , 1000, 555
	cmdWindowStyled%NowAppID%:=1
  } Else If WinActive("ahk_exe Explorer.EXE") {
	WinShow, ToolbarWindow326
  } Return
WindowResponse:
  ; If WinActive(".zip ahk_class CabinetWClass") {
  ;   WinGet, NowAppID, ID, A
  ;   Send {LAlt}jz
  ;   WinWait, ahk_class Net UI Tool Window
  ;   Send a
  ;   WinWaitActive, Extract Compressed (Zipped) Folders
  ;   Send {Enter}
  ;   WinWaitClose, ahk_id %WindowResponse% 
  If WinActive("Extract Compressed (Zipped) Folders") {
  	ControlSend, #327701, {Enter}, A
  }
  If WinActive("ahk_exe 7zFM.exe") {
	SetTimer, , Off
	Send {F5}
	WinWaitActive, Copy ahk_class #32770
	Send {Enter}
	WinWaitClose
	Send ^w
	Sleep 5
	SetTimer, , On
  } Else If WinActive("Opening ahk_class MozillaDialogClass ahk_exe firefox.exe") { ; Save Executable
	Sleep 1111
	Send {Left}{Enter}
  } Else If WinActive("ahk_exe WindowsTerminal.exe") {
	WinGetPos, , y, w, h, A
	If (y>11)||(h<A_ScreenHeight*0.8)
	  Send #{Right}
	Sleep 111
   } Return

CenterWindow(target) {
  SetWinDelay, -1
  WinWait, %target%
  WinGetPos, , , Width, Height, %target%
  WinMove, %target%, , (A_ScreenWidth-Width)/2, (A_ScreenHeight-Height)/2
  Return
}
CenterMouse() {
  CoordMode, Mouse, Screen
  MouseMove, A_ScreenWidth/2, A_ScreenHeight/2
  Return
}

; Move window to side
<#RAlt::Send #{Up}
<#F12::Send #{Down}
<#F11::Send #{Right}
<#Home::Send #{Left}
; LCtrl & F12:: ; [Toggle Window Title][Toggle Window Menubar]
  KeyWait, F12, T.2
  If !ErrorLevel 
	WinSet, Style, ^0xC00000, A 
  Else {
	DllCall("SetMenu", uint, WinActive( "A" ), uint, 0)
	ToggleMenu( WinExist("A") )
  } Return
  ToggleMenu( hWin )
  {
	static hMenu, visible
	if hMenu =
	  hMenu := DllCall("GetMenu", "uint", hWin)
	if !visible
	  DllCall("SetMenu", "uint", hWin, "uint", hMenu)
	else
	  DllCall("SetMenu", "uint", hWin, "uint", 0)
	visible := !visible
	Return
  }
; LCtrl & F1::
  KeyWait, F1, T.15
  If !ErrorLevel
	Run %A_Programs%
  Else
	Run %A_ProgramsCommon%
  Return

Up:: ; Move Window
  CoordMode, Mouse ; Switch to screen/absolute coordinates.
  MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
  WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,, EWD_OriginalHeight, ahk_id %EWD_MouseWin%
  WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
  If (EWD_OriginalHeight>A_ScreenHeight*0.93)
	SetTimer, EWD_WatchMouseStretched, 10
  Else if (EWD_WinState = 0) ; Only if the window isn't maximized
	SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
  Return
  EWD_WatchMouseStretched:
  GetKeyState, EWD_KeyState, Up, P
  if EWD_KeyState = U ; Button has been released, so drag is complete.
	SetTimer, EWD_WatchMouseStretched, off
  GetKeyState, EWD_EscapeState, Delete, P
  if (EWD_EscapeState = D) { ; Escape Hotkey Break
	SetTimer, EWD_WatchMouseStretched, off
	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
  }
  ; Otherwise, reposition the window to match the change in mouse coordinates
  ; caused by the user having dragged the mouse:
  CoordMode, Mouse
  MouseGetPos, EWD_MouseX, EWD_MouseY
  WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
  SetWinDelay, -1 ; Makes the below move faster/smoother.
  WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, 0, , A_ScreenHeight
  EWD_MouseStartX := EWD_MouseX ; Update for the next timer-call to this subroutine.
  EWD_MouseStartY := EWD_MouseY
  return
  EWD_WatchMouse:
  GetKeyState, EWD_KeyState, Up, P
  If EWD_KeyState = U ; Button has been released, so drag is complete.
	SetTimer, EWD_WatchMouse, off
  GetKeyState, EWD_EscapeState, Delete, P
  if (EWD_EscapeState = D) { ; Escape has been pressed, so drag is cancelled.
	SetTimer, EWD_WatchMouse, off
	WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
  }
  ; Otherwise, reposition the window to match the change in mouse coordinates caused by the user having dragged the mouse:
  CoordMode, Mouse
  MouseGetPos, EWD_MouseX, EWD_MouseY
  WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
  SetWinDelay, -1 ; Makes the below move faster/smoother.
  WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
  EWD_MouseStartX := EWD_MouseX
   ; Update for the next timer-call to this subroutine.
  EWD_MouseStartY := EWD_MouseY
  return
Down:: ; Resize Window
  CoordMode, Mouse ; Switch to screen/absolute coordinates.
  MouseGetPos, EWR_MouseStartX, EWR_MouseStartY, EWR_MouseWin
  WinGetPos, EWR_OriginalPosX, EWR_OriginalPosY,,, ahk_id %EWR_MouseWin%
  WinGet, EWR_WinState, MinMax, ahk_id %EWR_MouseWin%
  if EWR_WinState = 0 ; Only if the window isn't maximized
  SetTimer, EWR_WatchMouse, 10 ; Track the mouse as the user drags it.
  return
  
  EWR_WatchMouse:
  GetKeyState, EWR_KeyState, Down, P
  If EWR_KeyState = U ; Button has been released, so drag is complete.
	SetTimer, EWR_WatchMouse, off
  GetKeyState, EWR_EscapeState, Delete, P
  If (EWR_EscapeState = D) { ; Escape has been pressed, so drag is cancelled.
	SetTimer, EWR_WatchMouse, off
	WinMove, ahk_id %EWR_MouseWin%,, %EWR_OriginalPosX%, %EWR_OriginalPosY%
  }
  ; Otherwise, reposition the window to match the change in mouse coordinates
  ; caused by the user having dragged the mouse:
  CoordMode, Mouse
  MouseGetPos, EWR_MouseX, EWR_MouseY
  WinGetPos, EWR_WinX, EWR_WinY, EWR_WinW, EWR_WinH, ahk_id %EWR_MouseWin%
  SetWinDelay, -1 ; Makes the below move faster/smoother.
  if (EWR_MouseX-EWR_WinX) <= (EWR_WinW/3)
  {
  if (EWR_MouseY-EWR_WinY) <= (EWR_WinH/3)
	WinMove, ahk_id %EWR_MouseWin%,, EWR_WinX + EWR_MouseX - EWR_MouseStartX, EWR_WinY + EWR_MouseY - EWR_MouseStartY, EWR_WinW + EWR_MouseStartX - EWR_MouseX, EWR_WinH + EWR_MouseStartY - EWR_MouseY
  else if (EWR_MouseY-EWR_WinY) <= (EWR_WinH/3)*2
	WinMove, ahk_id %EWR_MouseWin%,, EWR_WinX + EWR_MouseX - EWR_MouseStartX, , EWR_WinW + EWR_MouseStartX - EWR_MouseX,
  else
	WinMove, ahk_id %EWR_MouseWin%,, EWR_WinX + EWR_MouseX - EWR_MouseStartX, , EWR_WinW + EWR_MouseStartX - EWR_MouseX, EWR_WinH + EWR_MouseY - EWR_MouseStartY
  
  }
  else if (EWR_MouseX-EWR_WinX) <= (EWR_WinW/3)*2
  {
  If (EWR_MouseY-EWR_WinY) <= (EWR_WinH/2)
	WinMove, ahk_id %EWR_MouseWin%,,, EWR_WinY + EWR_MouseY - EWR_MouseStartY,, EWR_WinH + EWR_MouseStartY - EWR_MouseY
  Else
	WinMove, ahk_id %EWR_MouseWin%,,,,, EWR_WinH + EWR_MouseY - EWR_MouseStartY
  }
  else
  {
  if (EWR_MouseY-EWR_WinY) <= (EWR_WinH/3)
  {
  WinMove, ahk_id %EWR_MouseWin%,,, EWR_WinY + EWR_MouseY - EWR_MouseStartY, EWR_WinW + EWR_MouseX - EWR_MouseStartX, EWR_WinH + EWR_MouseStartY - EWR_MouseY
  }
  else if (EWR_MouseY-EWR_WinY) <= (EWR_WinH/3)*2 {
	WinMove, ahk_id %EWR_MouseWin%,,, , EWR_WinW + EWR_MouseX - EWR_MouseStartX,
  }
  else
  {
  WinMove, ahk_id %EWR_MouseWin%,,, , EWR_WinW + EWR_MouseX - EWR_MouseStartX, EWR_WinH + EWR_MouseY - EWR_MouseStartY
  }
  }
  EWR_MouseStartX := EWR_MouseX ; Update for the next timer-call to this subroutine.
  EWR_MouseStartY := EWR_MouseY
  return