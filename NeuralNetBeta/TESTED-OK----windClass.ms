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

	wndF = 0,
	wndFPast = wndF,

	tiltFinal = [0,0,0],

	fn updateValue name valueClass=
	(
		name.wndF = valueClass.wndF

	),
	fn updatePast name = 
	(
		name.wndFPast = name.windF
	),



	fn importValues name vClass wClass =
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
		return true
	),

	fn calculate name= 
	(
		deltaCalculate = [0,0,0]
		speedCalculate = [0,0,0]
		acelCalculate  = [0,0,0]
		tiltCalculate  = [0,0,0]
		sumation = 0
		windCalculate  = 0
		--print name.tiltAbs
		for a=1 to 3 do
		(
			deltaCalculate[a] = mathClass.limitFn (name.deltaAbs[a] * name.deltaCurW[a]) 1 -1
			speedCalculate[a] = mathClass.limitFn (name.speedAbs[a] * name.speedCurW[a]) 1 -1
			acelCalculate[a]  = mathClass.limitFn (name.AcelAbs[a] * name.acelCurW[a]) 1 -1
			
			sumation          = (deltaCalculate[a] + speedCalculate[a] + acelCalculate[a])
			
			tiltCalculate[a]  = ((name.tiltAbs[a]))
			windCalculate    += (sumation/3)
		)

		name.windforce    = mathClass.limitFn ((windCalculate/3) * const.maxWindForce) const.maxWindForce 0 
		name.tiltFinal[1] = tiltCalculate[1]
		name.tiltFinal[2] = tiltCalculate[2]
		name.tiltFinal[3] = tiltCalculate[3]
		--format " TiltDiferences:1-%,2-%,3-% \n" (name.tiltFinal[1] - name.tiltAbs[1]) (name.tiltFinal[2] - name.tiltAbs[2]) (name.tiltFinal[3] - name.tiltAbs[3])
		return true
	),

	fn testValues name= 
	(
		for a=1 to 3 do
		(
			name.deltaActVal[a] = mathClass.randomGenFn -const.maxDistance const.maxDistance
			name.speedActVal[a] = mathClass.randomGenFn -const.maxSpeed const.maxSpeed
			name.AcelActVal[a]  = mathClass.randomGenFn -const.maxAcel const.maxAcel
			name.tiltActVal[a]  = mathClass.randomGenFn -const.maxTilt const.maxTilt

			name.deltaCurW[a]   = mathClass.randomGenFn -1.0 1.0
			name.speedCurW[a]   = mathClass.randomGenFn -1.0 1.0
			name.acelCurW[a]    = mathClass.randomGenFn -1.0 1.0
			name.tiltCurW[a]    = mathClass.randomGenFn -1.0 1.0
		)
		return true
	),


	private
	
	const = constClass(),
	

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
	windClassTest.importValues windClassTest windClassTest windClassTest
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
--testWindClassFn()