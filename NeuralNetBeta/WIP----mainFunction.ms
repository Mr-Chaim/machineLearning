



if nvpx.IsSimulating() == true do
(
	if slidertime == 1 do (counter = 1)
	dummyPositioner counter
	if counter > steps do (counter = 0)
	counter +=1
	print ( "Counter: " +(Counter as string) )
	
	for n=1 to b.Pos.count do
	(

		--print ("Starting with N = " + (n as string))


		/* 
			Get the variables from each tilt, 1=X, 2=Y and 3=Z. 
			The X and Y have the same maxWind speed and Z has a higher one as it has to account for gravity. 
			Then for last we will assign the speed of the last frame as spdPastAbs.
		*/

		/*
			In here we will use some functions to get the wind from used in the last frame.
			Then the delta of the position from the last frame to now.
		*/
		
		/*
			In here we will calculate the maximum acelAbseration which will take in consideration the distance from the target, the furthest from the target, the faster the acceleration can be.
			We also calculate the absolute windforce from the wind in the previous frame.
			We calculate the change in speed from last frame to this one.
			Finaly we calculate the speed in the current frame. 
		*/

		--changingLimits maxObjSpdArr maxAcelArr deltaDirAbs spdPastAbs acelPast n

		/*
		
		After we calculated all of the current atributes, we can use that information to predict the atributes in the next timeStep.
		*/


		
		/*
		Now we will calculate the derivative of the weights and balance it agains our predictions.
	
		*/


		
		/*
		
		This here will get the weigths.
		*/



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

		splineObjPositioner bDummy dummyLinesArr n
		
		splineObjPositioner b boxLinesArr n

		boxHeightChange windacelAbs maxWindSpd N analysisBox

		--print ("Step 6.3 Spline: Done")

		--print ("Done with N = " + (n as string))
	)

	bPastArr = #(b.Pos[1],b.Pos[2],b.Pos[3])
	--print ("Step 7.1 bPastArr: " + ( bPastArr as string))	
	--displayInfo delta spdNowAbs windArray 
	
)
