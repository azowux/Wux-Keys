#If WinActive("ahk_exe cmd.exe")
::fb::fastboot
::rb::reboot
::rec::recovery

#If WinActive(" - diskpart")
:*:lsd::list disk`n
:*:sld::select disk `

#If (!WinActive("AutoHotkey")&&!WinActive("ahk_class ConsoleWindowClass"))&&(WinActive("Atom")||WinActive("Sublime Text")||WinActive("AutoHotkey Help"))
<!BackSpace:: ; New Tab/Window
	KeyWait, BackSpace, T.15
	If ErrorLevel
		LongPress:=1
	Send ^a^c!-
	ClipWait, 0, 1
	If !LongPress
		Send ^t
	Else
		Send ^n
	Sleep 55
	Send ^v^{Home}^k^1 ; Go to file beginning, fold ∀
	LongPress:=0
	Return
CapsLock & RAlt:: ; Column Select ↑
	While GetKeyState("RAlt", "P") {
		 Send !^{Up}
		 Sleep 100
	}
	Return
CapsLock & F12:: ; Column Select ↓
	While GetKeyState("F12", "P") {
		 Send !^{Down}
		 Sleep 100
	} Return
;Tab & RAlt:: ; Move Selected Lines ↑
	While GetKeyState("RAlt", "P") {
		 Send +^{Up}
		 Sleep 100
	} Return
;Tab & F12:: ; Move Selected Lines ↓
	While GetKeyState("F12", "P") {
		 Send +^{Down}
		 Sleep 100
	}Return

VerticalSelect:
	If !GetKeyState("CapsLock", "P") {
		SetTimer, VerticalSelect, Off
		Send ^+l{Home}
	}
	Return

#If WinActive(".ahk")||WinActive("AutoHotkey Help")&&!WinActive("AutohotKey")
F1:: ; AutoHotkey Help
	KeyWait, F1, T.2
	If ErrorLevel {
		If WinExist("ahk - Google Chrome")
			WinActivate
		Else
			Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
		WinWaitActive, Google Chrome
		Send ^1
		Send ^l
		Sleep 111
		Send ahk `
		}
	Else
		GoSub, AutoHotkeyHelp
	Return
	AutoHotkeyHelp:
	If WinActive("AutoHotkey Help")
		WinClose
	Else If WinExist("AutoHotkey Help") {
		WinActivate
		Send !s
	} Else If !WinExist("AutoHotkey Help") {
		Run "C:\Program Files\AutoHotkey\AutoHotkey.chm"
		WinWaitActive, AutoHotkey Help
		WinMaximize
		WinSet, Style, -0xC00000, A
		Sleep 100
		DllCall("SetMenu", uint, WinActive( "A" ), uint, 0)
	} Return
::Azo?:: ; Device Name
	Sleep 11
	Send If A_ComputerName = AZO`n`t`nElse`n{End}`nReturn
	Return

#Hotstring T C

:*:{ :: `{
:*:&::&&
:*:# ::#If `
::I::If
::E::Else
:*c:EI::Else If `
:*c:IEL::If ErrorLevel `
:*:-c::ahk_class `
:*:-e::ahk_exe `
:*:-i::ahk_id `
:*:-g::ahk_group `
:*:CL::CapsLock
:*:BS::BackSpace
:*:LB::LButton
:*:RB::RButton
:*:MB::MButton
:*:WU::WheelUp
:*:WD::WheelDown
:*:WL::WheelLeft
:*:WR::WheelRight
:*:VU::Volume_Up
:*:VD::Volume_Down
:*:VM::Volume_Mute
:*:CB::Clipboard
:*:CW::ClipWait
:*:GS::GoSub, `
:*:#IL::#InputLevel `
:*:#WA::#IfWinActive `
::ATC::A_TickCount
::ATI::A_TImeIdle
::ATIM::A_TimeIdleMouse
::ATIK::A_TimeIdleKeyboard
::AIS::A_IsSuspended
::AIP::A_IsPaused
::EL::ErrorLevel
::B_H::Browser_Home
::B_S::Browser_Search
::B_F::Browser_Forward
::B_B::Browser_Back
::MPP::Media_Play_Pause
::M_N::Media_Next
::M_P::Media_Prev
:*:CMMS::CoordMode, Mouse, Screen
:*:CMTS::CoordMode, ToolTip, Screen
::KW::KeyWait
::STMM::SetTitleMatchMode
::DHW::DetectHiddenWindows
::MGP::MouseGetPos
::MM::MouseMove
::GA::GroupAdd
::WA::WinActive
::WE::WinExist
::WW::WinWait
::WV::WinActivate
::WWA::WinWaitActive
::WWC::WinWaitClose
::CS::ControlSend
::CGF::ControlGetFocus
::CF::ControlFocus

:*:GKS::
	SendInput GetKeyState("")
	Send {Left 2}
	KeyWait, CapsLock, D
	Send {Right}, "P"{Right}
	Return
::IGKS::If GetKeyState 
	;Send If `GetKeyState(""){Left 2}
	;Return
::WGKS::
	Send While `GetKeyState(""){Left 2}
	Return
::SKD::SetKeyDelay
::SMD::SetMouseDelay
:c:AUD::C:\Users\%A_UserName%\Downloads\
:c:AUF::C:\Users\%A_UserName%\
:c:AUN::A_UserName
:c:ASD::A_ScriptDir
:c:APK::A_PriorKey
:c:APH::A_PriorHotkey
:c:ATH::A_ThisHotkey
:c:ATSTH::A_TimeSinceThisHotkey
:c:ATSPH::A_TimeSincePriorHotkey
:c:ASH::A_ScreenHeight
:c:ASW::A_ScreenWidth
:c:IX::InputBox
:c:MX::MsgBox
:*:.,::Sleep
:*::"::SendInput
:*:;'::Send
::SR::SendRaw
::SM::SendMode
:*:SL::SendLevel `
::ST::SetTimer
::KLP:: ; Key Long Press
	Send {Left 2}+^{Left}^c{Right 3}`n`tKeyWait, `^v, `T.2`nIf `{!}ErrorLevel`n{End}`nElse`n`nReturn{Up}
	Return
::CNM:: ; ClickNoMove
	Send ClickNoMove(){Left}
	Return
::TT::ToolTip
::WS::WinSet
::WG::WinGet
::WGP::WinGetPos
::WGC::WinGetClass
::WGT::WinGetTitle
::WGAT::WinGetActiveTitle
::WGNA::WinGet, NowAppID, ID, A ; Get NowApp ID
::WM::WinMove
::WMX::WinMaximize
::WMN::WinMinimize
::WMSI::WinMenuSelectItem
:*:;.:: ; Begin Hotkey
	Send {:}{:}`r`t
	Return
:*:.;:: ; Finish Thread
	Send Return
	GoSub, TestScript
	Return
#HotString T0 C0

#If

