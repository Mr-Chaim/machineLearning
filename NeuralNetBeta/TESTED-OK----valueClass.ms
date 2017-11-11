struct valueClass
(
	public

	wndF     = 0,
	wndFPast = 0,
	wndFPred = 0,
	
	dstS     = 0,
	dstSPast = 0,
	dstSPred = 0,
	
	spdS     = 0,
	spdSPast = 0,
	spdSPred = 0,
	
	aclS     = 0,
	aclSPast = 0,
	aclSPred = 0,
	
	tltF     = [0,0,0],
	tltFPast = [0,0,0],
	tltFPred = [0,0,0],

	dstLc     = 0,
	dstLcPast = 0,

	tltLc     = [0,0,0],
	tltLcPast = [0,0,0],
	
	souPos    = [0,0,0],
	souPosPast = [0,0,0],
	
	tarPos    = [0,0,0],
	tarPosPast = [0,0,0],

	fn importWnd name windClass =
	(
		name.wndF      = windClass.wndF    
		name.wndFPast  = windClass.wndFPast

		return true
	),
	fn importDist name posClass =
	(
		name.dstS      = posClass.dstS
		name.dstSPast  = posClass.dstSPast

		name.dstLc     = posClass.dstLc
		name.dstLcPast = posClass.dstLcPast

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
		name.tltF      = posClass.tltF
		name.tltFPast  = posClass.tltFPast
		name.tltLc     = posClass.tltLc
		name.tltLcPast = posClass.tltLcPast

		return true
	),
	fn importPos name posClass =
	(
		name.souPos     = posClass.souPos
		name.souPosPast = posClass.souPosPast

		name.tarPos     = posClass.tarPos
		name.tarPosPast = posClass.tarPosPast

		return true
	),
	fn importPred name predClass =
	(
		name.wndFPred = predClass.wndFPred
		name.dstSPred = predClass.dstSPred
		name.spdSPred = predClass.spdSPred
		name.aclSPred = predClass.aclSPred
		name.tltFPred = predClass.tltFPred

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
			
			test.tltLc[a]     =mathClass.randomGenFn -maxT maxT
			test.tltLcPast[a] =mathClass.randomGenFn -maxT maxT
			
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

	print valclassTEST.tltLc     
	print valclassTEST.tltLcPast 
	
	print valclassTEST.souPos    
	print valclassTEST.souPosPast
	
	print valclassTEST.tarPos    
	print valclassTEST.tarPosPast

	return true
)
