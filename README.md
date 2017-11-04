# Max NeuralNet
Machine Learning Algoritm with NN inside max.

Demonstration of a neural network that will identify an location on a 3d space and learn to move an object to that location using one emiter which will change direction, compensating for tilt, inertia and gravity.

10/30/2017-

	-Right now I am working on updating to only one emiter which will change direction and angle in order to stay up.
	-The previous WORKING version of the script is in the alpha folder, it will not be updated.

11/04/2017-

New interation of the project - Still in progress WIP.

Whats new:

	-Separated the functions into different classes.
	-Changed from 3 emiters to a single emiter that will change directions.
	-Added 3 layers to take the angle or tilt in consideration.
	-Weight creation is simpler.
	-All classes will be initialized with zeroed variables.
	-No need for confusing starting variables.
	-As of now the algoritm is not finished or tested.

Needs:

	- Finish the last algoritm - I am turning the last function into a class by itself and need to figure out how to correlate the angle with the force. 
	- Test - As far as now, I have not completely tested all of the classes and had some issues when trying to run them.
	- Shrink the code - Right now the code is very explicit on all of the classes for readability. 
	- Add comments - Folowing the same problem as the issue above, the code needs more readability. 

Future:

	-Add obj Options - theoricaly the algoritm can hold as many diferent objects as long as there are as many dummys and windEmiters. 
	-QA - Batery of tests and QA to find bugs.
	-Translate into C++ - this will be in the future, the code needs to be working very well before that.
	-Build interface - this will be done before or after the translation, or maybe during. 
