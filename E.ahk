/*

[script info]
version     = 3.4
description = goto line and highlight the error text (autohotkey only)
author      = davebrny
source      = https://gist.github.com/davebrny/ff6a00e55d9d81e4bea9fe1d852d84a9
*/

#Persistent
#SingleInstance, Force
#NoTrayIcon
SetTimer, sublime_goto_error, 1000

CloseErrorWin:
    SetTimer, CloseErrorWin, Off
    WinClose, ahk_class #32770
    ; WinWaitActive, ahk_class #32770
    ; Send {Enter}
    Return


sublime_goto_error:
if winExist("ahk_class #32770", "The script was not reloaded")
or winExist("ahk_class #32770", "The current thread will exit")
or winExist("ahk_class #32770", "The program will exit")
    {
    setTimer, sublime_goto_error, off

    winGetTitle, sublime_title, ahk_exe sublime_text.exe
    winGetTitle, error_title, ahk_class #32770
    if inStr(sublime_title, "\" error_title)  ;# get file path from focused file
        {
        stringGetPos, pos, sublime_title, -, R
        stringMid, mid_title, sublime_title, pos, , L
        splitPath, mid_title, , file_dir, file_ext, name_no_ext
        stringSplit, split, file_ext, % a_space    ; remove • from an unsaved file
        error_path := file_dir "\" name_no_ext "." split1
        }

    winGetText, error_text, ahk_class #32770  ; only continue if error path is in the msgBox or the focused file
    if !inStr(error_text, "in #include file") and (error_path = "")
        goTo, sublime_error_end ; -----------------------------------
; 
        ;# move msgBox to the right
    winGetPos, , , error_width, , ahk_class #32770
    sysGet, monitor_, MonitorWorkArea
    winMove, ahk_class #32770, , % monitor_right - error_width
    winSet, alwaysOnTop, off, ahk_class #32770    ; keep msgBox on top
    ;ControlSend,, {Space},  ahk_class #32770
        ;# get sublime .exe path

   sublime_path="C:\°\Text\Text.exe"
    if !fileExist(sublime_path)    ; if invalid exe path
        goTo, sublime_error_end ; -------------------------------------

        ;# get file path from msgBox

    if inStr(error_text, "in #include file")
        error_path := get_error_path(error_text)

        ;# get error text

    if inStr(error_text, "Specific")
        line_text := specific_error(error_text)
    else if inStr(error_text, "Line Text:")
        line_text := get_line_text(error_text)
    else if inStr(error_text, "Unexpected")
        line_text := unexpected_error(error_text)
    else if inStr(error_text, "illegal character:")
        line_text := get_illegal(error_text)

        ;# get line number

    if inStr(error_text, "--->")
        line_number := get_arrow_line(error_text)
    else if inStr(error_text, "Error at line")
        line_number := get_error_line(error_text)

    if (line_number != "")
        line_number := ":" . line_number

    ; --------------------------------------------------------------------

    run, % """" sublime_path """" a_space """" error_path """" line_number 

    ; --------------------------------------------------------------------

    winWaitActive, ahk_exe sublime_text.exe, , 3
    if winExist("ahk_exe sublime_text.exe") and (line_text != "")
        {
        fileRead, file_contents, % error_path
        strReplace(file_contents, line_text, , count)
        if inStr(file_contents, line_text) and (count = 1)
            {
            winActivate, ahk_exe sublime_text.exe
            send ^{f}    ;# select the error text
            sleep 100
            sendRaw % line_text
            ;sleep 700
            send {esc}  
            }
        }

    ; winActivate, ahk_class #32770  ; have the error msg lose focus once sublime text is focused on
    SetTimer, CloseErrorWin, On
    loop,    ; wait for ahk error window to close
        sleep 1000
    until !winExist(error_title " ahk_class #32770")
    goTo, sublime_error_end
    }
return

sublime_error_end:
file_contents := ""
line_number   := ""
error_path    := ""
setTimer, sublime_goto_error, on
return

get_error_line(error_text) {
    stringGetPos, pos, error_text, % "Error at line"
    stringMid, text_after, error_text, pos + 1
    stringGetPos, pos, text_after, `n, L1
    stringMid, line_text, text_after,pos, , L
    line_text .= a_space
    stringGetPos, pos, line_text, % a_space, L4
    stringMid, line_number, line_text, pos, , L
    return regExReplace(line_number, "[^0-9]")
}

get_error_path(error_text) {
    stringGetPos, pos, error_text, % "in #include file"
    stringMid, text_after, error_text, pos + 19
    stringGetPos, pos, text_after, % """", L1
    stringMid, path, text_after, pos, , L
    return path
}

get_line_text(error_text) {
    stringGetPos, pos, error_text, Line Text:
    stringMid, line_text, error_text, pos + 12
    stringSplit, split, line_text, `n, % a_space
    return split1
}

get_illegal(error_text) {
    stringGetPos, pos, error_text, illegal character:
    stringMid, illegal, error_text, pos + 21
    stringGetPos, pos, illegal, % """", R1
    stringMid, illegal, illegal, pos, , L
    return illegal
}

get_arrow_line(error_text) {
    stringGetPos, pos, error_text, --->
    stringMid, after_arrow, error_text, pos + 5
    StringSplit, split, after_arrow, :, % a_space
    return trim(split1)
}

specific_error(error_text) {
    stringGetPos, pos, error_text, Specifically:
    stringMid, specific_text, error_text, pos + 15
    stringSplit, split, specific_text, `n, % a_space
    if !inStr(error_text, "Action:")
        return split1
}

unexpected_error(error_text) {
    stringGetPos, pos, error_text, unexpected
    stringMid, unexpected, error_text, pos + 13
    stringSplit, split, unexpected, """", % a_space
    return split1
}