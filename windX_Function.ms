-- X force variables

bXpos
bDummyXpos
windAbsoluteX
acelX
bXpast
windacelX
bXpos
speedNowX
windForceX
aOverX
aUnderX
x_Force.strength
--X force function

fn windXAxis = 
(
	if nvpx.IsSimulating() == true do
	(
		bXpast = bXpos
		bXpos = b.pos[1]
		bDummyXpos = bDummy.pos[1]
		counter +=1
		if counter == 1 do
		(
			windAbsoluteX = (windForceX/maxSpeed)
			acelX = ((speedNowX-(bXpos-bXpast)))/maxAcceleration
			speedNowX = (bXpos-bXpast)/topSpeed
			bXpast = bXpos
			if acelX > maxAcceleration do (acelX = maxAcceleration)
			if acelX < -maxAcceleration do (acelX = -maxAcceleration)
			if acelX == 0.0 then (windacelX = maxAcceleration)
			else  (windacelX = (acelX/windAbsoluteX))
			if (bXpos/bDummyXpos) < 1.0 then 
			(
				--if acelX == 0.0 do (windacelX = maxAcceleration)
				aUnderX =abs (bDummyXpos-(bDummyXpos-bXpos))/bDummyXpos
				windacelX = (((speedNowX)+(windAbsoluteX+acelX))/aUnderX)*maxSpeed
				if acelX == 0.0 do (windacelX = maxAcceleration)
				if windacelX < 0 do (windacelX = -windacelX)
				windForceX = windacelX
				append allSpeedsArray1 aUnderX
				format "1.Bpos: %. Dpos: %. Wstr: % , wacelX: % , UDummy: %. Acc at: % Spd: % Gforce1: %\n" bXpos bDummyXpos windAbsoluteX (windacelX/maxSpeed) aUnderX (acelX) speedNowX gforce1
				if windForceX > maxSpeed do
				(
					windForceX = maxSpeed
				)
				if windForceX < -maxSpeed do
				(
					windForceX = -maxSpeed
				)
				
			)
			else (windForceX = 0.0)
			if (bXpos/bDummyXpos) > 1.0 do
			(
				--if acelX == 0.0 do (windacelX = -maxAcceleration)
				aOverX = abs (bDummyXpos-(bXpos-bDummyXpos))/bDummyXpos
				windacelX = (((speedNowX)+(windAbsoluteX+acelX))/aOverX)*maxSpeed
				if acelX == 0.0 do (windacelX = -maxAcceleration)
				--if windacelX < 0.0 do (windacelX = -windacelX)
				windForceX = windacelX
				append allSpeedsArray2 aOverX
				format "2.Bpos: %. Dpos: %. Wstr: % , wacelX: % , ODummy: %. Acc at: % Spd: % Gforce2: %\n" bXpos bDummyXpos windAbsoluteX (windacelX/maxSpeed) aOverX (acelX) speedNowX gforce2
			 	if windForceX > maxSpeed do
				(
					windForceX = maxSpeed
				)
				if windForceX < -maxSpeed do
				(
					windForceX = -maxSpeed
				) 
				
			) 
			

			x_Force.strength = windForceX

			counter = 0
		)	
		
	)
)