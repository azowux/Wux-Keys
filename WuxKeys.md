# <center><b>•.AHK</b></center>
 <center><i>Coding a mouse-keyboard music instrument by Azo Wux</i></center>

## <center><i>Prime Concepts</span></i></center>
>- Hands positioning to hardware - make sure you have the keys where they feel better. 
>- Automated algorithms execution
>- Windows OS UI improvements

## <center><i>Architecture</i></center>
It all starts from •.ahk file. Comment out Include directives to disable corresponding functionality.

 * [•](•.ahk) — Core.
 * [A](A.ahk) — Auto-execute.
 * [#](/#.ahk) — Apps instances navigation.
 * [&](/&.ahk) — Text navigation, editting clipboard.
 * [§](/§.ahk) — Language, symbols, transliteration.
 * [G](/G.ahk) —  [GestureSign](https://gesturesign.win/#/) integration, pen button shortcuts, windows, desktop switching.
 * [X](/X.ahk) — Hotstrings.
 * [Z](Z.ahk) — Coding  keys & strings.
 * [%](%.ahk) — Utility keys, lib functions.

## <center><i>Installation</i></center>
Written in up to date [AutoHotKey](https://www.autohotkey.com/). Once cloned, open •.ahk file, the code doesn't leave any traces once exited apart from saving text clipboard data in your C:\Clipboard\

## <center><i>Usage: Noticable Handles</i></center>

### <center><b>Shifted Spacebar</b></center>
>     •  Type with  Spacebar held for  shifted letters. Produces a space if released before a specified timeout value.
>     •  Move mouse with Spacebar held  to show AltTab, release Spacebar to click on chosen window.
>     •  The advantage renders obvious here: there're many times when you Shift for punctuation with a space following. The script feels powerful by reducing amount of keys by 1/3 ([Spacebar + Key] for [Shift + Key  + Spacebar]) in many linguistic cases.
>     •  Doesn't intercept with remaining keys, no matter the input level. Preserves Spacebar key modification. Use any key combos right after. 

### <center><b>App Instances Manipulation</b></center>
   * [LAlt]: go to Last App
   * [Key] + Mouse Motion : app switching mode toggle
      * Press key while moving mouse to activate instance
      * App switching mode toggled, some keys are now just to switch designated windows
      * Mouse motion deactivates mode
   * Premade system dialog responses
   * Window styling
   * Linux style move{Up}/resize{Down} window on key press
### <center><b>Accelerated navigation; text selection/editting</b></center>
   * ←→ strike briefly to move by word, hold steady to lightly move by letter
   * ↑↓ hold to accelerate scrolling
### <center><b>Clipboard</b></center>
   * Press & Hold [End] to show current clipboard contents, scroll with navigation keys through recent clips, release to paste selection
   * [Space + LMouse/RMouse] — Put mouse somewhere in text. Ater using mouseclick to rather Copy or Cut selected text AltTab appears. Release Spacebar to paste to window under mouse, return to last app.
   * Links cross-app casting, item title, data automation — select item title on webpage, insert it & corresponding link into database of preference.
### <center><b>Languages</b></center>
   * [RShift] — •Eng/°Ru (Long/Short Press)
   * [Space] + [RShift] — Keep selecting prior text until [RShift ↑], release [Space] to transliterate. 

### <center><b>First Words to Community:</b></center>
Greetings everyone & welcome to my personal collection of scripts that I've been working on for around 2 years already. The prime reason I began publishing my scripts appeared on recent functionality search. I kept advancing in AutoHotkey since right from beginning it concerned every single aspect of my virtual experience. I did purchasing optimizations for a small customshop drone company, managed & automated online workflows, built utilities with UI, thanks all to AutoHotkey that helped me and my colleagues. Publishing was still not a concern until recently I've been looking for a hotkey implementation for Spotify currently played song liking and couldn't find a stable solution nowadays. Since several folks online tried to implement it, I figured out I could save some people time and finally join a huge community of high-end problem solvers here to work on things together.
So here we go. The way I implemented scripts up to now meant I'd have everything in a single huge file. Even though it's great for local debugging, I've figured out integration might take insane time for folks to split my code in chunks & cross-integrate them. Therefore running scripts separately was my choice and I'll keep splitting them into branches for easier access to utilities you need most without sacrificying compatibility. Now I'm more focused on making my stuff readable, integrateable & more user-friendly. Enjoy!
Reason I'm using branches instead of separate repos is I want all of my scripts to be cross-compatible and just because I'm new to GitHub it feels like a good option, don't blame me if later I discover otherwise.
Please do contact me for any discussions. I want my stuff to work for you, me & everyone in the Community. Ain't wasting kBs here;)

