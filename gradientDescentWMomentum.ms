-- constants

maxAcel = 10.0
maxWindSpd = 5
maxWindSpdXY = 1
topObjSpd = 100
maxWindSpdArr = #(maxWindSpdXY,maxWindSpdXY,maxWindSpd)

-- obj Variables

x_force = $y_Force
z_force = $z_Force
y_force = $y_Force
b = $Box003
bDummy = $Dummy001
windArray = #(x_force,y_force,z_force)

-- Counters

counterLine=0
counterLine2=1
counter = 0
counter2 = 0
steps = 15

-- Starting Variables

windForceX = x_Force.strength
windForceY = y_Force.strength
windForceZ = z_Force.strength

bXpos = b.pos[1]
bYpos = b.pos[2]
bZpos = b.pos[3]

bXpast = bXpos
bYpast = bYpos
bZpast = bZpos

bDummyXpos = bDummy.pos[1]
bDummyYpos = bDummy.pos[2]
bDummyZpos = bDummy.pos[3]

speedNowX = (bXpos-bXpast)/topObjSpd
speedNowY = (bYpos-bYpast)/topObjSpd
speedNowZ = (bZpos-bZpast)/topObjSpd

sumationArr1=0
sumationArr2=0
allSpeedsArray1 = #()
allSpeedsArray2 = #()

-- Order of function activation

-- 1. Basic Variables

fn windForceFunc windVar = (windVar.strength)

fn deltaFunc bpos bDummyPos = ((bpos-bDummypos)/bDummyPos)

fn speedNowFunc bpos bpast topObjSpd = ((bpos-bpast)/topObjSpd)

-- 2. Complex Variables and basic calculations

fn windAbsoluteFunc windForce maxWindSpd = (windForce/maxWindSpd)

fn maxAcelFunc maxAcel delta= (maxAcel*delta)

fn acelFunc speedNow bpos bpast maxAcelLocal = ((speedNow-(bpos-bpast))/maxAcelLocal)

-- 3. Final Complex calculation

fn windAcelFunc speedNow windAbs acel delta maxWindSpdArr = (((speedNow + (windAbs +acel ) ) / delta ) * maxWindSpdArr)


-- Functions defined by object
fn windAllDir = 
(
	if nvpx.IsSimulating() == true do
	(

		counter +=1

		for n=1 to bPos.count do
		(
			bDummyPos = bDummy.pos[n]
			bPos = b.pos[n]
			bPast = bPastArr[n]
			maxWindSpd = maxWindSpdArr[n]

			windForce = windForceFunc windArray
			
			delta = deltaFunc bPos bDummyPos

			speedNow = speedNowFunc bPos bPast topObjSpd

			maxAcelLocal = maxAcelFunc maxAcel delta
			
			windAbs = windAbsoluteFunc windForce maxWindSpd
			
			acel = acelFunc speedNow bPos bPast maxAcelLocal
			
			
			


			/* if acel > maxAcelLocal do (acel = maxAcelLocal)
			if acel < -maxAcelLocal do (acel = -maxAcelLocal)
			if acel == 0.0 then (windacel = maxAcelLocal)
			else  (windacel = (acel/windAbs)) */

			windacel = windAcelFunc speedNow windAbs acel delta maxWindSpd

			if (delta) < 0.0 or (delta) > 1.5 do
			(
				--if acelX == 0.0 do (windacelX = maxAcel)
				windForce = -windacel
				--append allSpeedsArray1 delta
				if windForce > maxWindSpd do
				(
					windForce = maxWindSpd
				)
				if windForce < -maxWindSpd do
				(
					windForce = -maxWindSpd
				)
				
			)
			
			windArray[n].strength = windForce

			counter = 0
		)
		bPastArr = #(bPos[1],bPos[2],bPos[3])	
		
	)
)
/* fn windXAxis = 
(
	if nvpx.IsSimulating() == true do
	(

		counter +=1

		if counter == 1 do
		(
			bDummyXpos = bDummy.pos[1]
			bXpos = b.pos[1]
			windForceX = windForceFn x_force
			maxAcel = maxAcelFun maxAcel deltaX
			deltaX = delta bXpos bDummyXpos
			windAbsoluteX = windAbsolute windForceX maxWindSpdXY
			acelX = acelFunc speedNowX bXpos bXpast maxAcel
			speedNowX = speedNow bXpos bXpast topObjSpd
			bXpast = bXpos
			


			if acelX > maxAcel do (acelX = maxAcel)
			if acelX < -maxAcel do (acelX = -maxAcel)
			if acelX == 0.0 then (windacelX = maxAcel)
			else  (windacelX = (acelX/windAbsoluteX))

			windacelX = windAcelFunc speedNowX windAbsoluteX acelX deltaX maxWindSpd

			if (bXpos/bDummyXpos) < 1.0 do 
			(
				--if acelX == 0.0 do (windacelX = maxAcel)
				
				if acelX == 0.0 do (windacelX = maxAcel)
				if windacelX < 0 do (windacelX = -windacelX)
				windForceX = windacelX
				append allSpeedsArray1 deltaX
				if windForceX > maxWindSpdXY do
				(
					windForceX = maxWindSpdXY
				)
				if windForceX < -maxWindSpdXY do
				(
					windForceX = -maxWindSpdXY
				)
				
			)
			if (bXpos/bDummyXpos) == 0.0 do (windForceX = 0.0)
			if (bXpos/bDummyXpos) > 1.0 do
			(
				--if acelX == 0.0 do (windacelX = -maxAcel)
				windacelX = (((speedNowX)+(windAbsoluteX+acelX))/deltaX)*maxWindSpdXY
				if acelX == 0.0 do (windacelX = -maxAcel)
				if windacelX < 0.0 do (windacelX = -windacelX)
				windForceX = windacelX
				append allSpeedsArray2 deltaX
			 	if windForceX > maxWindSpdXY do
				(
					windForceX = maxWindSpdXY
				)
				if windForceX < -maxWindSpdXY do
				(
					windForceX = -maxWindSpdXY
				) 
				
			) 
			

			x_Force.strength = windForceX

			counter = 0
		)	
		
	)
)
fn windYAxis = 
(
	if nvpx.IsSimulating() == true do
	(
		
		counter +=1
		if counter == 1 do
		(
			bYpos = b.pos[2]
			bDummyYpos = bDummy.pos[2]
			windAbsoluteY = (windForceY/maxWindSpdXY)
			acelY = ((speedNowY-(bYpos-bYpast)))/maxAcel
			speedNowY = (bYpos-bYpast)/topObjSpd
			bYpast = bYpos
			deltaY = (bYpos-bDummyYpos)/bDummyYpos
			if acelY > maxAcel do (acelY = maxAcel)
			if acelY < -maxAcel do (acelY = -maxAcel)
			if acelY == 0.0 then (windacelY = maxAcel)
			else  (windacelY = (acelY/windAbsoluteY))
			if (bYpos/bDummyYpos) < 1.0 do 
			(
				--if acelY == 0.0 do (windacelY = maxAcel)
				windacelY = (((speedNowY)+(windAbsoluteY+acelY))/deltaY)*maxWindSpdXY
				if acelY == 0.0 do (windacelY = maxAcel)
				if windacelY < 0 do (windacelY = -windacelY)
				windForceY = windacelY
				append allSpeedsArray1 deltaY
				if windForceY > maxWindSpdXY do
				(
					windForceY = maxWindSpdXY
				)
				if windForceY < -maxWindSpdXY do
				(
					windForceY = -maxWindSpdXY
				)
				
			)
			if (bYpos/bDummyYpos) == 0.0 do (windForceY = 0.0)
			if (bYpos/bDummyYpos) > 1.0 do
			(
				--if acelY == 0.0 do (windacelY = -maxAcel)
				windacelY = (((speedNowY)+(windAbsoluteY+acelY))/deltaY)*maxWindSpdXY
				if acelY == 0.0 do (windacelY = -maxAcel)
				--if windacelY < 0.0 do (windacelY = -windacelY)
				windForceY = windacelY
				append allSpeedsArray2 deltaY
			 	if windForceY > maxWindSpdXY do
				(
					windForceY = maxWindSpdXY
				)
				if windForceY < -maxWindSpdXY do
				(
					windForceY = -maxWindSpdXY
				) 
				
			) 
			

			y_Force.strength = windForceY

			 
			counter = 0
		)	
		
	)
)
fn windZAxis = 
(
	if nvpx.IsSimulating() == true do
	(
		
		counter +=1
		if counter == 1 do
		(
			bZpos = b.pos[3]
			bDummyZpos = bDummy.pos[3]
			windAbsoluteZ = (windForceZ/maxWindSpd)
			acelZ = ((speedNowZ-(bZpos-bZpast)))/maxAcel
			speedNowZ = (bZpos-bZpast)/topObjSpd
			bZpast = bZpos
			deltaZ = (bZpos-bDummyZpos)/bDummyZpos
			if acelZ > maxAcel do (acelZ = maxAcel)
			if acelZ < -maxAcel do (acelZ = -maxAcel)
			if acelZ == 0.0 then (windacelZ = maxAcel)
			else  (windacelZ = (acelZ/windAbsoluteZ))
			if (bZpos/bDummyZpos) < 1.0 do 
			(
				windacelZ = (((speedNowZ)+(windAbsoluteZ+acelZ))/deltaZ)*maxWindSpd
				if acelZ == 0.0 do (windacelZ = maxAcel)
				if windacelZ < 0 do (windacelZ = -windacelZ)
				windForceZ = windacelZ
				append allSpeedsArray1 deltaZ
				if windForceZ > maxWindSpd do
				(
					windForceZ = maxWindSpd
				)
				if windForceZ < -maxWindSpd do
				(
					windForceZ = -maxWindSpd
				)
				
			)
			if (bZpos/bDummyZpos) == 0.0 do  (windForceZ = 0.0)
			if (bZpos/bDummyZpos) > 1.0 do
			(
				windacelZ = (((speedNowZ)+(windAbsoluteZ+acelZ))/deltaZ)*maxWindSpd
				if acelZ == 0.0 do (windacelZ = -maxAcel)
				windForceZ = windacelZ
				append allSpeedsArray2 deltaZ
			 	if windForceZ > maxWindSpd do
				(
					windForceZ = maxWindSpd
				)
				if windForceZ < -maxWindSpd do
				(
					windForceZ = -maxWindSpd
				) 
				
			) 
			

			z_Force.strength = windForceZ
			 
			counter = 0
		)	
		
	)
) */

-- Information and display Functions

fn displayInfo = 
(
	deltaX = (bXpos-bDummyXpos)/bDummyXpos
	deltaY = (bYpos-bDummyYpos)/bDummyYpos
	aUnderZ =abs (bDummyZpos-(bDummyZpos-bZpos))/bDummyZpos
	windAbsoluteX = x_Force.strength/maxWindSpdXY
	windAbsoluteY = y_Force.strength/maxWindSpdXY
	windAbsoluteZ = z_Force.strength/maxWindSpd
	format "Wstr: %X,%Y,%Z." windAbsoluteX windAbsoluteY windAbsoluteZ
	format "Deltas: %X,%Y,%Z ." deltaX deltaY deltaZ
	format "Acc at: %X,%Y,%Z .\n" speedNowX speedNowY speedNowZ
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

fn unregisterAllTimeCallBacks = (
	unregisterTimeCallback windAllDir
/* 	unregisterTimeCallback windXAxis
	unregisterTimeCallback windYAxis
	unregisterTimeCallback windZAxis */
	unregisterTimeCallback displayInfo
	unregisterTimeCallback gLine
	)

unregisterAllTimeCallBacks()
deleteSplineFN()

registerTimeCallback windAllDir
/* registerTimeCallback windXAxis
registerTimeCallback windYAxis
registerTimeCallback windZAxis */
registerTimeCallback displayInfo
registerTimeCallback gLine