--Final Calculation function


/* fn windacelAbsFunc currentValues maxWindSpd currentWeightsArr currentNames windDisp n windDifArr= 
(
	summation = 0
	divi = 0
 	for a = 1 to currentWeightsArr.count do
 	(
 		cVA = limiterFunc currentValues[a] 1 -1
 		cWA = limiterFunc currentWeightsArr[a] 1 -1
 		--print ("Step 4.1.1."+(a as string)+" - " + currentNames[a] +" Value : "  + (twoDecimalScaleFunc cVA as string))
 		--print ("Step 4.1.2."+(a as string)+" - " + currentNames[a] +" Weight : "  + (twoDecimalScaleFunc cWA as string))
 		pResult = (cVA*cWA)
 		--print ("Step 4.1.3."+(a as string)+" - pResult : "  + (twoDecimalScaleFunc pResult as string))
 		summation += pResult
 		divi += cWa
 	)
 	--print ("Step 4.2 - summation : "  + (twoDecimalScaleFunc summation as string))
 	division = summation/divi
 	--print ("Step 4.3 - division : "  + (twoDecimalScaleFunc division as string))
 	--print ((n as string) + " " +(twoDecimalScaleFunc (windDisp + windDifArr[n]) as string))
	multiplication = (maxWindSpd * summation) + ((windDisp + windDifArr[n] ))
	--print ("Step 4.4.1 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	multiplication = limiterFunc multiplication maxWindSpd -maxWindSpd
	--print ("Step 4.5.2 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	return multiplication
	
) --Final calculation to find the ideal wind speed for each axis.
 */

const = constClass()
compClass = compFnClass()

struct windClass
(
	public

	deltaAbs = [0,0,0],
	speedAbs = [0,0,0],
	AcelAbs = [0,0,0],
	tiltAbs = [0,0,0],

	deltaW = [0,0,0],
	speedW = [0,0,0],
	acelW = [0,0,0],
	tiltW = [0,0,0],

	windforce = 0,

	tiltFinal = [0,0,0],


	fn updateValues name vClass wClass =
	(
		name.deltaActVal = vClass.deltaActVal
		name.speedActVal = vClass.speedActVal
		name.AcelActVal = vClass.AcelActVal
		name.tiltActVal = vClass.tiltActVal
		name.deltaCurW = wClass.deltaCurW
		name.speedCurW = wClass.speedCurW
		name.acelCurW = wClass.acelCurW
		name.tiltCurW = wClass.tiltCurW
		return true
	),

	fn updateAbsolute name =
	(
		for a = 1 to 3 do
		(
			name.deltaAbs[a] = compClass.absFn name.deltaActVal[a] name.maxDistance
			name.speedAbs[a] = compClass.absFn name.speedActVal[a] name.maxSpeed
			name.AcelAbs[a] = compClass.absFn name.AcelActVal[a] name.maxAcel
			name.tiltAbs[a] = compClass.absFn name.tiltActVal[a] name.maxTilt
		)
		name.deltaW = name.deltaCurW
		name.speedW = name.speedCurW
		name.acelW = name.acelCurW
		name.tiltW = name.tiltCurW

		return true
	),

	fn calculate name= 
	(
		foo5 = 0
		foo4 = [0,0,0]
		for a=1 to 3 do
		(
			foo1 = compClass.limitFn (name.deltaAbs[a] * name.deltaW[a]) 1 -1
			
			foo2 = compClass.limitFn (name.speedAbs[a] * name.speedW[a]) 1 -1
			
			foo3 = compClass.limitFn (name.AcelAbs[a] * name.acelW[a]) 1 -1
			
			foo4[a] = ((name.tiltAbs[a] + (name.tiltW[a]*(foo1 + foo2 + foo3)/3) )* name.maxTilt )
			
			foo5 += (foo1 + foo2 + foo3)/3
		)

		name.windforce = (foo5/3) * name.maxWindForce
		name.tiltFinal = foo4

		return true
	),

	fn testValues name= 
	(
		for a=1 to 3 do
		(
			name.deltaActVal[a] = compClass.randomGen -const.maxDistance const.maxDistance
			name.speedActVal[a] = compClass.randomGen -const.maxSpeed const.maxSpeed
			name.AcelActVal[a] = compClass.randomGen -const.maxAcel const.maxAcel
			name.tiltActVal[a] = compClass.randomGen -const.maxTilt const.maxTilt
			name.deltaCurW[a] = compClass.randomGen -1.0 1.0
			name.speedCurW[a] = compClass.randomGen -1.0 1.0
			name.acelCurW[a] = compClass.randomGen -1.0 1.0
			name.tiltCurW[a] = compClass.randomGen -1.0 1.0
		)
		return true
	),


	private 

	maxWindForce = const.maxWindForce,
	maxDistance = const.maxDistance,
	maxSpeed = const.maxSpeed,
	maxAcel = const.maxAcel,
	maxTilt = const.maxTilt,
	randomGen = compClass.randomGen,
	limitFn = compClass.limitFn,
	absFn = compClass.absFn,


	deltaActVal = [0,0,0],
	speedActVal = [0,0,0],
	AcelActVal = [0,0,0],
	tiltActVal = [0,0,0],
	deltaCurW = [0,0,0],
	speedCurW = [0,0,0],
	acelCurW = [0,0,0],
	tiltCurW = [0,0,0]

)
fn testWindClassFn = 
(
	const = constClass()
	compClass = compFnClass()
	windClassTest = windClass()

	windClassTest.testValues windClassTest
	windClassTest.updateValues windClassTest windClassTest windClassTest
	windClassTest.updateAbsolute windClassTest
	windClassTest.calculate windClassTest

	print windClassTest.windforce
	print windClassTest.tiltFinal
	
	return true
)