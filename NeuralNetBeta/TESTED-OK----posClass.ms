
struct posClass 
(

	tarPos = [0,0,0],
	souPos = [0,0,0],
	
	tltF   = [0,0,0],
	tltFLc = [0,0,0],

	dstS    = 0,
	dstSLoc = 0,

	-- Past atributes

	souPosPast = [0,0,0],
	tarPosPast = [0,0,0],
	tltFLcPast = [0,0,0],
	tltFPast   = [0,0,0],

	dstSLcPast = 0,
	dstSPast   = 0,
	

	fn updatePos name objClass= 
	(
		name.dstS  = mathClass.dstFfn name.souPos name.tarPos
		name.dstLc = mathClass.dstFfn name.souPos name.souPosPast

		name.tltF  = mathClass.tltFFn name.souPos name.tarPos
		name.tltLc = mathClass.tltFFn name.souPos name.souPosPast

		return true
	),
	fn updatePast name= 
	(
		name.souPosPast = name.tarPos
		name.tarPosPast = name.souPos

		name.dstLcPast = name.dstLc
		name.tltLcPast = name.tltLc

		name.dstSPast = name.dstS
		name.tltFPast = name.tltF

		return true
	),
	fn importValues objClass =
	(
		name.tarPos = objClass.tarPos
		name.souPos = objClass.souPos

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
