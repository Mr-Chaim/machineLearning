struct layer
(
	public

	LayerName             = undefined,
	type                  = undefined,
	MaxValue              = undefined,
	
	NumberNodes           = undefined,
	weightArray           = undefined,
	
	CurrentValue          = undefined,
	currentAbsolute       = undefined,
	PastValue             = undefined,
	
	Weight                = undefined,
	WeightPosition        = undefined,
	
	PastWeight            = undefined,
	PastWeightPosition    = undefined,
	
	Prediction            = undefined,
	PastPrediction        = undefined,

	outsideVal            = undefined,
	outsideMax            = undefined,

	value1                = undefined,
	value2                = undefined,
	value3                = undefined,
	value4                = undefined,
	value5                = undefined,
	value6                = undefined,
	value7                = undefined,
	value8                = undefined,
	value9                = undefined,
	value10               = undefined,
	value11               = undefined,
	value12               = undefined,
	value13               = undefined,
	value14               = undefined,
	value15               = undefined,



	fn InitType name Interger=
	(
		if Interger == 1 do
		(
			name.type               = "Distance"
			name.MaxValue           = 0
			name.NumberNodes        = 0
			name.CurrentValue       = 0
			name.PastValue          = 0
			name.PastPrediction     = 0
			name.Weight             = 0
			name.PastWeight         = 0
			name.WeightPosition     = [0,0]
			name.PastWeightPosition = [0,0]
		)
		if Interger == 2 do
		(
			name.type               = "Angle"
			name.MaxValue           = 0
			name.NumberNodes        = 0
			name.CurrentValue       = [0,0]
			name.PastValue          = [0,0]
			name.Prediction         = [0,0]
			name.PastPrediction     = [0,0]
			name.Weight             = [0,0]
			name.PastWeight         = [0,0]
			name.WeightPosition     = #([1,1],[1,1])
			name.PastWeightPosition = #([1,1],[1,1])
		)
		if Interger == 3 do
		(
			name.type               = "Movement"
			name.MaxValue           = 0
			name.NumberNodes        = 0
			name.CurrentValue       = 0
			name.PastValue          = 0
			name.PastPrediction     = 0
			name.Weight             = 0
			name.PastWeight         = 0
			name.WeightPosition     = [0,0]
			name.PastWeightPosition = [0,0]
		)
		if Interger == 4 do
		(
			name.type               = "Wind"
			name.MaxValue           = 0
			name.NumberNodes        = 0
			name.CurrentValue       = 0
			name.PastValue          = 0
			name.PastPrediction     = 0
			name.Weight             = 0
			name.PastWeight         = 0
			name.WeightPosition     = [0,0]
			name.PastWeightPosition = [0,0]
		)
		if Interger == 5 do
		(
			name.type               = "Object"
			name.MaxValue           = 0
			name.NumberNodes        = 0
			name.CurrentValue       = [0,0,0]
			name.PastValue          = [0,0,0]
			name.PastPrediction     = 0
			name.Weight             = 0
			name.PastWeight         = 0
			name.WeightPosition     = [0,0]
			name.PastWeightPosition = [0,0]
		)
		return name.type
	),
	fn InitWeights name = 
	(
		if type == "Angle" then
		(
			for a=1 to 2 do
			(
				name.weightArray[a] = mathClass.arrayGenFn name.NumberNodes
			)
		)
		else
		(
			name.weightArray = mathClass.arrayGenFn name.NumberNodes
		)


		return true
	),
	fn getCurrentValue name =
	(
		if name.type == "Distance" do
		(
			name.CurrentValue = mathClass.dstFfn name.Value1 name.Value2
			name.currentAbsolute = mathClass.absFn name.CurrentValue name.MaxValue
			name.WeightPosition = mathClass.constrainFn name.currentAbsolute name.NumberNodes
		)
		if name.type == "Movement" do
		(
			name.CurrentValue = mathClass.movementFn name.Value1 name.Value2
			name.currentAbsolute = mathClass.absFn name.CurrentValue name.MaxValue
			name.WeightPosition = mathClass.constrainFn name.currentAbsolute name.NumberNodes
		)
		if name.type == "Angle" do
		(
			name.CurrentValue = mathClass.tltFFn name.Value1 name.Value2
			name.currentAbsolute = mathClass.absFn name.CurrentValue name.MaxValue
			name.WeightPosition = mathClass.constrainFn name.currentAbsolute name.NumberNodes
		)
		if name.type == "Object" do
		(
			name.CurrentValue = name.value1.pos
		)
		if name.type == "Wind" do
		(
			Weight1 = Layer1.Weight[layer1.WeightPosition,layer2.WeightPosition]
			Weight2 = Layer2.Weight[layer2.WeightPosition,layer3.WeightPosition]
			Weight3 = Layer3.Weight[layer3.WeightPosition,layer4.WeightPosition]
			Weight4 = Layer4.Weight[layer4.WeightPosition,layer5.WeightPosition]
			Weight5 = Layer5.Weight[layer5.WeightPosition,layer6.WeightPosition]
			Weight6 = Layer6.Weight[layer6.WeightPosition,layer7.WeightPosition]
			Weight7 = Layer7.Weight[layer7.WeightPosition,layer8.WeightPosition]
			Weight8 = Layer8.Weight[layer8.WeightPosition,layer9.WeightPosition]
			Weight9 = Layer9.Weight[layer9.WeightPosition,WindPast.WeightPosition]

			layerArr = #(Weight1,Weight2,Weight3,Weight4,Weight5,Weight6,Weight7)
			name.CurrentValue =  mathClass.wndFinlFn layersArr mW
		)

		return true
	),

	--private
)

WndF = layer() WndF.InitType WndF 4
dstF = layer() dstF.InitType dstF 1
dstS = layer() dstS.InitType dstS 1
spdS = layer() spdS.InitType spdS 3
aclS = layer() aclS.InitType aclS 3

dstT = layer() dstT.InitType dstT 2
spdT = layer() spdT.InitType spdT 2
wndT = layer() wndT.InitType wndT 2
tltF = layer() tltF.InitType tltF 2
tltL = layer() tltL.InitType tltL 2