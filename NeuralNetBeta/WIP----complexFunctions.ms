--Complex Variables and basic calculations


struct compFnClass
(

	fn windForceFn windNow maxWindSpd= --This function takes the strength of the selected wind on the windArray
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
	fn deltaFn movingObj staticObj = ((staticObj-movingObj)), --The delta function calculates the distance the box is from the Dummy 
	
	fn spdNowFn deltaPast deltaPresent = (deltaPast-deltaPresent), --This will calculate the delta on position from the previous frame to the current frame and divide by the maximum possible speed.
	
	fn windAbsFn windForce maxWindSpd= (windForce/maxWindSpd), --This will take the wind strength on the previous frame and divide by the maximum wind for the axis.
	
	fn maxAcelFn maxAcel = (abs (maxAcel)), -- This will take the possible maximum acelAbseration and multiply by the delta.
	
	fn acelfn spdPast speedNow= (speedNow-spdPast), --Calculates the acelAbseration

	fn tiltFn varOposite varAdj= --Finds the tilt from source to target in one axis
	(
		hip = sqrt((varOposite*varOposite)+(varAdj*varAdj))
		coship = varAdj/hip
		tilthip = acos coship

		if varOposite < 0.0 do
		(
			tilthip = -tilthip
		)

		tilthip
	),

	fn sigmFn InputVar = (1/(1+ e^(-(InputVar as float)))),
	
	fn binaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4 =
	(
		if InputVar > bolVar1 do
		(
			foo = bolvar2
		)
		if InputVar < bolvar3 do
		(
			foo = bolvar4
		)
		return foo
	),
	fn randomGenFn minValue maxValue= 
	(
		
		random minValue maxValue
	),

	fn arrayCreaFn InputVar=
	(
		arr = #()

		for a=1 to InputVar do
		(
			foo = compFnClass.randomGenFn -1.0 1.0
			append arr foo
		)
		arr
	),

	fn rectifierFn var1 var2 var3 = (1-(1^(1+var2))),
	
	fn twoDecFn InputVar= (formattedprint InputVar format:"#.2f"),

	fn absFn InputVar maxVar = (InputVar/maxVar),
	
	fn constrainFn InputVar = 
	(
		InputVar = compFnClass.limitFn InputVar 1 -1
		foo = ((InputVar * 10)+10) as integer
		compFnClass.limitFn foo 20 1
	),
	
	fn limitFn InputVar maxValue minValue = 
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
	
	--prediction functions


	fn speedPredFn acel currentSpd maxSpeed=
	(
		foo = currentSpd + acel
		return (compFnClass.limitFn foo maxSpeed -maxSpeed)
	),

	fn acelPredFn acel windNow windMax maxAcel=
	(
		foo = acel + (acel * (windNow/windMax))
		return (compFnClass.limitFn foo maxAcel -maxAcel)
	),
	
	fn distPredFn delta currentSpd maxDistance=
	(
		foo = delta + currentSpd
		return (compFnClass.limitFn foo maxDistance -maxDistance)
	),

	fn tiltPredFn deltaPredOpos deltaPredAdj= 
	(

		hip = sqrt((deltaPredOpos*deltaPredOpos)+(deltaPredAdj*deltaPredAdj))
		coship = deltaPredAdj/hip
		tilthip = acos coship

		if deltaPredOpos < 0.0 do
		(
			tilthip = -tilthip
		)

		tilthip
	),

	fn windDispFn deltaDirAbs currentSpdAbs windAbs n acelAbs= 
	(
		if n == 3 do
		(
			foo1 =  compFnClass.binaryFn (currentSpdAbs*10) 1 0 1 1
			foo2 =  compFnClass.binaryFn (acelAbs*10) 1 0 1 1
			foo3 = 	compFnClass.binaryFn (foo1 + foo2) 1 0 1 1
			foo5 =  compFnClass.binaryFn (deltaDirAbs*10) 1 1 1 0
			foo6 = 	deltaDirAbs * foo5
			foo7 = 	(foo1* foo2*foo5)*(maxWindSpdArr[n]/100)
		 	a = 0
		 	--print (((twoDecFn (foo1)) as string) +"-"+ ((twoDecFn (foo2)) as string)+"-"+((twoDecFn foo3) as string)+"-"+((twoDecFn foo5) as string)+"-"+((twoDecFn foo6) as string)+"-"+((twoDecFn a) as string))
		)
		if n != 3 do
		(
			a = 0.0
		)

		a
	),


	-- testing functions


	fn dummyRandomFn counter= 
	(
		if (counter == 1) do
		(
			bdummy.pos = [(random 500 5500),(random 500 5500),(random 500 5500)]
		)
	),
	
	fn windDifFn deltaDirAbs  currentSpdAbs windAbs n acelAbs=
	(
		if n == 3 do
		(
			foo1 = compFnClass.binaryFn (currentSpdAbs*100) 1 0 1 1
			foo2 = compFnClass.binaryFn (acelAbs*10) 1 0 1 1
			foo3 = compFnClass.binaryFn (foo1 + foo2) 1 0 1 1
			foo5 = compFnClass.binaryFn (deltaDirAbs*1000) 1 1 1 1
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
		actValA = actVal[a]
		predValA = predVal[a]
		pastValA = pastVal[a]
		weightPosA = weightPos[a]
		weigthType = a
		
	
		past = compFnClass.limitFn pastValuesA 1 -1
		past = compFnClass.constrainFn past

		multiplierA = compFnClass.limitFn multiplierA 1 -1
		multiplierA = compFnClass.constrainFn multiplierA

		previousWeight = wClassN.type[multiplierA]
		
		foo = compFnClass.sigmFn (previousWeight - (predValuesA-currentValuesA))
		
		wClassN.type[multiplierA] = (limitFn foo 1 -1)
	)
)