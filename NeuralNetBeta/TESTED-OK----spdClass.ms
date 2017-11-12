struct spdClass
(
	spdS     = 0,
	spdSPast = 0,
	fn updateSpd name = 
	(
		name.spdS = mathClass.spdFn name.dstSPast name.dstS
		
		return true
	),
	fn updatePast name= 
	(
		name.spdSPast = name.spdS
		
		return true
	),
	fn importValues name valueClass = 
	(
		dstS     = valueClass.dstS
		dstSPast = valueClass.dstSPast
	),
	fn testValue test=
	(
		maxD   = const.maxDistance
		ranGen = mathClass.randomGenFn

		test.deltaPast = [(ranGen -maxD maxD),(ranGen -maxD maxD),(ranGen -maxD maxD)]
		test.delta     = [(ranGen -maxD maxD),(ranGen -maxD maxD),(ranGen -maxD maxD)]

		return true
	),
	private
	const = constClass(),
	dstS = 0,
	dstSPast = 0
)

fn testSpdClassFn =
(
	testspd = spdClass()

	testspd.testValue testspd
	testspd.updateSpd testspd testspd
	testspd.updatePast testspd

	print testspd.spdPast

	testspd.testValue testspd
	testspd.updateSpd testspd testspd

	print testspd.spdNow

	

	return true
)