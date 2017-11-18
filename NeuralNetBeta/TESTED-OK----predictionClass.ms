struct predClass
(

	dstSPred = 0,
	spdSPred = 0,
	aclSPred = 0,
	posFPred = [0,0,0],
	tltLPred = [0,0,0],

	fn updatePred name = ---This should be in the end.
	(	
		name.dstSPred = mathClass.PredFn name.dstS name.spdS name.dstSW name.maxD name.maxS
		name.posFPred = mathClass.posPredFn name.tltL name.souPos name.dstSPred
		name.tltLPred = mathClass.tltPredFn name.souPos name.posFPred
		name.spdSPred = mathClass.PredFn name.spdS name.aclS name.spdSW name.maxS name.maxA
		name.aclSPred = mathClass.PredFn name.aclS name.wndF name.aclSW  name.maxA name.maxW

		return true
	),
	fn importValues name valueClass= 
	(
		name.wndF = valueClass.wndF
		name.spdS = valueClass.spdS
		name.aclS = valueClass.aclS
		name.tltF = valueClass.tltF

		name.tltL   = valueClass.tltL
		name.tarPos = valueClass.tarPos
		name.souPos = valueClass.souPos
		
		name.dstSW = valueClass.dstSW
		name.spdSW = valueClass.spdSW
		name.aclSW = valueClass.aclSW

		-- Constant Values --

		name.maxD = valueClass.maxD
		name.maxS = valueClass.maxS
		name.maxA = valueClass.maxA
		name.maxW = valueClass.maxW
		name.maxT = valueClass.maxT

		
		return True
	),
	
	private
	
	maxD = 0,
	maxS = 0,
	maxA = 0,
	maxW = 0,
	maxT = [0,0,0],	

	wndFEst = 0,
	wndF    = 0,
	dstS    = 0,
	spdS    = 0,
	aclS    = 0,
	tltF    = [0,0,0],
	tltL    = [0,0,0],
	tarPos  = [0,0,0],
	souPos  = [0,0,0],
	
	dstSW = 0,
	spdSW = 0,
	aclSW = 0
)