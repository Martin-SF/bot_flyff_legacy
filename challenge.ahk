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
		tries_left := 9
	}
	
	challenge_wolken()
	log("pink found, uebrige Veruche/n = " . tries_left)

	if (tries_left>1) {
		tries_left -= 1
		SetTimer, wolken, % -77000 ;pink:136000 grün: 75000
		/*
		
		optimierungen: 
		* settimer 500 ms vor wolken start (winactivate..)
		* mit loc_screen goto kommen 1000ms drauf
		* searched time- 15ms erkennungszeit= differenz die man runter nehmen muss von settimer wolken
		
		*/
	}
return

challenge_wolken() {
	global emu_wintitle
	t := perf_TickCount()
	elapsed_time(0)
	blockinput, on
	Click, up
	MouseGetPos, xa, ya, win
	wakelite(emu_wintitle)

	log("wolken start")

	x1 := 450 
	y1 := 240 
	x2 := 850 
	y2 := 450 

	;monitoring über gui: n; timer bis neustart
	;in log esteminated letzter klickLbutton up

	/*
	x1 := 0
	y1 := 0
	x2 := 1200
	y2 := 750
	*/

	gamewin_goto("loc_screen") ;GARANTIEREN DAS AUF LOC-SCREEN!!!!!!!!!!
	
	
	;log("estimated endtime (n = " . n . ") " . endtime . " Uhr.")
	loop {
		if !(happywolkenhour()) {
			msgbox, momentan keine pinke wolken ;Zeit dazuschreiben
			return
		}
		/*
		if waitime>= 137000
			error
		*/
		s := perf_TickCount()
		wakelite(emu_wintitle, 0)
		PixelSearch, Px, Py, 450, 240, 850, 450, 0x23A701, 30, Fast RGB   ; pink:0xDD0100 ;kalibrieren: 40 geht nicht
		;loop mit paar pixelfarben die gesucht werden, -> ist performanter als pixelsearch; var hoch machen
		log("wolken: searched: " elapsed_time(s) "ms")
		if (ErrorLevel = 0) {
			;specialClickBS(Px, Py, 25 ,25) ;SendEvent {Click 100, 200}
			specialClickBS(641, 438, 0 ,0)
			;Send, {Click %Px%, %Py%}
			WinWaitActivate("ahk_id " win)
			mousemove, xa, ya
			BlockInput, off
			log("wolken: elapsed time: " elapsed_time(t) "ms")
			return

		}
	}
	

}

perf_TickCount() {
	ret := 0
	DllCall("QueryPerformanceCounter", "Int64*", ret)
	return ret
}

elapsed_time(last_timestamp) {
	global calib_ms
	return (perf_TickCount()-last_timestamp)/calib_ms
}

happywolkenhour() {
	if (A_Hour=13 or A_Hour=14 or A_Hour=23 or A_Hour=0)
		return true
	else return false
}