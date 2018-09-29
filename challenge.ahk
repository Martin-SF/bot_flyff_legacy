;---------------------------------------
;-----------------::WOLKEN-KRATER::-----
;---------------------------------------

wolken:
	/*
	if (first=1) {
		s := 1000*60*17
		SetTimer, wolken, -%s%
		first := 0
		return
	}
	*/
	if (first=1) {
		first := 0
		tries_left := 30
	}
	
	challenge_wolken()

	if (tries_left>1) {
		tries_left -= 1
		SetTimer, wolken, % -136000
	}
return

challenge_wolken() {
	global emu_wintitle
	
	Send, {Lbutton up}
	MouseGetPos, xa, ya, win

	wakelite(emu_wintitle)

	log("wolken start")

	/*
	x1 := 551
	y1 := 245
	x2 := 717
	y2 := 373
	*/

	var := 300 ;warum geht das nur mit dieses parametertn???
	x1 := 620-var
	y1 := 300-var
	x2 := 670+var
	y2 := 350+var

	;monitoring über gui: n; timer bis neustart
	;in log esteminated letzter klickLbutton up

	/*
	x1 := 0
	y1 := 0
	x2 := 1200
	y2 := 750
	*/

	gamewin_goto("loc_screen")
	
	;log("estimated endtime (n = " . n . ") " . endtime . " Uhr.")
	loop {
		blockinput, on
		if !(happywolkenhour()) {
			msgbox, momentan keine pinke wolken ;Zeit dazuschreiben
			return
		}
		/*
		if waitime>= 137000
			error
		*/
		
		wakelite(emu_wintitle, 0)
		PixelSearch, Px, Py, %x1%, %y1%, %y2%, %x2%, 0xDD0100, 10, Fast RGB   ; 0000BF 
		;2 settimer: 1. vorbereiten , blockinput, loc_screen, 2. klickt genau nach 136,5 sec 
		;loop mit paar pixelfarben die gesucht werden, -> ist performanter als pixelsearch; var hoch machen

		if (ErrorLevel = 0) {
			log("pink found, uebrige Veruche/n = " . n)
			
			Click, up
			specialClickBS(Px, Py, 0 ,0) ;SendEvent {Click 100, 200}
			;Send, {Click %Px%, %Py%}
			WinWaitActivate("ahk_id " win)
			mousemove, xa, ya
			BlockInput, off
			
			if (n=1)  ;aka letzter versuch gerade geklickt
				msgbox, wolken ready
		}
	}
	

}

happywolkenhour() {
	if (A_Hour=13 or A_Hour=14 or A_Hour=23 or A_Hour=0)
		return true
	else return false
}

/*
swolken:
wakewolken := 0
settimer, wait_for_wakewolken, 250

wakewolken:
wakeup(975, 170, emu_wintitle, random(0, 400), 3) ;wakeup über wolke
wakewolken := 1
return

wait_for_wakewolken:
if wakewolken!=1 ;noch nicht das erste mal gewaked
	return
settimer, wait_for_wakewolken, delete

wolken:
clickBS(951, 410 ,10 , 10) ;wolke (bisschen über charakter

SetTimer, wolken, % -random(137*1000, 139*1000)
SetTimer, wakewolken, % -random(125*1000, 127*1000)
return

