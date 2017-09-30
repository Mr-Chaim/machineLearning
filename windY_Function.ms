-- Y force variables

bYpos
bDummyYpos
windAbsoluteY
acelY
bYpast
windacelY
bYpos
speedNowY
windForceY
aOverY
aUnderY
y_Force.strength
--Y force function

fn windYAxis = 
(
	if nvpx.IsSimulating() == true do
	(
		bYpast = bYpos
		bYpos = b.pos[2]
		bDummyYpos = bDummy.pos[2]
		counter +=1
		if counter == 1 do
		(
			windAbsoluteY = (windForceY/maxSpeed)
			acelY = ((speedNowY-(bYpos-bYpast)))/maxAcceleration
			speedNowY = (bYpos-bYpast)/topSpeed
			bYpast = bYpos
			if acelY > maxAcceleration do (acelY = maxAcceleration)
			if acelY < -maxAcceleration do (acelY = -maxAcceleration)
			if acelY == 0.0 then (windacelY = maxAcceleration)
			else  (windacelY = (acelY/windAbsoluteY))
			if (bYpos/bDummyYpos) < 1.0 then 
			(
				--if acelY == 0.0 do (windacelY = maxAcceleration)
				aUnderY =abs (bDummyYpos-(bDummyYpos-bYpos))/bDummyYpos
				windacelY = (((speedNowY)+(windAbsoluteY+acelY))/aUnderY)*maxSpeed
				if acelY == 0.0 do (windacelY = maxAcceleration)
				if windacelY < 0 do (windacelY = -windacelY)
				windForceY = windacelY
				append allSpeedsArray1 aUnderY
				format "1.Bpos: %. Dpos: %. Wstr: % , wacelY: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" bYpos bDummyYpos windAbsoluteY (windacelY/maxSpeed) aUnderY (acelY) speedNowY gforce1
				if windForceY > maxSpeed do
				(
					windForceY = maxSpeed
				)
				if windForceY < -maxSpeed do
				(
					windForceY = -maxSpeed
				)
				
			)
			else (windForceY = 0.0)
			if (bYpos/bDummyYpos) > 1.0 do
			(
				--if acelY == 0.0 do (windacelY = -maxAcceleration)
				aOverY = abs (bDummyYpos-(bYpos-bDummyYpos))/bDummyYpos
				windacelY = (((speedNowY)+(windAbsoluteY+acelY))/aOverY)*maxSpeed
				if acelY == 0.0 do (windacelY = -maxAcceleration)
				--if windacelY < 0.0 do (windacelY = -windacelY)
				windForceY = windacelY
				append allSpeedsArray2 aOverY
				format "2.Bpos: %. Dpos: %. Wstr: % , wacelY: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" bYpos bDummyYpos windAbsoluteY (windacelY/maxSpeed) aOverY (acelY) speedNowY gforce2
			 	if windForceY > maxSpeed do
				(
					windForceY = maxSpeed
				)
				if windForceY < -maxSpeed do
				(
					windForceY = -maxSpeed
				) 
				
			) 
			

			y_Force.strength = windForceY

			 
			counter = 0
		)	
		
	)
)