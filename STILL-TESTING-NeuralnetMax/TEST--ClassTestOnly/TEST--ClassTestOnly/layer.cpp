#include "stdafx.h"
#include <vector>
#include <string>
#include "mathLibrary.h"
#include "layer.h"
#include <string>

using namespace std;
using std::vector;

struct layer
{
	string layerName;
	string type;
	float maxValue;
	int numberNodes;
	int exitNodes;

	float currentValue;
	float currentRelative;
	float pastValue;

	float weightArray;
	float weight;
	int weightPosition;

	int pastweight;
	int pastweightPosition;

	float prediction;
	float pastprediction;
	//#define typeNumber

	float ousideVal;
	float outsideMax;
	void initType(int typeNumber)
	{
		switch (typeNumber)
		{
		case 1:
		{
			string type = "Distance";
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
		}
		case 2:
		{
			string type = "Angle";
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
		}
		case 3:
		{
			string type = "Movement";
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
		}
		case 4:
		{
			string type = "Wind";
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
		}
		case 5:
		{
			string type = "Object";
			float currentValue[3];
			float pastValue[3];
			float pastprediction[3];
			break;
		}
		}
	}
	void initWeights()
	{
		if (type == "Angle")
		{
			std::vector<std::vector<std::vector<float> > > weightArray;
			for (int a = 0; a < 3; a++)
			{
				weightArray[a] = mathLibrary::arrayGenFn(numberNodes, exitNodes);
			}
		}
		std::vector<std::vector<float> > weightArray = mathLibrary::arrayGenFn(numberNodes, exitNodes);
	}
};