const = constClass()
mathClass = mathClass()

struct windClass
(
	public

	deltaAbs = [0,0,0],
	speedAbs = [0,0,0],
	AcelAbs  = [0,0,0],
	tiltAbs  = [0,0,0],

	deltaW = [0,0,0],
	speedW = [0,0,0],
	acelW  = [0,0,0],
	tiltW  = [0,0,0],

	windforce = 0,

	tiltFinal = [0,0,0],


	fn updateValues name vClass wClass =
	(

		name.deltaActVal = vClass.deltaActVal
		name.speedActVal = vClass.speedActVal
		name.AcelActVal  = vClass.AcelActVal
		name.tiltActVal  = vClass.tiltActVal
		name.deltaCurW   = wClass.deltaCurW
		name.speedCurW   = wClass.speedCurW
		name.acelCurW    = wClass.acelCurW
		name.tiltCurW    = wClass.tiltCurW

		return true

	),

	fn updateAbsolute name =
	(

		for a = 1 to 3 do
		(

			name.deltaAbs[a] = mathClass.absFn name.deltaActVal[a] const.maxDistance
			name.speedAbs[a] = mathClass.absFn name.speedActVal[a] const.maxSpeed
			name.AcelAbs[a]  = mathClass.absFn name.AcelActVal[a] const.maxAcel
			name.tiltAbs[a]  = mathClass.absFn name.tiltActVal[a] const.maxTilt

		)
		name.deltaW = name.deltaCurW
		name.speedW = name.speedCurW
		name.acelW  = name.acelCurW
		name.tiltW  = name.tiltCurW
		return true
	),

	fn calculate name= 
	(
		
		limitFn = mathClass.limitFn

		deltaCalculate = name.deltaCalculate
		speedCalculate = name.speedCalculate
		acelCalculate  = name.acelCalculate
		tiltCalculate  = name.tiltCalculate
		windCalculate  = name.windCalculate



		for a=1 to 3 do
		(

			deltaCalculate[a] = limitFn (name.deltaAbs[a] * name.deltaW[a]) 1 -1
			speedCalculate[a] = limitFn (name.speedAbs[a] * name.speedW[a]) 1 -1
			acelCalculate[a]  = limitFn (name.AcelAbs[a] * name.acelW[a]) 1 -1
			tiltCalculate[a]  = ((name.tiltAbs[a] + (name.tiltW[a]*(deltaCalculate[a] + speedCalculate[a] + acelCalculate[a])/3) )* name.maxTilt )
			windCalculate    += (deltaCalculate[a] + speedCalculate[a] + acelCalculate[a])/3
		)

		name.windforce = limitFn ((windCalculate/3) * const.maxWindForce) const.maxWindForce 0 
		name.tiltFinal = tiltCalculate

		return true
	),

	fn testValues name= 
	(

		ranGen = mathClass.randomGenFn
		for a=1 to 3 do
		(
			name.deltaActVal[a] = ranGen -const.maxDistance const.maxDistance
			name.speedActVal[a] = ranGen -const.maxSpeed const.maxSpeed
			name.AcelActVal[a]  = ranGen -const.maxAcel const.maxAcel
			name.tiltActVal[a]  = ranGen -const.maxTilt const.maxTilt
			name.deltaCurW[a]   = ranGen -1.0 1.0
			name.speedCurW[a]   = ranGen -1.0 1.0
			name.acelCurW[a]    = ranGen -1.0 1.0
			name.tiltCurW[a]    = ranGen -1.0 1.0
		)
		return true
	),


	private 

	maxWindForce = const.maxWindForce,
	maxDistance  = const.maxDistance,
	maxSpeed     = const.maxSpeed,
	maxAcel      = const.maxAcel,
	maxTilt      = const.maxTilt,
	randomGenFn  = mathClass.randomGenFn,
	limitFn      = mathClass.limitFn,
	absFn        = mathClass.absFn,


	deltaActVal = [0,0,0],
	speedActVal = [0,0,0],
	AcelActVal  = [0,0,0],
	tiltActVal  = [0,0,0],
	deltaCurW   = [0,0,0],
	speedCurW   = [0,0,0],
	acelCurW    = [0,0,0],
	tiltCurW    = [0,0,0],

	deltaCalculate = [0,0,0],
	speedCalculate = [0,0,0],
	acelCalculate  = [0,0,0],
	tiltCalculate  = [0,0,0],
	windCalculate  = 0


)


fn testWindClassFn = 
(
	const = constClass()
	mathClass = mathClass()
	windClassTest = windClass()

	windClassTest.testValues windClassTest
	windClassTest.updateValues windClassTest windClassTest windClassTest
	windClassTest.updateAbsolute windClassTest
	windClassTest.calculate windClassTest
	format "\n"
	format "Result for deltaAbs : % \n"  windClassTest.deltaAbs
	format "Result for speedAbs : % \n"  windClassTest.speedAbs
	format "Result for AcelAbs : % \n"   windClassTest.AcelAbs
	format "Result for tiltAbs : % \n"   windClassTest.tiltAbs
	format "Result for deltaW : % \n"    windClassTest.deltaW
	format "Result for speedW : % \n"    windClassTest.speedW
	format "Result for acelW : % \n"     windClassTest.acelW
	format "Result for tiltW : % \n"     windClassTest.tiltW
	format "Result windforce: % \n"      windClassTest.windforce
	format "Result tiltFinal: % \n"      windClassTest.tiltFinal

	return true
)
testWindClassFn()