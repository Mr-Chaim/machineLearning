--Final Calculation function


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
 	--print ((n as string) + " " +(twoDecimalScaleFunc (windDisp + windDifArr[n]) as string))
	multiplication = (maxWindSpd * summation) + ((windDisp + windDifArr[n] ))
	--print ("Step 4.4.1 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	multiplication = limiterFunc multiplication maxWindSpd -maxWindSpd
	--print ("Step 4.5.2 - multiplication : "  + (twoDecimalScaleFunc multiplication as string))
	return multiplication
	
) --Final calculation to find the ideal wind speed for each axis.

struct windClass
(
	deltaActVal = [0,0,0],
	speedActVal = [0,0,0],
	AcelActVal = [0,0,0],
	tiltActVal = [0,0,0],

	deltaCurW = [0,0,0],
	speedCurW = [0,0,0],
	acelCurW = [0,0,0],
	tiltCurW = [0,0,0],

	fn update valueStoreClass weightClass=
	(
		deltaActVal = vClass.deltaActVal
		speedActVal = vClass.speedActVal
		AcelActVal = vClass.AcelActVal
		tiltActVal = vClass.tiltActVal

		deltaCurW = wClass.deltaCurW
		speedCurW = wClass.speedCurW
		acelCurW = wClass.acelCurW
		tiltCurW = wClass.tiltCurW
	),

	fn calculate = 
	(

	)

	private

	wClass = weightClass
	vClass = valueStoreClass
)
