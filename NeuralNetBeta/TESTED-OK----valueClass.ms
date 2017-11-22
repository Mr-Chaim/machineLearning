struct valueClass
(
	public

	---Constant Values -----------------
	
		maxAbs = 0,
		maxW   = 0,
		maxD   = 0,
		maxS   = 0,
		maxA   = 0,
		maxT   = 0,
		currentMaxD  = 0,
		CurrentMaxS  = 0,
		CurrentMaxA  = 0,

	---Wind Values----------------------
	
		wndF        = 0,
		wndFPast    = 0,

		wndFW       = 0,
		wndFPWeight = 0,

		wndFWpos    = [1,1],
		wndFPWpos   = [1,1],
		
		wndT        = [0,0,0],
		wndTpast    = [0,0,0],

		wndTW       = [0,0,0],
		wndTPWeight = [0,0,0],

		wndTWpos    = #([1,1],[1,1],[1,1]),
		wndTPWpos   = #([1,1],[1,1],[1,1]),
		
	---Absolute Distance Values------------------

		dstF        = 0,
		dstFPast    = 0,

		dstFpred    = 0,
		dstFPPred   = 0,
	
		dstFW       = 0,
		dstFPWeight = 0,
	
		dstFWpos    = [1,1],
		dstFPWpos   = [1,1],

	---Local Distance Values------------------

		dstS        = 0,
		dstSPast    = 0,
	
		dstSPred    = 0,
		dstSPPred   = 0,
	
		dstSW       = 0,
		dstSPWeight = 0,
	
		dstSWpos    = [1,1],
		dstSPWPos   = [1,1],
	
	---Speed Values---------------------

		spdS      = 0,
		spdSPast  = 0,
	
		spdSPred  = 0,
		spdSPPred = 0,
	
		spdSW       = 0,
		spdSPWeight = 0,
	
		spdSWpos  = [1,1],
		spdSPWPos = [1,1],
	
	---Aceleration Values---------------

		aclS     = 0,
		aclSPast = 0,
	
		aclSPred  = 0,
		aclSPPred = 0,
	
		aclSW       = 0,
		aclSPWeight = 0,
	
		aclSWpos  = [1,1],
		aclSPWPos = [1,1],
	
	---Absolute Tilt Values----------------------
	
		tltF        = [0,0,0],
		tltFPast    = [0,0,0],
	
	---Local Tilt Values----------------------
	
		tltL        = [0,0,0],
		tltLPast    = [0,0,0],
	
		tltLPred    = [0,0,0],
		tltLPPred   = [0,0,0],
	
		tltLW       = [0,0,0],
		tltLPWeight = [0,0,0],
	
		tltLWpos    = #([1,1],[1,1],[1,1]),
		tltLPWPos   = #([1,1],[1,1],[1,1]),

	---Position Values------------------

		posFPred   = [0,0,0],
		posFPPred  = [0,0,0],

		souPos     = [0,0,0],
		souPosPast = [0,0,0],
	
		tarPos     = [0,0,0],
		tarPosPast = [0,0,0],
		
		tarObjPos  = [0,0,0],
		souObjPos  = [0,0,0],
	
	---Functions----------------------

		fn importConst name constClass =
		(
			name.maxAbs = constClass.maxAbs
			name.maxW   = constClass.maxWindForce
			name.maxD   = constClass.maxDistance
			name.maxS   = constClass.maxSpeed
			name.maxA   = constClass.maxacel
			name.maxT   = constClass.maxTilt
			name.currentMaxD = constClass.currentMaxD
			name.CurrentMaxS = constClass.CurrentMaxS
			name.CurrentMaxA = constClass.CurrentMaxA

			return true
		),
		fn importObjPos name objClass=
		(
			name.tarPos = objClass.tarPos
			name.souPos = objClass.souPos

			return True
		),
		fn importPos name posClass =
		(
			name.dstF = posClass.dstF
			name.dstS = posClass.dstS
			name.spdS = posClass.spdS
			name.aclS = posClass.aclS
			name.tltF = posClass.tltF
			name.tltL = posClass.tltL

			return true
		),
		fn importWnd name windClass =
		(
			name.wndF    = windClass.wndF
			name.wndT    = windClass.wndT
			
			return true
		),
		fn importWeights name weightClass =
		(
			name.wndFW = weightClass.wndFCurW
			name.dstFW = weightClass.dstFCurW
			name.dstSW = weightClass.dstSCurW
			name.spdSW = weightClass.spdSCurW
			name.aclSW = weightClass.aclSCurW
			name.tltLW = weightClass.tltLCurW

			name.wndFWpos = weightClass.wndFWpos
			name.dstFWpos = weightClass.dstFWpos
			name.dstSWpos = weightClass.dstSWpos
			name.spdSWpos = weightClass.spdSWpos
			name.aclSWpos = weightClass.aclSWpos
			name.tltLWpos = weightClass.tltLWpos

			/*
			seconds = (getLocalTime())
			if (seconds[8] >= 50 and seconds[8] < 100) do
		 	(
		 		clearListener()
				format "dstFW: %  dstFCurW: %  dstFWpos: %  \n" name.dstFW weightClass.dstFCurW weightClass.dstFWpos
				format "dstSW: %  dstSCurW: %  dstSWpos: %  \n" name.dstSW weightClass.dstSCurW weightClass.dstSWpos
				format "spdSW: %  spdSCurW: %  spdSWpos: %  \n" name.spdSW weightClass.spdSCurW weightClass.spdSWpos
				format "aclSW: %  aclSCurW: %  aclSWpos: %  \n" name.aclSW weightClass.aclSCurW weightClass.aclSWpos
				format "tltLW: %  tltLCurW: %  tltLWpos: %  \n" name.tltLW weightClass.tltLCurW weightClass.tltLWpos
			)
			*/
			
			return true
		),
		fn importPred name predClass =
		(
			name.dstFpred = predClass.dstFpred
			name.dstSPred = predClass.dstSPred
			name.spdSPred = predClass.spdSPred
			name.aclSPred = predClass.aclSPred
			name.tltLPred = predClass.tltLPred
			name.posFPred = predClass.posFPred

			return True
		),
		fn updatePast name =
		(
			-- Prediction Values --

				name.dstFPPred = name.dstFPred
				name.dstSPPred = name.dstSPred
				name.spdSPPred = name.spdSPred
				name.aclSPPred = name.aclSPred
				name.tltLPPred = name.tltLPred
				name.posFPPred = name.posFPred
			
			-- Position Values --
			
				name.wndFpast = name.wndF
				name.wndTpast = name.wndT
				name.dstFPast = name.dstF
				name.dstSPast = name.dstS     
				name.spdSPast = name.spdS     
				name.aclSPast = name.aclS     
				name.tltFPast = name.tltF
				name.tltLPast = name.tltL
			
			-- Weight Values --

				name.wndFPWeight = name.wndFW
				--name.wndTPWeight = name.wndTW -- Not Being used yet
				name.dstFPWeight = name.dstFW
				name.dstSPWeight = name.dstSW 
				name.spdSPWeight = name.spdSW
				name.aclSPWeight = name.aclSW
				name.tltLPWeight = name.tltLW
				
			-- Weight Position --
				
				name.wndFPWpos = name.wndFWpos
				--name.wndTPWpos = name.wndTWpos -- Not Being used yet
				name.dstFPWpos = name.dstFWpos
				name.dstSPWPos = name.dstSWPos
				name.spdSPWPos = name.spdSWPos
				name.aclSPWPos = name.aclSWPos
				name.tltLPWPos = name.tltLWPos

			-- Object Position --
			
				name.souPosPast = name.souPos     
				name.tarPosPast = name.tarPos     
			
			return true
		)
)