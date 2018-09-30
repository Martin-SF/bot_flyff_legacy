;---------------------------------------
;-----------------::IDEEN::-------------
;---------------------------------------
/*
-	screenshot bei wichtigen oder allen klicks machen um rauszufinden wo fehleranfälligkeit besteht

CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Icon3 %A_ProgramFiles%\SomeApp\SomeApp.exe
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
	
	
* Object für Fenster machen:
 * get location
 * change position...
 * private variables für
 
* Idee für orb/tier

	* Erkennung für Tot, dann Tränke einkaufen (Beutel voll beobachten)
	* dann einfach jagd klicken
	
* var für alle imagesearchs untersuchen

* manuel optimize mode wo gegebene umgebung genutzt wird um das programm für alle "sleeps" also s1 oder sl2 zu trainieren, außerdem h*-1 w500 usw.
*/

;---------------------------------------
;-----------------::INITIALISIERUNG::---
;---------------------------------------
if not A_IsAdmin {
	Run *RunAs "%A_ScriptFullPath%" ;wegen blockinput und steam beenden
	Exitapp
}
#NoEnv
#SingleInstance, force
#Warn
SetBatchLines, -1
ListLines, Off
SendMode, Input
SetWinDelay, -1
SetControlDelay, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0


;lvl := 2
;lvl2 := 3
;cc := 0
first := 1
emu_wintitle := "ahk_class Qt5QWindowIcon"
n := 0
;emu_wintitle := "ahk_exe BlueStacks.exe"

Gui, Add, Button, x30 y40 w100 h30 gsellitems_periodic , sellitems
Gui, Add, Button, x30 y90 w100 h30 gwolken, wolken
Gui, Add, Button, x30 y140 w100 h30 gorb_exchange, Orb-Swap
Gui, Add, Button, x30 y190 w100 h30 +disabled, Tierbauch
Gui, Show, w165 h289, Flyff Legacy Bot - by Peter Holz

goto, calib_ticks_start
return


;---------------------------------------
;-----------------::HOTKEYS::-----------
;---------------------------------------
ctrl & h::
GuiClose:
ExitApp

~f5:: ;f5 nicht blockieren
if (winactive("ahk_exe SciTE.exe") or winactive(emu_wintitle)) {
	exitapp
}

;---------------------------------------
;-----------------::INCLUDES::----------
;---------------------------------------
#Include, orbs.ahk
#Include, challenge.ahk
#Include, functions_bot.ahk
#Include, dungeons.ahk

;---------------------------------------
;-----------------::SONSTIGER-CODE::----
;---------------------------------------
sellitems_periodic:
	sellitems()
	SetTimer, sellitems_periodic, % -random(1000*60*7.6, 1000*60*8)
return


orb_exchange:
	orb_exchange("loc_orbswapsite3")
	SetTimer, orb_exchange, % -random(1000*60*4.5, 1000*60*5.5)
return


orb_exchange(loc_world_book) {
	global emu_wintitle
	
	Send, {LButton up}
	BlockInput, on
	MouseGetPos, xa, ya, win
	
	wakelite(emu_wintitle) ;(emu_wintitle)
	;Send, {Alt down}{F9 down}{Alt up}{F9 up}
	log("orb_exchange")
	
	orbs_hunt_next(loc_world_book)
	;sellitems()
	gamewin_goto(loc_world_book)
	
	
	WinWaitActivate("ahk_ID " win)
	mousemove, xa, ya
	blockinput, off
	
	;Send, {Alt down}{F9 down}{Alt up}{F9 up}
}
return


sellitems() {
	global emu_wintitle
	
	Send, {LButton up}
	BlockInput, on
	MouseGetPos, xa, ya, win
	
	wakelite(emu_wintitle)
	log("sellitems")
	gamewin_goto("loc_zerlegen") 
	;gamewin_goto("loc_beutel")
	;wakeup(662, 441, emu_wintitle)
	;clickBS(1289, 980, 45, 15) ;Zerlegen-Fenster-Button ;surface
	;clickBS(865, 679, 45, 15, 50, 50) ;Zerlegen-Fenster-Button ;win10
	
	res := gamewin_search_boo("*10 pictures/sellitems_empty_slots.png")
	if (res=0) { ;"empty"
		log("nichts zu verkaufen, drücke abbrechen")
		clickBS(865, 679, 45, 15, 75, 75) ;Zerlegen-Fenster-Button
	} else if (res=1) {
		log("verkaufen errorlevel = " errorlevel)
		clickBS(470, 551, 5, 5, 75, 75) ;grün
		clickBS(255, 596, 5, 5, 75, 75) ;blau
		clickBS(469, 673, 45, 15, 75, 75) ;Zerlegen-Button
		clickBS(651, 553, 35, 15, 175, 175) ;mini diaglog weg
	} else {
		MsgBox, 16, , sellitems`, error, 2
	}
	
	;gamewin_goto(curr_loc)
	
	WinWaitActivate("ahk_ID " win)
	mousemove, xa, ya
	BlockInput, off
	
}

;---------------------------------------
;-----------------::TESTS::-------------
;---------------------------------------
 

/*

ctrl & g::
wakelite(emu_wintitle)

ImageSearch, FoundX, FoundY, 0, 0, 1280, 720, *150 *TransWhite pictures/cloud.PNG  ;*w200 *h-1
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%, %FoundY%.
;1 if it was not found, or 2 if there was a problem that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option).

	mousemove, %FoundX%+65, %FoundY%+47
	/*
	0x15142F = kein ausrufe52514

*/ /*
return

drag(x1,y1,x2,y2) {
	MouseMove,x1,y1
	humansleep(400)
	Send, {LButton down}
	humansleep(700)
	MouseMove,x2,y2
	
	Send, {LButton up}
}

