
struct posClass 
(

	tarPos = [0,0,0],
	souPos = [0,0,0],
	
	tltF = [0,0,0],
	tltL = [0,0,0],

	dstS = 0,
	dstL = 0,

	-- Past atributes

	souPosPast = [0,0,0],
	tarPosPast = [0,0,0],

	tltLPast = [0,0,0],
	tltFPast = [0,0,0],

	dstLPast = 0,
	dstSPast = 0,
	

	fn updatePos name = 
	(
		name.dstS = mathClass.dstFfn name.souPos name.tarPos
		name.dstL = mathClass.dstFfn name.souPos name.souPosPast

		name.tltF = mathClass.tltFFn name.souPos name.tarPos
		name.tltL = mathClass.tltFFn name.souPos name.souPosPast

		return true
	),
	fn updatePast name= 
	(
		name.souPosPast = name.tarPos
		name.tarPosPast = name.souPos

		name.dstLPast = name.dstL
		name.tltLPast = name.tltL

		name.dstSPast = name.dstS
		name.tltFPast = name.tltF

		return true
	),
	fn importValues name valueClass =
	(
		name.tarPos = valueClass.tarPos
		name.souPos = valueClass.souPos

		return True
	),
	fn testValue test=
	(
		maxD   = const.maxDistance
		ranGen = mathClass.randomGenFn

		test.tarPos = [(ranGen -maxD maxD),(ranGen -maxD maxD),(ranGen -maxD maxD)]
		test.souPos = [(ranGen -maxD maxD),(ranGen -maxD maxD),(ranGen -maxD maxD)]

		return true
	),
	private
	const = constClass()
)

fn testPosClassFn =
(

	constClass()
	mathClass()
	testPos = posClass()

	testPos.testValue testPos
	testPos.updatePos testPos testPos
	testPos.updatePast testPos

	print testPos.souPosPast
	print testPos.tarPosPast
	print testPos.deltaPast
	print testPos.tiltPast
	print testPos.windPast

	testPos.testValue testPos
	testPos.updatePos testPos testPos

	print testPos.tarPos
	print testPos.souPos
	print testPos.delta
	print testPos.tilt
	print testPos.windNow

	return true
)
