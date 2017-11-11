-- Weight handler


struct weightClass
(

	public
	wndFW = 0,
	dstSW = 0,
	spdSW = 0,
	aclSW = 0,
	tltFW = #(0.0,0.0,0.0),

	wndFCurW = 0,
	dstSCurW = 0,
	spdSCurW = 0,
	aclSCurW = 0,
	tltFCurW = [0,0,0],

	fn init name=
	(
		name.wndFW = mathClass.arrayGenFn 20
		name.dstSW = mathClass.arrayGenFn 20
		name.spdSW = mathClass.arrayGenFn 20
		name.aclSW = mathClass.arrayGenFn 20
		
		for a=1 to 3 do
		(
			name.tltFW[a] = mathClass.arrayGenFn 20 --Should be 3 arrays with 20 different numbers each	
		)	

		return true
	),
	fn updateWeight name=
	(
		maxW = const.maxWindForce
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxacel
		maxT = const.maxTilt

		name.wndFW = mathClass.wUpdtFn name.wndFW name.wndF name.wndFPred name.wndFPast maxW
		name.dstSW = mathClass.wUpdtFn name.dstSW name.dstS name.dstSPred name.dstSPast maxD
		name.spdSW = mathClass.wUpdtFn name.spdSW name.spdS name.spdSPred name.spdSPast maxS
		name.aclSW = mathClass.wUpdtFn name.aclSW name.aclS name.aclSPred name.aclSPast maxA
		
		for a=1 to 3 do 
		(
			name.tltFW[a] = mathClass.wUpdtFn name.tltFW[a] name.tltF[a] name.tltFPred[a] name.tltFPast[a] maxT
		)
		return true
	),
	fn catchCurrent name= 
	(
		maxW = const.maxWindForce
		maxD = const.maxDistance
		maxS = const.maxSpeed
		maxA = const.maxacel
		maxT = const.maxTilt

		name.wndFCurW = mathClass.getWeightFn name.wndFW name.wndF maxW
		name.dstSCurW = mathClass.getWeightFn name.dstSW name.dstS maxD
		name.spdSCurW = mathClass.getWeightFn name.spdSW name.spdS maxS
		name.aclSCurW = mathClass.getWeightFn name.aclSW name.aclS maxA
		
		for a=1 to 3 do 
		(
			name.tltFCurW[a] = mathClass.getWeightFn name.tltFW[a] name.tltF[a] maxT
		)
		return true
	),
	fn importVar name valueClass = 
	(
		name.wndF     = valueClass.wndF
		name.wndFPast = valueClass.wndFPast

		name.dstS     = valueClass.dstS
		name.dstSPast = valueClass.dstSPast
		
		name.spdS     = valueClass.spdS
		name.spdSPast = valueClass.spdSPast
		
		name.aclS     = valueClass.aclS
		name.aclSPast = valueClass.aclSPast
		
		name.tltF     = valueClass.tltF
		name.tltFPast = valueClass.tltFPast
		
		
		return true
	),
	fn importPred name valueClass =
	(
		name.wndFPred = valueClass.wndFPred
		name.dstSPred = valueClass.dstSPred
		name.spdSPred = valueClass.spdSPred
		name.aclSPred = valueClass.aclSPred
		name.tltFPred = valueClass.tltFPred

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
	tltFPred = [0,0,0]

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