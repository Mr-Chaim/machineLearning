--limits Handling

fn changingLimits maxObjSpdArr maxAcelArr deltaVar spdPastAbs acelPast n=
(


	maxObjSpdArr = #(maxSpeedX,maxSpeedY,maxSpeedZ)
	maxAcelArr = #(maxAcelX,maxAcelY,maxAcelZ)
	maxWindSpdArr = #(maxWindSpdX,maxWindSpdY,maxWindSpdZ)
	maxWindSpdArr[n] = maxWindSpdArr[n] /( ((limiterFunc spdPastAbs spdPastAbs 1) + (limiterFunc acelPast acelPast 1))/2)

)