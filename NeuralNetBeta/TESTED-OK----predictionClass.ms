struct predClass
(
	dstFPred = 0,
	dstSPred = 0,
	spdSPred = 0,
	aclSPred = 0,
	posFPred = [0,0,0],
	tltLPred = [0,0,0],

	fn updatePred name = ------------------- Calculates Predictions. This should be in the end.
	(
		dstS   = name.dstS
		spdS   = name.spdS
		aclS   = name.aclS
		tltL   = name.tltL
		souPos = name.souPos
		tarPos = name.tarPos

		dstSW = name.dstSW
		spdSW = name.spdSW
		aclSW = name.aclSW

		maxD = name.maxD
		maxS = name.maxS
		maxA = name.maxA

		name.dstSPred = mathClass.PredFn dstS spdS dstSW maxD maxS
		name.spdSPred = mathClass.PredFn spdS name.dstSPred spdSW  maxS maxD
		name.aclSPred = mathClass.PredFn aclS name.spdSPred aclSW  maxA maxS
		name.posFPred = mathClass.posPredFn tltL souPos name.dstSPred
		name.tltLPred = mathClass.tltPredFn souPos name.posFPred
		name.dstFPred = mathClass.dstFPredFn tarPos name.posFPred

		return true
	),
	fn importValues name valueClass= ------- Import Values from Value Class
	(
		-- Position Values --

			name.dstS   = valueClass.dstS
			name.spdS   = valueClass.spdS
			name.aclS   = valueClass.aclS
			name.tltL   = valueClass.tltL
			name.souPos = valueClass.souPos
			name.tarPos = valueClass.tarPos

		-- Weight Values --

			name.dstSW = valueClass.dstSW
			name.spdSW = valueClass.spdSW
			name.aclSW = valueClass.aclSW

		-- Constant Values --

			name.maxD = valueClass.maxD
			name.maxS = valueClass.maxS
			name.maxA = valueClass.maxA
			name.maxT = valueClass.maxT
		-- Wind Values
			name.wndF = valueClass.wndF
			name.maxW = valueClass.maxW
		
		return True
	),
	
	private
	maxW = 0,
	maxD = 0,
	maxS = 0,
	maxA = 0,
	maxT = [0,0,0],	

	wndF = 0,
	dstS   = 0,
	spdS   = 0,
	aclS   = 0,
	tltL   = [0,0,0],
	souPos = [0,0,0],
	tarPos = [0,0,0],
	
	dstSW = 0,
	spdSW = 0,
	aclSW = 0
)