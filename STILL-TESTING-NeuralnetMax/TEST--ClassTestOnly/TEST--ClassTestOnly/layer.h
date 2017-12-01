#include <string>
#include <vector>
using namespace std;
using std::vector;

struct layer
{
	string layerName;
	string type;
	float maxValue;
	int numberNodes;

	float currentValue;
	float currentRelative;
	float pastValue;

	float weight;
	int weightPosition;

	float pastweight;
	float pastweightPosition;

	float prediction;
	float pastprediction;

	float ousideVal;
	float outsideMax;

	void initType(int typeNumber)
	{
		switch(typeNumber)
		{
			case 1:
			{
				type = "Distance";
				float maxValue;
				int numberNodes;
				float currentValue;
				float pastValue;
				float pastprediction;
				float weight;
				float pastweight;
				int weightPosition[2];
				int pastweightPosition[2];
				break;
			};
			case 2:
			{
				type = "Angle";
				float maxValue;
				int numberNodes;
				float currentValue[3];
				float pastValue[3];
				float prediction[3];
				float pastprediction[3];
				float weight[3];
				float pastweight[3];
				int weightPosition[3][2];
				int pastweightPosition[3][2];
				break;
			};
			case 3:
			{
				type = "Movement";
				float maxValue;
				int numberNodes;
				float currentValue;
				float pastValue;
				float pastprediction;
				float weight;
				float pastweight;
				int weightPosition[2];
				int pastweightPosition[2];
				break;
			};
			case 4:
			{
				type = "Wind";
				float maxValue;
				int numberNodes;
				float currentValue;
				float pastValue;
				float pastprediction;
				float weight;
				float pastweight;
				int weightPosition[2];
				int pastweightPosition[2];
				break;
			};
			case 5:
			{
				type = "Object";
				float currentValue[3];
				float pastValue[3];
				float pastprediction[3];
				break;
			};
		}
	}
	//void initWeights()
};