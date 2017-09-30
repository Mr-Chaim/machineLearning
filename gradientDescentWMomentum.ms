maxAcceleration = 100/10
gForce1 = random 0.1 1.0
gForce2 = random 0.1 1.0
x_force = $y_Force
z_force = $z_Force
y_force = $y_Force
b = $Box003
bDummy = $Dummy001
counterLine=0
maxSpeed = 5
maxSpeedXY = 1
topSpeed = 100
windForceX = x_Force.strength
windForceY = y_Force.strength
windForceZ = z_Force.strength
counter = 0
counter2 = 0
bXpos = b.pos[1]
bYpos = b.pos[2]
bZpos = b.pos[3]
bXpast = bXpos
bYpast = bYpos
bZpast = bZpos
bDummyXpos = bDummy.pos[1]
bDummyYpos = bDummy.pos[2]
bDummyZpos = bDummy.pos[3]
speedNowX = (bXpos-bXpast)/topSpeed
speedNowY = (bYpos-bYpast)/topSpeed
speedNowZ = (bZpos-bZpast)/topSpeed
steps = 5
sumationArr1=0
sumationArr2=0
allSpeedsArray1 = #()
allSpeedsArray2 = #()
fn unregisterAllTimeCallBacks =
(
	unregisterTimeCallback windXAxis
	unregisterTimeCallback windYAxis
	unregisterTimeCallback windZAxis
	unregisterTimeCallback displayInfo
	unregisterTimeCallback gLine
)
unregisterAllTimeCallBacks()
deleteSplineFN()
fn windXAxis = 
(
	if nvpx.IsSimulating() == true do
	(

		counter +=1
		if counter == 1 do
		(
			bDummyXpos = bDummy.pos[1]
			bXpos = b.pos[1]
			windAbsoluteX = (windForceX/maxSpeedXY)
			acelX = ((speedNowX-(bXpos-bXpast)))/maxAcceleration
			speedNowX = (bXpos-bXpast)/topSpeed
			bXpast = bXpos
			if acelX > maxAcceleration do (acelX = maxAcceleration)
			if acelX < -maxAcceleration do (acelX = -maxAcceleration)
			if acelX == 0.0 then (windacelX = maxAcceleration)
			else  (windacelX = (acelX/windAbsoluteX))
			if (bXpos/bDummyXpos) < 1.0 do 
			(
				--if acelX == 0.0 do (windacelX = maxAcceleration)
				aUnderX = (bDummyXpos-(bDummyXpos-bXpos))/bDummyXpos
				windacelX = (((speedNowX)+(windAbsoluteX+acelX))/aUnderX)*maxSpeedXY
				if acelX == 0.0 do (windacelX = maxAcceleration)
				if windacelX < 0 do (windacelX = -windacelX)
				windForceX = windacelX
				append allSpeedsArray1 aUnderX
				--format "1.Bpos: %. Dpos: %. Wstr: % , wacelX: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" bXpos bDummyXpos windAbsoluteX (windacelX/maxSpeedXY) aUnderX (acelX) speedNowX gforce1
				if windForceX > maxSpeedXY do
				(
					windForceX = maxSpeedXY
				)
				if windForceX < -maxSpeedXY do
				(
					windForceX = -maxSpeedXY
				)
				
			)
			if (bXpos/bDummyXpos) == 0.0 do  (windForceX = 0.0)
			if (bXpos/bDummyXpos) > 1.0 do
			(
				--if acelX == 0.0 do (windacelX = -maxAcceleration)
				aOverX =  (bDummyXpos-(bXpos-bDummyXpos))/bDummyXpos
				windacelX = (((speedNowX)+(windAbsoluteX+acelX))/aOverX)*maxSpeedXY
				if acelX == 0.0 do (windacelX = -maxAcceleration)
				--if windacelX < 0.0 do (windacelX = -windacelX)
				windForceX = windacelX
				append allSpeedsArray2 aOverX
				--format "2.Bpos: %. Dpos: %. Wstr: % , wacelX: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" bXpos bDummyXpos windAbsoluteX (windacelX/maxSpeedXY) aOverX (acelX) speedNowX gforce2
			 	if windForceX > maxSpeedXY do
				(
					windForceX = maxSpeedXY
				)
				if windForceX < -maxSpeedXY do
				(
					windForceX = -maxSpeedXY
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
			windAbsoluteY = (windForceY/maxSpeedXY)
			acelY = ((speedNowY-(bYpos-bYpast)))/maxAcceleration
			speedNowY = (bYpos-bYpast)/topSpeed
			bYpast = bYpos
			if acelY > maxAcceleration do (acelY = maxAcceleration)
			if acelY < -maxAcceleration do (acelY = -maxAcceleration)
			if acelY == 0.0 then (windacelY = maxAcceleration)
			else  (windacelY = (acelY/windAbsoluteY))
			if (bYpos/bDummyYpos) < 1.0 do 
			(
				--if acelY == 0.0 do (windacelY = maxAcceleration)
				aUnderY = (bDummyYpos-(bDummyYpos-bYpos))/bDummyYpos
				windacelY = (((speedNowY)+(windAbsoluteY+acelY))/aUnderY)*maxSpeedXY
				if acelY == 0.0 do (windacelY = maxAcceleration)
				if windacelY < 0 do (windacelY = -windacelY)
				windForceY = windacelY
				append allSpeedsArray1 aUnderY
				--format "1.Bpos: %. Dpos: %. Wstr: % , wacelY: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" bYpos bDummyYpos windAbsoluteY (windacelY/maxSpeedXY) aUnderY (acelY) speedNowY gforce1
				if windForceY > maxSpeedXY do
				(
					windForceY = maxSpeedXY
				)
				if windForceY < -maxSpeedXY do
				(
					windForceY = -maxSpeedXY
				)
				
			)
			if (bYpos/bDummyYpos) == 0.0 do (windForceY = 0.0)
			if (bYpos/bDummyYpos) > 1.0 do
			(
				--if acelY == 0.0 do (windacelY = -maxAcceleration)
				aOverY =  (bDummyYpos-(bYpos-bDummyYpos))/bDummyYpos
				windacelY = (((speedNowY)+(windAbsoluteY+acelY))/aOverY)*maxSpeedXY
				if acelY == 0.0 do (windacelY = -maxAcceleration)
				--if windacelY < 0.0 do (windacelY = -windacelY)
				windForceY = windacelY
				append allSpeedsArray2 aOverY
				--format "2.Bpos: %. Dpos: %. Wstr: % , wacelY: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" bYpos bDummyYpos windAbsoluteY (windacelY/maxSpeedXY) aOverY (acelY) speedNowY gforce2
			 	if windForceY > maxSpeedXY do
				(
					windForceY = maxSpeedXY
				)
				if windForceY < -maxSpeedXY do
				(
					windForceY = -maxSpeedXY
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
			windAbsoluteZ = (windForceZ/maxSpeed)
			acelZ = ((speedNowZ-(bZpos-bZpast)))/maxAcceleration
			speedNowZ = (bZpos-bZpast)/topSpeed
			bZpast = bZpos
			if acelZ > maxAcceleration do (acelZ = maxAcceleration)
			if acelZ < -maxAcceleration do (acelZ = -maxAcceleration)
			if acelZ == 0.0 then (windacelZ = maxAcceleration)
			else  (windacelZ = (acelZ/windAbsoluteZ))
			if (bZpos/bDummyZpos) < 1.0 do 
			(
				--if acelZ == 0.0 do (windacelZ = maxAcceleration)
				aUnderZ =abs (bDummyZpos-(bDummyZpos-bZpos))/bDummyZpos
				windacelZ = (((speedNowZ)+(windAbsoluteZ+acelZ))/aUnderZ)*maxSpeed
				if acelZ == 0.0 do (windacelZ = maxAcceleration)
				if windacelZ < 0 do (windacelZ = -windacelZ)
				windForceZ = windacelZ
				append allSpeedsArray1 aUnderZ
				--format "1.Bpos: %. Dpos: %. Wstr: % , wacelZ: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" bZpos bDummyZpos windAbsoluteZ (windacelZ/maxSpeed) aUnderZ (acelZ) speedNowZ gforce1
				if windForceZ > maxSpeed do
				(
					windForceZ = maxSpeed
				)
				if windForceZ < -maxSpeed do
				(
					windForceZ = -maxSpeed
				)
				
			)
			if (bZpos/bDummyZpos) == 0.0 do  (windForceZ = 0.0)
			if (bZpos/bDummyZpos) > 1.0 do
			(
				--if acelZ == 0.0 do (windacelZ = -maxAcceleration)
				aOverZ = abs (bDummyZpos-(bZpos-bDummyZpos))/bDummyZpos
				windacelZ = (((speedNowZ)+(windAbsoluteZ+acelZ))/aOverZ)*maxSpeed
				if acelZ == 0.0 do (windacelZ = -maxAcceleration)
				--if windacelZ < 0.0 do (windacelZ = -windacelZ)
				windForceZ = windacelZ
				append allSpeedsArray2 aOverZ
				--format "2.Bpos: %. Dpos: %. Wstr: % , wacelZ: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" bZpos bDummyZpos windAbsoluteZ (windacelZ/maxSpeed) aOverZ (acelZ) speedNowZ gforce2
			 	if windForceZ > maxSpeed do
				(
					windForceZ = maxSpeed
				)
				if windForceZ < -maxSpeed do
				(
					windForceZ = -maxSpeed
				) 
				
			) 
			

			z_Force.strength = windForceZ
			 
			counter = 0
		)	
		
	)
)
fn displayInfo = 
(
	aUnderX = (bDummyXpos-(bDummyXpos-bXpos))/bDummyXpos
	aUnderY = (bDummyYpos-(bDummyYpos-bYpos))/bDummyYpos
	aUnderZ =abs (bDummyZpos-(bDummyZpos-bZpos))/bDummyZpos
	windAbsoluteX = x_Force.strength/maxSpeedXY
	windAbsoluteY = y_Force.strength/maxSpeedXY
	windAbsoluteZ = z_Force.strength/maxSpeed
	--format "1.Bpos: %X,%Y,%Z ." bXpos bYpos bZpos
	--format "Dpos: %X,%Y,%Z ." bDummyXpos bDummyYpos bDummyZpos
	format "Wstr: %X,%Y,%Z." windAbsoluteX windAbsoluteY windAbsoluteZ
	format "UDummy: %X,%Y,%Z ." aUnderX aUnderY aUnderZ
	format "Acc at: %X,%Y,%Z .\n" speedNowX speedNowY speedNowZ
)
fn gLine = 
(
 	if newLine == undefined do
 	(
  		newLine = splineShape ()
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
  		addnewSpline newLine2
  		addKnot newLine2 1 #smooth  #line b.pos
  		--updateShape newLine2
 	)
 	addKnot newLine2 1 #smooth  #line b.pos
  	updateShape newLine2
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
)
registerTimeCallback windXAxis
registerTimeCallback windYAxis
registerTimeCallback windZAxis
registerTimeCallback displayInfo
registerTimeCallback gLine