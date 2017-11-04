--Complex Variables and basic calculations


struct compFnClass
(
	fn windForceFunc windNow maxWindSpd= --This function takes the strength of the selected wind on the windArray
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
	
	fn windAbsoluteFunc windForce maxWindSpd= (windForce/maxWindSpd), --This will take the wind strength on the previous frame and divide by the maximum wind for the axis.
	
	fn maxAcelFunc maxAcel = (abs (maxAcel)), -- This will take the possible maximum acelAbseration and multiply by the delta.
	
	fn acelfn spdPast speedNow= (speedNow-spdPast), --Calculates the acelAbseration

	fn dirtiltFn deltaOposite deltaAdj= --Finds the tilt from source to target in one axis
	(
		hip = sqrt((deltaOposite*deltaOposite)+(deltaAdj*deltaAdj))
		coship = deltaAdj/hip
		tilthip = acos coship

		if deltaOposite < 0.0 do
		(
			tilthip = -tilthip
		)

		tilthip
	),

	fn sigmFn InputVar = (1/(1+ e^(-(InputVar as float)))),
	
	fn binaryFunc varInput var1 var2 var3 var4 =
	(
		if varInput >= var1 do
		(
			foo = var2
		)
		if varInput < var3 do
		(
			foo = var4
		)
		return foo
	),
	fn randomGen = 
	(
		
		random 0.0 1.0
	),

	fn arrayCreaFn var=
	(
		arr = #()

		for a=1 to var do
		(
			foo = compFunction.randomGen()
			append arr foo
		)
		arr
	),

	fn rectifierFunc var1 var2 var3 = (1-(1^(1+var2))),
	
	fn twoDecimalScaleFunc var1= (formattedprint var1 format:"#.2f"),

	fn absFn var maxVar = (var/maxVar),
	
	fn constrainFn var = 
	(
		var = compFunction.limitFn var 1 -1
		foo = ((var * 10)+10) as integer
		compFunction.limitFn foo 20 1
	),
	
	fn limitFn var1 var2 var3 = 
	(
		if var1 >= var2 do
		(
			var1 = var2
		)
		if var1 < var3 do
		(
			var1 = var3
		)
		return var1
	),
	
	--prediction functions


	fn speedPredFn acel currentSpd =
	(
		foo = currentSpd + acel
		return (compFnClass.limitFn foo 1 -1)
	),

	fn acelPredFn acel windNow windMax=
	(
		foo = acelAbs + (acelAbs * (windNow/windMax))
		return (compFnClass.limitFn foo 1 -1)
	),
	
	fn distPredFn delta currentSpd=
	(
		foo = delta + currentSpd
		return (compFnClass.limitFn foo 1 -1)
	),

	fn tiltPredFn  deltaPredOpos deltaPredAdj= 
	(

		hip = sqrt((deltaPredOpos*deltaPredOpos)+(deltaPredAdj*deltaPredAdj))
		coship = deltaAdj/hip
		tilthip = acos coship

		if deltaOposite < 0.0 do
		(
			tilthip = -tilthip
		)

		tilthip
	),

	fn windDisplacementFn deltaDirAbs currentSpdAbs windAbs n acelAbs= 
	(
		if n == 3 do
		(
			foo1 =  compFunction.binaryFunc (currentSpdAbs*10) 1 0 1 1
			foo2 =  compFunction.binaryFunc (acelAbs*10) 1 0 1 1
			foo3 = 	compFunction.binaryFunc (foo1 + foo2) 1 0 1 1
			foo5 =  compFunction.binaryFunc (deltaDirAbs*10) 1 1 1 0
			foo6 = 	deltaDirAbs * foo5
			foo7 = 	(foo1* foo2*foo5)*(maxWindSpdArr[n]/100)
		 	a = 0
		 	--print (((twoDecimalScaleFunc (foo1)) as string) +"-"+ ((twoDecimalScaleFunc (foo2)) as string)+"-"+((twoDecimalScaleFunc foo3) as string)+"-"+((twoDecimalScaleFunc foo5) as string)+"-"+((twoDecimalScaleFunc foo6) as string)+"-"+((twoDecimalScaleFunc a) as string))
		)
		if n != 3 do
		(
			a = 0.0
		)

		a
	),


	-- testing functions


	fn dummyPositioner counter= 
	(
		if (counter == 1) do
		(
			bdummy.pos = [(random 500 5500),(random 500 5500),(random 500 5500)]
		)
	),
	
	fn windDiferenceFunc deltaDirAbs  currentSpdAbs windAbs n acelAbs=
	(
		if n == 3 do
		(
			foo1 = compFunction.binaryFunc (currentSpdAbs*100) 1 0 1 1
			foo2 = compFunction.binaryFunc (acelAbs*10) 1 0 1 1
			foo3 = compFunction.binaryFunc (foo1 + foo2) 1 0 1 1
			foo5 = compFunction.binaryFunc (deltaDirAbs*1000) 1 1 1 1
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
	),

	fn weightChangerFunc predVal actVal pastVal type weightPos=
	(	
		for a=1 to actVal.count do 
		(
			actValA = actVal[a]
			predValA = predVal[a]
			pastValA = pastVal[a]
			weightPosA = weightPos[a]
			weigthType = a
			
		
			past = compFunction.limitFn pastValuesA 1 -1
			past = compFunction.constrainFn past

			multiplierA = compFunction.limitFn multiplierA 1 -1
			multiplierA = compFunction.constrainFn multiplierA

			previousWeight = wClassN.type[multiplierA]
			
			foo = compFunction.sigmFn (previousWeight - (predValuesA-currentValuesA))
			
			wClassN.type[multiplierA] = (limitFn foo 1 -1)
		)
	)

	
)


struct predClass
(
	distPredFn = compFnClass.distPredFn,
	speedPredFn = compFnClass.speedPredFn,
	acelPredFn = compFnClass.acelPredFn,
	tiltPredFn = compFnClass.tiltPredFn,

	deltaPred = [0,0,0],
	speedPred = [0,0,0],
	acelPred  = [0,0,0],
	tiltPred = [0,0,0],



	fn update basicClass speedClass acelClass =
	(

		for a=1 to 3 do 
		(
			deltaPred[a] = distPredFn basicClass.delta[a] speedClass.spdNow[a]
			speedPred[a] = speedPredFn acelClass.acel[a] speedClass.spdNow[a]
			acelPred[a] = acelPredFn acelClass.acel[a] basicClass.windNow constClass.maxWind
		)
		tiltPred[1] = tiltPredFn deltaPred[1] deltaPred[3]
		tiltPred[2] = tiltPredFn deltaPred[2] deltaPred[3]
		tiltPred[3] = tiltPredFn deltaPred[2] deltaPred[1]
	)
	--windDispX = windDisplacementFn deltaDirAbs currentSpdAbs windAbs n acelAbs
)

struct valueStoreClass
(
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

	fn update basicVarClass spdClass acelClass predClass= 
	(

		deltaPredVal = predClass.deltaPred
		deltaPastVal = basicVarClass.deltaPast
		deltaActVal = basicVarClass.delta

		speedPredVal = predClass.speedPred
		speedPastVal = spdClass.spdPast
		speedActVal = spdClass.spdNow

		AcelPredVal = predClass.acelPred
		AcelPastVal = acelClass.acelPast
		AcelActVal = acelClass.acel

		tiltPredVal = predClass.anglePred
		tiltPastVal = basicVarClass.tiltPast
		tiltActVal = basicVarClass.tilt

	)
)
