/*


To start the main class, we have to initialize the other classes. 

constantClass() - include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----constantClass.ms"
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

include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----constantClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----mathLibrary.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----ObjClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----weighHandler.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----posClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----spdClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----acelClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----predictionClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----valueClass.ms"
include "C:\Users\Samir\Documents\GitHub\MachineLearningMax\machineLearning\NeuralNetBeta\TESTED-OK----windClass.ms"

--  1- Initialize:

const = constClass()
mathClass()

fn testLimitParameters delta sourceObj=
(
	dist = [const.maxDistance,const.maxDistance,const.maxDistance]

	if delta[1] > dist[1] or delta[2] > dist[2] or delta[3] > dist[3] do 
	(
		sourceObj.pos = [20,20,20]
	)
)

fn testMainClassFn = 
(
	simulation1 = objClass()
	weightsS1 = weightClass()
	posS1 = posClass()
	spdS1 = spdClass()
	acelS1 = acelClass()
	predS1 = predClass()
	valueS1 = valueClass()
	windS1 = windClass()


	simulation1.initAll simulation1 a b w
	weightClass.init weightsS1


			/* 
				Get the variables from each tilt, 1=X, 2=Y and 3=Z. 
				The X and Y have the same maxWind speed and Z has a higher one as it has to account for gravity. 
				Then for last we will assign the speed of the last frame as spdPastAbs.
			*/

	simulation1.updateValue simulation1
	posS1.updatePos posS1 simulation1
	spdS1.updateSpd spdS1 posS1
	acelS1.updateAcel acelS1 spdS1

			/*
				In here we will use some functions to get the wind from used in the last frame.
				Then the delta of the position from the last frame to now.
			*/

	predS1.updateValues predS1 posS1 spdS1 acelS1

			/*
				Next I will take all f the previous values in the other classes and import them into a single class.
			*/

	valueS1.importVar valueS1 posS1 spdS1 acelS1 predS1

			/*
				Next, the Weight class will Import the values from the Values class and update the weights using back backPropagation. 
				The weights are calculated as the derivate of the previous prediction, the actual result and the past values.
				Right now I am using mainly a sigmoid function to get the weight, but I will update to another function soon.
				The last function will catch the waights and save them into their variables to be used in the wind Class.
			*/

	weightsS1.importVar weightsS1 valueS1
	weightsS1.updateWeight weightsS1
	weightsS1.catchCurrent weightsS1

			/*
				Now it is the Wind calculation class. It has been tested and is working so far as no bugs, but it still needs to be tested with the simulation.
				Right now the calculation is a simple FFN the value of each layer is multiplied by the weight.
				After the multiplication of that layer is completed, it then is added to the multiplication fo the next layer.
				The average fo the layers is multiplied to the weight of the tilt then to the tilt absolute.
				After the tilt is calculated, the average of the previous layers is summed into every axis.
				The average number of every axis should be a number between -1 and 1 this number is multiplied to the maxWind to be the wind Force. 
			*/

	windS1.importValues windS1 valueS1 weightsS1
	windS1.updateAbsolute windS1
	windS1.calculate windS1
			/*
				Now that i have the final wind I can assign it to the wind Object.
			*/

	simulation1.updateWind simulation1 windS1

			/*
				Now i will update the past Values to be used on the next interation.
			*/

	posS1.updatePast posS1
	spdS1.updatePast spdS1
	acelS1.updatePast acelS1
	testLimitParameters posS1.delta simulation1.source
	--debug
	
	format "End Angle: %\n" (simulation1.windObj.dir)
	format "Start tilt: % % %\n" (posS1.tilt[1]/180) (posS1.tilt[2]/180) (posS1.tilt[3]/180)
)
