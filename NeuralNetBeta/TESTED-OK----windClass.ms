struct windClass
(
	public

	wndF      = 0,
	wndFPast  = 0,
	wndFinalF = 0,
	wndFtlt   = [0,0,0],
	wndFinalA = [0,0,0],

	fn updateValue name =
	(
		maxW = const.maxWindForce
		maxT = const.maxTilt
		
		tltF  = name.tltF
		tltfW = name.tltfW

		wndFPred = name.wndFPred
		wndFW    = name.wndFW
		
		name.wndFinalA = mathClass.wndFinlTltFn tltF tltfW maxT
		name.wndFinalF = mathClass.wndFinlFn wndFPred wndFW maxW

		return true
	),
	fn updatePast name = 
	(
		name.wndFPast = name.wndF

		return true
	),
	fn importValues name valueClass =
	(
		name.tltF     = valueClass.tltF
		name.tltfW    = valueClass.tltfW
		
		name.wndFW    = valueClass.wndFW
		name.wndFPred = valueClass.wndPred

		return true
	),

	private

	wndFWPred = 0,
	tltF  = [0,0,0],
	tltfW = [0,0,0],
	const = constClass()

)


fn testWindClassFn = 
(
	const = constClass()
	mathClass = mathClass()
	windClassTest = windClass()

	return true
)
--testWindClassFn()