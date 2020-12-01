LanguageTip:
	Language:=!Language
	If Language
		ToolTip ` ` •` ` `r` ` •` ` `r` ` •` ` 
	Else
		ToolTip •
	Return

LanguageSwitch(Language) {
	If Language
		Send +!1
	Else
	 	Send +!0
	Sleep 5
	Return
}

#InputLevel 1
SC029::Key("SC029", "``", "~", "ё", "~")
SC033::
	AppSwitchMode(111)
	If AppSwitchMode
		App(" - Mozilla Firefox", "Firefox")
	Else
		Key("SC033", ",", ", `", "б", "б")
	Return
SC034::
	AppSwitchMode(111)
	If AppSwitchMode
		App(" - Sublime Text", "Text")
	Else
		Key("SC034", ".", ". `", "ю", "ю")
	Return
<!SC035::
SC035::
	AppSwitchMode(111)
	If (AppSwitchMode)||GetKeyState("LAlt", "P") {
		App("OneNote", "OneNote")
		WinWaitActive, OneNote
		Sleep 777
		ToolbarHeight:=133
		; WinMove, A, , 0, -ToolbarHeight, A_ScreenWidth, A_ScreenHeight
	} Else
		Key("SC035", "/", "\", ".", ". `")
	Return
Space & SC035::Key("SC035", "?", "?!", ",", "/")

*SC027::
	SendLevel 0
	If (A_TimeIdleMouse<111)||(GetKeyState("LAlt", "P")) {
		App( " - Deezer", "Deez")
	} Else If GetKeyState("Space", "P") {
		Key("SC027", ":", " `", "Ж", "Ж `")
	} Else {
		Key("SC027", ";", "; `", "ж", "ж `")
	} Return

Space & SC01A::Key("SC01A", "{", "[", "Х", "[")
Space & SC01B::Key("SC01B", "}", "]", "Ъ", "]")
SC01A::
	AppSwitchMode(111)
	If AppSwitchMode
		App("- Notion", "Notion")
	Else
		Key("SC01A", "(", "(""", "х", "(")
	Return
SC01B::
	AppSwitchMode(111)
	If AppSwitchMode
		App(" - Sticky Notes", "Sticky Notes")
	Else
		Key("SC01B", ")", """)", "ъ", ")")
	Return
; Number Keys

	1::NumberAppKey("", "", "This PC")
	2::NumberAppKey("", "", "C:\•\")
	3::NumberAppKey("", "", "C:\↓\")
	4::NumberAppKey("", "", "C:\•\Bambook\")
	5::NumberAppKey("", "", "C:\OneDrive\")
	6::NumberAppKey("", "", A_ProgramsCommon)
	7::NumberAppKey("ahk_exe doublecmd.exe", "2cmd", "")
	8::NumberAppKey("Studio Code", "Code", "")
	9::NumberAppKey("- Brave", "Brave", "")
	0::NumberAppKey("Unigram", "Unigram", "C:\OneDrive\")

Space & 1::
	KeyWait, 1, T.13
	SendLevel 1
	If !ErrorLevel
		SendRaw !
	Else
		Send ` {|} `
	Return
Space & 2::
	KeyWait, 2, T.13
	SendLevel 1
	If !ErrorLevel
		SendRaw @
	Else
		SendRaw "
	Return
Space & 3::
	KeyWait, 3, T.13
	SendLevel 1
	If !ErrorLevel
		Send {#}
	Else
		Send {№}
	Return

Space & 9::
	SendLevel 0
	SendRaw ₽
	Return
Space & 0::
	KeyWait, 0, T.13
	If !ErrorLevel
		SendRaw •
	Else
		SendRaw °
	Return
Space & 7::
	KeyWait, 7, T.13
	SendLevel 1
	If (!ErrorLevel&&!Language)
		Send {&}
	Else If (ErrorLevel&&!Language) {
		Send {.}
		Sleep 5
		SendInput `b||
	} Else If (!ErrorLevel&&Language)
		Send ?
	Else If (ErrorLevel&&Language)
		SendRaw ?!
	Return

-::
	; KeyWait, -, T.11
	; SendLevel 1
 	AppSwitchMode(111)
 	If AppSwitchMode
		Send ^{-} ; Zoom Out
	; Else If ErrorLevel {
	; 	Send {Space} 
	; 	Sleep 5
	; 	Send — `
	; } Else
	; 	Send {-}
	Else
		Key(A_ThisHotkey, "-", " — ", "-", " — ")
	Return
=::
	KeyWait, =, T.13
	SendLevel 1
 	AppSwitchMode(111)
 	If AppSwitchMode
		Send ^{=} ; Zoom In
	Else If !ErrorLevel
		Send {+}
	Else
		Send {≈}
	Return
Space & =::
	KeyWait, =, T.13
	SendLevel 1
	If !ErrorLevel
		Send {=}
	Else
		Send {≠}
	Return
#InputLevel 0

Symbol(key, Short, Long) {
	KeyWait, %key%, T.17
	If !ErrorLevel
		Send %Short%
	Else
		Send %Long%
	Sleep 111
	If !GetKeyState("CapsLock", "P") {
		SendLevel 1
		Send {Space}
	}
	Return
}
; Special Characters
	; +Up::Send Up
	; +Down::Send Down
	CapsLock & SC035::Symbol("SC035", "...", "|")
	CapsLock & Up::Send {↑}
	CapsLock & Down::Send {↓}
	CapsLock & Left::Send {←}
	CapsLock & Right::Send {→}
	CapsLock & SC034::Send {≥}
	CapsLock & SC033::Send {≤}
	CapsLock & SC029::Send {≠}
	CapsLock & 2::Send {²}
	CapsLock & 3::Send {³}
	CapsLock & 4::Send {€}
	CapsLock & 5::Symbol("5", "✔", "✯")
	CapsLock & 6::Symbol("6", "^", "ˇ")
	CapsLock & 7::Send {§}
	CapsLock & 8::Send {∞}
	CapsLock & 9::Send {₽}
	CapsLock & 0::Symbol("0", "•", "°")
	CapsLock & -::Send {÷}
	CapsLock & =::Send {×}
	CapsLock & a::Symbol("a", "Δ", "∀")
	CapsLock & e::Send {Σ}
	CapsLock & u::Send {ü}
	CapsLock & p::Send {∏}
	CapsLock & m::Send {μ}
	CapsLock & o::Symbol("o", "Ω", "ó")






Key(key, ensh, enlg, rush, rulg) {
	; global
	SendLevel 1
	SetKeyDelay, -1, 5
	If !Language
		SendRaw %ensh%
	Else If Language
		SendRaw %rush%
	Sleep 111
	If GetKeyState(key, "P") {
		SendPlay {BackSpace}
		If !Language
			Sending:=enlg
		Else If Language
			Sending:=rulg
		If StrLen(Sending)>1 {
			SendRaw % SubStr(Sending, 1, 1)
			Sleep 5
			SendRaw % SubStr(Sending, 2, StrLen(Sending)-1)
		} Else
			SendRaw % Sending
	} Return
}
Transliterate() {
	SendLevel 0
	NowClip:=ClipboardAll
	Clipboard:=""
	; Sleep 11
	SendInput ^x
	; Sleep 11
	ClipWait
	transliterated:=transformTextLayout(Clipboard)
	Sleep 1
	; SetKeyDelay, 5, 5
	Send %transliterated%
	Clipboard:=NowClip
	; NowClip:=""
	; transliterated:=""
	Return
}
transformTextLayout(textContainer) {
	en := "``qwertyuiop[]asdfghjkl;'zxcvbnm,./~@#$^&QWERTYUIOP{}ASDFGHJKL:""ZXCVBNM<>?"
	ru := "ёйцукенгшщзхъфывапролджэячсмитьбю.Ё""№;:?ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,"
	textContainer ~= "i)[a-z]" ? (layoutIn := en, layoutOut := ru) : (layoutIn := ru, layoutOut := en)
	Loop, Parse, textContainer
	{
		IfNotInString, layoutIn, %A_LoopField%
			newChar := A_LoopField
		Else
			StringReplace, newChar, A_LoopField, %A_LoopField%, % SubStr(layoutOut, InStr(layoutIn, A_LoopField, True), 1)
		outputStr .= newChar
	}Return outputStr
}
