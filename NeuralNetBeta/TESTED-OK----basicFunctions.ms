--Basic Functions
const = constClass()
compClass = compFnClass()

struct posClass 
(

	targetPos = [0,0,0],
	sourcePos = [0,0,0],
	delta = [0,0,0],
	tilt = [0,0,0],
	windNow = 0,
	

	-- Past atributes

	sourcePosPast = [0,0,0],
	targetPosPast = [0,0,0],
	deltaPast = [0,0,0],
	tiltPast = [0,0,0],
	windPast = 0,


	fn updatePos name objClass= 
	(
		name.targetPos = objClass.targetPos
		name.sourcePos = objClass.sourcePos

		name.delta[1] = compClass.deltafn name.sourcePos[1] name.targetPos[1]
		name.delta[2] = compClass.deltafn name.sourcePos[2] name.targetPos[2]
		name.delta[3] = compClass.deltafn name.sourcePos[3] name.targetPos[3]

		name.tilt[1] = compClass.tiltfn name.delta[1] name.delta[3]
		name.tilt[2] = compClass.tiltfn name.delta[2] name.delta[3]
		name.tilt[3] = compClass.tiltfn name.delta[2] name.delta[1]

		name.windNow = objClass.windForce
		return true
	),

	fn updatePastPos name= 
	(
		name.sourcePosPast = name.targetPos
		name.targetPosPast = name.sourcePos
		name.deltaPast = name.delta
		name.tiltPast = name.tilt
		name.windPast = name.windNow
		return true
	),

	fn testValue test=
	(
		dist = const.maxDistance
		ranGen = compClass.randomGenFn

		test.targetPos = [(ranGen -dist dist),(ranGen -dist dist),(ranGen -dist dist)]
		test.sourcePos = [(ranGen -dist dist),(ranGen -dist dist),(ranGen -dist dist)]

		test.windForce = ranGen 0 const.maxWindForce
		return true
	),
	private
	windForce = 0
)

struct spdClass
(
	spdNow = [0,0,0],

	-- Past atributes

	spdPast = [0,0,0],

	fn updateSpd name posClass = 
	(
		for a=1 to 3 do 
		(
			name.spdNow[a] = compClass.spdNowFn posClass.deltaPast[a] posClass.delta[a]
		)
		return true
	),

	fn updatePast name= 
	(
		name.spdPast = name.spdNow

		return true
	),

	fn testValue test=
	(

		dist = const.maxDistance
		ranGen = compClass.randomGenFn

		test.deltaPast = [(ranGen -dist dist),(ranGen -dist dist),(ranGen -dist dist)]
		test.delta = [(ranGen -dist dist),(ranGen -dist dist),(ranGen -dist dist)]

		return true
	),

	private

	deltaPast = [0,0,0],
	delta = [0,0,0]
)

struct acelClass
(
	acel = [0,0,0],
	-- Past atributes

	acelPast = [0,0,0],

	fn updateAcel name speedClass =
	(
		for a=1 to 3 do 
		(
			name.acel[a] = compClass.acelFn speedClass.spdPast[a] speedClass.spdNow[a]
		)
	),
	fn updatePast name= (name.acelPast = name.acel),

	fn testValue test=
	(

		spd = const.maxSpeed
		ranGen = compClass.randomGenFn

		test.spdNow = [(ranGen -spd spd),(ranGen -spd spd),(ranGen -spd spd)]
		test.spdPast = [(ranGen -spd spd),(ranGen -spd spd),(ranGen -spd spd)]

		return true
	),
	private

	spdPast = [0,0,0],
	spdNow = [0,0,0]

)



fn testPosClassFn =
(

	const = constClass()
	compClass = compFnClass()
	testPos = posClass()

	testPos.testValue testPos
	testPos.updatePos testPos testPos
	testPos.updatePastPos testPos

	print testPos.sourcePosPast
	print testPos.targetPosPast
	print testPos.deltaPast
	print testPos.tiltPast
	print testPos.windPast
	
	testPos.testValue testPos
	testPos.updatePos testPos testPos

	print testPos.targetPos
	print testPos.sourcePos
	print testPos.delta
	print testPos.tilt
	print testPos.windNow




	return true
)
fn testSpdClassFn =
(

	const = constClass()
	compClass = compFnClass()
	testspd = spdClass()

	testspd.testValue testspd
	testspd.updateSpd testspd testspd
	testspd.updatePast testspd

	print testspd.spdPast

	testspd.testValue testspd
	testspd.updateSpd testspd testspd

	print testspd.spdNow

	

	return true
)
fn testacelClassFn =
(

	const = constClass()
	compClass = compFnClass()
	testacel = acelClass()

	testacel.testValue testacel
	testacel.updateAcel testacel testacel
	testacel.updatePast testacel

	print testacel.acelPast

	testacel.testValue testacel
	testacel.updateAcel testacel testacel

	print testacel.acel

	

	return true
)
fn testBasicClasses =
(
	print "\nTest Start-------\n"

	testPosClassFn()
	
	print "\nPos Pass-------\n"

	testSpdClassFn()
	
	print "\nSpeed Pass-------\n"

	testacelClassFn()
	
	print "\nAcel Pass-------\n"
	return true
)
