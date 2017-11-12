--Complex Variables and basic calculations


struct mathClass
(
-- Basic Math Functions Used in other Functions ---------------------------------------------------------------------
	fn absFn InputValue maxValue = ----------------------------------------------------------------------------------Return an absolute value from the Input value against the maximum value
	(
		var = InputValue
		maxVar = maxValue

		absRes = var/maxVar

		return absRes
	), 
	fn angleTriFn Ihipotenuse IsingleAngle = ------------------------------------------------------------------------Return the angles when given the Hipotenuse and an adj Angle.
	(
		hipAVar = Ihipotenuse
		angAVar = IsingleAngle

		angCCnst = 90
		
		angBRes = 180 - (angAVar + angCCnst)

		sideBres = sin(angBRes) * hipAVar
		sideCres = sin(angAVar) * hipAVar

		return [sideCres , sideBres]
	),
	fn arrayGenFn InputVar = ----------------------------------------------------------------------------------------Creates an array with Input number of interactions of value -1.0 to 1.0
	(
		arr = #()
		for a=1 to InputVar do
		(
			foo = mathClass.randomGenFn -1.0 1.0
			append arr foo
		)
		return arr
	),
	fn binaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4 = ----------------------------------------------------------Binary function, it takes the input value and returns the one of the bolVal. If input is Bigger than Var1, it will turn into val 2, if is smaller than var3 it will turn into val4
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
	fn constrainFn InputVar = ---------------------------------------------------------------------------------------Constrains the value into a Int between 1 and 20, it will take normaly values betwen -1.0 and 1.0
	(
		InputVar = mathClass.limitFn InputVar -1 1
		foo = ((InputVar * 10)+10) as integer
		mathClass.limitFn foo 1 20
	),
	fn limitFn InputVar minValue maxValue = -------------------------------------------------------------------------Limits the value between the the maxValue and the minValue, Atention, it will not calculate new values, any value over the max or under the min will be changed to the max or the min.
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
	fn randomGenFn minValue maxValue = ------------------------------------------------------------------------------Genearate random value between a max and a min value.
	(
		minVar = minValue
		maxVar = maxValue
		
		valRes = random minVar maxVar
		
		return valRes
	),
	fn twoDecFn InputVal IntVal= ------------------------------------------------------------------------------------Return a "IntVar" number of decimals float
	(
		InputVar = InputVaL
		intVar = IntVal
		
		formatedValue = (formattedprint InputVar format:("#."+ (intVar as string) +"f"))

		return formatedValue
	),
-- Weight Functions Start -------------------------------------------------------------------------------------------
	fn calcWeightFn IcurrVal IpredVal IpastW = ----------------------------------------------------------------------
	(
		curVar  = IcurrVal
		predVar = IpredVal
		pastW   = IpastW

		newWRes = mathClass.limitFn (pastW + (curVar - predVar)) -1.0 1.0
		
		return newWRes
	),
	fn getWeightPosFn IcurrVal ImaxValue = --------------------------------------------------------------------------
	(
		curVar = IcurrVal
		maxVar = ImaxValue

		absRes = mathClass.absFn curVar maxVar
		posRes = mathClass.constrainFn absRes
		
		return posRes
	),
	fn getWeightFn Iarray IcurrVal ImaxValue = ----------------------------------------------------------------------
	(
		curVar   = IcurrVal
		maxVar   = ImaxValue
		arrayVar = Iarray

		posRes = mathClass.getWeightPosFn curVar maxVar
		
		wVar = arrayVar[posRes]
		
		return wVar
	),
	fn weightUpdtFn Iarray IcurrVal IpredVal IpastVal ImaxValue = ---------------------------------------------------
	(
		arrVar  = Iarray
		mVar    = ImaxValue
		curVar  = IcurrVal
		predVar = IpredVal
		pastVar = IpastVal

		curRes  = mathClass.absFn curVar mVar
		predRes = mathClass.absFn predVar mVar

		posRes   = mathClass.getWeightPosFn pastVar mVar
		pastWVar = arrVar[posRes]
		
		newWRes = mathClass.calcWeightFn curRes predRes pastWVar
		
		arrVar[posRes] = newWRes
		
		return arrVar
	),
	fn tltWeightUpdateFn Iarray ItltL ItltF ItltLPred ItltLPast maxTltcnst = ----------------------------------------
	(
		arrVar      = Iarray
		tltLVar     = ItltL
		tltFVar     = ItltF
		tltLPredVar = ItltLPred
		tltLPastVar = ItltLPast

		maxTCnst = maxTltCnst

		tltLA    = mathClass.absFn (tltLVar     - tltFVar) maxT 
		tltLPrdA = mathClass.absFn (tltLPredVar - tltFVar) maxT 
		tltLPstR = tltLPastVar - tltFVar
		
		posRes   = mathClass.getWeightPosFn tltLPast maxTCnst
		pastWVar = arrVar[posRes]

		newWRes = mathClass.calcWeightFn tltLA tltLPrdA pastWVar

		arrVar[posRes] = newWRes

		return arrVar
	),
	fn wndWeightUpdateFn Iarray IwndFPast IDstS IwndFPred IdstSPred IDstSPast maxWCnst = ----------------------------
	(
		arrVar  = Iarray 
		
		dstSVar = IDstS 
		
		dstSPredVar = IdstSPred
		wndFPredVar = IwndFPred 
		
		wndFPastVar = IwndFPast 
		dstSPastVar = IDstSPast 

		maxWCnst = maxWCnst
		
		dstSPredA = mathClass.absFn (dstSPastVar - dstSPredVar) dstSPastVar
		dstSAbs   = mathClass.absFn (dstSPastVar - dstSVar) dstSPastVar
		
		dstSRes = dstSPredA - dstSAbs
		
		pastAbs = mathClass.absFn wndFPastVar maxWCnst
		
		currAbs = pastAbs + dstSRes
		
		predAbs = mathClass.absFn wndFPredVar maxWCnst

		posRes  = mathClass.getWeightPosFn wndFPastVar maxWCnst

		pastWVar = arrVar[posRes]

		newWRes = mathClass.calcWeightFn currAbs predAbs pastWVar

		arrVar[posRes] = newWRes
		
		return arrVar
	),
-- Weight Functions End ---------------------------------------------------------------------------------------------
-- Position Functions Start -----------------------------------------------------------------------------------------
	fn dstFfn IsourcePos ItargetPos = -------------------------------------------------------------------------------
	(
		deltaX = ItargetPos[1]-IsourcePos[1]
		deltaY = ItargetPos[2]-IsourcePos[2]
		deltaZ = ItargetPos[3]-IsourcePos[3]
		
		deltaXY    = sqrt(deltaX^2+deltaY^2)
		deltaFinal = sqrt(deltaXY^2+deltaZ^2)

		return deltaFinal
	),	
	fn spdFn IDstPast IDst = ----------------------------------------------------------------------------------------This will calculate the delta on position from the previous frame to the current frame and divide by the maximum possible speed.
	(
		dstCVar = IDst 
		dstPVar = IDstPast

		spdRes  = dstCVar-dstPVar

		return spdRes
	),
	fn acelfn ISpdPast ISpd = ---------------------------------------------------------------------------------------Calculates the acelAbseration
	(
		spdCVar = ISpd
		spdPVar = ISpdPast

		aclRes = spdCVar-spdPVar
		
		return aclRes
	), 
	fn tltFFn IpastVal IcurrVal = -----------------------------------------------------------------------------------
	(
		pastPosVar = IpastVal
		currPosVar = IcurrVal
		
		deltaX = pastPosVar[1] - currPosVar[1]
		deltaY = pastPosVar[2] - currPosVar[2]
		deltaZ = pastPosVar[3] - currPosVar[3]

		deltaXZ = sqrt(deltaX^2 + deltaZ^2)
		angleY  = acos(deltaX / deltaXZ)
		
		if (deltaX > 0) or (deltaZ > 0) do 
		(
			if deltaX < 0 do (angleY = 270 - angleY)
			if deltaZ < 0 do (angleY = angleY - 90)
		)
		
		if (deltaX < 0) and (deltaZ < 0) do (angleY = angleY - 90)
		if (deltaX > 0) and (deltaZ > 0) do	(angleY = 270 - angleY)
		
		deltaFinal = sqrt(deltaXZ^2+deltaY^2)
		angleX     = acos(deltaXZ/deltaFinal)
		
		if deltaXZ > 0 or deltaY > 0 do 
		(
			if deltaXZ < 0 do (angleX = angleX-360)
			if deltaY < 0 do  (angleX = -angleX)
		)

		return [angleX,angleY,180]
	),
-- Position Functions End -------------------------------------------------------------------------------------------
-- Prediction Functions Start ---------------------------------------------------------------------------------------
	fn wndPredFn IDst ISpd IAcl IDstWght ISpdWght IAclWght maxWndCnst maxDstCnst maxSpdCnst maxAclCnst = ------------
	(
		dstSvar = IDst
		spdSVar = ISpd
		aclSVar = IAcl

		dstWVar = IDstWght
		spdWVar = ISpdWght
		aclWVar = IAclWght

		maxWConst = maxWndCnst
		maxDConst = maxDstCnst
		maxSConst = maxSpdCnst
		maxAConst = maxAclCnst

		dstAbsRes = mathClass.absFn dstSvar maxDConst
		spdAbsRes = mathClass.absFn spdSVar maxSConst
		aclAbsRes = mathClass.absFn aclSVar maxAConst

	
		dstFinal = (mathClass.limitFn (dstAbsRes + dstWVar) 0 1.0)/4
		spdFinal = (mathClass.limitFn (spdAbsRes + spdWVar) 0 1.0)/4
		aclFinal = (mathClass.limitFn (aclAbsRes + aclWVar) 0 1.0)/4

		wndFRes = (dstFinal+spdFinal+aclFinal)*maxWConst

		return wndFRes
	),
	fn dstPredFn ISpd IAcl ISpdWght IAclWght maxDstCnst maxSpdCnst maxAclCnst = -------------------------------------Predicts the Next delta, or the point in space in the next timestep. Takes current delta and currentSpeed.
	(
		spdVar = ISpd
		aclVar = IAcl

		spdWVar = ISpdWght
		aclWVar = IAclWght
		
		maxDCnst = maxDstCnst
		maxSCnst = maxSpdCnst
		maxACnst = maxAclCnst

		spdARes = mathClass.absFn spdVar maxSCnst
		aclARes = mathClass.absFn aclVar maxACnst

		dstRes = spdARes+(aclARes+aclWVar)+spdWVar

		distResLmt = mathClass.limitFn distRes -maxDCnst maxDCnst

		return dstResLmt
	),
	fn spdPredFn ISpd IAcl ISpdWght IAclWght maxSpdCnst maxAclCnst = ------------------------------------------------Predicts the speed on the next timestep. Takes current aceleration, current speed and MaxSpeed.
	(
		spdSVar = ISpd
		aclSVar = IAcl
		
		spdWVar = ISpdWght
		aclWVar = IAclWght
		
		maxSConst = maxSpdCnst
		maxAConst = maxAclCnst

		spdARes = mathClass.absFn spdSVar maxSConst
		aclARes = mathClass.absFn aclSVar maxAConst

		spdRes = spdARes + spdWVar(aclARes + aclWVar)
		
		spdResLmt = mathClass.limitFn spdRes -maxSConst maxSConst
		
		return spdResLmt
	),
	fn aclPredFn Iwnd IAcl IwindWght IAclWght maxWndCnst maxAclCnst = -----------------------------------------------Predicts the aceleration on the next timestep. Takes current Aceleration and windForce.
	(
		wndSVar = Iwnd
		aclSVar = IAcl
		
		wndWVar = IwindWght
		aclWVar = IAclWght

		maxConstW = maxWndCnst
		maxConstA = maxAclCnst

		wndARes = mathClass.absFn wndSVar maxConstW
		aclARes = mathClass.absFn aclSVar maxConstA

		aclRes = aclARes + aclWVar + (wndARes + wndWVar)

		aclResLmt = mathClass.limitFn aclRes -maxConstA maxConstA

		return aclResLmt
	),
	fn posPredFn IpredDist IpredAngles IcurrPos = -------------------------------------------------------------------
	(
		posXvar       = IcurrPos[1]
		posYvar       = IcurrPos[2]
		posZvar       = IcurrPos[3]
		knownAngleVar = IpredAngles
		hipVar        = IpredDist

		deltasVar   = [0,0,0] 
		finalposRes = [0,0,0]

		deltYRes  = mathClass.angleTriFn hipVar knownAngleVar[1]
		deltXZRes = mathClass.angleTriFn deltYRes[2] -knownAngleVar[2]

		deltaRes = [deltXZRes[1],deltYRes[1],deltXZRes[2]] 
		
		finalPosRes[1] = deltaRes[1] + posXvar
		finalPosRes[2] = deltaRes[2] + posYvar
		finalPosRes[3] = deltaRes[3] + posZvar

		return finalPosRes
	),
	fn tltPredFn IpresentPos IfuturePos = ---------------------------------------------------------------------------I will get the angle of the source to the target and use that as prediction.
	(
		presentVar = IpresentPos
		futureVar = IfuturePos

		delVarX = futureVar[1]-presentVar[1]
		delVarY = futureVar[2]-presentVar[2]
		delVarZ = futureVar[3]-presentVar[3]

		hipXZRes = sqrt(delVarX^2 + delVarZ^2)
		angYRes  = acos(delVarX / hipXZRes)
		
		if (delVarX > 0) or (delVarZ > 0) do 
		(
			if delVarX < 0 do 
			(
				angYRes = 270-angYRes
			)
			if delVarZ < 0 do 
			(
				angYRes = angYRes-90
			)
		)
		if (delVarX < 0) and (delVarZ < 0) do 
		(
			angYRes = angYRes-90 
		)
		if (delVarX > 0) and (delVarZ > 0) do 
		(
			angYRes = angYRes-90
		)
		
		hiYRes  = sqrt(hipXZRes^2+delVarY^2)
		angXRes = acos(hipXZRes/hiYRes)
		
		if delVarY < 0 do  
		(
			angXRes = angXRes
		)

		anglesRes = [angXRes,angYRes,180]

		return anglesRes
	),
-- Prediction Functions End -----------------------------------------------------------------------------------------
-- Wind Calculation Functions Start ---------------------------------------------------------------------------------

	fn wndFinlTltFn ItltF ItltFWght maxTltCnst = --------------------------------------------------------------------
	(
		
		tltFXvar = ItltF[1]
		tltFYvar = ItltF[2]
		
		tltWXvar = ItltFWght[1]
		tltWYvar = ItltFWght[2]

		maxTcnst = maxTltCnst

		tltAbsXRes = mathClass.absFn tltFXvar maxTcnst
		tltAbsYRes = mathClass.absFn tltFYvar maxTcnst

		wndFTltXRes = (tltAbsXRes + tltWXvar) * maxTcnst
		wndFTltYRes = (tltAbsYRes + tltWYvar) * maxTcnst

		finalTlt = [wndFTltXRes,wndFTltYRes,180]

		return finalTlt
	),
	fn wndFinlFn IwndFPred IwindWght maxWndCnst = -------------------------------------------------------------------
	(
		wndSVar = Iwnd

		wndWVar = IwindWght

		maxWConst = maxWndCnst

		wndAbsRes = mathClass.absFn wndSVar maxWConst

		wndFnlLmt = mathClass.limitFn (wndAbsRes + wndWVar) 0 1.0
		
		wndFRes = wndFnlLmt*maxWConst

		return wndFRes
	),
	fn windDispFn deltaAbs speedAbs maxWind acelerationAbs = --------------------------------------------------------
	(

		foo1 =  mathClass.binaryFn (abs speedAbs) 0.1 0 0.1 1 -------True only when speed percentage is under 0.1.
		foo2 =  mathClass.binaryFn (abs acelerationAbs) 0.1 0 0.1 1--True only when aceleration is under 0.1.
		foo3 =  mathClass.binaryFn (abs deltaAbs) 0.1 1 0.1 0 -------True only when delta percentage is 0.1 or over.
		foo4 = 	mathClass.binaryFn (foo1 + foo2) 1 0 1 1 ------------True only when both speed and acel are True.
		foo5 = 	(deltaAbs*foo3*foo4)---------------------------------If all previous values are true, it will return the delta to be multiplied as weight to the wind.

		return foo5

	)
)
/*
	fn testMathClass = 
	(
		testMathClass = mathClass()
		rgen = testMathClass.randomGenFn
		testWindNow = (rgen 0.0 1000.0)
		testMaxWind = testWindNow



		
		movingObj = (rgen -1000 1000) 
		staticObj = (rgen -1000 1000)

		result = testMathClass.deltaFn movingObj staticObj
		
		format "\n------------------------\n\ndeltaFn movingObj staticObj: % , % , %\n" result movingObj staticObj



		
		deltaPast = (rgen -1000 1000) 
		deltaPresent = (rgen -1000 1000)

		result = testMathClass.spdNowFn deltaPast deltaPresent
		
		format "\n------------------------\n\nspdNowFn deltaPast deltaPresent: % , % , %\n" result deltaPast deltaPresent



		
		windForce = (rgen 0 testWindNow) 
		maxWindSpd = testMaxWind

		result = testMathClass.windAbsFn windForce maxWindSpd
		
		format "\n------------------------\n\nwindAbsFn windForce maxWindSpd: % , % , %\n" result windForce maxWindSpd



		
		maxAcel = (rgen 0 100)

		result = testMathClass.maxAcelFn maxAcel
		
		format "\n------------------------\n\nmaxAcelFn maxAcel: % , %\n" result maxAcel



		
		spdPast  = (rgen 0 100) 
		speedNow = (rgen 0 100) 

		result = testMathClass.acelfn spdPast speedNow
		
		format "\n------------------------\n\nacelfn spdPast speedNow: % , % , %\n" result spdPast speedNow



		
		var1 = (rgen 0 100) 
		var2 = (rgen 0 100) 
		var3 = (rgen 0 100)

		result = testMathClass.rectifierFn var1 var2 var3
		
		format "\n------------------------\n\nrectifierFn var1 var2 var3: % , % , % , %\n" result var1 var2 var3



		
		InputVar = (rgen 0.0 100.0)
		
		result = testMathClass.twoDecFn InputVar
		
		format "\n------------------------\n\ntwoDecFn InputVar: % , %\n" result InputVar



		
		maxVar = (rgen 0 1000) 
		
		InputVar = (rgen 0 maxVar) 
		
		result = testMathClass.absFn InputVar maxVar
		
		format "\n------------------------\n\nabsFn InputVar maxVar: % , % , %\n" result InputVar maxVar




		InputVar = (rgen -1.0 1.0)

		result = testMathClass.sigmFn InputVar
		
		format "\n------------------------\n\nsigmFn InputVar: % , %\n" result InputVar



		varOposite = (rgen -180 180)
		varAdj = (rgen -180 180)

		result = testMathClass.tiltFn varOposite varAdj
		
		format "\n------------------------\n\ntiltFn varOposite varAdj: % , % , %\n" result varOposite varAdj



		
		windNow = (rgen 0 testWindNow)
		maxWindSpd = testMaxWind

		result = testMathClass.windForceFn windNow maxWindSpd
		
		format "\n------------------------\n\nwindForceFn windNow maxWindSpd: % , % , %\n" result windNow maxWindSpd





		InputVar = (rgen -10.0 10.0)
		bolVar1 = (rgen -1.0 1.0)
		bolvar2 = (rgen -1.0 1.0)
		bolvar3 = (rgen -1.0 1.0)
		bolvar4 = (rgen -1.0 1.0)

		result = testMathClass.binaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4
		
		format "\n------------------------\n\nbinaryFn InputVar bolVar1 bolvar2 bolvar3 bolvar4: % , % , % , % , % , %\n" result InputVar bolVar1 bolvar2 bolvar3 bolvar4



		
		InputVar = (rgen 1 5)

		result = testMathClass.arrayGenFn InputVar
		
		format "\n------------------------\n\narrayGenFn InputVar: % , %\n" result InputVar




		InputVar = (rgen -1.0 1.0)
		
		result = testMathClass.constrainFn InputVar
		
		format "\n------------------------\n\nconstrainFn InputVar: % , %\n" result InputVar



		
		InputVar = (rgen -5.0 5.0)
		maxValue = (rgen 0 2.0)
		minValue = (rgen -2.0 0)

		result = testMathClass.limitFn InputVar minValue maxValue
		
		format "\n------------------------\n\nlimitFn InputVar minValue maxValue : % , % , % , %\n" result InputVar  minValue maxValue




		maxSpeed = (rgen -200 200)
		acel = (rgen -(maxSpeed/50) (maxSpeed/50))
		currentSpd = (rgen -maxSpeed maxSpeed)
		
		result = testMathClass.speedPredFn acel currentSpd maxSpeed
		
		format "\n------------------------\n\nspeedPredFn acel currentSpd maxSpeed: % , % , % , %\n" result acel currentSpd maxSpeed




		acel = (rgen -(maxSpeed/50) (maxSpeed/50))
		maxAcel = (maxSpeed/50)
		windNow = (rgen 0 testWindNow)
		windMax = testMaxWind
		
		result = testMathClass.acelPredFn acel windNow windMax maxAcel
		
		format "\n------------------------\n\nacelPredFn acel windNow windMax maxAcel: % , % , % , % , %\n" result acel windNow windMax maxAcel




		maxDistance = (rgen -maxSpeed maxSpeed)
		delta = (rgen -maxDistance maxDistance)
		
		result = testMathClass.distPredFn delta currentSpd maxDistance
		
		format "\n------------------------\n\ndistPredFn delta currentSpd maxDistance: % , % , % , %\n" result delta currentSpd maxDistance



		
		deltaPredOpos = (rgen -maxDistance maxDistance)
		deltaPredAdj = (rgen -maxDistance maxDistance)

		result = testMathClass.tiltPredFn deltaPredOpos deltaPredAdj
		
		format "\n------------------------\n\ntiltPredFn deltaPredOpos deltaPredAdj: % , % , %\n" result deltaPredOpos deltaPredAdj




		deltaAbs = (rgen -1.0 1.0)
		speedAbs = (rgen -1.0 1.0)
		maxWind = maxWindSpd
		acelerationAbs = (rgen -1.0 1.0)
		
		result = testMathClass.windDispFn deltaAbs speedAbs maxWind acelerationAbs
		
		format "\n------------------------\n\nwindDispFn deltaAbs speedAbs maxWind acelerationAbs: % , % , % , % , %\n" result deltaAbs speedAbs maxWind acelerationAbs

	)
*/