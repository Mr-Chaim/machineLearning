struct valueClass
(
	public
	-- Constant Values -----------------
		maxAbs = 0,
		maxW = 0,
		maxD = 0,
		maxS = 0,
		maxA = 0,
		maxT = 0,

	---Wind Values----------------------
	
		wndF     = 0,
		wndT     = [0,0,0],
		
		wndFEst  = 0,
		wndFPast = 0,
		
		wndFW       = 0,
		wndFPWeight = 0,
		
		wndFWpos = [1,1],
		wndPWpos = [1,1],

	
	---Distance Values------------------

		dstS     = 0,
		dstSPast = 0,

		dstF     = 0,
		dstFPast = 0,
	
		dstSPred  = 0,
		dstSPPred = 0,
	
		dstSW       = 0,
		dstSPWeight = 0,
	
		dstSWpos    = [1,1],
		dstPWPos    = [1,1],
	
	---Speed Values---------------------

		spdS      = 0,
		spdSPast  = 0,
	
		spdSPred  = 0,
		spdSPPred = 0,
	
		spdSW       = 0,
		spdSPWeight = 0,
	
		spdSWpos = [1,1],
		spdPWPos = [1,1],
	
	---Aceleration Values---------------

		aclS     = 0,
		aclSPast = 0,
	
		aclSPred  = 0,
		aclSPPred = 0,
	
		aclSW       = 0,
		aclSPWeight = 0,
	
		aclSWpos = [1,1],
		aclPWPos = [1,1],

	---Tilt Values----------------------
	
		tltL        = [0,0,0],
		tltF        = [0,0,0],

		tltLPast    = [0,0,0],
		tltFPast    = [0,0,0],
	
		tltLPred    = [0,0,0],
		tltLPPred   = [0,0,0],
	
		tltLW       = [0,0,0],
		tltLPWeight = [0,0,0],
	
		tltLWpos     = #([1,1],[1,1],[1,1]),
		tltPWPos    = #([1,1],[1,1],[1,1]),

	---Position Values------------------

		posFPred  = [0,0,0],
		posFPPred = [0,0,0],

		souPos     = [0,0,0],
		souPosPast = [0,0,0],
	
		tarPos     = [0,0,0],
		tarPosPast = [0,0,0],
		
		tarObjPos = [0,0,0],
		souObjPos = [0,0,0],
	
	fn importConst name constClass =
	(
		name.maxAbs = constClass.maxAbs
		name.maxW   = constClass.maxWindForce
		name.maxD   = constClass.maxDistance
		name.maxS   = constClass.maxSpeed
		name.maxA   = constClass.maxacel
		name.maxT   = constClass.maxTilt

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
		name.dstS = posClass.dstS
		name.dstF = posClass.dstF
		name.spdS = posClass.spdS
		name.aclS = posClass.aclS
		name.tltF = posClass.tltF
		name.tltL = posClass.tltL

		return true
	),
	fn importWnd name windClass =
	(
		name.wndFEst = windClass.wndFEst
		name.wndF    = windClass.wndF
		name.wndT    = windClass.wndT
		
		return true
	),
	fn importWeights name weightClass =
	(
		name.wndFW = weightClass.wndFCurW
		name.dstSW = weightClass.dstSCurW
		name.spdSW = weightClass.spdSCurW
		name.aclSW = weightClass.aclSCurW
		name.tltLW = weightClass.tltLCurW

		name.wndFWpos = weightClass.wndFWpos
		name.dstSWpos = weightClass.dstSWpos
		name.spdSWpos = weightClass.spdSWpos
		name.aclSWpos = weightClass.aclSWpos
		name.tltLWpos = weightClass.tltLWpos
		
		return true
	),
	fn importPred name predClass =
	(
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

			name.dstSPPred = name.dstSPred
			name.spdSPPred = name.spdSPred
			name.aclSPPred = name.aclSPred
			name.tltLPPred = name.tltLPred
			name.posFPPred = name.posFPred
		
		-- Position Values --
		
			name.wndFpast = name.wndF
			name.dstSPast = name.dstS     
			name.dstFPast = name.dstF
			name.spdSPast = name.spdS     
			name.aclSPast = name.aclS     
			name.tltFPast = name.tltF
			name.tltLPast = name.tltL
		
		-- Weight Values --
			name.wndFPWeight = name.wndFW
			name.dstSPWeight = name.dstSW 
			name.spdSPWeight = name.spdSW
			name.aclSPWeight = name.aclSW
			name.tltLPWeight = name.tltLW
			
		-- Weight Position --

			name.wndPWpos = name.wndFWpos
			name.dstPWPos = name.dstSWPos
			name.spdPWPos = name.spdSWPos
			name.aclPWPos = name.aclSWPos
			name.tltPWPos = name.tltLWPos

		-- Object Position --
		
			name.souPosPast = name.souPos     
			name.tarPosPast = name.tarPos     
		
		return true
	),
	fn testValues test = 
	(
		
		maxW = const.maxWindForce
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxacel
		maxT = const.maxTilt
		
		test.wndF     = mathClass.randomGenFn -maxW maxW
		test.wndFPast = mathClass.randomGenFn -maxW maxW
		test.wndFPred = mathClass.randomGenFn -maxW maxW
		
		test.dstS     = mathClass.randomGenFn -maxD maxD
		test.dstSPast = mathClass.randomGenFn -maxD maxD
		test.dstSPred = mathClass.randomGenFn -maxD maxD
		
		test.spdS     = mathClass.randomGenFn -maxS maxS
		test.spdSPast = mathClass.randomGenFn -maxS maxS
		test.spdSPred = mathClass.randomGenFn -maxS maxS
		
		test.aclS     = mathClass.randomGenFn -maxA maxA
		test.aclSPast = mathClass.randomGenFn -maxA maxA
		test.aclSPred = mathClass.randomGenFn -maxA maxA
		
		test.dstFc     = mathClass.randomGenFn -maxD maxD
		test.dstFcPast = mathClass.randomGenFn -maxD maxD
		
		for a=1 to 3 do
		(
			test.tltF[a]     = mathClass.randomGenFn -maxT maxT
			test.tltFPast[a] = mathClass.randomGenFn -maxT maxT
			test.tltFPred[a] = mathClass.randomGenFn -maxT maxT
			
			test.tltL[a]     =mathClass.randomGenFn -maxT maxT
			test.tltLPast[a] =mathClass.randomGenFn -maxT maxT
			
			test.souPos[a]    =mathClass.randomGenFn -maxD maxD
			test.souPosPast[a] =mathClass.randomGenFn -maxD maxD
			
			test.tarPos[a]    =mathClass.randomGenFn -maxD maxD
			test.tarPosPast[a] =mathClass.randomGenFn -maxD maxD
		)



		return true
	)
)
/*
fn valueClassTestFn =
(
	constClass()
	mathClass()

	valclassTEST = valueClass()
	
	valclassTEST.testValues valclassTEST
	valclassTEST.importVar valclassTEST valclassTEST valclassTEST valclassTEST valclassTEST

	print valclassTEST.wndF
	print valclassTEST.wndFPast
	print valclassTEST.wndFPred

	print valclassTEST.dstS
	print valclassTEST.dstSPast
	print valclassTEST.dstSPred
	
	print valclassTEST.spdS
	print valclassTEST.spdSPast
	print valclassTEST.spdSPred
	
	print valclassTEST.aclS
	print valclassTEST.aclSPast
	print valclassTEST.aclSPred
	
	print valclassTEST.tltF
	print valclassTEST.tltFPast
	print valclassTEST.tltFPred

	print valclassTEST.dstFc     
	print valclassTEST.dstFcPast 

	print valclassTEST.tltL     
	print valclassTEST.tltLPast 
	
	print valclassTEST.souPos    
	print valclassTEST.souPosPast
	
	print valclassTEST.tarPos    
	print valclassTEST.tarPosPast

	return true
)
*/