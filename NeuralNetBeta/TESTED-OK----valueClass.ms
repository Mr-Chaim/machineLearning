struct valueClass
(
	public

	wndFPast  = 0,
	wndFPred  = 0,
	wndFW     = 0,
	wndFinalF = 0,
	wndFinalT = [0,0,0],
	
	dstS     = 0,
	dstSPast = 0,
	dstSPred = 0,
	dstSW    = 0,
	
	spdS     = 0,
	spdSPast = 0,
	spdSPred = 0,
	spdSW    = 0,
	
	aclS     = 0,
	aclSPast = 0,
	aclSPred = 0,
	aclSW    = 0,
	
	tltF     = [0,0,0],
	tltFPast = [0,0,0],
	tltFPred = [0,0,0],
	tltFW    = [0,0,0],

	dstL     = 0,
	dstLPast = 0,

	tltL     = [0,0,0],
	tltLPast = [0,0,0],
	
	souPos     = [0,0,0],
	souPosPast = [0,0,0],
	
	tarPos     = [0,0,0],
	tarPosPast = [0,0,0],

	tarObjPos = [0,0,0],
	souObjPos = [0,0,0],

	

	fn importWnd name windClass =
	(
		name.wndFinalF = windClass.wndFinalF
		name.wndFinalT = windClass.wndFinalT
		name.wndFPast  = windClass.wndFPast

		return true
	),
	fn importDist name posClass =
	(
		name.dstS      = posClass.dstS
		name.dstSPast  = posClass.dstSPast

		name.dstL     = posClass.dstL
		name.dstLPast = posClass.dstLPast

		return true
	),
	fn importSpd name spdClass =
	(
		name.spdS      = spdClass.spdS
		name.spdSPast  = spdClass.spdSPast

		return true
	),
	fn importAcl name acelClass =
	(
		name.aclS      = acelClass.aclS
		name.aclSPast  = acelClass.aclSPast

		return true
	),
	fn importTlt name posClass =
	(
		name.tltF     = posClass.tltF
		name.tltFPast = posClass.tltFPast

		name.tltL     = posClass.tltL
		name.tltLPast = posClass.tltLPast

		return true
	),
	fn importPred name predClass =
	(
		name.wndFPred = predClass.wndFPred
		name.dstSPred = predClass.dstSPred
		name.spdSPred = predClass.spdSPred
		name.aclSPred = predClass.aclSPred
		name.tltLPred = predClass.tltFPred

		return True
	),
	fn importWeights name weightClass =
	(
		name.wndFW = weightClass.wndFCurW
		name.dstSW = weightClass.dstSCurW
		name.spdSW = weightClass.spdSCurW
		name.aclSW = weightClass.aclSCurW
		name.tltLW = weightClass.tltLCurW
		
		return true
	),
	fn importPos name objClass posClass=
	(
		name.tarPos = objClass.tarPos
		name.souPos = objClass.souPos

		name.souPosPast = posClass.souPosPast
		name.tarPosPast = posClass.tarPosPast

		return True
	),
	fn testValues test= 
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
		
		test.dstLc     = mathClass.randomGenFn -maxD maxD
		test.dstLcPast = mathClass.randomGenFn -maxD maxD
		
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
	),

	private
	
	const = constClass()
)

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

	print valclassTEST.dstLc     
	print valclassTEST.dstLcPast 

	print valclassTEST.tltL     
	print valclassTEST.tltLPast 
	
	print valclassTEST.souPos    
	print valclassTEST.souPosPast
	
	print valclassTEST.tarPos    
	print valclassTEST.tarPosPast

	return true
)
