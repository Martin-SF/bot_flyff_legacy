gamewin_goto(loc_tar, loc_curr := 0) {
	log("gamewin_goto: " loc_curr " to " loc_tar)
	BlockInput, on
	if !(InStr(loc_curr, "loc_"))
		loc_curr := current_location()
	if (loc_curr=loc_tar) {
		BlockInput, off
		loc_curr_run := current_location()
		if (loc_curr_run != loc_tar) { ;extra verifizierung ob "richtig rausgekommen" bzw. endseite komplett geladen ist.
			BlockInput, off ;!!!!!!!!!!!!!!!!!!! hier gibt es komische fehler
			;msgbox, %loc_curr_run% != %loc_tar% (loc_curr = %loc_curr%)
		}
		BlockInput, off
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

gamewin_goto_click(loc_curr, loc_tar, sl := 200) {
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
			;buchname_tar := SubStr(loc_tar, 1 , StrLen(loc_tar)-5) ;aka "loc_tierbuch ohne zahlen ud site
			;buchname_curr := SubStr(loc_curr, 1 , StrLen(loc_curr)-5) ;aka "loc_tierbuch ohne zahlen ud site
			;log("buchname_tar= " buchname_tar)
			;log("buchname_curr= " buchname_curr)
			
			/*
			else if ((loc_curr = "loc_tierbuchsite") or (loc_curr = "loc_orbswapsite")) 
				return gamewin_goto(buchname, loc_curr)
			else if (InStr(loc_tar, "loc_tierbuchsite") or InStr(loc_tar, "loc_orbswapsite"))
				return gamewin_goto(buchname, loc_curr)
			*/
			
			
			if (InStr(loc_tar, "loc_tierbuchsite") or InStr(loc_tar, "loc_orbswapsite"))
				return gamewin_goto(SubStr(loc_tar, 1 , StrLen(loc_tar)-5), loc_curr) ;aka "loc_tierbuch ohne zahlen ud site
			
			else if ((loc_tar = "loc_tierbuch") or (loc_tar = "loc_orbswap"))
				return gamewin_goto("loc_leiste", loc_curr)
	
			else if ( (loc_tar = "loc_leiste") and ( InStr(loc_curr, "loc_tierbuchsite") or InStr(loc_curr, "loc_orbswapsite") ) )
				return gamewin_goto(SubStr(loc_curr, 1 , StrLen(loc_curr)-5), loc_curr) ;aka "loc_tierbuch ohne zahlen ud site
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
			
			/*
			
			
			
			else if ( ((loc_tar = "loc_tierbuch") or (loc_tar = "loc_orbswap")) and ((loc_curr="loc_screen") or (loc_curr="loc_beutel") or (loc_curr="loc_zerlegen") or (loc_curr="loc_zerlegen") or (InStr(loc_tar, "loc_tierbuchsite") or InStr(loc_tar, "loc_orbswapsite")) ) )
				
				return gamewin_goto("loc_leiste", loc_curr)
			
			
			
			else if ( ((loc_tar = "loc_tierbuch") or (loc_tar = "loc_orbswap")) and ((loc_curr="loc_screen") or (loc_curr="loc_beutel") or (loc_curr="loc_zerlegen")) )
				return gamewin_goto("loc_leiste", loc_curr)

			
			
			
			else {
				log("fallback to loc_screen!")
				return gamewin_goto("loc_screen", loc_curr)
			}
			
			
			
			
			if (InStr(loc_tar, "loc_tierbuchsite") or InStr(loc_tar, "loc_orbswapsite")) {
				
				gamewin_goto(buchname, loc_curr)
				return buchname
			} else if ((loc_curr = "loc_orbswap") or (loc_curr = "loc_tierbuch")) {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen"
				
				
			} else if (InStr(loc_tar, "loc_tierbuch") or InStr(loc_tar, "loc_orbswap")) {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen" 
			} else if (loc_tar = "loc_beutel") {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen" 
			} else if ((loc_curr = "loc_orbswap") or (loc_curr = "loc_tierbuch")) {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen"
			} else if (InStr(loc_curr, "loc_orbswapsite") or InStr(loc_curr, "loc_tierbuchsite")) {
				gamewin_goto(buchname, loc_curr)
				return buchname
			} else if (loc_tar = "loc_zerlegen") {
				gamewin_goto("loc_screen", loc_curr)
				gamewin_goto("loc_beutel", "loc_screen")
				return "loc_beutel"
			} else if (loc_tar = "loc_zerlegen") {
				gamewin_goto("loc_beutel", loc_curr)
				return "loc_beutel"
			} else {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen"
			}
			
			/*
			if (InStr(loc_tar, "loc_tierbuchsite") or InStr(loc_tar, "loc_orbswapsite")) {
				buchname := SubStr(loc_tar, 1 , StrLen(loc_tar)-5) ;aka "loc_tierbuch ohne zahlen ud site
				gamewin_goto(buchname, loc_curr)
				return buchname
			} else if (InStr(loc_tar, "loc_tierbuch") or InStr(loc_tar, "loc_orbswap")) {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen" 
			} else if (loc_tar = "loc_beutel") {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen" 
			} else if ((loc_curr = "loc_orbswap") or (loc_curr = "loc_tierbuch")) {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen"
			} else if (InStr(loc_curr, "loc_orbswapsite") or InStr(loc_curr, "loc_tierbuchsite")) {
				buchname := SubStr(loc_curr, 1 , StrLen(loc_curr)-5) ;aka "loc_tierbuch ohne zahlen ud site
				gamewin_goto(buchname, loc_curr)
				return buchname
			} else if (loc_tar = "loc_zerlegen") {
				gamewin_goto("loc_screen", loc_curr)
				gamewin_goto("loc_beutel", "loc_screen")
				return "loc_beutel"
			} else if (loc_tar = "loc_zerlegen") {
				gamewin_goto("loc_beutel", loc_curr)
				return "loc_beutel"
			} else {
				gamewin_goto("loc_screen", loc_curr)
				return "loc_screen"
			}
			*/
		}
		
		blockinput, off
		MsgBox, 0, , error: %errorlevel% `ngoto: %loc%`n closing...
		exitapp
	}
	clickBS(xq, yq, 1, 1, 0,0) ;var für klicken: with und high von goto_%loc%.png rerausfinden und ab mitte mit var klicken
	;if (loc_tar="loc_screen") 
		;sleep 1500
	/* mögliche wege:
	
	beutel - screen
	beutel - zerlegen
	screen - tierbuch1-3
	screen - orbswap-3
	
	
	
	*/
	
	return loc_tar
	
	/*
	
	if (InStr(loc, "loc_screen_loc_beutel")) ;;
		return "loc_beutel"
	if (InStr(loc, "loc_beutel_loc_screen")) { ;;
		return "loc_screen"
	}
	
	
	if (InStr(loc, "loc_beutel_loc_zerlegen")) ;;
		return "loc_zerlegen"
	if (InStr(loc, "loc_zerlegen_loc_beutel")) ;;
		return "loc_beutel"
	
	if (InStr(loc, "loc_screen_loc_tierbuch") or InStr(loc, "loc_screen_loc_orbswap") )  ;;
		return "loc_leiste"
	if (InStr(loc, "loc_leiste_loc_screen"))  ;;
		return "loc_screen"
	
	if (InStr(loc, "loc_leiste_loc_tierbuch"))  ;;
		return "loc_tierbuch"
	if (InStr(loc, "loc_leiste_loc_orbswap"))  ;;
		return "loc_orbswap"
	
	if (InStr(loc, "loc_tierbuchsite") and InStr(loc, "_loc_screen")) ;;
		return "loc_tierbuch"
	if (InStr(loc, "loc_orbswapsite") and InStr(loc, "_loc_screen")) ;;
		return "loc_orbswap"
	if ((InStr(loc, "loc_tierbuch") and InStr(loc, "_loc_screen")) or (InStr(loc, "loc_orbswap") and InStr(loc, "_loc_screen"))) ;;
		return "loc_leiste"
	
	
	if (InStr(loc, "loc_tierbuch_loc_tierbuchsite3"))
		return "loc_tierbuchsite3"
	if (InStr(loc, "loc_orbswap_loc_orbswapsite1"))
		return "loc_orbswapsite1"
	if (InStr(loc, "loc_orbswap_loc_orbswapsite2"))
		return "loc_orbswapsite2"
	if (InStr(loc, "loc_orbswap_loc_orbswapsite3"))
		return "loc_orbswapsite3"
	*/
	
}

current_location(sl := 200, n := 20) {
	humansleep(sl)
	log("currentlocation(" sl ")")
	t := A_TickCount
	errorlevel := 1
	while ((errorlevel=1) and (A_TickCount-t <= 1500)) {
		;log("current_location: " errorlevel " und " A_TickCount " " t)
		
		;array machen oder loc_%num%
		;liste aus files machen diese packen in array
		
		if (gamewin_search_boo("*" n " pictures\loc_leiste.png")=0)
			return "loc_leiste"
		if (gamewin_search_boo("*" n " pictures\loc_zerlegen.png")=0)
			return "loc_zerlegen"
		if (gamewin_search_boo("*" n " pictures\loc_tierbuch.png")=0)
			return "loc_tierbuch"
		if (gamewin_search_boo("*" n " pictures\loc_tierbuchsite3.png")=0)
			return "loc_tierbuchsite3"
		if (gamewin_search_boo("*" n " pictures\loc_orbswap.png")=0)
			return "loc_orbswap"
		if (gamewin_search_boo("*" n " pictures\loc_orbswapsite1.png")=0)
			return "loc_orbswapsite1"
		if (gamewin_search_boo("*" n " pictures\loc_orbswapsite2.png")=0)
			return "loc_orbswapsite2"
		if (gamewin_search_boo("*" n " pictures\loc_orbswapsite3.png")=0)
			return "loc_orbswapsite3"
	
		if (gamewin_search_boo("*" n " pictures\loc_beutel.png")=0) 
			return "loc_beutel"
		if (gamewin_search_boo("*" n " pictures\loc_screen.png")=0) 
			return "loc_screen"
	}
	
	blockinput, off
	msgbox, 0, ,  location not found `n`nclosing...
	exitapp
}

gamewin_search_boo(options, waittime := 1) {
	errorlevel := 1
	t := A_TickCount
	while ((errorlevel=1) and (A_TickCount-t <= waittime)) 
		imagesearch, xq, yq, 0, 0, 1284, 752, %options%
	
	log("gamewin_search_boo: Errorlevel = " errorlevel " und " A_TickCount " " t)
	
	if (errorlevel=2) {
		blockinput, off
		msgbox, 0, ,  errorlevel = 2 check file (%options%) `n`nclosing...
		exitapp
	} else 
		return Errorlevel
	
	/*
	`nErrorLevel = 0 if the image was found in the specified region 
	`nErrorLevel = 1 if it was not found
	`nErrorLevel = 2 if there was a problem that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option).
	*/
}



clickBS(x, y, varx, vary, sl1 := 1300,sl2 := 700) {
	humansleep(500)
	specialClickBS((x+random(-varx,varx)), (y+random(-vary,vary)), sl1, sl2)
}

specialClickBS(x,y,sl1 := 1300,sl2 := 700) {
	MouseMove,x,y
	humansleep(sl1)
	SendInput {LButton down}
	humansleep(sl2)
	SendInput {LButton up}
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