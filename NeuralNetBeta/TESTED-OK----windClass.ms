struct windClass
(
	public

	wndFinalF = 0,
	wndFinalT = [0,0,0],
	
	wndFPast = 0,
	wndPPred = 0,
	wndTpast = [0,0,0],

	fn updateValue name =
	(
		maxW = const.maxWindForce
		maxT = const.maxTilt
		
		tltL = name.tltL
		tltLW = name.tltLW

		wndCPred = name.wndCPred
		wndFW = name.wndFW
		
		name.wndFinalF = mathClass.wndFinlFn wndCPred wndFW maxW
		name.wndFinalT = mathClass.wndFinlTltFn tltL tltLW maxT

		return true
	),
	fn updatePast name = 
	(
		name.wndPPred = name.wndCPred
		name.wndFPast = name.wndFinalF
		name.wndTpast = name.wndFinalT

		return true
	),
	fn importValues name valueClass =
	(
		name.tltL    = valueClass.tltL
		name.tltLW   = valueClass.tltLW
		
		name.wndFW    = valueClass.wndFW
		name.wndCPred = valueClass.wndCPred

		return true
	),

	private

	wndCPred = 0,
	tltL     = [0,0,0],
	tltLW    = [0,0,0],
	const    = constClass()
)


fn testWindClassFn = 
(
	const = constClass()
	mathClass = mathClass()
	windClassTest = windClass()

	return true
)
--testWindClassFn()