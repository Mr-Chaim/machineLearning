-- Weight handler


struct weightClass
(
	public -----------------------------------------------

	-- Weight Array --------------------------------------
		
		WndFWarr = 0,
		dstFWarr = 0,
		dstSWarr = 0,
		spdSWarr = 0,
		aclSWarr = 0,

		tltLWarr = #(0.0,0.0,0.0),
		dstTWarr = #(0.0,0.0,0.0),
		spdTWarr = #(0.0,0.0,0.0),
	
	-- Current Weight ------------------------------------

		wndFCurW = 0,
		dstFCurW = 0,
		dstSCurW = 0,
		spdSCurW = 0,
		aclSCurW = 0,

		tltLCurW = [0,0,0],
		dstTCurW = [0,0,0],
		spdTCurW = [0,0,0],

	-- Current weight Position ---------------------------
		
		wndFWpos = [1,1],
		dstFWpos = [1,1],
		dstSWpos = [1,1],
		spdSWpos = [1,1],
		aclSWpos = [1,1],

		tltLWpos = #([1,1],[1,1],[1,1]),
		dstTWpos = #([1,1],[1,1],[1,1]),
		spdTWpos = #([1,1],[1,1],[1,1]),

	-- Functions -----------------------------------------

		fn init name =-------------------------------------Initiate the Weights.
		(
			name.WndFWarr = mathClass.arrayGenFn 20 --(name.maxAbs as integer)
			name.dstFWarr = mathClass.arrayGenFn 20 --(name.maxAbs as integer)
			name.dstSWarr = mathClass.arrayGenFn 20 --(name.maxAbs as integer)
			name.spdSWarr = mathClass.arrayGenFn 20 --(name.maxAbs as integer)
			name.aclSWarr = mathClass.arrayGenFn 20 --(name.maxAbs as integer)
			
			for a=1 to 2 do
			(	
				name.tltLWarr[a] = mathClass.arrayGenFn 360 --(name.maxT as integer)	
				name.dstTWarr[a] = mathClass.arrayGenFn 360 --(name.maxT as integer)
				name.spdTWarr[a] = mathClass.arrayGenFn 360 --(name.maxT as integer)
			)	
			return true
		),
		fn updateWeights name = ---------------------------This will be used in the midle, when looking at past predictions after the wind estimate is complete.
		(
			---------------------------------------1-------------2-------------3--------------4----------------5----------------6----------------7--------------8---------9-----------10--------11-------
			--Weight Array  Update Function        Curr array    Primary Val   Second Val     Ter val          Forth Val        Past Weight      Past W pos     Max Val 1 Max Val 2   Max Val 3 max Val 4
			name.WndFWarr = mathClass.wndWUpdateFn name.WndFWarr name.wndFPast name.dstF      name.dstS        name.tltF        name.wndFPWeight name.wndFPWpos name.maxW name.maxAbs name.maxD name.maxT
			
			----------------------------------------1-------------2-------------3--------------4----------------5----------------6----------------7-------------8-----
			--Weight Array  Update Function         Curr array    Primary Val   Second Val     Prediction Val   Past Weight      Past Weight pos  Max Constant  Max Second
			name.dstFWarr = mathClass.weightUpdtFn 	name.dstFWarr name.dstF     name.tltF[2]   name.dstFPPred   name.dstFPWeight name.dstFPWpos   name.maxAbs   name.maxT  
			name.dstSWarr = mathClass.weightUpdtFn 	name.dstSWarr name.dstS     name.tltF[2]   name.dstSPPred   name.dstSPWeight name.dstSPWpos   name.maxD     name.maxT
			name.spdSWarr = mathClass.weightUpdtFn 	name.spdSWarr name.spdS     name.tltF[2]   name.spdSPPred   name.spdSPWeight name.spdSPWpos   name.maxS     name.maxT
			name.aclSWarr = mathClass.weightUpdtFn 	name.aclSWarr name.aclS     name.tltF[2]   name.aclSPPred   name.aclSPWeight name.aclSPWpos   name.maxA     name.maxT
			
			for a=1 to 2 do 
			(
				-----------------------------------------------1----------------2------------3------------4-----------------5-------------------6-----------------7-----------8--------
				--Weight Array     Update Function             Curr array       Primary Val  Second Val   Prediction Value  Past Weight         Past Weight pos   Max Val 1   Max Val 2
				name.tltLWarr[a] = mathClass.tltWeightUpdateFn name.tltLWarr[a] name.tltL[a] name.tltF[a] name.tltLPPred[a] name.tltLPWeight[a] name.tltLPWPos[a] name.maxT   name.maxT
				name.dstTWarr[a] = mathClass.tltWeightUpdateFn name.dstTWarr[a] name.dstF    name.tltF[a] name.dstFPPred    name.dstTPWeight[a] name.dstTPWPos[a] name.maxAbs name.maxT
				name.spdTWarr[a] = mathClass.tltWeightUpdateFn name.spdTWarr[a] name.spdS    name.tltF[a] name.spdSPPred    name.spdTPWeight[a] name.spdTPWPos[a] name.maxS   name.maxT
			)
			return true
		),
		fn catchWeights name = ----------------------------This will be in the midle in order to catch the weights to be used in the wind calculation and then the predictions
		(
			---------------------------------------------1---------2---------3-----------4-----------5-----------6------------------
			--Current Pos   Method Function              Prim Val  Sec Val   Angle Val   Max Prim    Max Sec     Number of Nodes
			name.wndFWpos = mathClass.getWndFWeightPosFn name.dstF name.dstS name.tltF   name.maxAbs name.maxD   name.WndFWarr.count
			
			---------------------------------------------1---------2---------3-----------4-----------5------------------
			--Current Pos   Method Function              Prim Val  Sec Val   Max Prim    Max Sec     Number of Nodes
			name.dstFWpos = mathClass.getDstFWeightPosFn name.dstF name.tltF name.maxAbs name.maxT   name.dstFWarr.count
			name.dstSWpos = mathClass.getWeightPosFn     name.dstS name.dstF name.maxD   name.maxAbs name.dstSWarr.count
			name.spdSWpos = mathClass.getWeightPosFn     name.spdS name.dstF name.maxS   name.maxAbs name.spdSWarr.count
			name.aclSWpos = mathClass.getWeightPosFn     name.aclS name.dstF name.maxA   name.maxAbs name.aclSWarr.count
			
			--------------------------------------1-------------2------------
			--Curr Weight   Method Function       Curr Array    Curr Position
			name.wndFCurW = mathClass.getWeightFn name.WndFWarr name.wndFWpos
			name.dstFCurW = mathClass.getWeightFn name.dstFWarr name.dstFWpos
			name.dstSCurW = mathClass.getWeightFn name.dstSWarr name.dstSWpos
			name.spdSCurW = mathClass.getWeightFn name.spdSWarr name.spdSWpos
			name.aclSCurW = mathClass.getWeightFn name.aclSWarr name.aclSWpos

			
			for a=1 to 2 do 
			(
				--------------------------------------------1------------2------------3-----------4---------5---------------------
				--Current Pos      Method Function          Primary Val  Second Val   Max Prim    Max Sec   Number of Nodes
				name.tltLWpos[a] = mathClass.getWeightPosFn name.tltL[a] name.tltF[a] name.maxT   name.maxT name.tltLWarr[a].count
				name.dstTWpos[a] = mathClass.getWeightPosFn name.dstF    name.tltF[a] name.maxAbs name.maxT name.dstTWarr[a].count
				name.spdTWpos[a] = mathClass.getWeightPosFn name.spdS    name.tltF[a] name.maxS   name.maxT name.spdTWarr[a].count
			)
			for a=1 to 2 do 
			(
				-----------------------------------------1----------------2-------
				--Current Weight   Method Function       Curr Array       Curr Position
				name.tltLCurW[a] = mathClass.getWeightFn name.tltLWarr[a] name.tltLWpos[a]
				name.dstTCurW[a] = mathClass.getWeightFn name.dstTWarr[a] name.dstTWpos[a]
				name.spdTCurW[a] = mathClass.getWeightFn name.spdTWarr[a] name.spdTWpos[a]
			)
			/*
			seconds = (getLocalTime())
			if (seconds[8] >= 50 and seconds[8] < 100) do
		 	(
		 		clearListener()
				format "dstFCurW: %  dstFWpos: %  \n" dstFCurW dstFWpos
				format "dstSCurW: %  dstSWpos: %  \n" dstSCurW dstSWpos
				format "spdSCurW: %  spdSWpos: %  \n" spdSCurW spdSWpos
				format "aclSCurW: %  aclSWpos: %  \n" aclSCurW aclSWpos
				format "tltLCurW: %  tltLWpos: %  \n" tltLCurW tltLWpos
			)
			*/
			return true
		),
		fn importValues name valueClass = -----------------Import values from ValueClass in order to catch the weights.
		(
			-- Current Values --

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
			name.dstFPWeight = valueClass.dstFPWeight
			name.dstSPWeight = valueClass.dstSPWeight
			name.spdSPWeight = valueClass.spdSPWeight
			name.aclSPWeight = valueClass.aclSPWeight
			
			name.tltLPWeight = valueClass.tltLPWeight
			name.dstTPWeight = valueClass.dstTPWeight
			name.spdTPWeight = valueClass.spdTPWeight

			-- Past weight Position --

			name.wndFPWpos = valueClass.wndFPWpos
			name.dstFPWpos = valueClass.dstFPWpos
			name.dstSPWPos = valueClass.dstSPWPos
			name.spdSPWPos = valueClass.spdSPWPos
			name.aclSPWPos = valueClass.aclSPWPos
			
			name.tltLPWPos = valueClass.tltLPWPos
			name.dstTPWPos = valueClass.dstTPWPos
			name.spdTPWPos = valueClass.spdTPWPos

			-- Constant Values --

			name.maxW   = valueClass.maxW
			name.maxAbs = valueClass.maxAbs
			name.maxD   = valueClass.maxD
			name.maxS   = valueClass.maxS
			name.maxA   = valueClass.maxA
			
			name.maxT   = valueClass.maxT

			return true
		),
		fn importPastPred name valueClass =----------------Import the Past predictions in order to compare with the results and balance the weights.
		(
			name.dstFPPred = valueClass.dstFPPred
			name.dstSPPred = valueClass.dstSPPred
			name.spdSPPred = valueClass.spdSPPred
			name.aclSPPred = valueClass.aclSPPred

			name.tltLPPred = valueClass.tltLPPred

			return True
		),

	-- Hidden Variables ----------------------------------

	private ----------------------------------------------
	
	-- Constant Values -----------------------------------

		maxW   = 0,
		maxAbs = 0,
		maxD   = 0,
		maxS   = 0,
		maxA   = 0,

		maxT   = 0,
		
	-- Current Values ------------------------------------

		wndF = 0,
		dstF = 0,
		dstS = 0,
		spdS = 0,
		aclS = 0,

		tltF = [0,0,0],
		tltL = [0,0,0],

	-- Past Values ---------------------------------------

		wndFPast = 0,
		dstFPast = 0,
		dstSPast = 0,
		spdSPast = 0,
		aclSPast = 0,

		tltFPast = [0,0,0],
		tltLPast = [0,0,0],

	-- Past predictions ----------------------------------
	
		dstFPPred = 0,
		dstSPPred = 0,
		spdSPPred = 0,
		aclSPPred = 0,

		tltLPPred = [0,0,0],
	
	-- Current Predictions -------------------------------

		dstFPred = 0,
		dstSPred = 0,
		spdSPred = 0,
		aclSPred = 0,

		tltFPred = [0,0,0],
		tltLPred = [0,0,0],

	-- Past Weights --------------------------------------

		wndFPWeight = 0,
		dstFPWeight = 0,
		dstSPWeight = 0,
		spdSPWeight = 0,
		aclSPWeight = 0,

		tltLPWeight = [0,0,0],
		dstTPWeight = [0,0,0],
		spdTPWeight = [0,0,0],

	-- Past Weight Position ------------------------------
		
		wndFPWpos = [1,1],
		dstFPWpos = [1,1],
		dstSPWPos = [1,1],
		spdSPWPos = [1,1],
		aclSPWPos = [1,1],

		tltLPWPos = #([1,1],[1,1],[1,1]),
		dstTPWPos = #([1,1],[1,1],[1,1]),
		spdTPWPos = #([1,1],[1,1],[1,1])
)