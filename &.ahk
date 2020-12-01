; Add clipboard data to the stack when copy/paste.
ClipboardAdd(content) {
	ClipboardBackup:=ClipboardAll
	Clipboard:=content
	GoSub, ClipStack
	Clipboard:=ClipboardBackup
	Return
}
ClipStack: ; Add Entry
	maxindex+=1
	clipindex:=maxindex
	clip%clipindex%:=Clipboard
	Sleep 11
	GoSub, ClipMenu
	FileAppend, %Clipboard%, C:\Clipboard\clip%clipindex%.txt
	DestroyToolTip(777)
	Return
ClipMenu: ; Scroll Entries
	thisclip:=clip%clipindex%
	; If (thisclip!=previousclip) { ; fixing tooltip flickering due to being called on same contents.
		MouseGetPos, x, y
		ToolTip, % SubStr(thisclip, 1, 88)
	; }
	previousclip:=thisclip
	Return
	
	CopyPastetoLastWindow:
		Copy()
		Sleep 55
		WinGet, NowAppID, ID, A
		WinActivate, ahk_id %LastAppID%
		LastAppID:=NowAppID
		Sleep 55
		Paste()
		WinActivate, ahk_id %LastAppID%
		Return

getClipboard() {
	JustClip:=ClipboardAll
	Clipboard:=""
	Copy()
	ClipWait
	NowThisClip:=ClipboardAll
	Clipboard:=""
	Clipboard:=JustClip
	ClipWait
	Return %NowThisClip%
}
CapsLock & RShift:: ; Great example of using methods.
	ThisClip.getClipboard()
	MsgBox, %ThisClip%
	Return
ClearClipboardHistory() {
	FileDelete, C:\Clipboard\clip*.*
	Clipboard := ""
	thisclip :=
	SplashTextOn, 333, 77, , Clipboard History Deleted
	Sleep 1111
	SplashTextOff
	GoSub, TestScript
	Return
}
Paste() {
	If (A_PriorHotkey="<!BackSpace") {
		Send ^l
		Sleep 111
		Send ^v{Enter}
	} Else If WinActive("- OneNote")||WinActive("ahk_class ApplicationFrameWindow")
		SendPlay ^v
	Else
		Send ^v
	Sleep 11
	Return
}
Copy() {
	; Clipboard=""
	If WinActive("- OneNote")
		SendPlay ^c
	Else
		Send ^c
	ClipWait
	Sleep 5
	GoSub, ClipStack
	Return 
}
Cut(){
	; Clipboard=""
	If WinActive("- OneNote")
		SendPlay ^x
	Else
		Send ^x
	ClipWait
	Sleep 5
	GoSub, ClipStack
	Return 
}
PasteLink:
	Send ^k
	If WinActive("- OneNote")
		Send !t
	KeyWait, CapsLock, D
	Sleep 111
	Paste()
	Sleep 111
	Send {Enter}
	Sleep 11
	Return
PasteLinkOfMarkedTitle(ItemTitle, ItemLink) {
	Send ^k
	Send %ItemTitle%
	Send {Tab}
	Send %ItemLink%
	Send {Tab}{Space}
	Return
}

End:: ; Paste
 	GoSub, ClipMenu
	; Send #v
	; WinWait, ahk_class Shell_LightDismissOverlay
	KeyWait, End
	; If (A_PriorHotkey="LShift") {
	; 	Send {Esc}^l
	; 	Copy()
	; 	Sleep 111
	; 	GoSub, ToggleLastWindow
	; 	Sleep 111
	; 	GoSub, PasteLink
	; } Else
	; Send {Enter}
	If (A_PriorKey!="CapsLock") {
		Clipboard:=""
		Clipboard:=clip%clipindex%
		; ClipWait
		Paste()
		DestroyToolTip(11)
	} Return
Space & End:: ; Copy/Cut
	KeyWait, End, T.15
	; If ErrorLevel
	; 	Cut()
	; Else
	; 	Copy()
	ErrorLevel ? Cut()	: Copy()

	Return

; Text navigation
F12::
	AppSwitchMode(111)
 	While GetKeyState("F12", "P") {
 		If AppSwitchMode {
			Send +!- ; Jump Next
			Sleep 155
		} Else If (GetKeyState("End", "P")) {
			If (clipindex<maxindex) {
				clipindex += 1
				FileRead, clip%clipindex%, C:\Clipboard\clip%clipindex%.txt
				GoSub, ClipMenu
				Sleep 188
			}
			; Send {Down}
			; Sleep 77
		} Else If Searching%NowAppID% {
			Send {F3}
			Sleep 111
		} Else If GetKeyState("Right", "P") {
			If (searchindex < maxsearchindex)
				searchindex += 1
			GoSub, SearchToolTip
			} Else If WinActive("- OneNote")
				SendPlay {Down} 
			Else
				Send {Down}
		If (A_TimeSinceThisHotkey<155)
			Sleep 111
	} Return
	Space & F12::
	 While GetKeyState("F12", "P") {
	 	If WinActive("- OneNote")
	 		SendPlay +{Down}
	 	Else
	 		Send +{Down}
	 	If A_TimeSinceThisHotkey < 222
			Sleep 55
		Else
			Sleep 11
	 } Return
F11::
	AppSwitchMode(111)
	If AppSwitchMode {
		While GetKeyState("F11", "P") {
			Send ^{PgDn}
			Sleep 155
		}
	} Else {
		Sleep %WordJump%
		If !GetKeyState("F11", "P")
			Send ^{Left}
		Else While GetKeyState("F11", "P") {
			If (AppSwitchMode)
				Send ^{PgDn}
			Else
				Send {Left}
			Sleep 123
		}
	} Return
	Space & F11::
	Sleep %WordJump%
	If GetKeyState("LAlt", "P")
		Send +^{PgUp}
	Else If !GetKeyState("F11", "P")
		Send +^{Left}
	Else While GetKeyState("F11", "P") {
		Send +{Left}
		Sleep 123
	} Return
	CapsLock & F11::
	KeyWait, F11, T.15
	Send % !ErrorLevel ? "{Home}" : "+{Home}"
	Sleep 123
	Return
Home::
	AppSwitchMode(111)
	If AppSwitchMode {
		While GetKeyState("Home", "P") {
			Send ^{PgUp}
			Sleep 155
		}
	} Else {
		Sleep %WordJump%
		If !GetKeyState("Home", "P")
			Send ^{Right}
		Else While GetKeyState("Home", "P") {
			If (AppSwitchMode)
				Send ^{PgUp}
			Else
				Send {Right}
			Sleep 123
		}
	} Return
	Space & Home::
	Sleep %WordJump%
	If GetKeyState("LAlt", "P")
		Send +^{PgUp}
	Else If !GetKeyState("Home", "P")
		Send +^{Right}
	Else While GetKeyState("Home", "P") {
		Send +{Right}
		Sleep 123
	} Return
	CapsLock & Home::
	KeyWait, Home, T.15
	Send % (!ErrorLevel) ? "{End}" : "+{End}"
	Sleep 123
	Return
RAlt::
	LCtrl & RAlt::
 	AppSwitchMode(111)
 	While GetKeyState("RAlt", "P") {
 		If AppSwitchMode {
			Send !- ; Jump Previous
			Sleep 155
		} Else If GetKeyState("End", "P") {
			If (clipindex > 1) {
	 			clipindex -= 1
	 			FileRead, clip%clipindex%, C:\Clipboard\clip%clipindex%.txt
	 			GoSub, ClipMenu
	 			Sleep 188
	 			}
 			; Send {Up}
 			; Sleep 88
 		} Else If (Searching%NowAppID%	) {
 			Send +{F3}
 			Sleep 111
 		} Else If GetKeyState("Right", "P") {
 			If (searchindex > 1)
 				searchindex -= 1
 			GoSub, SearchToolTip
 		} Else If WinActive("- OneNote")
 			SendPlay {Up}
 		Else
 			Send {Up}
		If (A_TimeSinceThisHotkey<222)
			Sleep 111
 		} Return

	Space & RAlt::
		While GetKeyState("RAlt", "P") {
		 	If WinActive("- OneNote")
		 		SendPlay +{Up}
		 	Else
		 		Send +{Up}
		 	If A_TimeSinceThisHotkey < 222
		 		Sleep 55
		 	Else
		 		Sleep 11
		} Return

Space & LButton:: ; Copy/Cut to chosen window
	KeyWait, LButton, T.3
	WinGet, NowAppID, ID, A
	Send +{Click}
	If !ErrorLevel
		Copy()
	Else
		Cut()
	Send !^{Tab}
	KeyWait, Space
	Click
	WinWaitNotActive, ahk_id %NowAppID%
	Sleep 33
	Paste()
	Send {Tab}
	GoSub, ToggleLastWindow
	Return

Space & BackSpace:: ; Timestamp/Shoot Letter
	KeyWait, BackSpace, T.15
	If WinActive("X.ahk") {
		InputBox, Hotstring, Hotstring, , , 300, 100, (A_ScreenWidth-500)/2, (A_ScreenHeight-300)/2
		InputBox, HotstringAbr, Hotstring's Shortcut, , , 300, 100, (A_ScreenWidth-500)/2, (A_ScreenHeight-300)/2
		Send {Home 2}{Enter}{Up}::%HotstringAbr%::%Hotstring%{Enter}{Tab}::%HotstringAbr%s::%Hotstring%s{Enter}::%HotstringAbr%'::%Hotstring%{BackSpace}ing{Enter}::%HotstringAbr%d::%Hotstring%d{Enter}::%HotstringAbr%n::%Hotstring%tion
		Send +{Home}{Up 3}
	} Else If (Searching%NowAppID%)&&WinActive("X.ahk") {
		Send ^a^c
		GoSub, FinishSearch
		InputBox, HotstringAbr, Hotstring Shortcut, , , 300, 100, (A_ScreenWidth-500)/2, (A_ScreenHeight-300)/2, , XString
		ClipWait, 0, 1
		Send {Home 2}{Enter}{Up}::%HotstringAbr%::%Clipboard%{Enter}{Tab}::%HotstringAbr%s::%Clipboard%s{Enter}::%HotstringAbr%'::%Clipboard%{BackSpace}ing{Enter}::%HotstringAbr%d::%Clipboard%d{Enter}::%HotstringAbr%n::%Clipboard%tion
		Send +{Home}{Up 3}
		Clipboard:=NowClip
		HotstringAbr:=""
	} Else If !ErrorLevel&&WinActive("ahk_exe sublime_text.exe") {
		WinGetClass, NowClass, A
		If (NowClass="#32770") {
			Copy()
			Send {Enter}
			WinWaitActive, - Sublime Text
			Send ^g
			Paste()
			Send {Esc}
		} Else
			Send ^g
	} Else If WinActive("- OneNote")&&!ErrorLevel
		GoSub, TimeStamp
	Else If ErrorLevel {
		GoSub, GlobalOneNoteOpen
	} Else If WinActive("ahk_exe doublecmd.exe") { ; New Directory
		Send {F1}
	} Else If WinActive("pgAdmin 4 - Mozilla Firefox")
		Send {F5} ; Run query
	Return
Space & \::
	While GetKeyState("\", "P") {
		Send +^{Left}{BackSpace}
		Sleep 88
	} 
	Hotstring("Reset")
	Return
Space & Enter::
	While GetKeyState("Enter", "P") {
		Send ^+{Right}{Del}
		Sleep 88
	} Return
Space & CapsLock::Send +{Tab}
Space & RCtrl:: ; Expanding Select All
	While GetKeyState("RCtrl", "P") {
		Send ^a
		Sleep 222
	} Return
Tab:: ;; Rotary Listing
	While GetKeyState("Tab", "P") {
		If WinActive("ahk_class CabinetWClass") {
			Sleep 111
			If GetKeyState("Tab", "P") {
				Send ^c
			} Else {
				Send ^x
			}
			Sleep 111
			Send {Tab}^v{Tab}
		} Else If !KeyRotate {
			Send {Tab}
			KeyRotate:=1
		} Else If (KeyRotate=1) {
			Send ^{.}
			KeyRotate:=2
		} Else If (KeyRotate=2) {
			Send ^{/}
			KeyRotate:=3
		} Else If (KeyRotate=3) {
			Send ^{.}+{Tab}
			KeyRotate:=0
		}
		Sleep 333
	} Return
CapsLock::
	SendLevel 0
	Send {Tab}
	Return
CapsLock & BackSpace:: ; Select — Delete Line
	Send {End}+{Home}
	KeyWait, BackSpace, T.2
	If ErrorLevel
		Send +{Home}^{BackSpace 2}
	Return
CapsLock & \::Send +{Home}{BackSpace} ; Delete line to left
CapsLock & Enter::Send +{End}{Delete} ; Delete line to right
CapsLock & End:: ; Copy/Cut Line
	KeyWait, End, T.15
	If !ErrorLevel
		Copy()
	Else
		Cut()
	Return
<!End:: ; Copy from current, paste to last window.
	Copy()
	Sleep 111
	GoSub, ToggleLastWindow
	Sleep 111
	Paste()
	Send {Tab}
	GoSub, ToggleLastWindow
	Return
LButton & Space:: ; Copy/Cut
	KeyWait, Space, T.2
	If !ErrorLevel
		Copy()
	Else
		Cut()
	Return
LButton & End:: ; Copy selected title & link
	Copy()
	ClipWait, 0, 1
	ItemTitle:=Clipboard
	Sleep 222
	SendInput {F6}
	Copy()
	ClipWait, 0, 1
	TitleLink:=Clipboard
	Return

<!F10:: ; Paste browser page link to last window & stay there.
	SetKeyDelay, -1, 5
	Send ^l^c
	Sleep 111
	GoSub, ToggleLastWindow
	Sleep 55
	Send ^k{Tab}
	KeyWait, CapsLock, D
	Send {Tab}^v{Enter}
	Return
Space & F10:: ; Create Link from Text Selected
	WinGet, NowAppID, ID, A
	Send ^k
	App("Mozilla Firefox", "Firefox")
	KeyWait, LShift, D
	Send {Esc}^l
	Copy()
	WinActivate, ahk_id %NowAppID%
	Paste()
	Send {Tab}{Space}
	Return

