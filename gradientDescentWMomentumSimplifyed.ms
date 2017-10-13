fn unregisterAllTimeCallBacks = 
(
	unregisterTimeCallback windAllDir
	unregisterTimeCallback gLine
)

unregisterAllTimeCallBacks()
--deleteSplineFN()
-- constants
guideAxis = #("X_Red","Y_Green","Z_Blue")
maxAcel = 50.0
maxWindSpdZ = 100.0
maxWindSpdXY = 100.0
topObjSpd = 505.0
maxAcelX = 50.0
maxAcelY = 50.0
maxAcelZ = 50.0
maxSpeedX = 505.0
maxSpeedY = 505.0
maxSpeedZ = 505.0
maxObjSpdArr = #(maxSpeedX,maxSpeedY,maxSpeedZ)
maxAcelArr = #(maxAcelX,maxAcelY,maxAcelZ)
maxWindSpdArr = #(maxWindSpdXY,maxWindSpdXY,maxWindSpdZ)

-- obj Variables

x_force = $x_Force
y_force = $y_Force
z_force = $z_Force
b = $Box003
bDummy = $Dummy001
windArray = #(x_force,y_force,z_force)
windNow=0

-- Counters

counterLine=0
counterLine2=1
counter = 0
counter2 = 0
steps = 15

-- Starting Variables

x_force.strength = 0.0
y_force.strength = 0.0
z_force.strength = 7.0
bPos = b.pos
bDummyPos = bDummy.pos
bPast = 0
bPastArr = #(bPos[1],bPos[2],bPos[3])	
spdNowAbs = #(0,0,0)
acelNowAbs = #(0,0,0)
delta = #(0,0,0)
deltaDirAbs=0
wireColorVar = #(([150,10,10] as color), ([10,150,10] as color),([10,10,150] as color))
abX = $Box_X_Red
abY = $Box_Y_Green
abZ = $Box_Z_Blue
analysisBox = #(abX,abY,abZ)
windDifArr= #(0,0,0) 
--Box Analisys creation

fn boxCreation=
(
	for a = 1 to analysisBox.count do 
	(
		analysisBox[a].wireColor = wireColorVar[a] as color
	)
)

fn boxHeightChange varWind varMaxWind varN arrayBox =
(
	percentage = varWind/varMaxWind
	arrayBox[varN].height = percentage*400
)
-- Layer Integrity check

deltaLayer = #("$DeltaLayer_Node01", "$DeltaLayer_Node02", "$DeltaLayer_Node03", "$DeltaLayer_Node04", "$DeltaLayer_Node05", "$DeltaLayer_Node06", "$DeltaLayer_Node07", "$DeltaLayer_Node08", "$DeltaLayer_Node09", "$DeltaLayer_Node10", "$DeltaLayer_Node11", "$DeltaLayer_Node12", "$DeltaLayer_Node13", "$DeltaLayer_Node14", "$DeltaLayer_Node15", "$DeltaLayer_Node16", "$DeltaLayer_Node17", "$DeltaLayer_Node18", "$DeltaLayer_Node19", "$DeltaLayer_Node20")
acelLayer = #("$AcelLayer_Nodes20", "$AcelLayer_Nodes19", "$AcelLayer_Nodes18", "$AcelLayer_Nodes17", "$AcelLayer_Nodes16", "$AcelLayer_Nodes15", "$AcelLayer_Nodes14", "$AcelLayer_Nodes13", "$AcelLayer_Nodes12", "$AcelLayer_Nodes11", "$AcelLayer_Nodes10", "$AcelLayer_Nodes09", "$AcelLayer_Nodes08", "$AcelLayer_Nodes07", "$AcelLayer_Nodes06", "$AcelLayer_Nodes05", "$AcelLayer_Nodes04", "$AcelLayer_Nodes03", "$AcelLayer_Nodes02", "$AcelLayer_Nodes01")
outputLayer = #("$OutputLayer_Nodes01", "$OutputLayer_Nodes02", "$OutputLayer_Nodes03", "$OutputLayer_Nodes04", "$OutputLayer_Nodes05", "$OutputLayer_Nodes06", "$OutputLayer_Nodes07", "$OutputLayer_Nodes08", "$OutputLayer_Nodes09", "$OutputLayer_Nodes10", "$OutputLayer_Nodes11", "$OutputLayer_Nodes12", "$OutputLayer_Nodes13", "$OutputLayer_Nodes14", "$OutputLayer_Nodes15", "$OutputLayer_Nodes16", "$OutputLayer_Nodes17", "$OutputLayer_Nodes18", "$OutputLayer_Nodes19", "$OutputLayer_Nodes20")
speedLayer = #("$SpeedLayer_Nodes01", "$SpeedLayer_Nodes02", "$SpeedLayer_Nodes03", "$SpeedLayer_Nodes04", "$SpeedLayer_Nodes05", "$SpeedLayer_Nodes06", "$SpeedLayer_Nodes07", "$SpeedLayer_Nodes08", "$SpeedLayer_Nodes09", "$SpeedLayer_Nodes10", "$SpeedLayer_Nodes11", "$SpeedLayer_Nodes12", "$SpeedLayer_Nodes13", "$SpeedLayer_Nodes14", "$SpeedLayer_Nodes15", "$SpeedLayer_Nodes16", "$SpeedLayer_Nodes17", "$SpeedLayer_Nodes18", "$SpeedLayer_Nodes19", "$SpeedLayer_Nodes20")
windLayer = #("$WindSpeed_Node20", "$WindSpeed_Node19", "$WindSpeed_Node18", "$WindSpeed_Node17", "$WindSpeed_Node16", "$WindSpeed_Node15", "$WindSpeed_Node14", "$WindSpeed_Node13", "$WindSpeed_Node12", "$WindSpeed_Node11", "$WindSpeed_Node10", "$WindSpeed_Node09", "$WindSpeed_Node08", "$WindSpeed_Node07", "$WindSpeed_Node06", "$WindSpeed_Node05", "$WindSpeed_Node04", "$WindSpeed_Node03", "$WindSpeed_Node02", "$WindSpeed_Node01")

circleArr = #(deltaLayer,speedLayer,acelLayer,windLayer,outputLayer)

locArr =#()



sumationArr1=0
sumationArr2=0
allSpeedsArray1 = #()
allSpeedsArray2 = #()

--Weights

fn randomGen = (random 0.0 1.0)

fn arrayCreator var= 
(
	var =#()
	for a=1 to 20 do 
	(
		arr=#()
		for b=1 to 20 do
		(
			var2 = randomGen()
			append arr var2
		)
		append var arr
	)
	return var
)

acelWeights= arrayCreator acelWeights
speedWeights= arrayCreator speedWeights
distanceWeights= arrayCreator distanceWeights
windWeights = arrayCreator windWeights

weightX = #(distanceWeights,speedWeights,acelWeights,windWeights)
weightY = #(distanceWeights,speedWeights,acelWeights,windWeights)
weightZ = #(distanceWeights,speedWeights,acelWeights,windWeights)


weights = #(weightX,weightY,weightZ)


fn weightsFunction weights n var= (return weights[n][var])

-- Line Creation

fn lineCreationFunc layerLineArr= 
(
	if layerLineArr == undefined or layerLineArr.count == 0 or (isDeleted layerLineArr[1]) == true do
	(
		layerLineArr=#()
		for arr=1 to b.pos.count do
		(
			LayerLine = splineShape()
			LayerLine.name = ("LayerLine_" + guideAxis[arr])
			layerLine.wirecolor = (wireColorVar[arr] as color)
			addnewSpline LayerLine
			for a=1 to circleArr.count do 
			(
				addKnot LayerLine 1 #corner #line [0,0,0]
			)
			updateShape LayerLine
			append layerLineArr LayerLine
		)
	)
	layerLineArr
)

layerLineArr = lineCreationFunc layerLineArr

-- Limits Handling
	maxWindSpdZ = 50000.0
	maxWindSpdX = 10000.0
	maxWindSpdY = 10000.0
	maxAcelX = 15.0
	maxAcelY = 15.0
	maxAcelZ = 15.0
	maxSpeedX = 15.0
	maxSpeedY = 15.0
	maxSpeedZ = 15.0

fn changingLimits maxObjSpdArr maxAcelArr deltaVar spdPastAbs acelPast n=
(


	maxObjSpdArr = #(maxSpeedX,maxSpeedY,maxSpeedZ)
	maxAcelArr = #(maxAcelX,maxAcelY,maxAcelZ)
	maxWindSpdArr = #(maxWindSpdX,maxWindSpdY,maxWindSpdZ)
	maxWindSpdArr[n] = maxWindSpdArr[n] /( ((limiterFunc spdPastAbs spdPastAbs 1) + (limiterFunc acelPast acelPast 1))/2)
	--print ((maxWindSpdArr) as string)
	--maxAcelArr[n] = limiterFunc (maxAcelArr[n] / abs deltaVar) 1000 1
	--print ((maxAcelArr) as string)
)

-- Order of function activation

-- 1. Basic Variables

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
) 

fn deltaFunc  = ((bDummyPos-bpos)/bDummyPos) --The delta function calculates the distance the box is from the Dummy 

fn spdNowAbsFunc maxObjSpdArr n = ((((bDummyPos-bpast)-(bDummyPos-bpos))/maxObjSpdArr[n])) --This will calculate the delta on position from the previous frame to the current frame and divide by the maximum possible speed.

-- 2. Complex Variables and basic calculations

fn windAbsoluteFunc windForce maxWindSpd= (windForce/maxWindSpd) --This will take the wind strength on the previous frame and divide by the maximum wind for the axis.

fn maxAcelFunc maxAcel = (abs (maxAcel)) -- This will take the possible maximum acelAbseration and multiply by the delta.

fn acelAbsFunc spdPastAbs maxAcelLocal = (((spdPastAbs-((bDummyPos-bpast)-(bDummyPos-bpos)))/maxAcelLocal)) --Calculates the acelAbseration

fn sigmFn InputVar = (1/(1+ e^(-(InputVar as float))))

fn binaryFunc varInput var1 var2 var3 var4 =
(
	if varInput >= var1 do
	(
		varInput = var2
	)
	if varInput < var3 do
	(
		varInput = var4
	)
	return varInput
)

fn rectifierFunc var1 var2 var3 = 
(
	1-(1^(1+var2))
)

fn twoDecimalScaleFunc var1= (formattedprint var1 format:"#.2f")

fn turnInto0to20Func var = 
(
	foo = ((var * 10)+10) as integer
	limiterFunc foo 20 1
)

fn limiterFunc var1 var2 var3 = 
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
)

fn speedPredFunc acelAbs currentSpdAbs=
(
	foo = currentSpdAbs + (currentSpdAbs * acelAbs)
	return (limiterFunc foo 1 -1)
)

fn acelPredFunc acelAbs windNow=
(
	foo = acelAbs + (acelAbs * windNow)
	return (limiterFunc foo 1 -1)
)

fn distPredFunc deltaDirAbs currentSpdAbs=
(
	foo = deltaDirAbs + (deltaDirAbs * currentSpdAbs)
	return (limiterFunc foo 1 -1)
)
fn windDisplacementFn deltaDirAbs currentSpdAbs windAbs n acelAbs= 
(
	if n == 3 do
	(
		foo1 =  binaryFunc (currentSpdAbs*10) 1 0 1 1
		foo2 =  binaryFunc (acelAbs*10) 1 0 1 1
		foo3 = 	binaryFunc (foo1 + foo2) 1 0 1 1
		foo5 =  binaryFunc (deltaDirAbs*10) 1 0 1 1
		foo6 = 	deltaDirAbs * foo5
		foo7 = 	(foo6*foo3)*(maxWindSpdArr[n]/100)
	 	a = foo7
	 	----print (((twoDecimalScaleFunc (foo3)) as string) +"-"+ ((twoDecimalScaleFunc (foo)) as string)+"-"+((twoDecimalScaleFunc foo2) as string)+"-"+((twoDecimalScaleFunc foo3) as string)+"-"+((twoDecimalScaleFunc foo4) as string)+"-"+((twoDecimalScaleFunc a) as string))
	)
	if n != 3 do
	(
		a = 0.0
	)

	a
)
fn windDiferenceFunc deltaDirAbs  currentSpdAbs windAbs n acelAbs=
(
	if n == 3 do
	(
		foo1 =  binaryFunc (currentSpdAbs*10) 1 0 1 1
		foo2 =  binaryFunc (acelAbs*10) 1 0 1 1
		foo3 = 	binaryFunc (foo1 + foo2) 1 0 1 1
		foo5 =  binaryFunc (deltaDirAbs*10) 1 0 1 1
		foo6 = 	deltaDirAbs * foo5
		foo7 = 	(foo6*foo3)*(maxWindSpdArr[n]/100)
	 	a = foo7
	 	----print (((twoDecimalScaleFunc (foo3)) as string) +"-"+ ((twoDecimalScaleFunc (foo)) as string)+"-"+((twoDecimalScaleFunc foo2) as string)+"-"+((twoDecimalScaleFunc foo3) as string)+"-"+((twoDecimalScaleFunc foo4) as string)+"-"+((twoDecimalScaleFunc a) as string))
	)
	if n != 3 do
	(
		a = 0.0
	)

	a
)
-- 3. Weight Calculation

fn getWeightFunc axisN1to3 weightType1to4 currentValue  multiplier1to20 weights= 
(
	
	multiplier1to20 = limiterFunc multiplier1to20 1 -1
	multiplier1to20 = turnInto0to20Func multiplier1to20
	
	currentValue = limiterFunc currentValue 1 -1
	currentValue = turnInto0to20Func currentValue
	


	weights[axisN1to3][weightType1to4][currentValue][multiplier1to20]	
)

fn getWeightArrFunc n currentValues multiplier weights= 
(
	currentWeightsArr = #()
	for a=1 to currentValues.count do 
	(
		currentValuesA = currentValues[a]
		multiplierA = multiplier[a]
		foo = getWeightFunc n a currentValuesA multiplierA weights
		append currentWeightsArr foo
		
		--print ("Step 3.4." + (a as string) + " - Weight" + (a as string) + ": "  + (twoDecimalScaleFunc foo as string))
	)
	currentWeightsArr
)

fn getWeightPos currentValues windAbs windacelAbs maxWindSpd= 
(
	varArr = #()
	for a=1 to currentValues.count do
		(
			currentValue = currentValues[a]
			currentValue = limiterFunc currentValue 1 -1
			currentValue = turnInto0to20Func currentValue
			append varArr currentValue
		)
	foo = limiterFunc windAbs 1 -1
	foo = turnInto0to20Func foo
	append varArr foo
	foo = windacelAbs/maxWindSpd
	foo = limiterFunc foo 1 -1
	foo = turnInto0to20Func foo
	append varArr foo
	varArr
)

fn getPosfromLayerFunc locarr circleArr = 
(
	posArr=#()
	for a=1 to circleArr.count do 
	(
		locArrVal = locArr[a]
		foo = execute circleArr[a][locArrVal]
		----print foo
		foo= foo.pos
		append posArr foo
	)
	posArr
)

fn weightChangerFunc predValueMinus1to1 actualValueMinus1to1 pastValueMinus1to1 axisN1to3 multiplier1to20=
(	
	for a=1 to actualValueMinus1to1.count do 
	(
		currentValuesA = actualValueMinus1to1[a]
		predValuesA = predValueMinus1to1[a]
		pastValuesA = pastValueMinus1to1[a]
		multiplierA = multiplier1to20[a]
		weigthType = a
		
	
		past = limiterFunc pastValuesA 1 -1
		past = turnInto0to20Func past
		--print ("Step 3.3.5." + (a as string) + ".1 - past Node Position : " +(past as string))

		multiplierA = limiterFunc multiplierA 1 -1
		multiplierA = turnInto0to20Func multiplierA
		--print ("Step 3.3.5." + (a as string) + ".2 - multiplier Node Position : " +(multiplierA as string))

		previousWeight = weights[axisN1to3][weigthType][past][multiplierA]
		--print ("Step 3.3.5." + (a as string) + ".3 - previousWeight Value: " +((twoDecimalScaleFunc previousWeight) as string))
		
		foo = sigmFn (previousWeight - (predValuesA-currentValuesA))
		--print ("Step 3.3.5." + (a as string) + ".4 - Weight Change : " +((twoDecimalScaleFunc (predValuesA-currentValuesA)) as string))
		
		weights[axisN1to3][weigthType][past][multiplierA] = (limiterFunc foo 1 -1)
		--print ("Step 3.3.5." + (a as string) + ".5 - New weight applied: " +((twoDecimalScaleFunc (limiterFunc foo 1 -1)) as string))
	)
)


-- 4. Final Complex calculation

fn windacelAbsFunc currentValues maxWindSpd currentWeightsArr currentNames windDisp n windDifArr= 
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
 	print ((n as string) + " " +(twoDecimalScaleFunc (windDisp + windDifArr[n]) as string))
	multiplication = (maxWindSpd * summation) + ((windDisp + windDifArr[n] ))
	print ("Step 4.4.1 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	multiplication = limiterFunc multiplication maxWindSpd -maxWindSpd
	--print ("Step 4.5.2 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	return multiplication
	
) --Final calculation to find the ideal wind speed for each axis.

-- Functions defined by object
fn windAllDir = 
(
	--print ("Frame : " + (sliderTime as string))

	if nvpx.IsSimulating() == true do
	(

		counter +=1
		--print ( "Counter: " +(Counter as string) )
		
		for n=1 to b.Pos.count do
		(

			--print ("Starting with N = " + (n as string))


			/* 
				Get the variables from each angle, 1=X, 2=Y and 3=Z. 
				The X and Y have the same maxWind speed and Z has a higher one as it has to account for gravity. 
				Then for last we will assign the speed of the last frame as spdPastAbs.
			*/

			


			bDummyPos = bDummy.pos[n]
			--print ("Step 1.1.1 - bDummyPos : "  + (twoDecimalScaleFunc bDummyPos as string))
			
			bPos = b.pos[n]
			--print ("Step 1.1.2 - bPos : "  + (twoDecimalScaleFunc bPos as string))
			
			bPast = bPastArr[n]
			--print ("Step 1.1.3 - bPast : "  + (twoDecimalScaleFunc bPast as string))

			deltaPast = delta[n]
			--print ("Step 1.2 - deltaPast : "  + (twoDecimalScaleFunc deltaPast as string)) 

			acelPast = acelNowAbs[n]
			--print ("Step 1.3 - acelPast : "  + (twoDecimalScaleFunc acelPast as string))
			
			maxWindSpd = maxWindSpdArr[n]
			--print ("Step 1.4 - maxWindSpd : "  + (twoDecimalScaleFunc maxWindSpd as string))
			
			spdPastAbs = spdNowAbs[n]
			--print ("Step 1.5 - spdPastAbs : "  + (twoDecimalScaleFunc spdPastAbs as string))

			
			
			windNow =  windArray[n].strength
			--print ("Step 1.6.1 - windNow : "  + (twoDecimalScaleFunc windNow as string))

			
				
			/*
				In here we will use some functions to get the wind from used in the last frame.
				Then the delta of the position from the last frame to now.
			*/


			windForce = limiterFunc windNow maxWindSpd -maxWindSpd
			--print ("Step 1.6.2 - WindForce : "  + (twoDecimalScaleFunc WindForce as string))
			
			delta[n] = deltaFunc()
			--print ("Step 1.8.1 - delta[n] : "  + (twoDecimalScaleFunc delta[n] as string))
			
			deltaDirAbs = delta[n]
			--print ("Step 1.8.2 - deltaDirAbs : "  + (twoDecimalScaleFunc deltaDirAbs as string))
			
			/*
				In here we will calculate the maximum acelAbseration which will take in consideration the distance from the target, the furthest from the target, the faster the acceleration can be.
				We also calculate the absolute windforce from the wind in the previous frame.
				We calculate the change in speed from last frame to this one.
				Finaly we calculate the speed in the current frame. 
			*/

			changingLimits maxObjSpdArr maxAcelArr deltaDirAbs spdPastAbs acelPast n

			maxAcelLocal = maxAcelArr[n]
			--print ("Step 1.9 - maxAcelLocal : " +(twoDecimalScaleFunc maxAcelLocal as string))
			
			windAbs = windAbsoluteFunc windForce maxWindSpd
			--print ("Step 2.1 - windAbs : " +(twoDecimalScaleFunc windAbs as string))
			
			acelAbs = acelAbsFunc spdPastAbs maxAcelLocal
			--print ("Step 2.2 - acelAbs : " +(twoDecimalScaleFunc acelAbs as string))

			acelNowAbs[n] = abs acelAbs
			--print ("Step 2.3 - acelNowAbs[n] : " +(twoDecimalScaleFunc acelNowAbs[n] as string))
			
			spdNowAbs[n] = spdNowAbsFunc maxObjSpdArr n
			--print ("Step 2.4 - spdNowAbs[n] : " +(twoDecimalScaleFunc spdNowAbs[n] as string))
			
			currentSpdAbs = spdNowAbs[n]
			--print ("Step 2.5 - currentSpdAbs : " +(twoDecimalScaleFunc currentSpdAbs as string))

			/*
			
			After we calculated all of the current atributes, we can use that information to predict the atributes in the next timeStep.

			*/

			deltaPred = distPredFunc deltaDirAbs currentSpdAbs
			--print ("Step 3.1.1 - deltaPred : " +(twoDecimalScaleFunc deltaPred as string))

			speedPred = speedPredFunc acelAbs currentSpdAbs
			--print ("Step 3.1.2 - speedPred : " +(twoDecimalScaleFunc speedPred as string))
			
			acelPred = acelPredFunc acelAbs windNow
			--print ("Step 3.1.3 - acelPred : " +(twoDecimalScaleFunc acelPred as string))

			windDisp = windDisplacementFn deltaDirAbs currentSpdAbs windAbs n acelAbs
			--print ("Step 3.1.4 - windDisp : " +(twoDecimalScaleFunc windDisp as string))
			
			/*

			Now we will calculate the derivative of the weights and balance it agains our predictions.
		
			*/
			currentNames = #("Direction", "Speed" , "Aceleration", "Wind")

			currentValues = #(deltaDirAbs,currentSpdAbs,acelAbs,windAbs)
			--print ("Step 3.3.1 - currentValues : " +(currentValues as string))
			predValues = #(deltaPred,speedPred,acelPred,windDisp)
			--print ("Step 3.3.2 - predValues : " +(predValues as string))
			pastValues = #(deltaPast,spdPastAbs,acelPast,windDisp)
			--print ("Step 3.3.3 - pastValues : " +(pastValues as string))
			multiplier = #(speedPred,acelPred,windAbs,deltaDirAbs)
			--print ("Step 3.3.4 - multiplier : " +(multiplier as string))

			weightChangerFunc predValues currentValues pastValues n multiplier
			
			/*
			
			This here will get the weigths.

			*/

			currentWeightsArr = getWeightArrFunc n currentValues multiplier weights

			/*
				The function windacelAbsFunc takes all of the variables previously and calculates them to find the optimal wind speed to reach the target.
			*/

			windDifArr[n] = windDifArr[n] + (windDiferenceFunc deltaDirAbs  currentSpdAbs windAbs n acelAbs)

			windacelAbs = windacelAbsFunc currentValues maxWindSpd currentWeightsArr currentNames windDisp n windDifArr
			
			
			windArray[n].strength = windacelAbs
			--print ("Step 5.2 - windacelAbs: " + ((twoDecimalScaleFunc windacelAbs) as string))

			
			
			locArr = getWeightPos currentValues windAbs windacelAbs maxWindSpd
			--print ("Step 6.1 locArr: " + ( locArr as string))	
			
			posArr = getPosfromLayerFunc locarr circleArr
			--print ("Step 6.2 posArr: " + ( posArr as string))
			
			splinePositioner posArr layerLineArr n

			boxHeightChange windacelAbs maxWindSpd N analysisBox

			--print ("Step 6.3 Spline: Done")

			--print ("Done with N = " + (n as string))
		)

		bPastArr = #(b.Pos[1],b.Pos[2],b.Pos[3])
		--print ("Step 7.1 bPastArr: " + ( bPastArr as string))	
		--displayInfo delta spdNowAbs windArray 
		
	)
)

-- Information and display Functions

fn getPosfromLayer circleArr locArr = 
(
	posArr = #()
	for a=1 to circleArr.count do
	(
		foo = execute layerArr[a][a]
		append posArr (foo.pos)
	)
	posArr
)

fn splinePositioner posArr layerLineArr n= 
(
 	if layerLineArr != undefined do
 	(
 		layerLine = layerLineArr[n]
 		for a=1 to posArr.count do
 		(
 			setKnotPoint LayerLine 1 a posArr[a] 
 		)
 		updateShape LayerLine
 	)

)

/*  fn displayInfo delta spdNowAbs windArray = 
(

	windAbsoluteX = twoDecimalScaleFunc windArray[1].strength
	windAbsoluteY = twoDecimalScaleFunc windArray[2].strength
	windAbsoluteZ = twoDecimalScaleFunc windArray[3].strength
	distX = twoDecimalScaleFunc delta[1]
	distY = twoDecimalScaleFunc delta[2]
	distZ = twoDecimalScaleFunc delta[3]
	spdNowAbsX = twoDecimalScaleFunc spdNowAbs[1]
	spdNowAbsY = twoDecimalScaleFunc spdNowAbs[2]
	spdNowAbsZ = twoDecimalScaleFunc spdNowAbs[3]
	format "TC: %." sliderTime
	format "Wstr: %X,%Y,%Z." windAbsoluteX windAbsoluteY windAbsoluteZ
	format "Dlt: %X,%Y,%Z ." distX distY distZ
	format "Spd: %X,%Y,%Z .\n" spdNowAbsX spdNowAbsY spdNowAbsZ
)
 */


/* 
fn gLine = 
(
	counterLine += 1

 	if newLine == undefined do
 	(
  		newLine = splineShape ()
  		newLine.name = "NewLine"
  		addnewSpline newLine
  		addKnot newLine 1 #corner #line b.pos
		addKnot newLine 1 #corner #line bDummy.pos
 	)
	setKnotPoint newLine 1 1 b.pos
	setKnotPoint newLine 1 2 bDummy.pos
	updateShape newLine

 	 if newLine2 == undefined do
 	(
  		newLine2 = splineShape ()
  		newLine2.name = "NewLine2"
  		addnewSpline newLine2
  		addKnot newLine2 1 #smooth #line b.pos
 	)

 	if sliderTime > 1 do
 	(
	 	addKnot newLine2 1 #smooth #line b.pos
	  	updateShape newLine2
	)
 	
  	if counterLine == steps do
  	(
	  	if newline3 == undefined do
	  	(
	  		newLine3 = splineShape()
	  		newLine3.name = "NewLine3"
	  	)
	  	
	  	addNewSpline newLine3
	  	addKnot newLine3 counterLine2 #corner #line b.pos
	  	addknot newLine3 counterLine2 #corner #line bDummy.pos
	  	updateShape newLine3
	  	counterLine = 0
	  	counterLine2 +=1
	 ) 

  	--if sliderTime == 0 do (deleteSplineFN())
) 
fn deleteSplineFN = 
(
	if newline != undefined do 
	(
		delete newLine
		newLine = undefined
	)
	if newLine2 != undefined do
	(
		delete newLine2
		newLine2 = undefined
	)
	if newLine3 != undefined do
	(
		delete newLine3
		newLine3 = undefined
	)
)
*/
-- Register and unregister Callbacks


registerTimeCallback windAllDir
--registerTimeCallback gLine
