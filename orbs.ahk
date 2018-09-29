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
			
			gamewin_goto("loc_screen")
			clickBS(1128, 312, 0, 0) ;auto aus
			gamewin_goto(loc)
			orbs_scroll(loc, a-1)
			clickBS(xq, (yq+65), 0, 0) ;65 = höhe des bildes ;sl für click´BS
			gamewin_goto(loc)
			orbs_scroll(loc, a-1)
		} else {
			log("jagd läuft noch, warte")
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
	mousemove, 1239, (181 + orbs_scroll_info("scrollheigh", loc)*(a-1)) ;weil 1. position bei unveränderter y koord. ist
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


buch:
	;SetTimer, sellitemsbuch, delete
	wakeup(351, 299, emu_wintitle)

	;SetTimer, sellitemsbuch, % -random(200000, 400000)
	;SetTimer, sellitemsbuch, 120000
	
	/*
	clickBS(1860, 57, 20, 20) ;close
	humansleep(3000)
	PixelGetColor, col, 1043, 398 ;col von wld ausruezeichen
	
	humansleep(500)
	clickBS(957, 480, 20, 20) ;wald
	humansleep(8000)
	 */
	 
	clickBS(1671, 968, 20, 20) ;ORBS einsammelnl
	
	;if (col="0xF0F0F0") { ;(col!="0x15142F")
		cc += 1
		;log("kein ausrufezeichen gesehen cc auf " . cc . " erhöht. gescannte Farbe: " . col . "|| 0x15142F=ausrufezeichen")
		log("cc auf " . cc )
	;}
	
	; 7*15 ist voll
	if (cc>=3) { ;(col="0xF0F0F0" and cc=2) { ;(col!="0x15142F" and cc=2) { ;ungleich ausrufezeichen bei 3 mal frei wird gewechselt -> orbs voll
		cc := 0
		log("cc auf 8, ändere monster und resete cc auf 0")
		
		;AUTO aus
		humansleep(3000)
		clickBS(1860, 57, 20, 20) ;close
		humansleep(1300)
		clickBS(1860, 57, 20, 20) ;close
		humansleep(1300)
		clickBS(1391, 437, 75, 75) ;leiste schließen irgendwo hinklicken
		humansleep(1300)
		
		clickBS(1688, 414,0,0) ;auto aus
		humansleep(1300)
		clickBS(31, 1022, 20, 20) ;bar unten öffnen
		humansleep(1300)
		clickBS(1167, 951, 20, 20) ;buch icon unten
		humansleep(1300)
		clickBS(957, 480, 20, 20) ;wald
		humansleep(6000)
		
		
		if (lvl=1 and lvl2=1) {
			lvl := 0
			lvl2 := 2
			log("lvl 1 abgeschlossen")
		}
		else if (lvl=3 and lvl2=2) {
			lvl := 0
			lvl2 := 3
			log("lvl 2 abgeschlossen")
		}
		else 
			lvl += 1
		
		
		step := 167
		x := 1670
		y := coord_jagen_lvl2(lvl2)+step*lvl
		clickBS(1857, coord_scroll_lvl2(lvl2), 0, 0) ;richtige stelle
	
		humansleep(1500)
		mousemove, x, y
		humansleep(1300)
		clickBS(x, y, 10, 0) ;jagen
		
	} else {
		clickBS(1860, 57, 20, 20) ;close
		humansleep(1300)
		clickBS(1860, 57, 20, 20) ;close
	}
		
	log("items verkaufen")
	;Verkaufen
	humansleep(1300)
	clickBS(1391, 437, 75, 75) ;leiste schließen irgendwo hinklicken
	humansleep(1300)
	clickBS(1389, 975, 20, 20) ;beutel
	humansleep(1300)
	clickBS(1289, 980, 45, 15) ;erhacken
	humansleep(1300)
	clickBS(711, 954, 45, 15) ;verhacken
	humansleep(1300)
	clickBS(948, 791, 35, 15) ;mini diaglog weg
	humansleep(1300)
	clickBS(1859, 55, 35, 15) ;beutel weg
	humansleep(1300)

	clickBS(31, 1022, 20, 20) ;bar unten öffnen
	humansleep(1300)
	clickBS(1167, 951, 20, 20) ;buch icon unten
	humansleep(1300)
	clickBS(957, 480, 20, 20) ;wald
	humansleep(8000)
	clickBS(1857, coord_scroll_lvl2(lvl2), 0, 0) ;richtige stelle
	
		step := 167
		x := 1670
		y := coord_jagen_lvl2(lvl2)+step*lvl
	
		humansleep(1500)
		mousemove, x, y
	
if (lvl=3 and lvl2=3) {
	log("tiere voll, change auf only verkaufen")
	changetoinv()
	SetTimer, sellitems, % -random(200000, 400000)
} else
	SetTimer, buch, % -random(1000*60*14, 1000*60*16)
return

changetoinv() {
	humansleep(1300)
	clickBS(1860, 57, 20, 20) ;close
	humansleep(1300)
	clickBS(1860, 57, 20, 20) ;close
	humansleep(1300)
	
	/* clickBS(1722, 950, 20, 20) ;autu
	humansleep(1300)
	clickBS(1098, 965, 20, 20) ;beute einmst
	humansleep(1300)
	clickBS(690, 347, 10, 10) ;gew. toggle
	humansleep(1300)
	clickBS(1322, 225, 20, 20) ;schließen mini fenster
	humansleep(1300)
	clickBS(1661, 54, 20, 20) ;schließen uto
	humansleep(1300) 
	*/
	
	clickBS(1371, 381, 40, 40) ;in die ebene klicken
	humansleep(1300)
	clickBS(1389, 975, 20, 20) ;beutel
	humansleep(1300)

}


/*
buch:
	;SetTimer, sellitemsbuch, delete
	wakeup(351, 299)

	;SetTimer, sellitemsbuch, % -random(200000, 400000)
	;SetTimer, sellitemsbuch, 120000
	
	/*
	clickBS(1860, 57, 20, 20) ;close
	humansleep(3000)
	PixelGetColor, col, 1043, 398 ;col von wld ausruezeichen
	
	humansleep(500)
	clickBS(957, 480, 20, 20) ;wald
	humansleep(8000)
	 /*
	clickBS(1671, 968, 20, 20) ;ORBS einsammelnl
	
	;if (col="0xF0F0F0") { ;(col!="0x15142F")
		cc += 1
		;log("kein ausrufezeichen gesehen cc auf " . cc . " erhöht. gescannte Farbe: " . col . "|| 0x15142F=ausrufezeichen")
		log("cc auf " . cc )
	;}
	
	; 7*15 ist voll
	if (cc>=3) { ;(col="0xF0F0F0" and cc=2) { ;(col!="0x15142F" and cc=2) { ;ungleich ausrufezeichen bei 3 mal frei wird gewechselt -> orbs voll
		cc := 0
		log("cc auf 8, ändere monster und resete cc auf 0")
		
		;AUTO aus
		humansleep(3000)
		clickBS(1860, 57, 20, 20) ;close
		humansleep(1300)
		clickBS(1860, 57, 20, 20) ;close
		humansleep(1300)
		clickBS(1391, 437, 75, 75) ;leiste schließen irgendwo hinklicken
		humansleep(1300)
		
		clickBS(1688, 414,0,0) ;auto aus
		humansleep(1300)
		clickBS(31, 1022, 20, 20) ;bar unten öffnen
		humansleep(1300)
		clickBS(1167, 951, 20, 20) ;buch icon unten
		humansleep(1300)
		clickBS(957, 480, 20, 20) ;wald
		humansleep(6000)
		
		
		if (lvl=1 and lvl2=1) {
			lvl := 0
			lvl2 := 2
			log("lvl 1 abgeschlossen")
		}
		else if (lvl=3 and lvl2=2) {
			lvl := 0
			lvl2 := 3
			log("lvl 2 abgeschlossen")
		}
		else 
			lvl += 1
		
		
		step := 167
		x := 1670
		y := coord_jagen_lvl2(lvl2)+step*lvl
		clickBS(1857, coord_scroll_lvl2(lvl2), 0, 0) ;richtige stelle
	
		humansleep(1500)
		mousemove, x, y
		humansleep(1300)
		clickBS(x, y, 10, 0) ;jagen
		
	} else {
		clickBS(1860, 57, 20, 20) ;close
		humansleep(1300)
		clickBS(1860, 57, 20, 20) ;close
	}
		
	log("items verkaufen")
	;Verkaufen
	humansleep(1300)
	clickBS(1391, 437, 75, 75) ;leiste schließen irgendwo hinklicken
	humansleep(1300)
	clickBS(1389, 975, 20, 20) ;beutel
	humansleep(1300)
	clickBS(1289, 980, 45, 15) ;erhacken
	humansleep(1300)
	clickBS(711, 954, 45, 15) ;verhacken
	humansleep(1300)
	clickBS(948, 791, 35, 15) ;mini diaglog weg
	humansleep(1300)
	clickBS(1859, 55, 35, 15) ;beutel weg
	humansleep(1300)

	clickBS(31, 1022, 20, 20) ;bar unten öffnen
	humansleep(1300)
	clickBS(1167, 951, 20, 20) ;buch icon unten
	humansleep(1300)
	clickBS(957, 480, 20, 20) ;wald
	humansleep(8000)
	clickBS(1857, coord_scroll_lvl2(lvl2), 0, 0) ;richtige stelle
	
		step := 167
		x := 1670
		y := coord_jagen_lvl2(lvl2)+step*lvl
	
		humansleep(1500)
		mousemove, x, y
	
if (lvl=3 and lvl2=3) {
	log("tiere voll, change auf only verkaufen")
	changetoinv()
	SetTimer, sellitems, % -random(200000, 400000)
} else
	SetTimer, buch, % -random(1000*60*14, 1000*60*16)
return
*/


coord_jagen_lvl2(i) { ;jagen button y koordinate
	if i=1
		return 730
	if i=2
		return 320
	if i=3
		return 407
}

coord_scroll_lvl2(i) {
	if i=1
		return 504
	if i=2
		return 610
	if i=3
		return 755
}