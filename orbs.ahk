;---------------------------------------
;-----------------::TIERBUCH::-----
;---------------------------------------

/*
* Idee für orb/tier

	* Erkennung für Tot, dann Tränke einkaufen (Beutel voll beobachten)
	
	* Erkennung:
	* Beutel voll
	* tränke leer, sterben lassen, tränke kaufen, auf jagd gehen
	* tränke nicht leer, aber low hp -> wolkenkrater zum auffüllen
	
	* dann einfach jagd klicken
	
*/



g::
orbs_scroll("loc_orbswapsite3", n)
n+=1
return


orbs_hunt_next(loc) {
	/*
	static last_y := 0
	Blockinput, on
	gamewin_goto(loc)
	
	;erkennung ob aktuelles voll ist brächte man... -> speichern von letzter jagd position
	clickBS(1130, 677, 0, 0) ;orbs hinzufügen
	;problem: bosse nicht angreifen; if "0/1"
	
	max_site := orbs_scroll_info("scrollcount", loc)
	
	a := 1
	errorlevel := 1
	while ((a <= max_site) and (errorlevel = 1)) {
		orbs_scroll(loc, a)
		imagesearch, xq, yq, 0, 0, 1284, 752, *85 pictures\orbs_jagd.png ; VARIANCE !!! leicht zu verwechseln mit /1 bild für boss
		a += 1
	}
	
	if (errorlevel = 2) 
		msgbox, errorlevel = 2
	else if (errorlevel=0) {
		if (last_y != yq) {
			last_y := yq
			mousemove, xq, (yq+65)
			sleep 1000
			gamewin_goto("loc_screen")
			clickBS(1128, 312, 0, 0) ;auto aus
			gamewin_goto(loc)
			Click, up
			sleep 2000
			orbs_scroll(loc, (a-1))
			;msgbox, %a%
			sleep 500
			clickBS(xq, (yq+65), 0, 0) ;65 = höhe des bildes ;sl für click´BS
			sleep 500
			;gamewin_goto(loc)
			;orbs_scroll(loc, a-1)
		} else {
			log("jagd läuft noch, warte")
			return
		}
	}
	
	*/
	
	if (orbs_hunt_next_search(loc, "search") = "next") {
		gamewin_goto("loc_screen")
		clickBS(1128, 312, 10, 10) ;auto aus ;autom. erkennung ob an oder aus
		orbs_hunt_next_search(loc, "click")
	}
}

orbs_hunt_next_search(loc, mode) {
	static last_y := 0
	static t := A_TickCount
	a := 1
	
	gamewin_goto(loc)
	clickBS(1130, 677, 0, 0, 500) ;orbs hinzufügen ;500 wegen öffnen der leiste
	sleep 1500 ;transparente abwarten (transparente)

	errorlevel := 1
	while ((a <= orbs_scroll_info("scrollcount", loc)) and (errorlevel = 1)) {
		orbs_scroll(loc, a)
		sleep 100
		imagesearch, xq, yq, 0, 0, 1284, 752, *105 pictures\orbs_jagd.png ; VARIANCE !!! leicht zu verwechseln mit /1 bild für boss  rechts: 130 links: 90-125 geht: 125
		;brauch system wo bilder mit Belohnung und jagd symbol gesucht werden (alle bilder ausschneiden)
		sleep 100
		a += 1
	}
	/*
	g := yq+65
	blockinput, off
	mousemove, %xq%, %g%
	sleep 5000
	blockinput, on
	*/
	log("last_y = " last_y " und yq = " yq)
	
	if (errorlevel = 2) 
		msgbox, errorlevel = 2
	else if (errorlevel=0) {
		if (((mode="click") or ((A_TickCount-t) >= (15*60*1000)) or (last_y = 0) or (last_y != yq))) { ;wenn letzten koordinaten meh rals ´;abs(last_y-yq) >= 40) or 
			t := A_TickCount
			
			last_y := yq
			if (mode="click")
				clickBS(xq, (yq+65), 0, 0, 100) ;65 = höhe des bildes ;sl für click´BS
			;sleep 1000
			;gamewin_goto(loc)
			;orbs_scroll(loc, a-1)
			
			return "next"
		} else {
			log("jagd läuft noch, warte")
			return "running"
		}
	} else {
		Blockinput, off
		log("jagd error")
		msgbox, log("jagd error")
		exitapp
	}
}

orbs_hunt_next_search_gen2(loc, mode) {
	static last_index := 0
	static t := A_TickCount
	a := 1
	
	gamewin_goto(loc)
	clickBS(1130, 677, 0, 0, 500) ;orbs hinzufügen ;500 wegen öffnen der leiste
	
	s := perf_TickCount()
	errorlevel := 1
	maxsites := orbs_scroll_info("scrollcount", loc)
	shift := 0
	while ((a <= maxsites) and (errorlevel = 1)) {
		orbs_scroll(loc, a)
		sleep 100
		log("scanne from " (shift) " to " (shift+4) " bei site = " a)
		errorlevel := 1
		;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! das shift system ist zu unberechenbar zusammen mit den scrolls -> zu inferpornamt
		while ((errorlevel=1) and (A_index <= (shift+(4+a)))) { ;mit seitenanzahl was machen
			pic := "pictures\orbs_jagd_reward" (A_index+shift) ".png"
			imagesearch, xq, yq, 0, 0, 1284, 752, *90 %pic% ;*; VARIANCE !!! leicht zu verwechseln mit /1 bild für boss  rechts: 130 links: 90-125 geht: 125
		} ;105 geht
		if (errorlevel = 2)
			errorlevel := 1
		shift := round(17/maxsites)*(A_index)
		;brauch system wo bilder mit Belohnung und jagd symbol gesucht werden (alle bilder ausschneiden)
		sleep 100
		a += 1
	}
	if (errorlevel = 2 or errorlevel = 1)
		msgbox, errorlevel gen2 %errorlevel%
	log("orbs_searched: " elapsed_time(s) "ms")
	

	
	yq += 20 
	xq += 515
	log("last_index = " last_index " und yq = " yq)
	
		blockinput, off
	mousemove, %xq%, %yq%
	sleep 5000
	blockinput, on
	
	if (errorlevel = 2) 
		msgbox, errorlevel = 2
	else if (errorlevel=0) {
		if (((mode="click") or (last_index = 0) or (last_index != A_Index))) { ;wenn letzten koordinaten meh rals ´;abs(last_y-yq) >= 40) or or ((A_TickCount-t) >= (15*60*1000))
			t := A_TickCount
			
			last_index := A_Index
			if (mode="click")
				clickBS(xq, yq, 0, 0, 100) ;65 = höhe des bildes ;sl für click´BS
			;sleep 1000
			;gamewin_goto(loc)
			;orbs_scroll(loc, a-1)
			
			return "next"
		} else {
			log("jagd läuft noch, warte")
			return "running"
		}
	} else {
		Blockinput, off
		log("jagd error")
		msgbox, log("jagd error")
		exitapp
	}
}

orbs_scroll(loc, a, sl := 75) { ;scrolls neu machen
	SendMode Event
	mousemove, 1239, 296, 100
	sleep, sl
	Click, down
	sleep, sl
	mousemove, 1239, 66, 100
	sleep, sl
	Click, up
	sleep, sl
	;# oberste positio
	
	specialClickBS(1239, orbs_scroll_info("scrollstart", loc)+(a-1)*orbs_scroll_info("scrollheigh", loc), 0, 0) orbs_scroll_info("scrollheigh", loc)
	sleep, sl
	SendMode Input
}

Click(x,y) {
	Click, %x%, %y%
}

orbs_scroll_obsolente(loc, a, sl := 75) { ;scrolls neu machen
	SendMode Event
	mousemove, 1239, 296, 100
	sleep, sl
	Click, down
	sleep, sl
	mousemove, 1239, 66, 100
	sleep, sl
	mousemove, 1239, (175 + orbs_scroll_info("scrollheigh", loc)*(a-1)), 100 ;weil 1. position bei unveränderter y koord. ist
	sleep, sl
	Click, up
	sleep, sl
	SendMode Input
}

orbs_scroll_info_obsolente(mode, loc) {
	if (mode="scrollcount") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 10 ;5
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) { 
			return 10 ;5
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 8 ;4
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 2 ;3
		} else 
			msgbox, scrollcount error! loc = %loc%
	} else if (mode="scrollheigh") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 55 ;103
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) {
			return 50 ;99
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 65 ;124
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 100 ;200
		} else 
			msgbox, scrollheigh error! loc = %loc%
	}
}

orbs_scroll_info(mode, loc) {
	if (mode="scrollcount") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 5
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) { 
			return 5
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 5
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 3
		} else 
			msgbox, scrollcount error! loc = %loc%
	} else if (mode="scrollheigh") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 95
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) {
			return 96
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 106 ;124
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 
		} else 
			msgbox, scrollheigh error! loc = %loc%
	} else if (mode="scrollstart") {
		if ((loc = "loc_orbswapsite1") or (loc = "loc_tierbuchsite1")) {
			return 182
		} else if ((loc = "loc_orbswapsite2") or (loc = "loc_tierbuchsite2")) {
			return 179
		} else if ((loc = "loc_orbswapsite3") or (loc = "loc_tierbuchsite3")) {
			return 192
		} else if ((loc = "loc_orbswapsite4") or (loc = "loc_tierbuchsite4")) {
			return 
		} else 
			msgbox, scrollheigh error! loc = %loc%
	}
}