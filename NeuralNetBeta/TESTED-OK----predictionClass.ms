struct predClass
(

	wndFPred = 0,
	dstSPred = 0,
	spdSPred = 0,
	aclSPred = 0,
	posFPred = [0,0,0],
	tltLPred = [0,0,0],

	fn updateValues name =
	(
		maxW = const.maxWindForce
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxAcel

		dstS = name.dstS 
		spdS = name.spdS 
		aclS = name.aclS 

		wndFW = name.wndFW 
		dstSW = name.dstSW 
		spdSW = name.spdSW 
		aclSW = name.aclSW
		
		tltL   = name.tltL 
		souPos = name.souPos
		
		wndFPast = name.wndFPast 
		
		
		name.dstSPred = mathClass.dstPredFn spdS aclS spdSW aclSW maxD maxS maxA
		name.spdSPred = mathClass.spdPredFn spdS aclS spdSW aclSW maxS maxA
		name.aclSPred = mathClass.aclPredFn wndFPast aclS wndFW aclSW maxW maxA


		return true
	),
	fn updateFinalPred name =
	(
		name.wndFPred = mathClass.wndPredFn dstS spdS aclS dstSW spdSW aclSW maxW maxD maxS maxA
		name.posFPred = mathClass.posPredFn name.dstSPred tltL souPos
		name.tltLPred = mathClass.tltPredFn souPos name.posFPred
		
	),
	fn importValues name valueClass= 
	(
		name.wndFPast = valueClass.wndFPast
		name.dstS     = valueClass.dstS
		name.spdS     = valueClass.spdS
		name.aclS     = valueClass.aclS
		name.tltF     = valueClass.tltF

		name.tltFL = valueClass.tltFL
		name.tarPos = valueClass.tarPos
		name.souPos = valueClass.souPos
		
		return True
	),
	fn importWeights name valueClass =
	(
		name.wndFW = valueClass.wndFCurW
		name.dstSW = valueClass.dstSCurW
		name.spdSW = valueClass.spdSCurW
		name.aclSW = valueClass.aclSCurW
		name.tltLW = valueClass.tltLCurW
		
		return true
	),
	fn testValues test= 
	(

		rGen = mathClass.randomGenFn
		maxS = const.maxSpeed
		maxW = const.maxWindForce
		maxA = const.maxAcel
		maxD = const.maxDistance
		maxT = const.maxTilt

		test.dstS = (rGen -maxD maxD) as float
		test.spdS = (rGen -maxS maxS) as float
		test.aclS = (rGen -maxA maxA) as float
		test.wndFPast = (rGen 0.0 maxW) as float

		for a=1 to 3 do
		(
			test.tltF[a]   = rGen -maxT maxT
			test.tarPos[a] = rGen -maxD maxD
			test.souPos[a] = rGen -maxD maxD
		)

		return true
	
	),

	private
	
	dstS   = 0,
	spdS   = 0,
	aclS   = 0,
	tltF   = [0,0,0],
	tltL   = [0,0,0],
	tarPos = [0,0,0],
	souPos = [0,0,0],
	wndFPast = 0,
	
	wndFW = 0,
	dstSW = 0,
	spdSW = 0,
	aclSW = 0,
	tltLW = [0,0,0]

)


--test


fn testPredClass =
(
	math = mathClass()
	const = constClass()
	predClsTst = predClass()

	predClsTst.testValues predClsTst
	predClsTst.importValues predClsTst predClsTst predClsTst predClsTst
	predClsTst.updateValues predClsTst
	
	print predClsTst.dstSPred
	print predClsTst.tltFPred
	print predClsTst.spdSPred
	print predClsTst.aclSPred

	return true
)
--testPredClass()
