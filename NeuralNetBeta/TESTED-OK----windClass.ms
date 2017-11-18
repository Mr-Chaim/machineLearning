struct windClass
(
	public

	wndFEst = 0,
	wndF    = 0,
	wndT    = [0,0,0],

	fn updateValues name =
	(
		name.wndT = mathClass.wndFinlTltFn name.tltL name.tltf name.tltLW name.maxT
		name.wndF = mathClass.wndFinlFn name.dstF name.dstS name.spdS name.aclS name.tltL name.tltF name.wndP name.wndFw name.dstSW name.spdSW name.aclSW name.maxAbs name.maxW name.maxD name.maxS name.maxA name.maxT
		
		return true
	),
	fn displacement name =
	(
		name.wndFEst = mathClass.wndFinlFn name.dstF name.dstS name.spdS name.aclS name.tltL name.tltF name.wndP 0 0 0 0 name.maxAbs name.maxW name.maxD name.maxS name.maxA name.maxT
		--name.wndFEst = mathClass.windEstimateFn name.dstF name.dstS name.spdS name.aclS name.maxW name.maxD name.maxS name.maxA
		name.wndF = 0
		name.wndT = 0
		
		return True
	),
	fn importValues name valueClass =
	(
		name.dstS = valueClass.dstS
		name.spdS = valueClass.spdS
		name.aclS = valueClass.aclS
		name.dstF = valueClass.dstF
		name.tltL = valueClass.tltL 
		name.tltF = valueClass.tltF
		name.wndP = valueClass.wndFPast

		-- Constant Values --
		name.maxAbs = valueClass.maxAbs
		name.maxD = valueClass.maxD
		name.maxS = valueClass.maxS
		name.maxA = valueClass.maxA
		name.maxW = valueClass.maxW
		name.maxT = valueClass.maxT

		return true
	),
	fn importWeights name valueClass =
	(
		name.wndFw = valueClass.wndFw
		name.dstSW = valueClass.dstSW
		name.spdSW = valueClass.spdSW
		name.aclSW = valueClass.aclSW
		name.tltLW = valueClass.tltLW

		return true
	),

	private

			-- Constant Values --
	maxAbs = 0,
	maxD = 0,
	maxS = 0,
	maxA = 0,
	maxW = 0,
	maxT = 0,

	dstS = 0,
	dstF = 0,
	spdS = 0,
	aclS = 0,
	tltL = [0,0,0],
	tltF = [0,0,0],
	wndP = 0,

	wndFW = 0,
	dstSW = 0,
	spdSW = 0,
	aclSW = 0,
	tltLW = [0,0,0],

	const    = constClass()
)