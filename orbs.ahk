;---------------------------------------
;-----------------::TIERBUCH::-----
;---------------------------------------

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