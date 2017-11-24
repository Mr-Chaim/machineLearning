
struct posClass 
(
	dstS = 0,
	dstF = 0,
	
	spdS = 0,
	aclS = 0,
	
	tltF = [0,0,0],
	tltL = [0,0,0],
	
	tarPos = [0,0,0],
	souPos = [0,0,0],

	dstSPast = 0,
	dstFPast = 0,
	spdSPast = 0,
	souPosPast = [0,0,0],
	
	fn importValues name valueClass =
	(
		name.souPos     = valueClass.souPos
		name.tarPos     = valueClass.tarPos
		name.souPosPast = valueClass.souPosPast
		name.dstSPast   = valueClass.dstSPast
		name.spdSPast   = valueClass.spdSPast
		return True
	),
	fn updateDst name = 
	(
		name.dstF = mathClass.dstFfn name.souPos name.tarPos
		name.dstS = name.dstFPast - name.dstF 
		--print name.souPosPast
		return true
	),
	fn updateSpd name = 
	(
		name.spdS = abs name.dstSPast - abs name.dstS
		
		return true
	),
	fn updateAcl name =
	(
		name.aclS = abs name.spdSPast - abs name.spdS
		
		return true
	),
	fn updateTlt name =
	(
		name.tltF = mathClass.tltFFn name.souPos name.tarPos
		name.tltL = mathClass.tltFFn name.souPosPast name.souPos

		return true
	)
)