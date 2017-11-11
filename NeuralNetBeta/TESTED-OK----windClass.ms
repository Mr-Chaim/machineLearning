struct windClass
(
	public

	wndF     = 0,
	wndFPast = 0,

	fn updateValue name valueClass=
	(
		name.wndF = valueClass.wndFPred

		return true
	),
	fn updatePast name = 
	(
		name.wndFPast = name.wndF

		return true
	),

	private
	
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