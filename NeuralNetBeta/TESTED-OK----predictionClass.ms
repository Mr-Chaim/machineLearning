struct predClass
(

	dstSPred = 0,
	spdSPred = 0,
	aclSPred = 0,
	posFPred = [0,0,0],
	tltFPred = [0,0,0],
	wndFPred = 0,

	fn updateValues name =
	(
		maxW = const.maxWindForce
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxAcel

		wndF  = name.wndF 
		dstS  = name.dstS 
		spdS  = name.spdS 
		aclS  = name.aclS 

		wndFW = name.wndFW 
		dstSW = name.dstSW 
		spdSW = name.spdSW 
		aclSW = name.aclSW
		
		tltFlc = name.tltFLc 
		souPos = name.souPos
		
		name.wndFPred = mathClass.wndPredFn wndF dstS spdS aclS wndFW dstSW spdSW aclSW maxW maxD maxS maxA
		name.dstSPred = mathClass.dstPredFn spdS aclS spdSW aclSW maxD maxS maxA
		name.spdSPred = mathClass.spdPredFn spdS aclS spdSW aclSW maxS maxA
		name.aclSPred = mathClass.aclPredFn wndF aclS wndFW aclSW maxW maxA

		name.posFPred = mathClass.posPredFn name.dstSPred tltFLc souPos
		name.tltFPred = mathClass.tltPredFn souPos name.posFPred
		
		return true
	),
	fn importValues name valueClass= 
	(
		name.wndF = valueClass.wndF
		name.dstS = valueClass.dstS
		name.spdS = valueClass.spdS
		name.aclS = valueClass.aclS
		name.tltF = valueClass.tltF

		name.tltFLc = valueClass.tltFLc
		name.tarPos = valueClass.tarPos
		name.souPos = valueClass.souPos
		
		return True
	),
	fn importWeights name weightClass =
	(
		name.wndFW = weightClass.wndFCurW
		name.dstSW = weightClass.dstSCurW
		name.spdSW = weightClass.spdSCurW
		name.aclSW = weightClass.aclSCurW
		name.tltFW = weightClass.tltFCurW
		
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
		test.wndF = (rGen 0.0 maxW) as float

		for a=1 to 3 do
		(
			test.tltF[a]   = rGen -maxT maxT
			test.tarPos[a] = rGen -maxD maxD
			test.souPos[a] = rGen -maxD maxD
		)

		return true
	
	),

	private
	
	wndF   = 0,
	dstS   = 0,
	spdS   = 0,
	aclS   = 0,
	tltF   = [0,0,0],
	tltFLc = [0,0,0],
	tarPos = [0,0,0],
	souPos = [0,0,0],
	
	wndFW = 0,
	dstSW = 0,
	spdSW = 0,
	aclSW = 0,
	tltFW = [0,0,0]

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
