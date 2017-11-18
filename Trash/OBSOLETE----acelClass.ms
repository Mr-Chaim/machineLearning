struct acelClass
(
	aclS     = 0,
	aclSPast = 0,

	fn updateAcel name speedClass =
	(
		name.acelSingle = mathClass.acelFn name.spdSPast name.spdS
		
		return true
	),
	fn importValues name valueClass =
	(
		name.spdS = valueClass.spdS
		name.spdSPast = valueClasss.spdSPast

		return true
	),
	private
	const    = constClass(),
	spdS     = 0,
	spdSPast = 0
)