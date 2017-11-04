--Basic Functions

struct basicVarClass 
(

	dPos = [0,0,0],
	bPos = [0,0,0],
	delta = [0,0,0],
	tilt = [0,0,0],

	windNow = 0,
	

	-- Past atributes

	bPosPast = [0,0,0],
	dPosPast = [0,0,0],
	deltaPast = [0,0,0],
	tiltPast = [0,0,0],

	windPast = 0,

	deltafn = compFnClass.deltaFn,
	tiltfn = compFnClass.dirtiltFn,

	fn update name= 
	(
		dPos = name.bDummy.pos
		bPos = name.b.pos

		delta[1] = deltafn bPos[1] dPos[1]
		delta[2] = deltafn bPos[2] dPos[2]
		delta[3] = deltafn bPos[3] dPos[3]

		tilt[1] = tiltfn delta[1] delta[3]
		tilt[2] = tiltfn delta[2] delta[3]
		tilt[3] = tiltfn delta[2] delta[1]

		windNow = name.windForce.strength
	),

	fn updatePast = 
	(

		bPosPast = dPos
		dPosPast = bPos
		deltaPast = delta
		tiltPast = tilt
		windPast = windNow

		
	)
)

struct spdClass
(
	spdNowFn = compFnClass.spdNowFn,

	spdNow = [0,0,0],

	-- Past atributes


	spdPast = [0,0,0],

	fn update basicClass = 
	(
		for a=1 to 3 do 
		(
			spdNow[a] = spdNowFn basicClass.deltaPast[a] basicClass.delta[a]
		)

	),

	fn updatePast = 
	(
		spdPast = spdNow
	)
)

struct acelClass
(
	acelFn = compFnClass.acelfn,

	acel = [0,0,0],

	-- Past atributes

	acelPast = [0,0,0],

	fn update speedClass =
	(
		for a=1 to 3 do 
		(
			acel[a] = acelFn speedClass.spdPast[a] speedClass.spdNow[a]
		)
	),

	fn updatePast = 
	(
		acelPast = acel
	)
)

