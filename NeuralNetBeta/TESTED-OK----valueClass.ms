struct valueClass
(
	public

	deltaPredVal = [0,0,0],
	deltaPastVal = [0,0,0],
	deltaActVal = [0,0,0],

	speedPredVal = [0,0,0],
	speedPastVal = [0,0,0],
	speedActVal = [0,0,0],

	AcelPredVal = [0,0,0],
	AcelPastVal = [0,0,0],
	AcelActVal = [0,0,0],

	tiltPredVal = [0,0,0],
	tiltPastVal = [0,0,0],
	tiltActVal = [0,0,0],


	wForce = undefined,

	fn importVar name posClass spdClass acelClass predClass= 
	(

		name.deltaPredVal = predClass.deltaPred
		name.deltaPastVal = posClass.deltaPast
		name.deltaActVal = posClass.delta

		name.speedPredVal = predClass.speedPred
		name.speedPastVal = spdClass.spdPast
		name.speedActVal = spdClass.spdNow

		name.AcelPredVal = predClass.acelPred
		name.AcelPastVal = acelClass.acelPast
		name.AcelActVal = acelClass.acel

		name.tiltPredVal = predClass.tiltPred
		name.tiltPastVal = posClass.tiltPast
		name.tiltActVal = posClass.tilt
		return true
	),

	fn testValues test= 
	(
		for a=1 to 3 do
		(
			test.deltaPred[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance
			test.deltaPast[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance
			test.delta[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance
			
			test.speedPred[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed
			test.spdPast[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed
			test.spdNow[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed
			
			test.acelPred[a] = mathClass.randomGenFn -const.maxAcel const.maxAcel
			test.acelPast[a] = mathClass.randomGenFn -const.maxAcel const.maxAcel
			test.acel[a] = mathClass.randomGenFn -const.maxAcel const.maxAcel
			
			test.tiltPred[a] = mathClass.randomGenFn -const.maxTilt const.maxTilt
			test.tiltPast[a] = mathClass.randomGenFn -const.maxTilt const.maxTilt
			test.tilt[a] = mathClass.randomGenFn -const.maxTilt const.maxTilt
		)

		return true
	),

	private
	
	const = constClass(),
	

	deltaPred = [0,0,0],
	deltaPast = [0,0,0],
	delta = [0,0,0],
	speedPred = [0,0,0],
	spdPast = [0,0,0],
	spdNow = [0,0,0],
	acelPred = [0,0,0],
	acelPast = [0,0,0],
	acel = [0,0,0],
	tiltPred = [0,0,0],
	tiltPast = [0,0,0],
	tilt = [0,0,0]
)


fn valueClassTestFn =
(
	const = constClass()
	mathClass = mathClass()
	valueClassTest = valueClass()
	valueClassTest.testValues valueClassTest
	valueClassTest.importVar valueClassTest valueClassTest valueClassTest valueClassTest valueClassTest

	print valueClassTest.deltaPredVal
	print valueClassTest.deltaPastVal
	print valueClassTest.deltaActVal
	print valueClassTest.speedPredVal
	print valueClassTest.speedPastVal
	print valueClassTest.speedActVal
	print valueClassTest.AcelPredVal
	print valueClassTest.AcelPastVal
	print valueClassTest.AcelActVal
	print valueClassTest.tiltPredVal
	print valueClassTest.tiltPastVal
	print valueClassTest.tiltActVal

	return true
)
