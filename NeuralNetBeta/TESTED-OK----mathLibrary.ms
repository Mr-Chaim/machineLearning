--Complex Variables and basic calculations


struct mathClass
(
-- Basic Math Functions Used in other Functions ---------------------------------------------------------------------
	fn absFn InputValue maxValue = ----------------------------------------------------------------------------------Return an absolute value from the Input value against the maximum value
	(

		var = InputValue
		maxVar = maxValue
		absRes = var/maxVar
		if var < 0.0 and var > 0.0 do
		(
			absRes = 0.0
		)

		return absRes
	), 
	fn absLimitFn InputCurrValue InputPastValue Iweight maxConstant =
	(
		Cvar = InputCurrValue
		PVar = InputPastValue
		WVar = Iweight
		maxC = maxConstant

		CAbs = mathClass.absFn Cvar maxC
		PAbs = mathClass.absFn PVar maxC

		diffRes = ((CAbs + WVar))

		absRes = mathClass.absFn diffRes maxC
		
		absLmt = mathClass.binaryRectFn diffRes -1.0 1.0

		return absLmt
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
	fn binaryFn InputValue LowVal highVal = -------------------------------------------------------------------------Binary function, it takes the input value and returns the one of the bolVal. If input is Bigger than Var1, it will turn into val 2, if is smaller than var3 it will turn into val4
	(
		foo=0.0

		if InputValue > LowVal and InputValue < highVal do
		(
			foo = 1.0
		)
		return (foo)
	),
	fn binaryRectFn InputValue LowVal highVal = ------------------------------------------------------------------------Binary function, it takes the input value and returns the one of the bolVal. If input is Bigger than Var1, it will turn into val 2, if is smaller than var3 it will turn into val4
	(
		foo=(1.0 * (InputValue/ abs InputValue))

		if InputValue >= LowVal and InputValue <= highVal do
		(
			foo = InputValue
		)
		--print foo
		return foo
	),
	fn constrainFn InputValue nLayers= ------------------------------------------------------------------------------Constrains the value into a Int between 1 and 20, it will take normaly values betwen -1.0 and 1.0
	(
		Ivar = InputValue
		halfL = (nLayers/2) as integer
		lmtRes = mathClass.binaryRectFn Ivar -1 1
		intRes = ((lmtRes * halfL)+halfL) as integer
		finalRes = mathClass.binaryRectFn intRes 1 nLayers

		return finalRes
	),
	fn limitFn InputValue minValue maxValue = -----------------------------------------------------------------------Limits the value between the the maxValue and the minValue, Atention, it will not calculate new values, any value over the max or under the min will be changed to the max or the min.
	(
		if InputValue >= maxValue do
		(
			InputValue = maxValue
		)
		if InputValue < minValue do
		(
			InputValue = minValue
		)
		return InputValue
	),
	fn randomGenFn minValue maxValue = ------------------------------------------------------------------------------Genearate random value between a max and a min value.
	(
		minVar = minValue
		maxVar = maxValue
		
		valRes = random minVar maxVar
		
		return valRes
	),
	fn sigmoidFn InputValue = ---------------------------------------------------------------------------------------Sigmoid function.
	(
		Ivar = InputValue
		sigRes = 1/(1+(e^-Ivar))
		return sigRes
	),
	fn twoDecFn InputValue= -----------------------------------------------------------------------------------------Reduces "InputValue" to 2 decimals float.
	(
		InputVar = InputValue
		intVar = 2
		
		formatedValue = (formattedprint InputVar format:("#."+ (intVar as string) +"f"))

		return formatedValue
	),
-- Weight Functions -------------------------------------------------------------------------------------------------
	--3-------------1--------2--------3-----
	fn calcWeightFn IcurrVal IpredVal IpastW = ----------------------------------------------------------------------
	(
		curVar  = mathClass.sigmoidFn (IcurrVal)
		predVar = mathClass.sigmoidFn (IpredVal)
		pastW   = IpastW

		newWRes = mathClass.binaryRectFn (pastW + (curVar-predVar)/2) -1.0 1.0
		
		return newWRes
	),
	--5---------------1-------------2---------------3----------------4------------------5--------
	fn getWeightPosFn IPrimaryValue IsecondaryValue ImaxPrimaryValue ImaxSecondaryValue nLayers= --------------------
	(
		curVar = IPrimaryValue
		secVar = IsecondaryValue
		
		maxPCnst = ImaxPrimaryValue
		maxSCnst = ImaxSecondaryValue

		absPrimRes = mathClass.absFn curVar maxPCnst
		absSecRes = mathClass.absFn secVar maxSCnst

		absPrimLmt = mathClass.binaryRectFn absPrimRes -1.0 1.0
		absSecLmt = mathClass.binaryRectFn absSecRes -1.0 1.0

		posPrimRes = mathClass.constrainFn absPrimRes nLayers
		posSecRes = mathClass.constrainFn absSecRes nLayers
		
		return [posPrimRes,posSecRes]
	),
	--5-------------------1-----------2---------3------------4------------5
	fn getDstFWeightPosFn IprimaryVal IsecValue ImaxPriValue ImaxSecValue nLayers= ------------------------------------
	(
		priVar = IprimaryVal
		secVar = IsecValue[2]

		mPCnst = ImaxPriValue
		mSCnst = ImaxSecValue

		absPriRes = mathClass.absFn priVar mPCnst
		absSecRes = mathClass.absFn secVar mSCnst

		limTerRes = mathClass.binaryRectFn absSecRes -1.0 1.0
		
		posPRes = mathClass.constrainFn absPriRes nLayers
		posSRes = mathClass.constrainFn limTerRes nLayers
		
		return [posPRes,posSRes]
	),
	--6-------------------1---------2---------3---------4------------5------------6
	fn getWndFWeightPosFn IpriValue IsecValue ItltValue ImaxPriValue ImaxSecValue nLayers= ------------------------------------
	(
		priVar = IpriValue
		secVar = IsecValue
		tltVar = ItltValue[2]

		mP = ImaxPriValue
		mS = ImaxSecValue
		mT = 90

		absPriRes = mathClass.absFn priVar mP
		absSecRes = mathClass.absFn secVar mS
		abstltRes = mathClass.absFn tltVar mT

		limTerRes = mathClass.binaryRectFn absSecRes -1.0 1.0
		
		posPRes = mathClass.constrainFn (absPriRes - abs limTerRes) nLayers
		posSRes = mathClass.constrainFn absSecRes nLayers
		
		return [posPRes,posSRes]
	),
	--2------------1------2-----------
	fn getWeightFn Iarray IweightPos = ------------------------------------------------------------------------------
	(
		arrayVar = Iarray
		pos1Var = IweightPos[1]
		pos2Var = IweightPos[2]

		wVar = arrayVar[pos1Var][pos2Var]
		
		return wVar
	),
	--8-------------1------2-------3-------4---------5-----------6-----------7-------8--------
	fn weightUpdtFn Iarray IpriVal IsecVal IValPPred IpastWeight IPweightPos maxVal1 maxVal2 = --------------------------
	(
		arrVar   = Iarray
		priVar   = IpriVal
		SecVar   = IsecVal
		pPredVar = IValPPred
		PastW    = IpastWeight
		wPos1    = IPweightPos[1]
		wPos2    = IPweightPos[2]

		maxPri  = maxVal1
		maxSec = maxVal2

		priA = mathClass.absFn priVar maxPri 
		secA = mathClass.absFn SecVar maxSec 
		pPrA = mathClass.absFn pPredVar maxPri 
		
		priLmt = mathClass.binaryRectFn priA -1.0 1.0
		secLmt = mathClass.binaryRectFn secA -1.0 1.0
		pPrLmt = mathClass.binaryRectFn pPrA -1.0 1.0
		--PastW  = mathClass.binaryRectFn PastW -1.0 1.0
		resCurr = priA
		resPred = (abs secA - 1) - pPrA
		--print resPred
		--newWRes = (PastW - (resCurr - resPred))
		newWRes = mathClass.calcWeightFn resCurr resPred PastW

		arrVar[wPos1][wPos2] = newWRes

		return arrVar
	),
	--8------------------1------2-------3-------4---------5-----------6-----------7-------8--------
	fn tltWeightUpdateFn Iarray IpriVal IsecVal IValPPred IpastWeight IPweightPos maxVal1 maxVal2 = --------------------------
	(
		arrVar   = Iarray
		priVar   = IpriVal
		SecVar   = IsecVal
		pPredVar = IValPPred
		PastW    = IpastWeight
		wPos1    = IPweightPos[1]
		wPos2    = IPweightPos[2]

		maxPri  = maxVal1
		maxSec  = maxVal2

		priA = mathClass.absFn priVar maxPri 
		secA = mathClass.absFn SecVar maxSec 
		pPrA = mathClass.absFn pPredVar maxPri 
		
		priLmt = mathClass.binaryRectFn priA -1.0 1.0
		secLmt = mathClass.binaryRectFn secA -1.0 1.0
		pPrLmt = mathClass.binaryRectFn pPrA -1.0 1.0
		PastW  = mathClass.binaryRectFn PastW -1.0 1.0
		
		resCurr = priA * (secLmt )
		resPred = pPrA * (secLmt )
		
		--newWRes = (PastW + (resCurr - resPred)/2)
		newWRes = mathClass.calcWeightFn resPred resCurr PastW

		arrVar[wPos1][wPos2] = -newWRes

		return arrVar
	),
	--8-------------1------2-----3-----4---------5-----------6--------------7------8----
	fn dstWUpdateFn Iarray IdstF ItltF IdstFPred IpastWeight IweightpastPos maxABS maxT= ----
	(
		arrVar  = Iarray

		dstFVar = IdstF
		dstPVar = IdstFPred
		tltYVar = ItltF[2]
		
		maxAbs = maxABS
		maxT   = maxT

		dstPW = IpastWeight

		pos1 = IweightpastPos[1]
		pos2 = IweightpastPos[2]

		dstFAbs = mathClass.absFn dstFVar maxAbs
		
		tltYAbs = mathClass.absFn tltYVar maxT
		
		dstPAbs = mathClass.absFn dstPVar maxAbs

		dstFLmt = mathClass.binaryRectFn dstFAbs -1.0 1.0
		dstPLmt = mathClass.binaryRectFn dstPAbs -1.0 1.0
		tltYLmt = mathClass.binaryRectFn tltYAbs -1.1 1.1

		currRes = dstFLmt
		predRes = dstPLmt
		--print tltYLmt
		newWRes = mathClass.calcWeightFn dstFLmt tltYLmt dstPW
		--print dstFLmt

		/*
			twoDec = mathClass.twoDecFn 
		 	seconds = (getLocalTime())
			if (seconds[8] >= 50 and seconds[8] < 100) do
		 	(
		 		clearListener()
		 		format "Soupos-------: %\n" $sourceBox.pos
				format "Tarpos-------: %\n" $TargetBox.pos
		 		format "\n"
		 		format "dstFVar------: %\n" (twoDec dstFVar)
		 		format "dstPVar------: %\n" (twoDec dstPVar)
		 		format "tltYVar------: %\n" (twoDec ItltF)
		 		format "\n"
		 		format "dstFAbs------: %\n" (twoDec dstFAbs)
		 		format "dstPAbs------: %\n" (twoDec dstPAbs)
		 		format "tltYAbs------: %\n" (twoDec tltYAbs)
		 		format "\n"
		 		format "dstFLmt------: %\n" (twoDec dstFLmt)
		 		format "dstPLmt------: %\n" (twoDec dstPLmt)
		 		format "tltYLmt------: %\n" (twoDec tltYLmt)
		 		format "\n"
		 		format "currRes------: %\n" (twoDec currRes)
		 		format "predRes------: %\n" (twoDec predRes)
		 		format "\n"
		 		format "dstPW--------: %\n" dstPW 		
		 		format "newWRes------: %\n" newWRes	 		
		 	)
		*/

		arrVar[pos1][pos2] = newWRes
		
		return arrVar
	),
	--11------------1------2---------3-----4-----5-----6-----------7--------------8----9------10---11----
	fn wndWUpdateFn Iarray IwndFPast IdstF IdstS ItltF IpastWeight IweightpastPos maxW maxABS maxD maxT= ----
	(
		arrVar  = Iarray

		wndPVar = IwndFPast
		dstFVar = IdstF
		dstSVar = IdstS
		tltYVar = ItltF[2]
		
		maxW   = maxW
		maxAbs = maxABS
		maxD   = maxD
		maxT   = maxT

		wndPW = IpastWeight

		pos1 = IweightpastPos[1]
		pos2 = IweightpastPos[2]

		wndPAbs = mathClass.absFn wndPVar maxW

		dstFAbs = mathClass.absFn dstFVar maxAbs
		dstPabs = mathClass.absFn dstSVar maxD

		tltYAbs = mathClass.absFn tltYVar maxT
		
		dstFLmt = mathClass.binaryRectFn dstFAbs -1.0 1.0
		dstPLmt = mathClass.binaryRectFn dstPabs -1.0 1.0
		tltYLmt = mathClass.binaryRectFn tltYAbs -1.1 1.1

		currRes = ((dstFLmt+dstPLmt)/2)
		predRes = ((dstFLmt+dstPLmt)/2) - (abs tltYLmt)

		newWRes = mathClass.calcWeightFn currRes predRes wndPW
		--newWRes = 0.5
		/*
			twoDec = mathClass.twoDecFn 
		 	seconds = (getLocalTime())
			if (seconds[8] >= 50 and seconds[8] < 100) do
		 	(
		 		clearListener()
				
				format "Soupos-------: %\n" $sourceBox.pos
				format "Tarpos-------: %\n" $TargetBox.pos
		 		format "\n"
		 		format "wndPVar------: %\n" (twoDec wndPVar)
		 		format "dstFVar------: %\n" (twoDec dstFVar)
		 		format "dstSVar------: %\n" (twoDec dstSVar)
		 		format "tltYVar------: %\n" (twoDec ItltF)
		 		format "\n"
		 		format "dstFAbs------: %\n" (twoDec dstFAbs)
		 		format "dstPabs------: %\n" (twoDec dstPabs)
		 		format "tltYAbs------: %\n" (twoDec tltYAbs)
		 		
		 		format "\n"
		 		format "dstFLmt------: %\n" (twoDec dstFLmt)
		 		format "dstPLmt------: %\n" (twoDec dstPLmt)
		 		format "tltYLmt------: %\n" (twoDec tltYLmt)
		 		format "\n"
		 		format "currRes------: %\n" (twoDec currRes)
		 		format "predRes------: %\n" (twoDec predRes)
		 		format "\n"
		 		format "wndPW--------: %\n" wndPW 		
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
	fn movementFn ISpdPast ISpd = ---------------------------------------------------------------------------------------Calculates the acelAbseration
	(
		spdCVar = ISpd
		spdPVar = ISpdPast

		aclRes = spdCVar-spdPVar
		
		return aclRes
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
			if deltaX < 0 do (angleYRes = 90 - angleYRes)
			if deltaZ < 0 do (angleYRes = angleYRes+90)
			if (deltaX > 0) and (deltaZ > 0) do (angleYRes = 90-angleYRes)
		)
		if (deltaX < 0) and (deltaZ < 0) do (angleYRes = angleYRes+90)
		
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

		primaryRes = (secondARes*(primarAres + primaryWVar))*maxPCnst

		primaryResLmt = mathClass.binaryRectFn primaryRes -maxPCnst maxPCnst

		return primaryRes
	),
	fn dstFPredFn ItargetPos IpredPos = -----------------------------------------------------------------------------Predicts the Next delta, or the point in space in the next timestep. Takes current delta and currentSpeed.
	(
		deltaX = ItargetPos[1]-IpredPos[1]
		deltaY = ItargetPos[2]-IpredPos[2]
		deltaZ = ItargetPos[3]-IpredPos[3]
		
		deltaXY    = sqrt(deltaX^2+deltaY^2)
		deltaFinal = sqrt(deltaXY^2+deltaZ^2)


		return deltaFinal
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
		
		spdResLmt = mathClass.binaryRectFn spdRes -maxSConst maxSConst
		
		return spdResLmt
	),
	fn aclPredFn ISpd IAcl IAclWght IspeedPred maxAclCnst = ---------------------------------------------------------Predicts the aceleration on the next timestep. Takes current Aceleration and windForce.
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

		aclResLmt = mathClass.binaryRectFn aclRes -maxConstA maxConstA

		return aclResLmt
	),
	fn posPredFn ItltL IcurrPos IpredDist  = ------------------------------------------------------------------------
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
			if delVarX < 0 do (angYRes = 90 - angYRes)
			if delVarZ < 0 do (angYRes = angYRes+90)
			if (delVarX > 0) and (delVarZ > 0) do (angYRes = 90-angYRes)
		)
		if (delVarX < 0) and (delVarZ < 0) do (angYRes = -angYRes)
		
		hiYRes  = sqrt(hipXZRes^2+delVarY^2)
		angXRes = acos(hipXZRes/hiYRes)
		
		if delVarY > 0 do (angXRes = -angXRes)

		anglesRes = [angXRes,angYRes,0]

		return anglesRes
	),
-- Wind Calculation Functions ---------------------------------------------------------------------------------------
	fn wndFinlTltFn IlayersArr maxWndCnst = --------------------------------------------------------------
	(
		layersArr = IlayersArr
		maxValue  = maxWndCnst
		
		
		foo = 0
		
		for a=1 to layersArr.count do
		(
			foo += layersArr[a]
		)
		
		layersRes = foo/layersArr.count
		
		wndRes = (layersRes)
		
				
		wndFRes = (mathClass.binaryRectFn wndRes -1.0 1.0 )*maxValue

		return wndFRes
	),

	fn wndFinlFn IlayersArr maxWndCnst = -------------------------------------------------------------------I dont realy like this formula, needs urgent care.
	(
		layersArr = IlayersArr
		maxValue  = maxWndCnst
		
		--print 
		foo = 0
		for a=1 to layersArr.count do
		(
			foo += layersArr[a]
		)

		layersRes = foo/layersArr.count

		wndFRes = (mathClass.binaryRectFn layersRes 0 1.0 ) * maxValue

		return wndFRes
	),
	fn windEstimateFn IdstF IDst ISpd IAcl maxWndCnst maxDstCnst maxSpdCnst maxAclCnst = ----------------------------
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
		
		dstFFinal = (mathClass.binaryRectFn (dstFAbsRes) 0 1.0)/4 	
		dstFinal  = (mathClass.binaryRectFn (dstAbsRes) 0 1.0)/4
		spdFinal  = (mathClass.binaryRectFn (spdAbsRes) 0 1.0)/4
		aclFinal  = (mathClass.binaryRectFn (aclAbsRes) 0 1.0)/4

		wndFRes = (dstFFinal+dstFinal+spdFinal+aclFinal)*maxWConst

		return wndFRes
	)
)
