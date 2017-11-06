struct spdClass
(
	spdNow = [0,0,0],

	-- Past atributes

	spdPast = [0,0,0],

	fn updateSpd name posClass = 
	(
		for a=1 to 3 do 
		(
			name.spdNow[a] = mathClass.spdNowFn posClass.deltaPast[a] posClass.delta[a]
		)
		return true
	),

	fn updatePast name= 
	(
		name.spdPast = name.spdNow

		return true
	),

	fn testValue test=
	(

		dist = const.maxDistance
		ranGen = mathClass.randomGenFn

		test.deltaPast = [(ranGen -dist dist),(ranGen -dist dist),(ranGen -dist dist)]
		test.delta = [(ranGen -dist dist),(ranGen -dist dist),(ranGen -dist dist)]

		return true
	),

	private
	
	const = constClass(),
	

	deltaPast = [0,0,0],
	delta = [0,0,0]
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