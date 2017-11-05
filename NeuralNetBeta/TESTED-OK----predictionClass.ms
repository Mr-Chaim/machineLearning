struct predClass
(

	deltaPred = [0,0,0],
	speedPred = [0,0,0],
	acelPred  = [0,0,0],
	tiltPred = [0,0,0],

	fn updateValues name posClass speedClass acelClass =
	(

		for a=1 to 3 do 
		(
			name.deltaPred[a] = (compClass.distPredFn posClass.delta[a]  speedClass.spdNow[a] const.maxDistance) as float
			name.speedPred[a] = (compClass.speedPredFn acelClass.acel[a]  speedClass.spdNow[a] const.maxSpeed) as float
			name.acelPred[a] = (compClass.acelPredFn acelClass.acel[a] posClass.windNow  const.maxWindForce const.maxAcel) as float
		)
		name.tiltPred[1] = (compClass.tiltPredFn name.deltaPred[1]  name.deltaPred[3] ) as float
		name.tiltPred[2] = (compClass.tiltPredFn name.deltaPred[2]  name.deltaPred[3] ) as float
		name.tiltPred[3] = (compClass.tiltPredFn name.deltaPred[2]  name.deltaPred[1] ) as float

		return true
	),

	fn testValues test= 
	(
		for a=1 to 3 do
		(

			test.deltaPast[a] = (compClass.randomGenFn -const.maxDistance const.maxDistance) as float
			test.delta[a] = (compClass.randomGenFn -const.maxDistance const.maxDistance) as float
			test.spdPast[a] = (compClass.randomGenFn -const.maxSpeed const.maxSpeed) as float
			test.spdNow[a] = (compClass.randomGenFn -const.maxSpeed const.maxSpeed) as float
			test.acelPast[a] = (compClass.randomGenFn -const.maxAcel const.maxAcel) as float
			test.acel[a] = (compClass.randomGenFn -const.maxAcel const.maxAcel) as float
			test.tiltPast[a] = (compClass.randomGenFn -const.maxTilt const.maxTilt) as float
			test.tilt[a] = (compClass.randomGenFn -const.maxTilt const.maxTilt) as float

		)
		test.windNow = (compClass.randomGenFn 0.0 const.maxWindForce) as float
		
		return true
	),

	private

	deltaPast = [0,0,0],
	delta = [0,0,0],
	spdPast = [0,0,0],
	spdNow = [0,0,0],
	acelPast = [0,0,0],
	acel = [0,0,0],
	tiltPast = [0,0,0],
	tilt = [0,0,0],
	windNow = 0.0
	--windDispX = windDispFn deltaDirAbs currentSpdAbs windAbs n acelAbs
)
fn testPredClass =
(
	const = constClass()
	compClass = compFnClass()
	predClassTest = predClass()
	predClassTest.testValues predClassTest
	predClassTest.updateValues predClassTest predClassTest predClassTest predClassTest

	print predClasstest.deltaPred
	print predClasstest.speedPred
	print predClasstest.acelPred
	print predClasstest.tiltPred
	return true
)
