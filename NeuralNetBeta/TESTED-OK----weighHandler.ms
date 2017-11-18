-- Weight handler


struct weightClass
(
	public
	
	--- Current Weight ------------------------------------

	wndFCurW = 0,
	dstSCurW = 0,
	spdSCurW = 0,
	aclSCurW = 0,
	tltLCurW = [0,0,0],

	--- Current weight Position ---------------------------
	
	wndFWpos = [1,1],
	dstSWpos = [1,1],
	spdSWpos = [1,1],
	aclSWpos = [1,1],
	tltLWpos = #([1,1],[1,1],[1,1]),

	-- Functions ------------------------------------------

	fn init name =-----------------------------------------
	(
		name.wndFWarr = mathClass.arrayGenFn 100
		name.dstSWarr = mathClass.arrayGenFn 100
		name.spdSWarr = mathClass.arrayGenFn 100
		name.aclSWarr = mathClass.arrayGenFn 100
		
		for a=1 to 3 do
		(
			name.tltLWarr[a] = mathClass.arrayGenFn 5100 --Should be 3 arrays with 20 different numbers each	
		)	
		return true
	),
	fn updateWeights name = -------------------------------This will be used in the midle, when looking at past predictions after the wind estimate is complete.
	(
		name.wndFWarr = mathClass.wndWUpdateFn name.wndFWarr name.dstF name.dstS      name.tltF      name.wndFPast    name.dstFPast name.maxW name.maxAbs name.maxT name.wndFPWeight name.wndPWpos
		name.dstSWarr = mathClass.weightUpdtFn name.dstSWarr name.dstS name.dstSPPred name.dstSPWeight name.dstPWpos name.maxD
		name.spdSWarr = mathClass.weightUpdtFn name.spdSWarr name.spdS name.spdSPPred name.spdSPWeight name.spdPWpos name.maxS
		name.aclSWarr = mathClass.weightUpdtFn name.aclSWarr name.aclS name.aclSPPred name.aclSPWeight name.aclPWpos name.maxA
		
		for a=1 to 3 do 
		(
			name.tltLWarr[a] = mathClass.tltWeightUpdateFn name.tltLWarr[a] name.tltL[a] name.tltF[a] name.tltLPPred[a] name.tltLPWeight[a] name.tltPWPos[a] name.maxT
		)
		return true
	),
	fn catchWeights name = --------------------------------This will be in the midle in order to catch the weights to be used in the wind calculation and then the predictions
	(
		name.wndFWpos = mathClass.getWindWeightPosFn name.dstF name.tltF    name.maxAbs name.maxT   name.wndFWarr.count
		name.dstSWpos = mathClass.getWeightPosFn     name.dstS name.spdS    name.maxD   name.maxS   name.dstSWarr.count
		name.spdSWpos = mathClass.getWeightPosFn     name.spdS name.aclS    name.maxS   name.maxA   name.spdSWarr.count
		name.aclSWpos = mathClass.getWeightPosFn     name.aclS name.wndFEst name.maxA   name.maxW   name.aclSWarr.count
		
		name.wndFCurW = mathClass.getWeightFn name.wndFWarr name.wndFWpos
		name.dstSCurW = mathClass.getWeightFn name.dstSWarr name.dstSWpos
		name.spdSCurW = mathClass.getWeightFn name.spdSWarr name.spdSWpos
		name.aclSCurW = mathClass.getWeightFn name.aclSWarr name.aclSWpos

		for a=1 to 3 do 
		(
			name.tltLWpos[a] = mathClass.getWeightPosFn name.tltL[a]     name.tltF[a]     name.maxT name.maxT name.tltLWarr[a].count
			name.tltLCurW[a] = mathClass.getWeightFn    name.tltLWarr[a] name.tltLWpos[a]
		)
		
		return true
	),
	fn importValues name valueClass = ---------------------
	(
		-- Current Values --

		name.wndFEst  = valueClass.wndFEst
		name.dstS     = valueClass.dstS
		name.dstF     = valueClass.dstF
		name.spdS     = valueClass.spdS
		name.aclS     = valueClass.aclS
		name.tltL     = valueClass.tltL
		name.tltF     = valueClass.tltF
		
		-- Past Values --
		
		name.wndFPast = valueClass.wndFPast
		name.dstSPast = valueClass.dstSPast
		name.dstFPast = valueClass.dstFPast
		name.spdSPast = valueClass.spdSPast
		name.aclSPast = valueClass.aclSPast
		name.tltLPast = valueClass.tltLPast
		name.tltFPast = valueClass.tltFPast
		
		--Past weights --

		name.wndFPWeight = valueClass.wndFPWeight
		name.dstSPWeight = valueClass.dstSPWeight
		name.spdSPWeight = valueClass.spdSPWeight
		name.aclSPWeight = valueClass.aclSPWeight
		name.tltLPWeight = valueClass.tltLPWeight

		-- Past weight Position --

		name.wndPWpos = valueClass.wndPWpos
		name.dstPWPos = valueClass.dstPWPos
		name.spdPWPos = valueClass.spdPWPos
		name.aclPWPos = valueClass.aclPWPos
		name.tltPWPos = valueClass.tltPWPos

		-- Constant Values --

		name.maxAbs = valueClass.maxAbs
		name.maxD = valueClass.maxD
		name.maxS = valueClass.maxS
		name.maxA = valueClass.maxA
		name.maxW = valueClass.maxW
		name.maxT = valueClass.maxT

		return true
	),
	fn importPastPred name valueClass =--------------------
	(
		--name.wndFPPred = valueClass.wndFPPred
		name.dstSPPred = valueClass.dstSPPred
		name.spdSPPred = valueClass.spdSPPred
		name.aclSPPred = valueClass.aclSPPred
		name.tltLPPred = valueClass.tltLPPred

		return True
	),

	--- Hidden Variables ----------------------------------
	
	private
	
	--- Constant Values -----------------------------------

	maxAbs = 0,
	maxD = 0,
	maxS = 0,
	maxA = 0,
	maxW = 0,
	maxT = 0,
	
	--- Past predictions ----------------------------------
	
	--wndFPpred = 0,
	dstSPPred = 0,
	spdSPPred = 0,
	aclSPPred = 0,
	tltLPPred = [0,0,0],
	
	--- Current Predictions -------------------------------

	dstSPred = 0,
	spdSPred = 0,
	aclSPred = 0,
	tltFPred = [0,0,0],
	tltLPred = [0,0,0],

	--- Weight array --------------------------------------

	wndFWarr = 0,
	dstSWarr = 0,
	spdSWarr = 0,
	aclSWarr = 0,
	tltLWarr = #(0.0,0.0,0.0),

	-- Past Weights ---------------------------------------

	wndFPWeight = 0,
	dstSPWeight = 0,
	spdSPWeight = 0,
	aclSPWeight = 0,
	tltLPWeight = [0,0,0],

	-- Past Weight Position -------------------------------
	
	wndPWpos = [1,1],
	dstPWPos = [1,1],
	spdPWPos = [1,1],
	aclPWPos = [1,1],
	tltPWPos = #([1,1],[1,1],[1,1]),

	-- Current Position Values ----------------------------
	
	wndFEst = 0,
	dstS    = 0,
	dstF    = 0,
	spdS    = 0,
	aclS    = 0,
	tltF    = [0,0,0],
	tltL    = [0,0,0],

	-- Past Position Values -------------------------------

	wndFPast = 0,
	dstSPast = 0,
	dstFPast = 0,
	spdSPast = 0,
	aclSPast = 0,
	tltFPast = [0,0,0],
	tltLPast = [0,0,0]
)