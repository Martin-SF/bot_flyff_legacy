;---------------------------------------
;-----------------::TIERBUCH::-----
;---------------------------------------

/*
* Idee f�r orb/tier

	* Erkennung f�r Tot, dann Tr�nke einkaufen (Beutel voll beobachten)
	
	* Erkennung:
	* Beutel voll
	* tr�nke leer, sterben lassen, tr�nke kaufen, auf jagd gehen
	* tr�nke nicht leer, aber low hp -> wolkenkrater zum auff�llen
	
	* dann einfach jagd klicken
	
*/

orb_exchange:
orb_exchange()
sellitems()
SetTimer, orb_exchange, % -random(1000*60*3, 1000*60*4)
return

orb_exchange() {
	global emu_wintitle
	
	Send, {LButton up}
	BlockInput, on
	MouseGetPos, xa, ya, win

	WinWaitActivate(emu_wintitle) ;wakelite(emu_wintitle)
	log("orb_exchange")
	sleep 500


	loc_world_book := "loc_orbswapsite3"
	orbs_hunt_next(loc_world_book)
}


orbs_hunt_next(loc) {
	static last_y := 0
	Blockinput, on
	gamewin_goto(loc)
	
	;erkennung ob aktuelles voll ist br�chte man... -> speichern von letzter jagd position
	clickBS(1130, 677, 0, 0) ;orbs hinzuf�gen
	;problem: bosse nicht angreifen; if "0/1"
	
	max_site := orbs_scroll_info("scrollcount", loc)
	
	a := 1
	errorlevel := 1
	while ((a <= max_site) and (errorlevel = 1)) {
		orbs_scroll(loc, a)
		imagesearch, xq, yq, 0, 0, 1284, 752, *85 pictures\orbs_jagd.png ; VARIANCE !!! leicht zu verwechseln mit /1 bild f�r boss
		a += 1
	}
	
	if (errorlevel = 2) 
		msgbox, errorlevel = 2
	else if (errorlevel=0) {
		if (last_y != yq) {
			last_y := yq
			
			gamewin_goto("loc_screen")
			clickBS(1128, 312, 0, 0) ;auto aus
			gamewin_goto(loc)
			orbs_scroll(loc, a-1)
			clickBS(xq, (yq+65), 0, 0) ;65 = h�he des bildes ;sl f�r click�BS
			gamewin_goto(loc)
			orbs_scroll(loc, a-1)
		} else {
			log("jagd l�uft noch, warte")
			return
		}
	}
	
	Blockinput, off
}

orbs_scroll(loc, a, sl := 50) {
	SendMode Event
	mousemove, 1239, 296
	sleep, sl
	Click, down
	sleep, sl
	mousemove, 1239, 66
	sleep, sl
	mousemove, 1239, (181 + orbs_scroll_info("scrollheigh", loc)*(a-1)) ;weil 1. position bei unver�nderter y koord. ist
	sleep, sl
	Click, up
	SendMode Input
}

orbs_scroll_info(mode, loc) {
	if (mode="scrollcount") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 5
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) { 
			return 5
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 4
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 3
		} else 
			msgbox, scrollcount error! loc = %loc%
	} else if (mode="scrollheigh") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 103
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) {
			return 99
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 124
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 200
		} else 
			msgbox, scrollheigh error! loc = %loc%
	}
}