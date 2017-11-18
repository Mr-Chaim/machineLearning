
struct CreateObj
(
	sourcebox = undefined,
	targetBox = undefined,
	posPred = undefined,
	windObj = undefined,   
	predObj = undefined,   
	tltLObj = undefined,   
	tltFObj = undefined,

	fn Init className = 
	(
		className.sourcebox = box()
		className.targetBox = box()
		className.posPred   = box()

		className.windObj   = wind()
		
		className.predObj   = cylinder()
		className.tltLObj   = cylinder()
		className.tltFObj   = cylinder()
		
		className.sourceBox.height = 10
		className.sourceBox.width  = 10
		className.sourceBox.length = 10
		
		className.targetBox.height = 10
		className.targetBox.width  = 10
		className.targetBox.length = 10
		
		className.posPred.height = 10
		className.posPred.width  = 10
		className.posPred.length = 10
		

		
		className.sourcebox.name = "sourcebox"
		className.targetBox.name = "targetBox"
		className.posPred.name   = "posPred"
		className.windObj.name   = "windObj"
		className.predObj.name   = "predObjRED"
		className.tltLObj.name   = "tltLObjGRE"
		className.tltFObj.name   = "tltFObjBLU"
		
		className.predObj.radius = 1
		className.tltLObj.radius = 1
		className.tltFObj.radius = 1

		className.predObj.wirecolor = (color 155 0 0)
		className.tltLObj.wirecolor = (color 0 155 0)
		className.tltFObj.wirecolor = (color 0 0 155)
		
		className.predObj.height = 50
		className.tltLObj.height = 50
		className.tltFObj.height = 50
		
		className.windObj.decay = 0
		className.windObj.turbulence = 0
		className.windObj.frequency = 0
		className.windObj.baseobject.scale = 0
		className.windObj.IconSize = 30

		className.targetBox.pos = [100,100,100]
		
		addmodifier className.sourceBox (MassFX_RBody())
		append className.sourceBox.MassFX_Rigid_Body.forcesList className.windObj
	),
	fn del className =
	(
		if className.sourcebox != undefined do (delete className.sourcebox)
		if className.targetBox != undefined do (delete className.targetBox)
		if className.windObj != undefined do (delete className.windObj)
		if className.predObj != undefined do (delete className.predObj)
		if className.tltLObj != undefined do (delete className.tltLObj)
		if className.tltFObj != undefined do (delete className.tltFObj)
		select $*
		delete $
	)
)
obj = CreateObj()
--obj.del obj
obj.init obj

