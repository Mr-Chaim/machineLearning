 -- Final Calculation function


/* fn windacelAbsFunc currentValues maxWindSpd currentWeightsArr currentNames windDisp n windDifArr= 
(
	summation = 0
	divi = 0
 	for a = 1 to currentWeightsArr.count do
 	(
 		cVA = limiterFunc currentValues[a] 1 -1
 		cWA = limiterFunc currentWeightsArr[a] 1 -1
 		 -- --format ("Step 4.1.1."+(a as string)+" - " + currentNames[a] +" Value : "  + (twoDecimalScaleFunc cVA as string))
 		 -- --format ("Step 4.1.2."+(a as string)+" - " + currentNames[a] +" Weight : "  + (twoDecimalScaleFunc cWA as string))
 		pResult = (cVA*cWA)
 		 -- --format ("Step 4.1.3."+(a as string)+" - pResult : "  + (twoDecimalScaleFunc pResult as string))
 		summation += pResult
 		divi += cWa
 	)
 	 -- --format ("Step 4.2 - summation : "  + (twoDecimalScaleFunc summation as string))
 	division = summation/divi
 	 -- --format ("Step 4.3 - division : "  + (twoDecimalScaleFunc division as string))
 	 -- --format ((n as string) + " " +(twoDecimalScaleFunc (windDisp + windDifArr[n]) as string))
	multiplication = (maxWindSpd * summation) + ((windDisp + windDifArr[n] ))
	 -- --format ("Step 4.4.1 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	multiplication = limiterFunc multiplication maxWindSpd -maxWindSpd
	 -- --format ("Step 4.5.2 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	return multiplication
	
) -- Final calculation to find the ideal wind speed for each axis.
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
		--format " -- Starting updateValues Function -- \n"

		name.deltaActVal = vClass.deltaActVal
		--format " -- 1 Value: % -- \n" name.deltaActVal

		name.speedActVal = vClass.speedActVal
		--format " -- 2 Value: % -- \n" name.speedActVal

		name.AcelActVal = vClass.AcelActVal
		--format " -- 3 Value: % -- \n" name.AcelActVal

		name.tiltActVal = vClass.tiltActVal
		--format " -- 4 Value: % -- \n" name.tiltActVal

		name.deltaCurW = wClass.deltaCurW
		--format " -- 5 Value: % -- \n" name.deltaCurW

		name.speedCurW = wClass.speedCurW
		--format " -- 6 Value: % -- \n" name.speedCurW

		name.acelCurW = wClass.acelCurW
		--format " -- 7 Value: % -- \n" name.acelCurW

		name.tiltCurW = wClass.tiltCurW
		--format " -- 8 Value: % -- \n" name.tiltCurW

		--format " -- Ending updateValues Function -- \n"
		return true

	),

	fn updateAbsolute name =
	(
		--format " -- Starting updateAbsolute Function -- \n"
		--format " -- Starting updateAbsolute Loop Function -- \n"

		for a = 1 to 3 do
		(
			--format " -- updateAbsolute Loop % -- \n" a

			name.deltaAbs[a] = compClass.absFn name.deltaActVal[a] const.maxDistance
			--format " -- 1 Value: % - Loop: % -- \n" name.deltaAbs[a] a

			name.speedAbs[a] = compClass.absFn name.speedActVal[a] const.maxSpeed
			--format " -- 2 Value: % - Loop: % -- \n" name.deltaActVal[a] a

			name.AcelAbs[a] = compClass.absFn name.AcelActVal[a] const.maxAcel
			--format " -- 3 Value: % - Loop: % -- \n" name.speedAbs[a] a

			name.tiltAbs[a] = compClass.absFn name.tiltActVal[a] const.maxTilt
			--format " -- 3 Value: % - Loop: % -- \n" name.tiltAbs[a] a

		)
		name.deltaW = name.deltaCurW
		--format " -- 1 Value: % -- \n" name.deltaW
		name.speedW = name.speedCurW
		--format " -- 2 Value: % -- \n" name.speedW
		name.acelW = name.acelCurW
		--format " -- 3 Value: % -- \n" name.acelW
		name.tiltW = name.tiltCurW
		--format " -- 4 Value: % -- \n" name.tiltW

		--format " -- Ending updateAbsolute Function -- \n"
		return true
	),

	fn calculate name= 
	(
		--format " -- Starting calculate Function -- \n"
		
		limitFn = compClass.limitFn

		deltaCalculate = name.deltaCalculate
		speedCalculate = name.speedCalculate
		acelCalculate = name.acelCalculate
		tiltCalculate = name.tiltCalculate
		windCalculate = name.windCalculate

		--format " -- deltaCalculate = % -- \n" deltaCalculate
		--format " -- speedCalculate = % -- \n" speedCalculate
		--format " -- acelCalculate = % -- \n" acelCalculate
		--format " -- tiltCalculate = % -- \n" tiltCalculate
		--format " -- windCalculate = % -- \n" windCalculate

		--format " -- Starting calculate Loop Function -- \n"

		for a=1 to 3 do
		(

			--format " -- calculate Loop % -- \n" a
			deltaCalculate[a] = limitFn (name.deltaAbs[a] * name.deltaW[a]) 1 -1
			--format " -- 1 Result: % - Imput : % - Weight: %  - Loop: % -- \n" deltaCalculate[a] name.deltaAbs[a] name.deltaW[a] a
			
			speedCalculate[a] = limitFn (name.speedAbs[a] * name.speedW[a]) 1 -1
			--format " -- 2 Result: % - Imput : % - Weight: %  - Loop: % -- \n" speedCalculate name.speedAbs[a] name.speedW[a] a
			
			acelCalculate[a] = limitFn (name.AcelAbs[a] * name.acelW[a]) 1 -1
			--format " -- 3 Result: % - Imput : % - Weight: %  - Loop: % -- \n" acelCalculate name.AcelAbs[a] name.acelW[a] a
			
			tiltCalculate[a] = ((name.tiltAbs[a] + (name.tiltW[a]*(deltaCalculate[a] + speedCalculate[a] + acelCalculate[a])/3) )* name.maxTilt )
			--format " -- 4 Result: % - Imput 1 : % - Imput 2: % - Imput 3: % - Imput 4: % - Imput 5: % - Loop: % -- \n" tiltCalculate[a] name.tiltAbs[a] name.tiltW[a] deltaCalculate[a] speedCalculate[a] acelCalculate[a] a
			
			windCalculate += (deltaCalculate[a] + speedCalculate[a] + acelCalculate[a])/3
			--format " -- 5 Result: % - Imput 1 : % - Imput 2: % - Imput 3: % - Loop: % -- \n" windCalculate deltaCalculate[a] speedCalculate[a] acelCalculate[a] a
		)

		name.windforce = limitFn ((windCalculate/3) * const.maxWindForce) const.maxWindForce 0 
		name.tiltFinal = tiltCalculate

		return true
	),

	fn testValues name= 
	(
		--format " -- Starting testValues Function -- \n"

		ranGen = compClass.randomGenFn
		--format " -- Starting testValues Loop Function -- \n"
		for a=1 to 3 do
		(
			--format " -- testValues Loop % -- \n" a
			name.deltaActVal[a] = ranGen -const.maxDistance const.maxDistance

			--format " -- 1 Value: % - Loop: % -- \n" name.deltaActVal[a] a
			
			name.speedActVal[a] = ranGen -const.maxSpeed const.maxSpeed
			--format " -- 2 Value: % - Loop: % -- \n" name.speedActVal[a] a
			
			name.AcelActVal[a] = ranGen -const.maxAcel const.maxAcel
			--format " -- 3 Value: % - Loop: % -- \n" name.AcelActVal[a] a
			
			name.tiltActVal[a] = ranGen -const.maxTilt const.maxTilt
			--format " -- 4 Value: % - Loop: % -- \n" name.tiltActVal[a] a
			
			name.deltaCurW[a] = ranGen -1.0 1.0
			--format " -- 5 Value: % - Loop: % -- \n" name.deltaCurW[a] a
			
			name.speedCurW[a] = ranGen -1.0 1.0
			--format " -- 6 Value: % - Loop: % -- \n" name.speedCurW[a] a
			
			name.acelCurW[a] = ranGen -1.0 1.0
			--format " -- 7 Value: % - Loop: % -- \n" name.acelCurW[a] a
			
			name.tiltCurW[a] = ranGen -1.0 1.0
			--format " -- 8 Value: % - Loop: % -- \n" name.tiltCurW[a] a
		)
		--format " -- Ending testValues Function -- \n"
		return true
	),


	private 

	maxWindForce = const.maxWindForce,
	maxDistance = const.maxDistance,
	maxSpeed = const.maxSpeed,
	maxAcel = const.maxAcel,
	maxTilt = const.maxTilt,
	randomGenFn = compClass.randomGenFn,
	limitFn = compClass.limitFn,
	absFn = compClass.absFn,


	deltaActVal = [0,0,0],
	speedActVal = [0,0,0],
	AcelActVal = [0,0,0],
	tiltActVal = [0,0,0],
	deltaCurW = [0,0,0],
	speedCurW = [0,0,0],
	acelCurW = [0,0,0],
	tiltCurW = [0,0,0],

	deltaCalculate = [0,0,0],
	speedCalculate = [0,0,0],
	acelCalculate = [0,0,0],
	tiltCalculate = [0,0,0],
	windCalculate = 0


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

	format "Result windforce: % -- \n" windClassTest.windforce
	format "Result tiltFinal: % -- \n" windClassTest.tiltFinal

	return true
)
testWindClassFn()