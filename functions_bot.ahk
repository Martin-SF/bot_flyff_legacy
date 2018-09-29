gamewin_goto(loc_tar, loc_curr := 0) {
	log("gamewin_goto: " loc_curr " to " loc_tar)
	BlockInput, on
	if !(InStr(loc_curr, "loc_"))
		loc_curr := current_location()
	if (loc_curr=loc_tar) {
		;BlockInput, off ;diese blockinbput dürfen erst am richtigen ende stehen
		
		loc_curr_run := current_location(loc_tar)
		if (loc_curr_run != loc_tar) { ;extra verifizierung ob "richtig rausgekommen" bzw. endseite komplett geladen ist.
			;BlockInput, off ;!!!!!!!!!!!!!!!!!!! hier gibt es komische fehler
			log(loc_curr_run " != " loc_tar " (loc_curr_run != loc_tar)")
			log("restart: gamewin_goto( " loc_tar " ," loc_curr ")" )
			static n := 0
			n+=1
			if (n=5) {
				msgbox, %loc_curr_run% != %loc_tar% (loc_curr_run != loc_tar)
			}
			gamewin_goto(loc_tar, loc_curr)
			return
			
		}
		;BlockInput, off
		log("reached: " loc_tar)
		return loc_curr ;loc_curr_run
	}
	
	loc_next := gamewin_goto_click(loc_curr, loc_tar)
	gamewin_goto(loc_tar, loc_next)
	/*
	gen2:
	* übersetzt loc_tar in kleine schritte. Problem: immernoch recht unandlicher hardcode von routen. Todo: goto_click wird einfacher (2. teil des strings ist immer tar_loc)
	* alle sleeps optimieren, im idealfall, wartet der nur genau bis dann ab wann die loc_ erkannt wurde, dann ein humansleep zur tarnung und weiter
	* ganz struktur umrüsten, es sind nur noch 1-er schritte
	
	* sachen hasslich gemacht:
	* code schnipsel überall
	* struktur auf die einzel steps anpassen
	* sleeps
	* 
	
	* wen loc nicht gefunden, versuche 2 mal rotes x zu drücken
	
	*müll in old_functions,bot ablagern
	
	* konsistenz von blockinput eingaben
	
	*try und catch
	*/
}

gamewin_goto_click(loc_curr, loc_tar, sl := 50) {
	log("gamewin_goto_click: " loc_curr " to " loc_tar)
	humansleep(sl)
	loc := loc_curr "_" loc_tar
	t := A_TickCount
	errorlevel := 1
	while (errorlevel=1 and (A_TickCount-t <= 1500)) {
		imagesearch, xq, yq, 0, 0, 1284, 752, *85 pictures\goto_%loc%.png ;75 gab fehler bei leiste-> screen
	}
	if (errorlevel != 0) {
		if (errorlevel=2) {
		
			if (InStr(loc_tar, "loc_tierbuchsite") or InStr(loc_tar, "loc_orbswapsite"))
				return gamewin_goto( SubStr(loc_tar, 1 , StrLen(loc_tar)-5), loc_curr) ;aka "loc_tierbuch ohne zahlen ud site
			
			else if ((loc_tar = "loc_tierbuch") or (loc_tar = "loc_orbswap"))
				return gamewin_goto("loc_leiste", loc_curr)
	
			else if ( (loc_tar = "loc_leiste") and ( InStr(loc_curr, "loc_tierbuchsite") or InStr(loc_curr, "loc_orbswapsite") ) )
				return gamewin_goto( SubStr(loc_curr, 1 , StrLen(loc_curr)-5), loc_curr) ;aka "loc_tierbuch ohne zahlen ud site
			else if ( (loc_tar = "loc_leiste") and ( (loc_curr = "loc_zerlegen") or (loc_curr = "loc_beutel") ) )
				return gamewin_goto("loc_screen", loc_curr)
			
			else if ( (loc_tar = "loc_screen") and ( InStr(loc_curr, "loc_tierbuch") or InStr(loc_curr, "loc_orbswap") ) ) ;linksseitiger vorschaltpkt.
				return gamewin_goto("loc_leiste", loc_curr)
			else if ( (loc_tar = "loc_screen") and (loc_curr = "loc_zerlegen") )
				return gamewin_goto("loc_beutel", loc_curr)
			
			else if (loc_tar = "loc_beutel")  ;and ((loc_curr = loc_leiste) or InStr(loc_curr, "loc_tierbuch") or InStr(loc_curr, "loc_orbswapsite") ) ;für alle links
				return gamewin_goto("loc_screen", loc_curr)
			
			else if (loc_tar = "loc_zerlegen")  ;and ((loc_curr = loc_leiste) or InStr(loc_curr, "loc_tierbuch") or InStr(loc_curr, "loc_orbswapsite") ) ;für alle links
				return gamewin_goto("loc_beutel", loc_curr)
			
		}
		
		blockinput, off
		MsgBox, 0, , error: %errorlevel% `ngoto: %loc%`n closing...
		exitapp
	}
	clickBS(xq, yq, 0, 0, 0, 0) ;var für klicken: with und high von goto_%loc%.png rerausfinden und ab mitte mit var klicken
	
	return loc_tar
}

current_location(prio_loc := "loc_gibsnicht", sl := 50, n := 20) {
	humansleep(sl)
	prio_wait := 500
	log("currentlocation(" sl ")")
	t := A_TickCount
	errorlevel := 1
	if (prio_loc = "loc_gibsnicht")
		sleep prio_wait
	while ((errorlevel=1) and (A_TickCount-t <= 1500)) {
		;log("current_location: " errorlevel " und " A_TickCount " " t)
		
		;array machen oder loc_%num%
		;liste aus files machen diese packen in array
		
		if ((gamewin_search_boo("*" n " pictures\loc_leiste.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_leiste")))
			return "loc_leiste"
		else if ((gamewin_search_boo("*" n " pictures\loc_zerlegen.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_zerlegen")))
			return "loc_zerlegen"
		else if ((gamewin_search_boo("*" n " pictures\loc_tierbuch.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_tierbuch")))
			return "loc_tierbuch"
		else if ((gamewin_search_boo("*" n " pictures\loc_tierbuchsite3.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_tierbuchsite3")))
			return "loc_tierbuchsite3"
		else if ((gamewin_search_boo("*" n " pictures\loc_orbswap.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_orbswap")))
			return "loc_orbswap"
		else if ((gamewin_search_boo("*" n " pictures\loc_orbswapsite1.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_orbswapsite1")))
			return "loc_orbswapsite1"
		else if ((gamewin_search_boo("*" n " pictures\loc_orbswapsite2.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_orbswapsite2")))
			return "loc_orbswapsite2"
		else if ((gamewin_search_boo("*" n " pictures\loc_orbswapsite3.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_orbswapsite3")))
			return "loc_orbswapsite3"
	
		else if ((gamewin_search_boo("*" n " pictures\loc_beutel.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_beutel")))
			return "loc_beutel"
		else if ((gamewin_search_boo("*" n " pictures\loc_screen.png")=0) and (((A_TickCount-t) >= prio_wait) or (prio_loc="loc_screen")))
			return "loc_screen"
	}
	
	blockinput, off
	msgbox, 0, ,  location not found `n`nclosing...
	exitapp
}

gamewin_search_boo(options, waittime := 1) {
	t := A_TickCount
	errorlevel := 1
	while ((errorlevel=1) and (A_TickCount-t <= waittime)) 
		imagesearch, xq, yq, 0, 0, 1284, 752, %options% ;win size übergeben und eventuell dann bilder skalieren

	save_errorlevel := errorlevel
	log("gamewin_search_boo: Errorlevel = " errorlevel " und " A_TickCount " " t)
	errorlevel := save_errorlevel
	
	if (errorlevel=2) {
		blockinput, off
		msgbox, 0, ,  errorlevel = 2 check file (%options%) `n`nclosing...
		exitapp
	} 
	return errorlevel
}



clickBS(x, y, varx := 0, vary := 0, sl1 := 50,sl2 := 50, sl3 := 50) {
	humansleep(sl3)
	specialClickBS((x+random(-varx,varx)), (y+random(-vary,vary)), sl1, sl2)
}

specialClickBS(x,y,sl1 := 1300,sl2 := 700) {
	MouseMove,x,y
	humansleep(sl1)
	;Send, {LButton down}
	Click, down
	humansleep(sl2)
	;Send, {LButton up}
	Click, up
}


wakeup(x, y, wintitle, sl := 1500, loops := 4) {
	loop %loops% {
		WinActivate, %wintitle%
		sleep sl
		clickBS(x, y, 100, 100)
	}
	soundplay *-1
}

wakelite(wintitle, sl := 350){
	WinWaitActivate(wintitle)
	humansleep(sl)
}

WinWaitActivate(wintitle) {
	WinActivate, %wintitle%
	WinWaitActive, %wintitle%
}


humansleep(a) {
	sleep random(a*0.7, a*1.3)
}

rangesleep(l, j) {
	sleep random(l, j)
}

log(s) {
	time = %a_dd%/%a_mm%/%a_yyyy% %a_hour%:%a_min%:%a_sec%
	FileAppend,% "`n" . time . " " . s , flyff_bot.log
}

random(min, max) {
	Random, OutputVar, min, max
	return OutputVar
}