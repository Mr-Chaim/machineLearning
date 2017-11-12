-- Weight handler


struct weightClass
(

	public

	wndFCurW = 0,
	dstSCurW = 0,
	spdSCurW = 0,
	aclSCurW = 0,
	tltLCurW = [0,0,0],

	fn init name=
	(
		name.wndFWarr = mathClass.arrayGenFn 20
		name.dstSWarr = mathClass.arrayGenFn 20
		name.spdSWarr = mathClass.arrayGenFn 20
		name.aclSWarr = mathClass.arrayGenFn 20
		
		for a=1 to 3 do
		(
			name.tltLW[a] = mathClass.arrayGenFn 20 --Should be 3 arrays with 20 different numbers each	
		)	

		return true
	),
	fn updateWeight name=
	(
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxacel

		name.dstSWarr = mathClass.weightUpdtFn name.dstSWarr name.dstS name.dstSPred name.dstSPast maxD
		name.spdSWarr = mathClass.weightUpdtFn name.spdSWarr name.spdS name.spdSPred name.spdSPast maxS
		name.aclSWarr = mathClass.weightUpdtFn name.aclSWarr name.aclS name.aclSPred name.aclSPast maxA

		return true
	),
	fn updateFinalWeights name=
	(
		maxW = const.maxWindForce
		maxT = const.maxTilt

		for a=1 to 3 do 
		(
			name.tltLWarr[a] = mathClass.tltWeightUpdateFn name.tltLWarr[a] name.tltL[a] name.tltF[a] name.tltLPred[a] name.tltLPast[a] maxT
		)
		
		name.wndFWarr = mathClass.wndWeightUpdateFn name.wndFWarr name.wndFPast name.dstS name.wndFPred name.dstSPred name.dstSPast maxW
		
		return true
	),
	fn catchCurrent name= 
	(
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxacel
		
		name.dstSCurW = mathClass.getWeightFn name.dstSWarr name.dstS maxD
		name.spdSCurW = mathClass.getWeightFn name.spdSWarr name.spdS maxS
		name.aclSCurW = mathClass.getWeightFn name.aclSWarr name.aclS maxA
		
		return true
	),
	fn catchFinalWeights name=
	(
		maxW = const.maxWindForce
		maxT = const.maxTilt

		for a=1 to 3 do 
		(
			name.tltLCurW[a] = mathClass.getWeightFn name.tltLWarr[a] name.tltL[a] maxT
		)
		
		name.wndFCurW = mathClass.getWeightFn name.wndFWarr name.wndFPred maxW

		return true
	),
	fn importVar name valueClass = 
	(
		name.wndFPred = valueClass.wndFPred
		name.wndFPast = valueClass.wndFPast

		name.dstS     = valueClass.dstS
		name.dstSPast = valueClass.dstSPast
		
		name.spdS     = valueClass.spdS
		name.spdSPast = valueClass.spdSPast
		
		name.aclS     = valueClass.aclS
		name.aclSPast = valueClass.aclSPast
		
		name.tltF     = valueClass.tltF
		name.tltFPast = valueClass.tltFPast
		
		name.tltL     = valueClass.tltL
		name.tltLPast = valueClass.tltLPast
		
		
		return true
	),
	fn importPred name valueClass =
	(
		name.wndFPred = valueClass.wndFPred
		name.dstSPred = valueClass.dstSPred
		name.spdSPred = valueClass.spdSPred
		name.aclSPred = valueClass.aclSPred
		name.tltLPred = valueClass.tltLPred

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

		for a=1 to 3 do
		(
			test.tltF[a]     = mathClass.randomGenFn -maxT maxT
			test.tltFPast[a] = mathClass.randomGenFn -maxT maxT
			test.tltFPred[a] = mathClass.randomGenFn -maxT maxT
		)

		return true
	),


	private
	
	const = constClass(),

	wndFWarr = 0,
	dstSWarr = 0,
	spdSWarr = 0,
	aclSWarr = 0,
	tltLWarr = #(0.0,0.0,0.0),

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
	tltL     = [0,0,0],
	tltLPast = [0,0,0],
	tltLPred = [0,0,0]

)




fn testWClsFn =

(
	mathClass()
	const = constClass()
	
	testWCls = weightClass()
	
	testWCls.init testWCls
	testWCls.testValues testWCls
	testWCls.updateWeight testWCls
	testWCls.catchCurrent testWCls
	
	print testWCls.dstSCurW
	print testWCls.spdSCurW
	print testWCls.aclSCurW
	print testWCls.tltFCurW

)