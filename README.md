# Max NeuralNet
Machine Learning Algoritm with NN inside max.

Demonstration of a neural network that will identify an location on a 3d space and learn to move an object to that location 
using one emiter which will change direction, compensating for tilt, inertia and gravity.

11/24/2017---------------------------------------------------------------------------------------------------------------------------

The algorithm is technicaly working. The object does aproach the target and stays there for a while.

The back-propagation still needs some adjustment to be perfect. 

Some of my math calculations were giving me an unexpected results, which was because of human(me!) error when creating them.

Also I have done some stress test:
        
        
        Networks----|----N of Layers----|----Nodes/layer----|----Weights/layer----|
        ------------|-------------------|-------------------|---------------------|
        Position    |        5          |        100        |       10,000        |
        Direction-1 |        3          |        100        |       10,000        |
        Direction-2 |        3          |        100        |       10,000        |

        The 3 neural network are running up to 100 times per second on a single thread.

What is new:

        Removed the 3rd direction network as it was never in use. Decresing from 4 networks to 3.
            
            1 - Position
            2 - Direction-1
            3 - Direction-2

        Added speed and distance layers to each of the directions networks in order to precisely predict the 
        angle it should be used.
    
        Removed the Absolute tilt layer as it should not have weights for it being an Input value 
        - Noting that the distance still has weights for it still takes in consideration the general angle in which 
        the source is from the target, as example, the Absolute distance should not have the same weight for being 
        10 meters above as it has for being below the target. It is a cheat to save weight space and nodes. 

        Many functions in the mathLybrary have been revisited and fixed.

        General polish and the addition of comments to the code itself.
    
        Issues Fixed:------------------------------------------------------------------------------------------------

        Emiter not leting object reach "Infinitesly small" distance. 
    
        Absolute distance getting getting infinitesly small or large, sending object flying away and breaking 
        the algoritm. 
            - This problem was avoided by not having conflicts between Absolute maximum distances and maximum 
            Delta being equal.

        Rogue weights have been, for the most part, fixed.
            - I will work on the optimization algorithm, for the most part is working with a sigmoid Function 
            and depending on the layer, a Binary rectifier function, but the training is quite slow and the results 
            are not as precise as i would like them to be.

        Orientation issue has been fixed, now the source is going in the right direction.
            - This was one of the math calculations re-writen with a better optimization method.


Needs:

        Problems described above are the main issues still looming.

        I have to come with a solution for the node distribution taking in consideration maximum and minimum values.
        Example, speed values will have nodes representing values between the Maximum value and the negative Maximum
        value or the minimum value. The issue I have to fix right now is for distributing the nodes also for values
        like absolute distance which the minimum value is 0, so the first node should be equivalent to 0, 
        not the Negative of the maximum value. 

        The node distribution is a big problem for the direction as well. While the first node would be equivalent to
        a negative of the maximum tilt, the values can range from 0 to 360 degree, whith that, 
        I am losing quite a bit of information, and have to compress that information even more when going to 
        the wind tilt which is even more limited.

        To solve the two above issues, the solution i have been using is to add more nodes, but it has its limitations
        as it drasticaly reduces preformance as well as increasing training time. 

        Code needs some cleaning to be done. Main algorithm is very much done, now it needs to be organized.

Future:

        I diddled around creating a layer class in order to deal with each of the layers and hold its parameters and
        methods, this seems like a good solution for the next interation of the algorithm, as it will require major 
        re-writing.
        Doing that will allow add and removal of layers to the network much easier. Right now i have to go into almost
        every class to remove it manualy.

        The other plans for the future are still in place when the current issues are solved.



11/22/2017---------------------------------------------------------------------------------------------------------------------------

Part - 1

Fixing some of the previous stated issues and added new some new modules. Code still contains testing modules which will be removed after testing.

What is new:
    
        Issues Fixed:------------------------------------------------------------------------------------------------

        Emiter sending object flying away when above the target.
        Emiter using maximum force.
        Issue of rogue weights being miscalculated. 

        MathLibrary Class:-------------------------------------------------------------------------------------------

        Weight calculation has been adjusted. - Note, it is not perfect yet. 

        Wind force calculation adjusted. - Working well enought, but still facing the problem of turning off 
        when getting close to target.

        Prediction Class:--------------------------------------------------------------------------------------------

        Changes on the acl and speed pred secondary inputs in order to fix the predictions.

...

There will not be a second part. New aditions explained on the next interation.

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
                  Ad      |     Absolute Distance  |     0 - 1.0          |         ---                ---
                  ld      |     local Distance     |  -1.0 - 1.0          |         ldW            -1.0 - 1.0
                  Sp      |     Speed              |  -1.0 - 1.0          |         SpW            -1.0 - 1.0
                  Al      |     Aceleration        |  -1.0 - 1.0          |         AlW            -1.0 - 1.0
                  wp      |     Past Wind force    |     0 - 1.0          |         ---                ---
                  WF      |     Present Wind Force |     0 - 1.0          |         wpW            -1.0 - 1.0

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
