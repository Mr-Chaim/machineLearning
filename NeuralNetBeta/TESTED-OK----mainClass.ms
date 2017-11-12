--maintTestTimer.stop maintTestTimer
/*


To start the main class, we have to initialize the other classes. 

constClass() - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----constClass.ms"
mathLibrary() - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----mathLibrary.ms"
objClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----ObjClass.ms"
weightClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----weighHandler.ms"
posClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----posClass.ms"
spdClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----spdClass.ms"
acelClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----acelClass.ms"
valueClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----valueClass.ms"
windClass - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----windClass.ms"

!!!! They are not supposed to be changed so they will not be variables. !!!!

classes Used:

1- Initialize:

	const = constClass()
	mathClass = mathClass()

	simulation1 = objClass()
	weightsS1 = weightClass()
	posS1 = posClass()
	spdS1 = spdClass()
	acelS1 = acelClass()
	valueS1 = valueClass()
	windS1 = windClass()

	simulation1.initAll simulation1 $Source $target $WindObj

	weightsS1 = weightClass.init weightsS1

2- Start the loop:

	simulation1.updateValue simulation1

	posS1.updatePos posS1 simulation1

	spdS1.updateSpd spdS1 posS1

	acelS1.updateAcel acelS1 spdS1

	predS1.updateValues predS1 posS1 spdS1 acelS1

	valueS1.importVar valueS1 posS1 spdS1 acelS1 predS1

	weightsS1.importVar weightsS1 valueS1
	weightsS1.updateWeights weightsS1
	weightsS1.catchCurrent weightsS1

	windS1.importValues windS1 valueS1 weightsS1
	windS1.updateAbsolute windS1
	windS1.calculate windS1

	simulation1.updateWind simulation1 windS1

	posS1.updatePast
	spdS1.updatePast
	acelS1.updatePast

*/

--External Libraries

include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----constClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----mathLibrary.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----ObjClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----weighHandler.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----posClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----spdClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----acelClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----predictionClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----valueClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----windClass.ms"

const = constClass()
mathClass()

fn testLimitParameters delta sourceObj =
(
	dist = [const.maxDistance,const.maxDistance,const.maxDistance]
	if delta[1] > dist[1] or delta[2] > dist[2] or delta[3] > dist[3] do 
	(
		sourceObj.pos = [20,20,20]
	)
)

struct mainClass
(

	const = constClass(),
	simulation1 = objClass(),
	weightsS1 = weightClass(),
	posS1 = posClass(),
	spdS1 = spdClass(),
	acelS1 = acelClass(),
	predS1 = predClass(),
	valueS1 = valueClass(),
	windS1 = windClass(),


	fn init name obj1 obj2 windObj =
	(
		/*
			
			Obj1 - Is the source object
			obj2 - Is the Target object
			WindObj - Is the WindObj

			simulation1.initAll Will import the obj1 obj2 windObj.
			weightsS1.init Will initialize the weights for Pos, Speed, Aceleration, Tilt and Wind.
			The weights are divided in 3 sets to represent the axis with 20 Tensors for each layer.
			The Wind layer has only one axis layer with 20 Tensors.

		*/

		name.simulation1.initAll name.simulation1 obj1 obj2 windObj
		name.weightsS1.init name.weightsS1
	),

	fn updateValue name =
	(
		name.localSim1 = name.simulation1
		name.localweS1 = name.weightsS1
		name.localpS1  = name.posS1
		name.localsS1  = name.spdS1
		name.localaS1  = name.acelS1
		name.localprS1 = name.predS1
		name.localvS1  = name.valueS1
		name.localwiS1 = name.windS1	
		/* 
			
			It will update the present values to the current frames. 
			localpS1.updatePos will update the present Position.
			localsS1.updateSpd will update the present Speed taking the values from the present and past Positions.
			localaS1.updateAcel will update the present Aceleration taking the values from the present and past Speed.

		*/
		name.localSim1.updateValue name.localSim1
		name.localpS1.updatePos name.localpS1 name.localSim1
		name.localsS1.updateSpd name.localsS1 name.localpS1
		name.localaS1.updateAcel name.localaS1 name.localsS1
		/*

			localprS1.updateValues will take the past and present values for Position, Speed and aceleration, make a prediction of the next value.

		*/
		name.localprS1.updateValues name.localprS1 name.localpS1 name.localsS1 name.localaS1
		/*

			localvS1.importVar will take all of the values from the previous variables used in this interation, then import the variables into a single class of values.

		*/
		name.localvS1.importVar name.localvS1 name.localpS1 name.localsS1 name.localaS1 name.localprS1
		/*
			
			Next, the Weight class will Import the values from the Values class and update the weights using back backPropagation. 
			The weights are calculated as the derivate of the previous prediction, the actual result and the past values.
			Right now I am using mainly a sigmoid function to get the weight, but I will update to another function soon.
			The last function will catch the waights and save them into their variables to be used in the wind Class.

		*/
		name.localweS1.importVar name.localweS1 name.localvS1
		name.localweS1.updateWeight name.localweS1
		name.localweS1.catchCurrent name.localweS1
		/*

			Now it is the Wind calculation class. It calculates, although it does not seem to be calculating a right value.
			Right now the calculation is a simple FFN the value of each layer is multiplied by the weight then assigned A foo variable. Excluding tilt.
			The foo variables then are added togheter and aveareged out. -- This seems sketchy, needs a better solution.
			The average fo the layers is multiplied to the weight of the Tilt for that axis, this then is added to the tilt value.
			The average of the foo variables are then added to the foo of the other axis, then averaged out. -- This also seems sketchy, needs a better solution.
			The resulting average of number should be multiplied to the wind weight then to the maximum weight to find the next wind force. -- Sketchy, needs better solution.

		*/
		name.localwiS1.importValues name.localwiS1 name.localvS1 name.localweS1
		name.localwiS1.updateAbsolute name.localwiS1
		name.localwiS1.calculate name.localwiS1
		/*

			Now that i have the final wind I can assign it to the wind Object.

		*/
		name.localSim1.updateWindTestMode name.localSim1 name.localwiS1
		--$prediction.dir = name.localprS1.tiltPred
		


		

		--TestTilt 
		--mathClass.tiltFn ($box002.pos[1] - $box001.pos[1]) ($box002.pos[3] - $box001.pos[3])
		



-----------------------------TEST----------------------------------------------------






		$prediction.pos = $Box001.pos
		$actualDirection.pos = $Box001.pos
		$manual.pos = $box001.pos
		$wind001.pos = $box001.pos
		


		$box003.height = ($box001.pos[3] - $box002.pos[3])
		$box003.pivot = [$box003.min.x,$box003.min.y,$box003.min.z]
		$box003.pos = $box001.pos
		$box003.width = abs($box001.pos[1] - $box002.pos[1])
		$box003.pivot = [$box003.min.x,$box003.min.y,$box003.min.z]
		$box003.pos = $box001.pos
		$box003.length = abs($box001.pos[2] - $box002.pos[2])
		$box003.pivot = [$box003.min.x,$box003.min.y,$box003.min.z]
		$box003.pos = $box001.pos
		

		--($manual.rotation as eulerAngles).x
		--$manual.rotation as angleaxis
		--$manual.rotation
		--$manual.rotation.X_rotation
		name.angles = mathClass.tiltFinalFn $box001.pos  $box002.pos
		--name.angles = ([( name.angles[1]),( name.angles[2]),( name.angles[3])])
		--$manual.dir = name.angles
		--$manual.dir=name.angles
		--acos $manual.dir[2]
		
		$manual.height = name.localpS1.deltaSingle
		--$prediction.height = sqrt(name.localpS1.delta[1]^2+name.localpS1.delta[3]^2)
		$actualDirection.height = name.localpS1.deltaSingle
		
		$actualDirection.dir = [0,0,1]
		$wind001.dir = [0,0,1]
		--$wind001.rotation = name.angles
		$wind001.rotation.X_rotation = name.angles[1]
		$wind001.rotation.Y_rotation = name.angles[2]
		--$wind001.rotation.Z_rotation = name.angles[3]
		
		$actualDirection.rotation.X_rotation = name.angles[1]
		$actualDirection.rotation.Y_rotation = name.angles[2]
		--$actualDirection.rotation.Z_rotation = name.angles[3]
		--$actualDirection.rotation.z_rotation = name.angles[3]
		--rotate $manual (angleaxis (180) [0,0,1])
		--rotate $manual (angleaxis (name.angles[1]) [1,0,0])
		
		--rotate $actualDirection (angleaxis (name.angles[1]) [1,0,0])
		--rotate $actualDirection (angleaxis (name.angles[2]) [0,2,0])
		--rotate $actualDirection (angleaxis (name.angles[1]) [0,0,1])

		format "Delta-% Tilt-% ManualDir-%\n" name.localpS1.delta name.angles [($manual.rotation.X_rotation),($manual.rotation.y_rotation),($manual.rotation.z_rotation)]
		--$wind001.dir[3] = $prediction.dir[3]
		--format "F-% P-% S-%\n" name.localwiS1.tiltFinal $prediction.dir $actualDirection.dir
		/*

			Now i will update the Past Values to be used on the next interation.

		*/
		name.localpS1.updatePast name.localpS1
		name.localsS1.updatePast name.localsS1
		name.localaS1.updatePast name.localaS1
		--testLimitParameters localpS1.delta localSim1.source
		/*

			Debugging

		*/
		--format "Start tilt: % % %\n" (name.localpS1.tilt[1]/180) (name.localpS1.tilt[2]/180) (name.localpS1.tilt[3]/180)
		--format "End Angle: %\n" (name.localSim1.windObj.dir)
	),

	angles=0,
	angles2 = 0,
	localSim1 = undefined,
	localweS1 = undefined,
	localpS1 = undefined,
	localsS1 = undefined,
	localaS1 = undefined,
	localprS1 = undefined,
	localvS1 = undefined,
	localwiS1 = undefined

)

struct testMainClass
(
	testVar = undefined,
	fn initTest name=
	(
		name.testVar = mainClass()
		name.testVar.init name.testVar $Box001 $Box002 $Wind001
	),
	fn runTest name=
	(
		name.testVar.updateValue testVar
	)
	
)
/*testClass = testMainClass()
testClass.initTest testClass
testClass.runTest testClass*/
testClass = mainClass()
testClass.init testClass $Box001 $Box002 $Wind001
testClass.updateValue testClass

struct clockClass
(
	functionName = undefined,
	fn create name func=
	(	
		name.theTimer = dotNetObject "System.Windows.Forms.Timer"
		name.theTimer.interval = 500
		dotnet.addEventHandler name.theTimer "tick" func
	),
	fn start name=
	(
		name.theTimer.start()
		return true
	),
	fn stop name=
	(
		name.theTimer.stop()
		return True
	),
	fn reload name func=
	(
		name()
		functionName = name
	),
	theTimer = undefined
)
fn mainTest = (testClass.updateValue testClass)
maintTestTimer = clockClass()
maintTestTimer.create maintTestTimer mainTest
maintTestTimer.start maintTestTimer
maintTestTimer.stop maintTestTimer
