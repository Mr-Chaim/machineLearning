-- constants

maxAcel = 10.0
maxWindSpdZ = 5.0
maxWindSpdXY = 1.0
topObjSpd = 100
maxWindSpdArr = #(maxWindSpdXY,maxWindSpdXY,maxWindSpdZ)

-- obj Variables

x_force = $y_Force
z_force = $z_Force
y_force = $y_Force
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

x_force.strength = 1.0
y_force.strength = 1.0
z_force.strength = 1.0
bPos = b.pos
bDummyPos = bDummy.pos
bPast = 0
bPastArr = #(bPos[1],bPos[2],bPos[3])	
speedNow = #(0,0,0)
delta = #(0,0,0)
deltaDir=0



sumationArr1=0
sumationArr2=0
allSpeedsArray1 = #()
allSpeedsArray2 = #()

-- Order of function activation

-- 1. Basic Variables

fn windForceFunc  = (windNow.strength) --This function takes the strength of the selected wind on the windArray
fn deltaFunc  = ((bpos-bDummypos)/bDummyPos) --The delta function calculates the distance the box is from the Dummy 
fn speedNowFunc  = ((bpos-bpast)/topObjSpd) --This will calculate the delta on position from the previous frame to the current frame and divide by the maximum possible speed.

-- 2. Complex Variables and basic calculations

fn windAbsoluteFunc windForce maxWindSpd= (windForce/maxWindSpd) --This will take the wind strength on the previous frame and divide by the maximum wind for the axis.
fn maxAcelFunc maxAcel = (maxAcel*deltaDir) -- This will take the possible maximum aceleration and multiply by the delta.
fn acelFunc speedPast maxAcelLocal = ((speedPast-(bpos-bpast))/maxAcelLocal) --Calculates the Aceleration

-- 3. Final Complex calculation

fn windAcelFunc windAbs acel currentSpeed deltaDir maxWindSpd= 
(
	a1 = windAbs + acel 
	print ("Step 4.1 - a1 : "  + (a1 as string))
	a2 = a1 + currentSpeed
	print ("Step 4.2 - a2 : "  + (a2 as string))
	a3 = a2 / deltaDir
	print ("Step 4.3 - a3 : "  + (a3 as string))
	a4 = maxWindSpd * a3
	print ("Step 4.4 - a4 : "  + (a4 as string))
	return a4
	--((currentSpeed + (windAbs + acel) ) / deltaDir) * maxWindSpd
) --Final calculation to find the ideal wind speed for each axis.

-- Functions defined by object
fn windAllDir = 
(
	print ("Frame :" + (sliderTime as string))

	if nvpx.IsSimulating() == true do
	(

		counter +=1
		print ( "Counter: " +(Counter as string) )
		
		for n=1 to b.Pos.count do
		(
			print ("Starting with N = " + (n as string))
			/* 
				Get the variables from each angle, 1=X, 2=Y and 3=Z. 
				The X and Y have the same maxWind speed and Z has a higher one as it has to account for gravity. 
				Then for last we will assign the speed of the last frame as speedPast.
			*/
			bDummyPos = bDummy.pos[n]
			print ("Step 1.1 - bDummyPos : "  + (bDummyPos as string))
			
			bPos = b.pos[n]
			print ("Step 1.2 - bPos : "  + (bPos as string))
			
			bPast = bPastArr[n]
			print ("Step 1.3 - bPast : "  + (bPast as string))
			
			maxWindSpd = maxWindSpdArr[n]
			print ("Step 1.4 - maxWindSpd : "  + (maxWindSpd as string))
			
			speedPast = speedNow[n]
			print ("Step 1.5 - speedPast : "  + (speedPast as string))
			
			windNow =  windArray[n]
			print ("Step 1.6 - windNow : "  + (windNow as string))
			
			/*
				In here we will use some functions to get the wind from used in the last frame.
				Then the delta of the position from the last frame to now.
			*/
			windForce = windForceFunc()
			print ("Step 2.1 - WindForce : "  + (WindForce as string))
			
			delta[n] = deltaFunc()
			print ("Step 2.2 - delta[n] : "  + (delta[n] as string))
			
			deltaDir = delta[n]
			print ("Step 2.3 - deltaDir : "  + (deltaDir as string))
			
			--print "Step 3"
			/*
				In here we will calculate the maximum aceleration which will take in consideration the distance from the target, the furthest from the target, the faster the acceleration can be.
				We also calculate the absolute windforce from the wind in the previous frame.
				We calculate the change in speed from last frame to this one.
				Finaly we calculate the speed in the current frame. 
			*/
			maxAcelLocal = maxAcelFunc maxAcel 
			print ("Step 3.1 - maxAcelLocal : " +( maxAcelLocal as string))
			
			windAbs = windAbsoluteFunc windForce maxWindSpd
			print ("Step 3.2 - windAbs : " +( windAbs as string))
			
			acel = acelFunc speedPast maxAcelLocal
			print ("Step 3.3 - acel : " +( acel as string))
			
			speedNow[n] = speedNowFunc()
			print ("Step 3.4 - speedNow[n] : " +( speedNow[n] as string))
			
			currentSpeed = SpeedNow[n]
			print ("Step 3.5 - currentSpeed : " +( currentSpeed as string))

			/*
				The function windAcelFunc takes all of the variables previously and calculates them to find the optimal wind speed to reach the target.
			*/

			windacel = windAcelFunc windAbs acel currentSpeed deltaDir maxWindSpd
			print ("Step 5.1 - windacel: " + ((windacel) as string))
			
		 	if windacel >= maxWindSpd do
			(
				print ("Step 5.1.2 - windacel higher by : " + ((windacel - maxWindSpd) as string))
				windacel = maxWindSpd
			)
			if windacel <= -maxWindSpd do
			(
				print ("Step 5.1.3 - windacel lower by : " + ((windacel + maxWindSpd) as string))
				windacel = -maxWindSpd
			)
			print ("Done with N = " + (n as string))
			
			windNow.strength = windacel

			
		)

		bPastArr = #(b.Pos[1],b.Pos[2],b.Pos[3])
		print ("Step 6.1 bPastArr: " + (bPastArr as string))
		gLine()	
		--displayInfo delta speedNow windArray
	)
)

-- Information and display Functions

 fn displayInfo delta speedNow windArray = 
(

	windAbsoluteX = windArray[1].strength
	windAbsoluteY = windArray[2].strength
	windAbsoluteZ = windArray[3].strength
	format "Wstr: %X,%Y,%Z." windAbsoluteX windAbsoluteY windAbsoluteZ
	format "Deltas: %X,%Y,%Z ." delta[1] delta[2] delta[3]
	format "Speed at: %X,%Y,%Z .\n" speedNow[1] speedNow[2] speedNow[3]
)
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
  	if sliderTime == 0 do (deleteSplineFN())
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
-- Register and unregister Callbacks

fn unregisterAllTimeCallBacks = 
(
	unregisterTimeCallback windAllDir
	--unregisterTimeCallback autoUnregister
	/* unregisterTimeCallback displayInfo
	unregisterTimeCallback gLine */
)

unregisterAllTimeCallBacks()
fn autoUnregister =
(
	if sliderTime == 0 do (unregisterAllTimeCallBacks())
)

if sliderTime == 0 do (deleteSplineFN())
--
autoUnregister()
registerTimeCallback windAllDir
--registerTimeCallback autoUnregister
/* registerTimeCallback displayInfo
registerTimeCallback gLine */