# Max NeuralNet
Machine Learning Algoritm with NN inside max.

Demonstration of a neural network that will identify an location on a 3d space and learn to move an object to that location using 3 wind emitters, compensating for inertia and gravity.

10/30/2017-

Right now I am working on updating to only one emiter which will change direction and angle in order to stay up.

The previous version of the script is in the alpha folder, it will not be updated.

11/04/2017-

New interation of the project - Still in progress.

-Separated the functions into different classes
-Separated the classes into diferent scripts 
-Changed from 3 emiters to a single emiter that will change directions.
-Added 3 layers to take the angle or tilt in consideration.
-As of now the algoritm is not finished or tested.

Needs:

	- Finish the last algoritm - I am turning the last function into a class by itself and need to figure out how to correlate the angle with the force. The solution might be easy, but i need to spend more time on it. 
	- Test - As far as now, i have not completely tested all of the classes and had some issues when trying to run them so probably after i finish the last algoritm, there will be alot of testing and fixing.
	- Shrink the code - Right now the code is very explicit on all of the classes for readability. After i finish the above steps, i should get the code to be a bit smaller. 
	- Add comments - Folowing the same problem as the issue above, the code needs more readability. 

future:

	-Add obj Options - theoricaly the algoritm can hold as many diferent objects as long as there are as many dummys and windEmiters. After the above issues are fixed, i should tackle the scalability of the algoritm.
	-Translate into C++ - this will be in the future, the code needs to be working very well before that.
	-Build interface - this will be done before or after the translation, or maybe during. 
