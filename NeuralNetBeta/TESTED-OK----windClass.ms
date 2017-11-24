struct windClass
(
	public

	wndF    = 0,
	wndT    = [0,0,0],

	fn updateValues name =
	(
		--- Wind Force Calc Start --------------------------------------------

			---- Weight Values -----------------------------------------------

				wFW = name.wndFW
				dFw = name.dstFw 
				dSW = name.dstSW 
				sSW = name.spdSW 
				aSW = name.aclSW 

			---- Constant ----------------------------------------------------
			
				mW  = name.maxW 
				
			---- Array Value -------------------------------------------------
			
				layersArr = #(wFW,dFw,dSW,sSW,aSW)
			
			---- Final Calculation -------------------------------------------
			
				nWindRes = mathClass.wndFinlFn layersArr mW
				
				name.wndF = nWindRes
		
			
		--- Wind Tilt Calc Start ---------------------------------------------
			
			---- Weights -----------------------------------------------------
			
				tLWX = name.tltLW[1]
				dTWX = name.dstTW[1]
				sTWX = name.spdTW[1]

				tLWY = name.tltLW[2]
				dTWY = name.dstTW[2]
				sTWY = name.spdTW[2]
			
			---- Constant ----------------------------------------------------

				mT = name.maxWT
			
			---- Array Value -------------------------------------------------

				wndXArr = [tLWX,dTWX,sTWX]
				wndYArr = [tLWY,dTWY,sTWY]

			---- Final Calculation -------------------------------------------
					
				name.wndT[1] = (mathClass.wndFinlTltFn wndXArr mT)
				name.wndT[2] = mathClass.wndFinlTltFn wndYArr mT
			
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
		-- Current Constants --

		name.maxW  = valueClass.maxW
		name.maxWT = valueClass.maxWT

		-- Weight Values --

		name.wndFW = valueClass.wndFW
		name.dstFw = valueClass.dstFw
		name.dstSW = valueClass.dstSW
		name.spdSW = valueClass.spdSW
		name.aclSW = valueClass.aclSW

		name.tltLW = valueClass.tltLW
		name.dstTW = valueClass.dstTW
		name.spdTW = valueClass.spdTW

		return true
	),

	private

	-- Constant Values --

	maxW   = 0,
	maxWT  = 0,

	-- Weight Values --

	wndFW = 0,
	dstFW = 0,
	dstSW = 0,
	spdSW = 0,
	aclSW = 0,

	tltLW = [0,0,0],
	dstTW = [0,0,0],
	spdTW = [0,0,0]
)