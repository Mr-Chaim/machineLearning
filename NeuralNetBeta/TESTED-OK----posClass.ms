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
