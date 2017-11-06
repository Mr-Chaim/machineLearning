--Complex Variables and basic calculations


struct mathClass
(


	fn deltaFn movingObj staticObj = ((staticObj-movingObj)), ------The delta function calculates the distance the box is from the Dummy 
	fn spdNowFn deltaPast deltaPresent = (deltaPast-deltaPresent),--This will calculate the delta on position from the previous frame to the current frame and divide by the maximum possible speed.
	fn windAbsFn windForce maxWindSpd = (windForce/maxWindSpd), ----This will take the wind strength on the previous frame and divide by the maximum wind for the axis.
	fn maxAcelFn maxAcel = (abs (maxAcel)), ------------------------This will take the possible maximum acelAbseration and multiply by the delta.
	fn acelfn spdPast speedNow = (speedNow-spdPast), ---------------Calculates the acelAbseration
	fn rectifierFn var1 var2 var3 = (1-(1^(1+var2))), --------------Rectifier function.
	fn twoDecFn InputVar = (formattedprint InputVar format:"#.2f"),--Return two decimal float
	fn randomGenFn minValue maxValue = (random minValue maxValue),--Genearate random value between a max and a min value.
	fn absFn InputVar maxVar = (InputVar/maxVar), ------------------Return an absolute value from the Input value against the maximum value
	fn sigmFn InputVar = (1/(1+ e^(-(InputVar as float)))), --------Calculates a sigmoid from the InputVar
	fn tiltFn varOposite varAdj = ----------------------------------Finds the tilt from source to target in one axis
	(
		hip     = sqrt((varOposite*varOposite)+(varAdj*varAdj))
		coship  = varAdj/hip
		tilthip = acos coship

		if varOposite < 0.0 do
		(
			tilthip = -tilthip
		)

		tilthip
	),
	fn windForceFn windNow maxWindSpd = ----------------------------This function takes the strength of the selected wind on the windArray
	(
		if windNow >= maxWindSpd then
		(
			windNow = maxWindSpd
		)
		else
		(
			if windNow < -maxWindSpd then
			(
				windNow = -maxWindSpd
			)
			else
			(
				windNow
			)
		)
	), 
	fn binaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4 = ---------Binary function, it takes the input value and returns the one of the bolVal. If input is Bigger than Var1, it will turn into val 2, if is smaller than var3 it will turn into val4
	(
		if InputVar >= bolVar1 do
		(
			foo = bolvar2
		)
		if InputVar < bolvar3 do
		(
			foo = bolvar4
		)
		return foo
	),
	
	fn arrayCreaFn InputVar =---------------------------------------Creates an array with Input number of interactions of value -1.0 to 1.0
	(
		arr = #()
		for a=1 to InputVar do
		(
			foo = mathClass.randomGenFn -1.0 1.0
			append arr foo
		)
		arr
	),
	fn constrainFn InputVar = --------------------------------------Constrains the value into a Int between 1 and 20, it will take normaly values betwen -1.0 and 1.0
	(
		InputVar = mathClass.limitFn InputVar 1 -1
		foo = ((InputVar * 10)+10) as integer
		mathClass.limitFn foo 20 1
	),
	fn limitFn InputVar maxValue minValue = ------------------------Limits the value between the the maxValue and the minValue, Atention, it will not calculate new values, any value over the max or under the min will be changed to the max or the min.
	(
		if InputVar >= maxValue do
		(
			InputVar = maxValue
		)
		if InputVar < minValue do
		(
			InputVar = minValue
		)
		return InputVar
	),

	----------------------------------------------------------------Prediction functions

	fn speedPredFn acel currentSpd maxSpeed =-----------------------Predicts the speed on the next timestep. Takes current aceleration, current speed and MaxSpeed.
	(
		foo = currentSpd + acel
		return (mathClass.limitFn foo maxSpeed -maxSpeed)
	),
	fn acelPredFn acel windNow windMax maxAcel =--------------------Predicts the aceleration on the next timestep. Takes current Aceleration and windForce.
	(
		foo = acel + (acel * (windNow/windMax))
		return (mathClass.limitFn foo maxAcel -maxAcel)
	),
	fn distPredFn delta currentSpd maxDistance =--------------------Predicts the Next delta, or the point in space in the next timestep. Takes current delta and currentSpeed.
	(
		foo = delta + currentSpd
		return (mathClass.limitFn foo maxDistance -maxDistance)
	),
	fn tiltPredFn deltaPredOpos deltaPredAdj = ---------------------Predicts the tilt in the next timeStep. Takes the Prediction of the deltas of 2 axis and caluculate the angle.
	(
		hip     = sqrt((deltaPredOpos*deltaPredOpos)+(deltaPredAdj*deltaPredAdj))
		coship  = deltaPredAdj/hip
		tilthip = acos coship
		if deltaPredOpos < 0.0 do
		(
			tilthip = -tilthip
		)
		tilthip
	),

	/*
	
	The wind Displacement has to be on a definition by itself. It is a complicated calculation and actually not proved completely yet. It basicaly compensate for the wind when the other formulas did not work completely.
	Right now it should compensate for gravity, it takes the delta, speed, aceleration and wind and compensate for what it was wrong. 
	It is still a bit WIP, i have to completely compensate for tilt now and clean it up more. 
	At the moment it is not being applied in the new interation as of 11-5-2017 Beta version.

	Where it should be used:

		-- It should be on the weight calculation for wind. In case the Speed is 0, Aceleration is 0, and delta is close enought. It should add weight to wind.

	*/
	fn windDispFn deltaAbs speedAbs maxWind acelerationAbs = 
	(

		foo1 =  mathClass.binaryFn (abs speedAbs) 0.1 0 0.1 1 --------True only when speed percentage is under 0.1.
		foo2 =  mathClass.binaryFn (abs acelerationAbs) 0.1 0 0.1 1 --True only when aceleration is under 0.1.
		foo3 =  mathClass.binaryFn (abs deltaAbs) 0.1 1 0.1 0 --------True only when delta percentage is 0.1 or over.
		foo4 = 	mathClass.binaryFn (foo1 + foo2) 1 0 1 1 -------------True only when both speed and acel are True.
		foo5 = 	(deltaAbs*foo3*foo4)----------------------------------If all previous values are true, it will return the delta to be multiplied as weight to the wind.

		return foo5

	),

	----------------------------------------------------------------Testing functions

	fn dummyRandomFn counter = 
	(
		if (counter == 1) do
		(
			bdummy.pos = [(random 500 5500),(random 500 5500),(random 500 5500)]
		)
	),
	fn windDifFn deltaDirAbs  currentSpdAbs windAbs n acelAbs =
	(
		if n == 3 do
		(
			foo1 = mathClass.binaryFn (currentSpdAbs*100) 1 0 1 1
			foo2 = mathClass.binaryFn (acelAbs*10) 1 0 1 1
			foo3 = mathClass.binaryFn (foo1 + foo2) 1 0 1 1
			foo5 = mathClass.binaryFn (deltaDirAbs*1000) 1 1 1 1
			foo6 = deltaDirAbs * foo5
			foo7 = (foo1*foo2*foo5)*((deltaDirAbs*5))
		 	a = foo7
		 	--print ((foo1 as string) + " - "+ (foo2 as string)+" - "+(foo3 as string)+" - "+(foo5 as string)+" - "+(foo6 as string)+" - "+(foo7 as string))
		)
		if n < 3 do
		(
			a = 0.0
		)
		a
	)
)
fn weightChangerFunc predVal actVal pastVal type weightPos=
(	
	for a=1 to actVal.count do 
	(
		actValA    = actVal[a]
		predValA   = predVal[a]
		pastValA   = pastVal[a]
		weightPosA = weightPos[a]
		weigthType = a
		
	
		past = mathClass.limitFn pastValuesA 1 -1
		past = mathClass.constrainFn past

		multiplierA = mathClass.limitFn multiplierA 1 -1
		multiplierA = mathClass.constrainFn multiplierA

		previousWeight = wClassN.type[multiplierA]
		
		foo = mathClass.sigmFn (previousWeight - (predValuesA-currentValuesA))
		
		wClassN.type[multiplierA] = (limitFn foo 1 -1)
	)
)
fn testMathClass = 
(
	testMathClass = mathClass()
	rgen = testMathClass.randomGenFn
	testWindNow = (rgen 0.0 1000.0)
	testMaxWind = testWindNow


-------------------------------------------------------
	
	movingObj = (rgen -1000 1000) 
	staticObj = (rgen -1000 1000)

	result = testMathClass.deltaFn movingObj staticObj
	
	format "\n------------------------\n\ndeltaFn movingObj staticObj: % , % , %\n" result movingObj staticObj


-------------------------------------------------------
	
	deltaPast = (rgen -1000 1000) 
	deltaPresent = (rgen -1000 1000)

	result = testMathClass.spdNowFn deltaPast deltaPresent
	
	format "\n------------------------\n\nspdNowFn deltaPast deltaPresent: % , % , %\n" result deltaPast deltaPresent


-------------------------------------------------------
	
	windForce = (rgen 0 testWindNow) 
	maxWindSpd = testMaxWind

	result = testMathClass.windAbsFn windForce maxWindSpd
	
	format "\n------------------------\n\nwindAbsFn windForce maxWindSpd: % , % , %\n" result windForce maxWindSpd


-------------------------------------------------------
	
	maxAcel = (rgen 0 100)

	result = testMathClass.maxAcelFn maxAcel
	
	format "\n------------------------\n\nmaxAcelFn maxAcel: % , %\n" result maxAcel


-------------------------------------------------------
	
	spdPast  = (rgen 0 100) 
	speedNow = (rgen 0 100) 

	result = testMathClass.acelfn spdPast speedNow
	
	format "\n------------------------\n\nacelfn spdPast speedNow: % , % , %\n" result spdPast speedNow


-------------------------------------------------------
	
	var1 = (rgen 0 100) 
	var2 = (rgen 0 100) 
	var3 = (rgen 0 100)

	result = testMathClass.rectifierFn var1 var2 var3
	
	format "\n------------------------\n\nrectifierFn var1 var2 var3: % , % , % , %\n" result var1 var2 var3


-------------------------------------------------------
	
	InputVar = (rgen 0.0 100.0)
	
	result = testMathClass.twoDecFn InputVar
	
	format "\n------------------------\n\ntwoDecFn InputVar: % , %\n" result InputVar


-------------------------------------------------------
	
	maxVar = (rgen 0 1000) 
	
	InputVar = (rgen 0 maxVar) 
	
	result = testMathClass.absFn InputVar maxVar
	
	format "\n------------------------\n\nabsFn InputVar maxVar: % , % , %\n" result InputVar maxVar


-------------------------------------------------------

	InputVar = (rgen -1.0 1.0)

	result = testMathClass.sigmFn InputVar
	
	format "\n------------------------\n\nsigmFn InputVar: % , %\n" result InputVar


-------------------------------------------------------
	varOposite = (rgen -180 180)
	varAdj = (rgen -180 180)

	result = testMathClass.tiltFn varOposite varAdj
	
	format "\n------------------------\n\ntiltFn varOposite varAdj: % , % , %\n" result varOposite varAdj


-------------------------------------------------------
	
	windNow = (rgen 0 testWindNow)
	maxWindSpd = testMaxWind

	result = testMathClass.windForceFn windNow maxWindSpd
	
	format "\n------------------------\n\nwindForceFn windNow maxWindSpd: % , % , %\n" result windNow maxWindSpd


-------------------------------------------------------


	InputVar = (rgen -10.0 10.0)
	bolVar1 = (rgen -1.0 1.0)
	bolvar2 = (rgen -1.0 1.0)
	bolvar3 = (rgen -1.0 1.0)
	bolvar4 = (rgen -1.0 1.0)

	result = testMathClass.binaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4
	
	format "\n------------------------\n\nbinaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4: % , % , % , % , % , %\n" result InputVar bolVar1 bolvar2 bolvar3 bolvar4


-------------------------------------------------------
	
	InputVar = (rgen 1 5)

	result = testMathClass.arrayCreaFn InputVar
	
	format "\n------------------------\n\narrayCreaFn InputVar: % , %\n" result InputVar


-------------------------------------------------------

	InputVar = (rgen -1.0 1.0)
	
	result = testMathClass.constrainFn InputVar
	
	format "\n------------------------\n\nconstrainFn InputVar: % , %\n" result InputVar


-------------------------------------------------------
	
	InputVar = (rgen -5.0 5.0)
	maxValue = (rgen 0 2.0)
	minValue = (rgen -2.0 0)

	result = testMathClass.limitFn InputVar maxValue minValue
	
	format "\n------------------------\n\nlimitFn InputVar maxValue minValue: % , % , % , %\n" result InputVar maxValue minValue


-------------------------------------------------------

	maxSpeed = (rgen -200 200)
	acel = (rgen -(maxSpeed/50) (maxSpeed/50))
	currentSpd = (rgen -maxSpeed maxSpeed)
	
	result = testMathClass.speedPredFn acel currentSpd maxSpeed
	
	format "\n------------------------\n\nspeedPredFn acel currentSpd maxSpeed: % , % , % , %\n" result acel currentSpd maxSpeed


-------------------------------------------------------

	acel = (rgen -(maxSpeed/50) (maxSpeed/50))
	maxAcel = (maxSpeed/50)
	windNow = (rgen 0 testWindNow)
	windMax = testMaxWind
	
	result = testMathClass.acelPredFn acel windNow windMax maxAcel
	
	format "\n------------------------\n\nacelPredFn acel windNow windMax maxAcel: % , % , % , % , %\n" result acel windNow windMax maxAcel


-------------------------------------------------------

	maxDistance = (rgen -maxSpeed maxSpeed)
	delta = (rgen -maxDistance maxDistance)
	
	result = testMathClass.distPredFn delta currentSpd maxDistance
	
	format "\n------------------------\n\ndistPredFn delta currentSpd maxDistance: % , % , % , %\n" result delta currentSpd maxDistance


-------------------------------------------------------
	
	deltaPredOpos = (rgen -maxDistance maxDistance)
	deltaPredAdj = (rgen -maxDistance maxDistance)

	result = testMathClass.tiltPredFn deltaPredOpos deltaPredAdj
	
	format "\n------------------------\n\ntiltPredFn deltaPredOpos deltaPredAdj: % , % , %\n" result deltaPredOpos deltaPredAdj


-------------------------------------------------------

	deltaAbs = (rgen -1.0 1.0)
	speedAbs = (rgen -1.0 1.0)
	maxWind = maxWindSpd
	acelerationAbs = (rgen -1.0 1.0)
	
	result = testMathClass.windDispFn deltaAbs speedAbs maxWind acelerationAbs
	
	format "\n------------------------\n\nwindDispFn deltaAbs speedAbs maxWind acelerationAbs: % , % , % , % , %\n" result deltaAbs speedAbs maxWind acelerationAbs

)