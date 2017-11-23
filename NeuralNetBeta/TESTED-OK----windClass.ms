struct windClass
(
	public

	wndF    = 0,
	wndT    = [0,0,0],

	fn updateValues name =
	(
		--- Wind Force Calc Start ----
			
			---- Current Values ----------------------------------------------
			
				wFV  = 0
				dFV  = name.dstF 
				dSV  = name.dstS 
				sSV  = name.spdS 
				aSV  = name.aclS 

			---- Past Values -------------------------------------------------

				wFp = name.wndFpast
				dFP = name.dstFPast
				dSP = name.dstSPast
				sSP = name.spdSPast
				aSP = name.aclSPast

			---- Weight Values -----------------------------------------------

				wFW = name.wndFW
				dFw = name.dstFw 
				dSW = name.dstSW 
				sSW = name.spdSW 
				aSW = name.aclSW 

			---- Constant ----------------------------------------------------
			
				mW  = name.maxW 
				mAb = name.maxAbs 
				mD  = name.maxD 
				mS  = name.maxS 
				mA  = name.maxA
			
			---- Absolute Value ----------------------------------------------

				wFAbs = mathClass.absLimitFn wFV wFp wFW mW 
				dFAbs = mathClass.absLimitFn dFV dFP dFW mAb
				dSAbs = mathClass.absLimitFn dSV dSP dSW mD 
				sSAbs = mathClass.absLimitFn sSV sSP sSW mS 
				aSAbs = mathClass.absLimitFn aSV aSP aSW mA
			
			---- Array Value -------------------------------------------------
			
				layersArr = #(wFW,dFw,dSW,sSW,aSW)
			
			---- Final Calculation -------------------------------------------
			
				nWindRes = mathClass.wndFinlFn wFp wFW layersArr mW
				if dFV >= mAb and dSV <= 0.05 and sSV <= 0.05 and aSV >= 0.05 do
				(
					nWindRes = mW *5
					print "Bump!"
				)
		
				name.wndF = nWindRes
		
			
		--- Wind Tilt Calc Start ----
			
			---- Current Values ----------------------------------------------
			
				wndTX = 0
				wndTY = 0
		
				tltLX  = name.tltL[1]
				tltLY  = name.tltL[2]
			
				tltFX  = name.tltF[1]
				tltFY  = name.tltF[2]
			
			---- Past Values -------------------------------------------------

				wndTpastX = 0
				wndTpastY = 0
				--wndTpastX = name.wndTpast[1]
				--wndTpastY = name.wndTpast[2]

				tltLPastX = name.tltLPast[1]
				tltLPastY = name.tltLPast[2]
			
				tltFPastX = name.tltFPast[1]
				tltFPastY = name.tltFPast[2]
			
			---- Weight Values -----------------------------------------------

				wndTWX = name.wndTw[1]
				wndTWY = name.wndTw[2]

				tltLWX = name.tltLW[1]
				tltLWY = name.tltLW[2]

				tltFWX = name.tltFw[1]
				tltFWY = name.tltFw[2]

			---- Constant ----------------------------------------------------

				mT = name.maxT
			
			---- Absolute Value ----------------------------------------------

				wndTPAbsX = mathClass.absLimitFn wndTX wndTPastX wndTWX mT
				wndTPAbsY = mathClass.absLimitFn wndTY wndTPastY wndTWY mT

				tltLAbsX = mathClass.absLimitFn tltLX tltLPastX tltLWX mT
				tltLAbsY = mathClass.absLimitFn tltLY tltLPastY tltLWY mT

				tltFAbsX = mathClass.absLimitFn tltFX tltFPastX tltLWX mT
				tltFAbsY = mathClass.absLimitFn tltFY tltFPastY tltLWY mT

			---- Array Value -------------------------------------------------

				wndXArr = [tltLAbsX,tltFAbsX]
				wndYArr = [tltLAbsY,tltFAbsY]

			---- Final Calculation -------------------------------------------
					
				name.wndT[1] = mathClass.wndFinlTltFn wndTPAbsX tltFAbsX mT
				name.wndT[2] = mathClass.wndFinlTltFn wndTPAbsY tltFAbsY mT
			
		/*
			twoDec = mathClass.twoDecFn 
		 	seconds = (getLocalTime())
			if (seconds[8] >= 50 and seconds[8] < 100) do
		 	(
		 		clearListener()
		 		format"\n"
		 		
		 		format "wndF: % - wndFpast: % - wndFAbs: % - wndFW: %\n" (twoDec wFV)(twoDec wFp) wFAbs wFW
		 		format "dstF: % - dstFPast: % - dstFAbs: % - dstFw: %\n" (twoDec dFV)(twoDec dFP) dFAbs dFw
		 		format "dstS: % - dstSPast: % - dstSAbs: % - dstSW: %\n" (twoDec dSV)(twoDec dSP) dSAbs dSW
		 		format "spdS: % - spdSPast: % - spdSAbs: % - spdSW: %\n" (twoDec sSV)(twoDec sSP) sSAbs sSW
		 		format "aclS: % - aclSPast: % - aclSAbs: % - aclSW: %\n" (twoDec aSV)(twoDec aSP) aSAbs aSW
		 		
		 		format"\n"
		 		
		 		format "wndF: %\n" (twoDec name.wndF)
		 		
		 		format"\n"
		 		
		 		format "wndTX: % --- wndTPastX: % --- wndTPAbsX: % ---wndTWX: %\n" (twoDec wndTX) wndTPastX wndTPAbsX wndTWX
		 		format "wndTY: % --- wndTPastY: % --- wndTPAbsY: % ---wndTWY: %\n" (twoDec wndTY) wndTPastY wndTPAbsY wndTWY
 
		 		format "tltLX: % --- tltLPastX: % --- tltLAbsX: % ----tltLWX: %\n" (twoDec tltLX) tltLPastX tltLAbsX  tltLWX
		 		format "tltLY: % --- tltLPastY: % --- tltLAbsY: % ----tltLWY: %\n" (twoDec tltLY) tltLPastY tltLAbsY  tltLWY
		 		 
		 		format "tltFX: % --- tltFPastX: % --- tltFAbsX: % ----tltFWX: %\n" (twoDec tltFX) tltFPastX tltFAbsX  tltFWX
		 		format "tltFY: % --- tltFPastY: % --- tltFAbsY: % ----tltFWY: %\n" (twoDec tltFY) tltFPastY tltFAbsY  tltFWY
		 		
		 		format"\n"
		 		
		 		format "wndTX: %\n" (name.wndT[1])
		 		format "wndTY: %\n" (name.wndT[2])
		 		
		 		format"\n"
		 	)
		*/

		

		return true
	),
	fn importValues name valueClass =
	(
		-- Current Values --

		name.dstF = valueClass.dstF
		name.dstS = valueClass.dstS
		name.spdS = valueClass.spdS
		name.aclS = valueClass.aclS
		name.tltL = valueClass.tltL 
		name.tltF = valueClass.tltF
		
		-- Past Values --
		
		name.wndFpast = valueClass.wndFpast
		name.wndTpast = valueClass.wndTpast
		name.dstFPast = valueClass.dstFPast
		name.dstSPast = valueClass.dstSPast
		name.spdSPast = valueClass.spdSPast
		name.aclSPast = valueClass.aclSPast
		name.tltLPast = valueClass.tltLPast
		name.tltFPast = valueClass.tltFPast

		-- Constant Values --

		name.maxAbs = valueClass.maxAbs
		name.maxD = valueClass.maxD
		name.maxS = valueClass.maxS
		name.maxA = valueClass.maxA
		name.maxW = valueClass.maxW
		name.maxT = valueClass.maxT

		-- Weight Values --

		name.wndFW = valueClass.wndFW
		name.dstFw = valueClass.dstFw
		name.dstSW = valueClass.dstSW
		name.spdSW = valueClass.spdSW
		name.aclSW = valueClass.aclSW
		name.tltLW = valueClass.tltLW

		/*
		seconds = (getLocalTime())
		if (seconds[8] >= 50 and seconds[8] < 100) do
	 	(
	 		clearListener()
			format "dstFW: %  dstFW: % \n" name.dstFW valueClass.dstFW
			format "dstSW: %  dstSW: % \n" name.dstSW valueClass.dstSW
			format "spdSW: %  spdSW: % \n" name.spdSW valueClass.spdSW
			format "aclSW: %  aclSW: % \n" name.aclSW valueClass.aclSW
			format "tltLW: %  tltLW: % \n" name.tltLW valueClass.tltLW
		)
		*/

		return true
	),

	private

	-- Constant Values --

	maxAbs = 0,
	maxD   = 0,
	maxS   = 0,
	maxA   = 0,
	maxW   = 0,
	maxT   = 0,

	-- Current Values --

	dstS = 0,
	dstF = 0,
	spdS = 0,
	aclS = 0,
	tltL = [0,0,0],
	tltF = [0,0,0],

	-- Past Values --
	
	wndFpast = 0,
	wndTpast = [0,0,0],
	dstFPast = 0,
	dstSPast = 0,
	spdSPast = 0,
	aclSPast = 0,
	tltLPast = [0,0,0],
	tltFPast = [0,0,0],

	-- Weight Values --

	wndFW = 0,
	wndTW = [0,0,0],
	dstFW = 0,
	dstSW = 0,
	spdSW = 0,
	aclSW = 0,
	tltLW = [0,0,0],
	tltFW = [0,0,0]
)