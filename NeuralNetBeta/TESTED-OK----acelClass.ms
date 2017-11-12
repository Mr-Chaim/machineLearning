struct acelClass
(
	aclS     = 0,
	aclSPast = 0,
	fn updateAcel name speedClass =
	(
		name.acelSingle = mathClass.acelFn name.spdSPast name.spdS
		
		return true
	),
	fn updatePast name = 
	(
		name.aclSPast = name.aclS
		
		return true
	),
	fn importValues name valueClass =
	(
		name.spdS = valueClass.spdS
		name.spdSPast = valueClasss.spdSPast

		return true
	),
	fn testValue test =
	(
		maxS   = const.maxSpeed
		ranGen = mathClass.randomGenFn

		test.spdS  = [(ranGen -maxS maxS),(ranGen -maxS maxS),(ranGen -maxS maxS)]
		test.spdSPast = [(ranGen -maxS maxS),(ranGen -maxS maxS),(ranGen -maxS maxS)]
		
		return true
	),
	private
	const    = constClass(),
	spdS     = 0,
	spdSPast = 0
)


fn testacelClassFn =
(
	testacel = acelClass()

	testacel.testValue testacel
	testacel.updateAcel testacel testacel
	testacel.updatePast testacel

	print testacel.acelPast

	testacel.testValue testacel
	testacel.updateAcel testacel testacel

	print testacel.acel

	

	return true
)