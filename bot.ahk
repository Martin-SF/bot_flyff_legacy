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
 
* 
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

lvl := 2
lvl2 := 3
cc := 0
first := 1
emu_wintitle := "ahk_class Qt5QWindowIcon"
;emu_wintitle := "ahk_exe BlueStacks.exe"

Gui, Add, Button, x30 y40 w100 h30 gsellitems , sellitems
Gui, Add, Button, x30 y90 w100 h30 gwolken, wolken
Gui, Add, Button, x30 y140 w100 h30 +disabled, Tierbuch
Gui, Add, Button, x30 y190 w100 h30 +disabled, Orb-Swap
Gui, Show, w165 h289, Flyff Legacy Bot - by Peter Holz
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
sellitems:
	Send, {LButton up}
	BlockInput, on
	MouseGetPos, xa, ya, win

	WinWaitActivate(emu_wintitle) ;wakelite(emu_wintitle)
	log("sellitems")
	sleep 500
	gamewin_goto("loc_zerlegen") 
	;gamewin_goto("loc_beutel")
	;wakeup(662, 441, emu_wintitle)
	;clickBS(1289, 980, 45, 15) ;Zerlegen-Fenster-Button ;surface
	;clickBS(865, 679, 45, 15, 50, 50) ;Zerlegen-Fenster-Button ;win10

	
	if (gamewin_search_boo("*10 pictures/sellitems_empty_slots.png")=0)
		res := "empty" ;direkt die if anweisung von unten...
	else 
		res := "filled"
	
	;funktioniert das blockinput?!?
	
	if (res="empty") {
		log("nichts zu verkaufen, drücke abbrechen")
		clickBS(865, 679, 45, 15, 0, 0) ;Zerlegen-Fenster-Button
	} else if (res="filled") {
		log("verkauft, Errorlevel = " res)
		clickBS(470, 551, 5, 5, 50, 50) ;grün
		clickBS(255, 596, 5, 5, 50, 50) ;blau
		clickBS(469, 673, 45, 15, 50, 50) ;Zerlegen-Button
		clickBS(651, 553, 35, 15, 50, 50) ;mini diaglog weg
	} else {
		MsgBox, 16, , sellitems`, error, 2
	}
	;gamewin_goto("loc_tierbuchsite3")
	
	WinWaitActivate("ahk_ID " win)
	mousemove, xa, ya
	BlockInput, off
	SetTimer, sellitems, % -random(1000*60*8, 1000*60*12)
return

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

