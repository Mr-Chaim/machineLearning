# Max NeuralNet
Machine Learning Algoritm with NN inside max.

Demonstration of a neural network that will identify an location on a 3d space and learn to move an object to that location 
using one emiter which will change direction, compensating for tilt, inertia and gravity.



11/18/2017---------------------------------------------------------------------------------------------------------------------------

Main algorithm has been finished, the classes are all working and a clock class has been added in order to have 
more control over time intervals between runs.

A good reminder or Note is to take in consideration that in 3ds max Space, the X(angle) should be negative if Y 
and Z coordenates are positive. To explain a bit more:

        - Lets take a rectangle triangle a,b,c. The side a = Y and b = Z,(Y=30,Z=25), with Hipotenuse = 43, aprox. 

        - The resulting angles are (ac=35.5,ab=90,bc=54.5). Because of 3ds max rotation, If the ac angle is 
        placed on X, the result would be equivalent to the coordenate (30,-25). So in order to avoid the issue, 
        that is taken in consideration when rotating an object.

What is new:

        Constant Class Change:---------------------------------------------------------------------------------------


        An Init function has been created to set the value for the constants.

        A new constant was created to determine the maximum distance an object can be from the target and to get an 
        absolute distance value from the source to the target.


        Positional Class Changes:------------------------------------------------------------------------------------


        Added Local Tilt - The local Tilt is designed to show at what direction the object is going in comparison 
        from the previous position to the current position. - Past position as point of Reference.

        Added Absolute Distance - The absolute distance was added to aid more explicitly say how far the object is 
        from the target. - Target position as point of Reference.

        Added Absolute Tilt - the absolute Tilt will always say what the direction the target is to the source. 
        - Source position as point of reference.

        Speed and Aceleration Classes have been merged with Position class in order to make a single class to process 
        all of the positional input.

        All of the values will transition from a class to another only through the Value class in order to work with 
        multi threading in the future, also to have more variable control betweeen classes.

        All past values will be updated in a single function on the Value class. 


        Weight/Network Class Changes:--------------------------------------------------------------------------------


        Each Node's weight will only be selected depending on the Nodes value and the Next node. - This for some 
        reason was overlooked by me in previous interations and worked but gave me only a fraction of the weight 
        possibilities I was supposed to have. 

        Each layer can have any number of nodes, testing now has been up to 100 nodes per layer with 10.000 weights 
        per layer.

        The wind layer also has weights and they are selected by the absolute distance and angle to the target. 


        Math Class Changes:------------------------------------------------------------------------------------------


        Because of the changes in weight number and to make space for scalability, the calculation for weight 
        position had to be changed to englobe input and output nodes. 

        Some of the math functions have been separated and so formulas can be used more broadly.

        Some obsolete functions have been deleted.

        Constrain function now has new Input for n of nodes in the layer being used.

        The tilt function has been fixed to show the exact value is expected from X and Y tilt. The values of tilt 
        range from -180 to 180.

        Some of the prediction functions have merged into a single, better suited new formula - More details on the 
        comments of PredFn in MathClass

        Array creator function has been modified to take the number of layers it needs to generate, it will generate 
        X number of Nodes with X number of weights for each Node. 
        - In hindside, that might create a problem when the number of input Nodes are not equal to the next Layer 
        number of nodes, but that will have to be fixed later. 

        The wind Function is Still in test faze, more details on the Issues sections.  


        Wind Class Change:-------------------------------------------------------------------------------------------


        The Wind class now will be used 2 times, one to estimate the wind to be used in order to get the wind weight, 
        then when all of the weights are gathered, a second time in order to get the final calculation. 
        - Thinking again, i might not use it the first time, but will have to check it again to make that change as 
        the main factors for the weight gathering for wind are the absolute distance to the target and the angle the
        source is from the target.


        Object class change:-----------------------------------------------------------------------------------------


        This class is the only one who has control over the whole algoritm input and output.

        It takes the current position of source and target.

        It does not input any state of the wind Object - On purpose.

        It as the output, it will use the final wind force and wind tilt imported from the Value class. 
        The first step is to zero the rotation of the wind object, then rotate on the designated X angle,
        then Rotate on the Y angle. After that the wind force is applied to the Wind Object. 

Issues:

        One issue is the source not coming down when its above the target.-------------------------------------------

                While it should be decreasing weightForce in order to adjust the weights, 
                seems like the weights are not making much difference there.

                The problem is probably my method of calculating the final force, the folowing is the formula:

                Acronym---|---------Variable-------|--Range of Value------|----Weight Acronym-----Weight Range
                          |                        |                      |                  
                --Ad      |     Absolute Distance  |     0 - 1.0          |         ---                ---
                --ld      |     local Distance     |  -1.0 - 1.0          |         ldW            -1.0 - 1.0
                --Sp      |     Speed              |  -1.0 - 1.0          |         SpW            -1.0 - 1.0
                --Al      |     Aceleration        |  -1.0 - 1.0          |         AlW            -1.0 - 1.0
                --wp      |     Past Wind force    |     0 - 1.0          |         ---                ---
                --WF      |     Present Wind Force |     0 - 1.0          |         wpW            -1.0 - 1.0

                WF = (wp * Wpw) + (Ad - ((ld*ldw)/3 + (Sp * Spw)/3 + (Al * Alw)/3)

                To be honest, i really dont like this formula.


        The windForce shortCircuit when very close to the target.----------------------------------------------------

                Then calculations are not in the stage where this happens often so i did not work on that side 
                of the problem. As a reminder, the alpha version had the same problem in the begining and 
                i hacked away a solution by setting a minimum distance where another set of 
                calculations would kick in. In this case, i created a maleable set of constants to be used, 
                so the constants for max wind, dist,acel,abs distance can theoricaly be changed so 
                the calculations become more precise. - Probably the next step after solving the above issue.

        Max constants are not working very well.---------------------------------------------------------------------

                The constants have to be set manualy and adjusted in order to give a better read. 
                Because some of the limits are never achieved or they are achieved too often, 
                the distribution of neurons has been a bit lacking. 
                Example - The source might be moving at a maximum of 50% of its set maximum speed, 
                so we have 50% of weights not being used, solving the above problem will be a start 
                on getting a solution, in the future, I have to create a function to analyze the max 
                values and re-set the constants.

Future:

        Organize the Usability, because of test being ran, there are many debuging and analytics being output 
        to the listener, as well as the main function being re organized to be restarted at any time. 

        The other plans for the future are still in place when the current issues are solved.


-------------------------------------------------------------------------------------------------------------------------------------


11/04/2017---------------------------------------------------------------------------------------------------------------------------

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

        - Finish the last algoritm - I am turning the last function into a class by itself and need to figure 
        out how to correlate the angle with the force. 
        - Test - As far as now, I have not completely tested all of the classes and had some issues when 
        trying to run them.
        - Shrink the code - Right now the code is very explicit on all of the classes for readability. 
        - Add comments - Folowing the same problem as the issue above, the code needs more readability. 

Future:

        -Add obj Options - theoricaly the algoritm can hold as many diferent objects as long as there are as 
        many dummys and windEmiters. 
        -QA - Batery of tests and QA to find bugs.
        -Translate into C++ - this will be in the future, the code needs to be working very well before that.
        -Build interface - this will be done before or after the translation, or maybe during. 


-------------------------------------------------------------------------------------------------------------------------------------


10/30/2017---------------------------------------------------------------------------------------------------------------------------

	-Right now I am working on updating to only one emiter which will change direction and angle in 
	order to stay up.
	-The previous WORKING version of the script is in the alpha folder, it will not be updated.
