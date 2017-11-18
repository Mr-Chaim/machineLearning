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
	fn arrayGenFn InputValue = --------------------------------------------------------------------------------------Creates an array with Input number of interactions of value -1.0 to 1.0
	(
		arrCount = InputValue
		arr = #()
		for a = 1 to arrCount do 
		(
			arr2 = #()
			for b=1 to arrCount do
			(
				--foo = 0
				foo = mathClass.randomGenFn -1.0 1.0
				append arr2 foo
			)
			append arr arr2
		)

		return arr
	),
	fn binaryFn InputVaL LowVal highVal = ---------------------------------------------------------------------------Binary function, it takes the input value and returns the one of the bolVal. If input is Bigger than Var1, it will turn into val 2, if is smaller than var3 it will turn into val4
	(
		foo=0

		if InputVaL >= LowVal and InputVaL <= highVal do
		(
			foo = 1
		)
		return (foo)
	),
	fn binary2Fn InputVaL LowVal highVal = ---------------------------------------------------------------------------Binary function, it takes the input value and returns the one of the bolVal. If input is Bigger than Var1, it will turn into val 2, if is smaller than var3 it will turn into val4
	(
		foo=0

		if InputVaL >= LowVal and InputVaL <= highVal do
		(
			foo = InputVaL
		)
		return (foo)
	),
	fn constrainFn InputVar nLayers= --------------------------------------------------------------------------------Constrains the value into a Int between 1 and 20, it will take normaly values betwen -1.0 and 1.0
	(
		Ivar = InputVar
		halfL = (nLayers/2) as integer
		lmtRes = mathClass.limitFn Ivar -1 1
		intRes = ((lmtRes * halfL)+halfL) as integer
		finalRes = mathClass.limitFn intRes 1 nLayers

		return finalRes
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
	fn sigmoidFn inputVar = -----------------------------------------------------------------------------------------
	(
		1/(1+(e^-InputVar))
	),
	fn twoDecFn InputVal= ------------------------------------------------------------------------------------Return a "IntVar" number of decimals float
	(
		InputVar = InputVaL
		intVar = 2
		
		formatedValue = (formattedprint InputVar format:("#."+ (intVar as string) +"f"))

		return formatedValue
	),
-- Weight Functions -------------------------------------------------------------------------------------------------
	fn calcWeightFn IcurrVal IpredVal IpastW = ----------------------------------------------------------------------
	(
		curVar  = IcurrVal
		predVar = IpredVal
		pastW   = IpastW

		newWRes = mathClass.limitFn (pastW + (predVar-curVar)) -1.0 1.0
		
		return newWRes
	),
	fn getWeightPosFn IPrimaryValue IsecondaryValue ImaxPrimaryValue ImaxSecondaryValue nLayers= --------------------------------------------------------------------------
	(
		curVar = IPrimaryValue
		secVar = IsecondaryValue
		
		maxPCnst = ImaxPrimaryValue
		maxSCnst = ImaxSecondaryValue

		absPrimRes = mathClass.absFn curVar maxPCnst
		absSecRes = mathClass.absFn secVar maxSCnst

		posPrimRes = mathClass.constrainFn absPrimRes nLayers
		posSecRes = mathClass.constrainFn absSecRes nLayers
		
		return [posPrimRes,posSecRes]
	),
	fn getWindWeightPosFn IsecValue IterValue ImaxSecValue ImaxTerValue nLayers= --------------------------------------------------------------------------
	(
		secVar = IsecValue
		terVar = IterValue[2]

		mSCnst = ImaxSecValue
		mTCnst = ImaxTerValue

		absSecRes = mathClass.absFn secVar mSCnst
		absTerRes = mathClass.absFn terVar mTCnst

		limTerRes = mathClass.binary2Fn absTerRes -1.0 1.0
		
		difRes = mathClass.binary2Fn (absSecRes * (abs limTerRes)) -1.0 1.0

		posPRes = mathClass.constrainFn absSecRes nLayers
		posSRes = mathClass.constrainFn limTerRes nLayers
		
		return [posPRes,posSRes]
	),
	fn getWeightFn Iarray IweightPos = ----------------------------------------------------------------------
	(
		arrayVar = Iarray
		pos1Var = IweightPos[1]
		pos2Var = IweightPos[2]

		wVar = arrayVar[pos1Var][pos2Var]
		
		return wVar
	),
	fn weightUpdtFn Iarray IcurrVal IpredVal IpastWeight IweightPos ImaxValue = ---------------------------------------------------
	(
		arrVar = Iarray
		mVar   = ImaxValue

		curVar  = IcurrVal
		predVar = IpredVal

		pastWVar = IpastWeight
		pos1Var = IweightPos[1]
		pos2Var = IweightPos[2]

		curRes  = mathClass.absFn curVar mVar
		predRes = mathClass.absFn predVar mVar
		
		newWRes = mathClass.calcWeightFn curRes predRes pastWVar
		
		arrVar[pos1Var][pos2Var] = newWRes
		
		return arrVar
	),
	fn tltWeightUpdateFn Iarray ItltL ItltF ItltLPPred IpastWeight IweightPos maxTltcnst = ----------------------------------------
	(
		arrVar      = Iarray
		tltLVar     = ItltL
		tltFVar     = ItltF
		tltLPredVar = ItltLPPred
		tiltPastW   = IpastWeight
		weightPos1  = IweightPos[1]
		weightPos2  = IweightPos[2]

		maxTCnst = maxTltcnst

		tltLA    = mathClass.absFn (tltLVar     - tltFVar) maxTCnst 
		tltLPrdA = mathClass.absFn (tltLPredVar - tltFVar) maxTCnst 
		
		newWRes = mathClass.calcWeightFn tltLA tltLPrdA tiltPastW

		arrVar[weightPos1][weightPos2] = newWRes

		return arrVar
	),
	fn wndWUpdateFn Iarray IDstF IdstS ItltF IwndFPast IDstFPast maxWCnst maxABSD maxTlt IpastWeight IweightPos= ----------------------------
	(
		arrVar  = Iarray 
		wndPVar = IwndFPast
		dstSVar = IdstS
		dstFVar = IDstF
		tltYVar = ItltF[2]
		dstPVar = IDstFPast
		
		maxW   = maxWCnst
		maxAbs = maxABSD
		maxT   = 90

		pWeight = IpastWeight

		pos1 = IweightPos[1]
		pos2 = IweightPos[2]

		wndPAbs = mathClass.absFn wndPVar maxW
		dstFAbs = mathClass.absFn (dstFVar+dstSVar) maxAbs
		tltYAbs = mathClass.absFn tltYVar maxT
		dstPabs = mathClass.absFn (dstPVar) maxAbs

		currRes = (dstPabs - dstFAbs) * abs (1 - abs tltYAbs)
		predRes = (dstPabs - dstFAbs) 

		newWRes = mathClass.calcWeightFn currRes predRes pWeight

		/*
		twoDec = mathClass.twoDecFn 
	 	seconds = (getLocalTime())
		if (seconds[8] >= 50 and seconds[8] < 100) do
	 	(
	 		clearListener()
	 		format "wndPAbs------: %  Max: %\n" (twoDec wndPAbs) (maxABSD)
	 		format "dstFAbs------: %  Max: %\n" (twoDec dstFAbs) (maxABSD)
	 		format "tltYAbs------: %  Max: %\n" (twoDec tltYAbs) (maxT)
	 		format "dstPabs------: %  Max: %\n" (twoDec dstPabs) (maxABSD)
	 		format "currRes------: %\n" (twoDec currRes)
	 		format "predRes------: %\n" (twoDec predRes)
	 		format "pWeight------: %\n" pWeight 		
	 		format "newWRes------: %\n" newWRes	 		
	 	)
		*/

		arrVar[pos1][pos2] = newWRes
		
		return arrVar
	),
-- Position Functions -----------------------------------------------------------------------------------------------
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

		deltaX = currPosVar[1] - pastPosVar[1]
		deltaY = currPosVar[2] - pastPosVar[2]
		deltaZ = currPosVar[3] - pastPosVar[3]
		
		deltaXZ    = sqrt(deltaX^2 + deltaZ^2)
		angleYRes  = acos(deltaX/deltaXZ)
		
		if (deltaX > 0) or (deltaZ > 0) do 
		(
			if deltaX < 0 do (angleYRes = angleYRes-180)
			if deltaZ < 0 do (angleYRes = angleYRes+90)
		)
		if (deltaX < 0) and (deltaZ < 0) do (angleYRes = -angleYRes)
		
		deltaFinal = sqrt(deltaXZ^2+deltaY^2)
		angleXRes  = acos(deltaXZ/deltaFinal)
		
		if deltaY > 0 do (angleXRes = -angleXRes)

		return [angleXRes,angleYRes,0]
	),
-- Prediction Functions ---------------------------------------------------------------------------------------------
	fn PredFn IprimaryVal IsecondVal IPrimaryWght maxPrimaryCnst maxSecondCnst= -------------------------------------Predicts the Next delta, or the point in space in the next timestep. Takes current delta and currentSpeed.
	(
		primarVar   = IprimaryVal
		secondVar   = IsecondVal

		primaryWVar = IPrimaryWght

		maxPCnst = maxPrimaryCnst
		maxSCnst = maxSecondCnst

		primarAres = mathClass.absFn primarVar maxPCnst
		secondARes = mathClass.absFn secondVar maxSCnst

		primaryRes = (secondARes+(primarAres * primaryWVar))*maxPCnst

		primaryResLmt = mathClass.limitFn primaryRes -maxPCnst maxPCnst

		return primaryRes
	),
	fn dstPredFn ISpd IDstWght ISpdWght maxDstCnst maxSpdCnst= -------------------------------------Predicts the Next delta, or the point in space in the next timestep. Takes current delta and currentSpeed.
	(
		spdVar  = ISpd

		dstWVar = IDstWght

		maxDCnst = maxDstCnst
		maxSCnst = maxSpdCnst

		spdARes = mathClass.absFn spdVar maxSCnst

		dstRes = (spdARes+dstWVar)*maxDCnst

		dstResLmt = mathClass.limitFn dstRes -maxDCnst maxDCnst

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
	fn aclPredFn ISpd IAcl IAclWght IspeedPred maxAclCnst = -----------------------------------------------Predicts the aceleration on the next timestep. Takes current Aceleration and windForce.
	(
		spdSVar = ISpd
		aclSVar = IAcl
		aclWVar = IAclWght
		spdPVar = IspeedPred

		maxConstA = maxAclCnst

		spdDif = spdPVar - spdSVar
		aclAdd = spdDif + aclSVar
		aclARes = mathClass.absFn aclAdd maxConstA

		aclRes = aclARes + aclWVar

		aclResLmt = mathClass.limitFn aclRes -maxConstA maxConstA

		return aclResLmt
	),
	fn posPredFn ItltL IcurrPos IpredDist  = -------------------------------------------------------------------
	(
		posXvar       = IcurrPos[1]
		posYvar       = IcurrPos[2]
		posZvar       = IcurrPos[3]
		knownAngleVar = ItltL
		hipVar        = IpredDist

		deltasVar   = [0,0,0] 
		finalposRes = [0,0,0]

		deltYRes  = mathClass.angleTriFn hipVar -knownAngleVar[1]
		deltXZRes = mathClass.angleTriFn deltYRes[2] knownAngleVar[2]

		deltaRes = [deltXZRes[1],deltYRes[1],deltXZRes[2]] 
		
		finalPosRes[1] = deltaRes[1] + posXvar
		finalPosRes[2] = deltaRes[2] + posYvar
		finalPosRes[3] = deltaRes[3] + posZvar

		return finalPosRes
	),
	fn tltPredFn IpresentPos IfuturePos = ---------------------------------------------------------------------------I will get the angle of the source to the target and use that as prediction.
	(
		presentVar = IpresentPos
		futureVar  = IfuturePos

		delVarX = futureVar[1]-presentVar[1]
		delVarY = futureVar[2]-presentVar[2]
		delVarZ = futureVar[3]-presentVar[3]

		hipXZRes = sqrt(delVarX^2 + delVarZ^2)
		angYRes  = acos(delVarX / hipXZRes)
		
		if (delVarX > 0) or (delVarZ > 0) do 
		(
			if delVarX < 0 do (angYRes = angYRes-180)
			if delVarZ < 0 do (angYRes = angYRes+90)
		)
		if (delVarX < 0) and (delVarZ < 0) do (angYRes = -angYRes)
		
		hiYRes  = sqrt(hipXZRes^2+delVarY^2)
		angXRes = acos(hipXZRes/hiYRes)
		
		if delVarY > 0 do (angXRes = -angXRes)

		anglesRes = [angXRes,angYRes,0]

		return anglesRes
	),
-- Wind Calculation Functions ---------------------------------------------------------------------------------------
	fn wndFinlTltFn ItltL ItltF ItltFWght maxTltCnst = --------------------------------------------------------------------
	(
		tltLXvar = ItltL[1]
		tltLYvar = ItltL[2]

		tltFXvar = ItltF[1]
		tltFYvar = ItltF[2]
		
		tltWXvar = ItltFWght[1]
		tltWYvar = ItltFWght[2]

		maxTcnst = maxTltCnst
		
		tltLAbsXRes = mathClass.absFn tltLXvar maxTcnst
		tltLAbsYRes = mathClass.absFn tltLYvar maxTcnst

		tltAbsXRes = mathClass.absFn tltFXvar maxTcnst
		tltAbsYRes = mathClass.absFn tltFYvar maxTcnst

		wndFTltXRes = (tltAbsXRes + tltWXvar) * maxTcnst
		wndFTltYRes = (tltAbsYRes + tltWYvar) * maxTcnst

		wndFTltXLmt = mathClass.limitFn wndFTltXRes -maxTcnst maxTcnst
		wndFTltYLmt = mathClass.limitFn wndFTltYRes -maxTcnst maxTcnst

		finalTlt = [wndFTltXLmt,wndFTltYLmt,0]

		return finalTlt
	),
	fn wndFinlFn IdstF IDst ISpd IAcl Itltl ItltF IwndFPast IwndWght IDstWght ISpdWght IAclWght maxAbsCnst maxWndCnst maxDstCnst maxSpdCnst maxAclCnst maxTltCnst = -------------------------------------------------------------------
	(
		dstFVar = IdstF
		dstSvar = IDst
		spdSVar = ISpd
		aclSVar = IAcl

		wndPVar = IwndFPast

		maxTcnst = maxTltCnst

		wndWVar = IwndWght
		dstWVar = IDstWght
		spdWVar = ISpdWght
		aclWVar = IAclWght

		maxWConst = maxWndCnst
		maxDConst = maxDstCnst
		maxSConst = maxSpdCnst
		maxAConst = maxAclCnst
		maxWConst = maxWndCnst
		maxABSD   = maxAbsCnst

		wndAbsRes = (mathClass.absFn wndPVar (maxWConst))
		dstFAbRes = (mathClass.absFn dstFvar (maxABSD))
		dstAbsRes = (mathClass.absFn dstSvar (maxDConst))
		spdAbsRes = (mathClass.absFn spdSVar (maxSConst))
		aclAbsRes = (mathClass.absFn aclSVar (maxAConst))
		
		
		dstAFinal = (mathClass.limitFn ((dstFAbRes)) -1.0 1.0)
		wndFinal  = (mathClass.limitFn ((wndAbsRes-wndWVar)) -1.0 1.0)
		dstFinal  = (mathClass.limitFn ((dstAbsRes-dstWVar)) -1.0 1.0)
		spdFinal  = (mathClass.limitFn ((spdAbsRes-spdWVar)) -1.0 1.0)
		aclFinal  = (mathClass.limitFn ((aclAbsRes-aclWVar)) -1.0 1.0)
		
		dstFTest  = dstAFinal-(wndFinal+dstFinal+spdFinal+aclFinal)	
		
		wndFRes = (mathClass.limitFn (dstFTest-wndWVar) 0 1.0 )*(maxWConst)
		--/*
		twoDec = mathClass.twoDecFn 
	 	seconds = (getLocalTime())
		if (seconds[8] >= 50 and seconds[8] < 100) do
	 	(
	 		clearListener()
	 		format "dstFTest------: %  -------------Weight: % Max: %\n" (twoDec dstFTest) wndWVar  (maxABSD)
	 		format "wndP----------: %  Abs Value: % Weight: % Max: %\n" (twoDec wndPVar) wndAbsRes wndWVar  (maxWConst)
	 		format "dstF----------: %  Abs Value: % Weight: % Max: %\n" (twoDec dstFVar) dstFAbRes dstWVar (maxABSD)
	 		format "dstS----------: %  Abs Value: % Weight: % Max: %\n" (twoDec dstSvar) dstAbsRes dstWVar  (maxDConst)
	 		format "spdS----------: %  Abs Value: % Weight: % Max: %\n" (twoDec spdSVar) spdAbsRes spdWVar  (maxSConst)
	 		format "aclS----------: %  Abs Value: % Weight: % Max: %\n" (twoDec aclSVar) aclAbsRes aclWVar  (maxAConst)
	 		format "wndFRes-------: %\n" (twoDec wndFRes)	 		
	 	)
		--*/

		

		return wndFRes
	),
	fn windEstimateFn IdstF IDst ISpd IAcl maxWndCnst maxDstCnst maxSpdCnst maxAclCnst = --------------------------------------------------------
	(
		dstFVar = IdstF
		dstSvar = IDst
		spdSVar = ISpd
		aclSVar = IAcl
		
		maxWConst = maxWndCnst
		maxDConst = maxDstCnst
		maxSConst = maxSpdCnst
		maxAConst = maxAclCnst

		dstFAbsRes = mathClass.absFn dstFvar maxDConst 
		dstAbsRes  = mathClass.absFn dstSvar maxDConst
		spdAbsRes  = mathClass.absFn spdSVar maxSConst
		aclAbsRes  = mathClass.absFn aclSVar maxAConst
		
		dstFFinal = (mathClass.limitFn (dstFAbsRes) 0 1.0)/4 	
		dstFinal  = (mathClass.limitFn (dstAbsRes) 0 1.0)/4
		spdFinal  = (mathClass.limitFn (spdAbsRes) 0 1.0)/4
		aclFinal  = (mathClass.limitFn (aclAbsRes) 0 1.0)/4

		wndFRes = (dstFFinal+dstFinal+spdFinal+aclFinal)*maxWConst

		return wndFRes
	)
)
