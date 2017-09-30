fn unregisterAllTimeCallBacks =
(
	unRegisterTimeCallback printBoxPos
	unRegisterTimeCallback windSpeedChange
	unregisterTimeCallback maxSpeedFinder
)
unregisterAllTimeCallBacks()





bThen = b.pos[3]
bPrevious = b.pos[3]
windStrgAVG = 0.0
allSpeedsArray =#()
w.strength  = 10
maxAcceleration = 70.45/10
gForce = -386.22
maxSpeed = 150
windForce = w.strength
counter = 0
bPast = b.pos[3]
initBpast = bPast
windAcel = 0
speedNow = b.pos[3]-bPast
bMass = b.MassFX_Rigid_Body.mass
prevDist = b.pos[3]/bDummy.pos[3]
stepsBetweenUses = 1
objPos = b.pos[3]/bDummy.pos[3]
eulerNum = 2.718281828459045



fn randomGen = (random 0.0 1.0)

fn printBoxPos= (if nvpx.IsSimulating() == false do (print "No animation running"))

fn accFinder bPast speedNow=(
	/* Nex is where i get and calculate the aceleration of the object,
	   the number will be turned into an absolute value between -1 and 1 as 1 being the maximum acceleration. */

	local var = ((speedNow-(b.pos[3]-bPast))/(maxAcceleration)) --Calculate the acceleration against a set maximum acceleration set previously
		
	/* In here I will set the maximum possible aceleration, 
	   my calculation is not taking kinks on the acceleration like sudent change in speed or the account for gravity.
	   when the aceleration is over the absolute number of 1 it will be set to the maximum acceleration,
	   the negative counterpart will be set to the negative of the maximum limit*/
	if var <=1.0 and var >= -1.0 do (acel = var)
	if var > 1.0 do (acel = maxAcceleration) 
	if var < -1.0 do (acel = -maxAcceleration)
	return acel)

fn speedFinder bPast= (b.pos[3]-bPast)

fn dirFinder bPrevious=(
	/* In here i will find the direction where the object is going, it can be a binary of up or down.*/
	local dir = ((bDummy.pos[3]-b.pos[3])/(bDummy.pos[3]-bPrevious))
	if dir > 0 do (objectDir = 1) --Object direction of 1 means that the object is aproaching the objective.
	if dir < 0 do (objectDir = -1) -- Object direction of -1 means the object is moving away from objective.
	if dir == 0 do ( objectDir = 0)
	return objectDir)

fn posFinder = (b.pos[3] - bDummy.pos[3])

fn distFinder objPos =(
	if objPos >= 1.0 do (dist = (((b.pos[3]-bDummy.pos[3])/bDummy.pos[3])))
	if objPos < 1.0 do (dist = (((bDummy.pos[3]-b.pos[3])/bDummy.pos[3])))
	return dist)

fn sigmFn InputVar = (1/(1+ eulerNum^(-InputVar)))

fn binaryFn inputVar binNum = (
	if binNum < 0 then
	(
		if inputVar >= 0 then (var = 0)
		else (var = inputVar)
	)
	else 
	( 
		if inputVar < 0 then (var = 0)
		else (var = inputVar)
	)
	return var)


l1w = #(randomGen(),randomGen())
l2w = #(randomGen(),randomGen(),randomGen(),randomGen())
l3w = #(randomGen(),randomGen())
l4w = #(randomGen())
l5w = #(randomGen())
l6w = #(randomGen())
NetworkLayers = #(l1w,l2w,l3w,l4w,l5w,l6w)




fn windSpeedChange windForce counter=
(
	if nvpx.IsSimulating() == true do
	(
		counter+=1
		if counter == stepsBetweenUses do
		(
			counter = 0
			NeuronOutput=#()
			windAbsolute = (windForce/maxSpeed) --Turn the wind into an absolute value with 1 would be equals to maxSpeed

		/* In here we will start to use our Neural Network, the first layer deals with deciding if the object is above or below the Objective.
		*/
			windForce = w.strength
			objPos = posFinder()
			absDist = distFinder objPos
			acel = accFinder bPast speedNow
			dir = dirFinder bPrevious
			spd = speedFinder bPast
			bPast = b.pos[3]
		/* 	This here is the representation of the neural network.

			First is an imput Layer

				inputLayer = windAbsolute * NetworkLayers[1][n]
			
			The 1st hidden layer uses a Binary activation function

				NeuronLayer1 = (binaryFn inputLayer objPos) * NetworkLayers[2][m]
			
			The 2nd hidden layer uses a Binary activation function

				NeuronLayer2 = (binaryFn NeuronLayer1 dir) * NetworkLayers[3][n]
			
			The 3rd hidden layer uses a Sigmoid activation function

				NeuronLayer3 = (sigmFn (NeuronLayer2 + absDist)) * NetworkLayers[4][o]
			
			The 4th hidden layer uses a Sigmoid activation function

				NeuronLayer4 = (sigmFn (NeuronLayer3 + spd)) * NetworkLayers[5][p]
			
			The 5th hidden layer uses a Sigmoid activation function

				NeuronLayer5 = (sigmFn (NeuronLayer4 + acel)) * NetworkLayers[6][q]
				
			The last is the output layer

				NeuronOutput = NeuronLayer5 
		*/

			for l=1 to NetworkLayers[1].count do 
			(
				inputLayer = windAbsolute * NetworkLayers[1][l]
				for m=1 to NetworkLayers[2].count do
				(
					NeuronLayer1 = (binaryFn inputLayer objPos) * NetworkLayers[2][m]
					
					for n=1 to NetworkLayers[3].count do 
					(
						NeuronLayer2 = (binaryFn NeuronLayer1 dir) * NetworkLayers[3][n]
					
						for o=1 to NetworkLayers[4].count do
						(
							NeuronLayer3 = (sigmFn (NeuronLayer2 + absDist)) * NetworkLayers[4][o]
					
							for p=1 to NetworkLayers[5].count do
							(
								NeuronLayer4 = (sigmFn (NeuronLayer3 + spd)) * NetworkLayers[5][p]
					
								for q=1 to NetworkLayers[6].count do
								(
									NeuronLayer5 = (sigmFn (NeuronLayer4 + acel)) * NetworkLayers[6][q]
									append NeuronOutput NeuronLayer5
								)
							)
						)
					)
				)
			)
		)
	)
)
fn backPropagation objPos absDist acel dir spd NetworkLayers NeuronOutput = 
(
	/*
	So this is the back propagation method. I am not completely sure on which method use. 
	Those are the atributes I have. 
	
	Aceleration
	Speed
	Distance
	Position
	Direction
	WindForce

	The weight for each layer

	My option is to make an DataSset of the values, then calculate the necessary speed, aceleration to cover the necessary distance in the necessary range of time,
	 also taking in consideration maxmum speed and aceleration 
	*/
	
)