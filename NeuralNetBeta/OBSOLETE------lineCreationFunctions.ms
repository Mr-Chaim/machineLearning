--Line Creation

fn lineCreationFunc layerLineArr= 
(
	if layerLineArr == undefined or layerLineArr.count == 0 or (isDeleted layerLineArr[1]) == true do
	(
		layerLineArr=#()
		for arr=1 to b.pos.count do
		(
			LayerLine = splineShape()
			LayerLine.name = ("LayerLine_" + guideAxis[arr])
			layerLine.wirecolor = (wireColorVar[arr] as color)
			addnewSpline LayerLine
			for a=1 to circleArr.count do 
			(
				addKnot LayerLine 1 #corner #line [0,0,0]
			)
			updateShape LayerLine
			append layerLineArr LayerLine
		)
	)
	layerLineArr
)

fn boxGuidelines posLinesArr obj = 
(
	if posLinesArr == undefined or posLinesArr.count == 0 or (isDeleted posLinesArr[1]) == true do
	(
		posLinesArr=#()
		for arr=1 to obj.pos.count do
		(
			posLines = splineShape()
			posLines.name = ("GuideLine_" + (obj.name as string) + "_" + guideAxis[arr])
			posLines.wirecolor = (wireColorVar[arr] as color)
			addnewSpline posLines
			addKnot posLines 1 #corner #line [0,0,0]
			addKnot posLines 1 #corner #line obj.pos
			updateShape posLines
			append posLinesArr posLines
		)
	)
	posLinesArr
)

fn boxGuidelinesPosfunc obj n= 
(
	fooPos = obj.pos
	fooPos[n] = 0
	fooPos
)

fn splineObjPositioner obj posLinesArr n= 
(
 	if posLinesArr != undefined do
 	(
 		fooPos = boxGuidelinesPosfunc obj n
 		posLines = posLinesArr[n]
 		setKnotPoint posLines 1 1 obj.pos 
 		setKnotPoint posLines 1 2 fooPos
 		updateShape posLines
 	)
)


dummyLinesArr = boxGuidelines dummyLinesArr bDummy
boxLinesArr = boxGuidelines boxLinesArr b
layerLineArr = lineCreationFunc layerLineArr