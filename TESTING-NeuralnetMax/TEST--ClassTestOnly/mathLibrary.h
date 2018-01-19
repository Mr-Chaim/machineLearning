#pragma once
#include "stdafx.h"
#include <iomanip> // setprecision
#include <sstream> // stringstream
#include <vector>
#include <string>
#include <cmath>
#include <cstdlib>
#include <stdlib.h>
#include <ctime>
#include <math.h>

using std::vector;
using namespace std;


class mathLibrary
{
	// Basic Math Functions Used in other Functions ---------------------------------------------------------------------
public:
	static void initRand()
	{
		srand(time(NULL));
	}
	static const double eulersN()
	{
		double result = std::exp(1.0);

		return result;
	};
	static float absFn(float inputValue, float maxValue)
	{
		float absRes = inputValue/maxValue;
		
		return absRes;
	};
	static float absLimitFn(float inputCurrValue, float inputPastValue, float iWeight, float maxConstant)
	{
		float cVar = inputCurrValue;
		float pVar = inputPastValue;
		float wVar = iWeight;
		float maxC = maxConstant;
		float cAbs = absFn(cVar, maxC);
		float pAbs = absFn(pVar, maxC);
		float diffRes = (cAbs + wVar);
		float absRes = absFn(diffRes, maxC);
		float absLmt = binaryRectFn(diffRes, -1.0, 1.0);

		return absLmt;
	};
	static float angleTriFn( float iHipotenuse, float iSingleAngle)//Return the angles when given the Hipotenuse and an adj Angle.
	{
		float angCCnst = 90.0;

		float angBRes = 180 - (iSingleAngle + angCCnst);
		float sideBres = (sin(angBRes) * iHipotenuse);
		float sideCres = (sin(iSingleAngle) * iHipotenuse);

		float resultArr[2] = {sideCres,sideBres};

		return resultArr[2];
	};
	static vector<vector<float>> arrayGenFn(int iLevelOne, int iLeveltwo)//Creates level 1 number of arrays with Level 2 of interactions of value -1.0 to 1.0
	{
		vector<vector<float>> iArr(iLevelOne);
		vector<float> iArr2(iLeveltwo);
		for ( int a=0 ; a < iLevelOne ; a++)
		{
			for ( int b=0 ; b < iLeveltwo ; b++)
			{
				iArr2[b] = randonGenFn(-1.0,1.0);	
			}
			iArr[a] = iArr2;
		}
		
		return iArr;
	};
	static bool binaryFn(float inputValue, float ilowValue, float ihighValue)//Simple binary function, takes value and returns 0 if value is not between low and high inputs, otherwise returns 1.
	{
		bool foo = 0;
		
		if ((inputValue > ilowValue) && (inputValue < ihighValue))
		{
			foo = 1;
		}

		return foo;
	};
	static float binaryRectFn(float inputValue, float ilowValue, float ihighValue)//This binary function will take the value and its direction, as well as minimum and maximum values, then return -1 or +1 if value does not fall between the minimum or maximum, or initial value.
	{
		float foo = (1.0 * (inputValue/(abs(inputValue))));

		if ((inputValue > ilowValue) && (inputValue < ihighValue))
		{
			foo = inputValue;
		}

		return foo;
	};
	static int constrainFn(float inputValue, int iNLayers, int iMinValue)
	{
		float iVar = inputValue;
		int nLayer = iNLayers;
		int minVal = iMinValue;
		
		float intRes;
		int halfL;
		int finalRes;
		float lmtRes;

		if (minVal < 0)
		{
			halfL = static_cast<int>(nLayer/2);
			lmtRes = binaryRectFn(iVar, minVal, 1);
			intRes = ((lmtRes*halfL) + halfL);
		}
		else 
		{
			halfL = static_cast<int>(nLayer);
			lmtRes = binaryRectFn(iVar, minVal, 1);
			intRes = ((lmtRes*halfL));
		}
		finalRes = static_cast<int>(binaryRectFn(intRes, 0, nLayer));
		
		
		return finalRes;
	}
	static float randonGenFn(float minVal, float maxVal)
	{	
		float rangeVal = abs(maxVal - minVal);
		float valRes = ((rand()% 20000))/ 20000.0;
		float  resultVal = minVal+(rangeVal*valRes);
		return resultVal;
	}
	static int ranIntGenFn(int minVal, int maxVal)
	{
		int rangeVal = abs(maxVal - minVal);
		int valRes = ((rand() % rangeVal));
		float  resultVal = minVal + valRes;
		return resultVal;
	}
	static float sigmoidFn(float inputValue)
	{
		double E = eulersN();
		float iVar = inputValue;
		float sigRes = 1.0/(1.0 + pow(E,-iVar));
		
		return sigRes;
	};
	static double nDecFn(double inputValue, int iPrecision)//Reduces "InputValue" to "iPrecision" number of decimals.
	{
		double iVar = inputValue;
		int decVar = iPrecision;
		stringstream nDecFloat;
		nDecFloat << fixed << setprecision(decVar) << iVar;
		double finalVal;
		nDecFloat >> finalVal;

		return finalVal;
	};
	// Weight Calculations ------------------------------------------------------------------------------------------------------------------------------------------------------------
	static float calcWeightFn(float iCurrVal, float iPredVal, float iPastW)
	{
		float currVar = sigmoidFn(iCurrVal);
		float predVar = sigmoidFn(iPredVal);
		float squrtVal = sqrt(pow(currVar, 2) + pow(predVar, 2));
		float dirVal = (currVar-predVar) / abs(currVar-predVar);
		float pastW = iPastW;
		float calcR = (pastW * squrtVal*dirVal);
		float newWRes = binaryRectFn(calcR, -1.0, 1.0);
		
		return newWRes;
	};
	static vector<int> getWeightPosFn(float iPrimRVal, float iSecRVal, int nLayers, int nlayers2, int iPriMinVal, int iSecMinVal) //Remember that tlt is an angle so it should not be imput as a float
	{
		vector<int> positions(2);
		float curVar = iPrimRVal;
		float secVar = iSecRVal;

		int priMin = iPriMinVal;
		int secMin = iSecMinVal;

		float absPrimLmt = binaryRectFn(curVar, iPriMinVal, 1.0);
		float absSecLmt = binaryRectFn(secVar, iSecMinVal, 1.0);

		positions[0] = constrainFn(absPrimLmt, nLayers, priMin);
		positions[1] = constrainFn(absSecLmt, nlayers2, secMin);
		return positions;
	};
	static int getWndFWeightPosFn(float IpriValue, float IsecValue, float ItltValue, float ImaxPriValue, float ImaxSecValue, float ImaxTlt, int nLayers, int iPriMinVal, int iSecMinVal) //Remember that tlt is an angle so it should not be imput as a float
	{
		float priVar = IpriValue;
		float secVar = IsecValue;
		float tltVar = ItltValue;
		
		int priMin = iPriMinVal;
		int secMin = iSecMinVal;


		float mP = ImaxPriValue;
		float mS = ImaxSecValue;
		float mT = ImaxTlt;

		float absPriRes = absFn(priVar, mP);
		float absSecRes = absFn(secVar, mS);
		float abstltRes = absFn(tltVar, mT);

		float limTerRes = binaryRectFn(absSecRes, -1.0, 1.0);
		
		int posPRes = constrainFn((absPriRes - abs(limTerRes)), nLayers, priMin);
		int posSRes = constrainFn(absSecRes, nLayers, secMin);
		
		return (posPRes,posSRes);
	};
	static float getWeightFn(vector<vector<float>> IWeightArr, vector<int> Iposition)
	{
		int position1 = Iposition[0];
		int position2 = Iposition[1];

		float weightVar = IWeightArr[position1][position2];

		return weightVar;
	};
	static float weightUpdtFn(float IpriVal, float IsecVal, float IValPPred, float IpastWeight, int minPrim, int minSec, int minTer)
	{
		float priVar   = IpriVal;
		float SecVar   = IsecVal;

		float pPredVar = IValPPred;

		float PastW    = IpastWeight;
		
		float priLmt = binaryRectFn(priVar, minPrim, 1.0);
		float secLmt = binaryRectFn(SecVar, minSec, 1.0);
		float pPrLmt = binaryRectFn(pPredVar, minTer, 1.0);
		
		float resCurr = priLmt;
		float resPred = ( abs(priLmt) - 1) - priLmt;
		
		float newWRes = calcWeightFn(resCurr, resPred, PastW);

		return newWRes;
	};
	static float tltWeightUpdateFn(float IpriVal, float IsecVal, float IValPPred, float IpastWeight, float maxVal1, float maxVal2)
	{
		float priVar   = IpriVal;
		float SecVar   = IsecVal;
		float pPredVar = IValPPred;
		float PastW    = IpastWeight;

		float maxPri = maxVal1;
		float maxSec = maxVal2;

		float priA = absFn(priVar, maxPri);
		float secA = absFn(SecVar, maxSec);
		float pPrA = absFn(pPredVar, maxPri);
		
		float priLmt = binaryRectFn(priA, -1.0, 1.0);
		float secLmt = binaryRectFn(secA, -1.0, 1.0);
		float pPrLmt = binaryRectFn(pPrA, -1.0, 1.0);
		float PastWLmt = binaryRectFn(PastW, -1.0, 1.0);
		
		float resCurr = (priA * secLmt);
		float resPred = (pPrA * secLmt);
		
		float newWRes = calcWeightFn(resPred, resCurr, PastWLmt);

		return newWRes;
	};
	static float wndWUpdateFn(float IwndFPast, float IdstF, float IdstS, float ItltF, float IpastWeight, float maxW, float maxABS, float maxD, float maxT)//Remember that tlt is an angle so it should not be imput as a float
	{
		float wndPVar = IwndFPast;
		float dstFVar = IdstF;
		float dstSVar = IdstS;
		float tltYVar = ItltF;

		float wndPW = IpastWeight;

		float wndPAbs = absFn(wndPVar, maxW);

		float dstFAbs = absFn(dstFVar, maxABS);
		float dstPabs = absFn(dstSVar, maxD);

		float tltYAbs = absFn(tltYVar, maxT);
		
		float dstFLmt = binaryRectFn(dstFAbs, -1.0, 1.0);
		float dstPLmt = binaryRectFn(dstPabs, -1.0, 1.0);
		float tltYLmt = binaryRectFn(tltYAbs, -1.1, 1.1);

		float currRes = ((dstFLmt+dstPLmt)/2);
		float predRes = ((dstFLmt+dstPLmt)/2) - (abs(tltYLmt));

		float newWRes = calcWeightFn(currRes, predRes, wndPW);
		
		return newWRes;
	};
	//Position Functions -----------------------------------------------------------------------------------------------
	static float dstFfn(float IsourcePos[], float ItargetPos[])// This should use point3 coordenates as input
	{
		float deltaX = ItargetPos[0]-IsourcePos[0];
		float deltaY = ItargetPos[1]-IsourcePos[1];
		float deltaZ = ItargetPos[2]-IsourcePos[2];
		
		float deltaXY    = sqrt(pow(deltaX, 2) + pow(deltaY, 2));
		float deltaFinal = sqrt(pow(deltaXY,2) + pow(deltaZ, 2));

		return deltaFinal;
	};	
	static float movementFn(float IPastVal, float ICurrVal)
	{
		float currVar = ICurrVal;
		float pastVar = IPastVal;
		float derVar1 = sqrt( pow(currVar, 2) + pow(pastVar, 2) );
		float derVar2 = (currVar - pastVar) / abs(currVar - pastVar);
		float derDir = derVar1 * derVar2;
		
		return derDir;
	};
	static vector<float> tltFFn(float IpastVal[], float IcurrVal[])
	{
		float deltaX = IcurrVal[0] - IpastVal[0];
		float deltaY = IcurrVal[1] - IpastVal[1];
		float deltaZ = IcurrVal[2] - IpastVal[2];
		
		float deltaXZ    = sqrt(pow(deltaX, 2) + pow(deltaZ, 2));
		float angleYRes  = acos(deltaX/deltaXZ);
		
		if ((deltaX > 0) || (deltaZ > 0))
		{
			if (deltaX < 0)
				{
					angleYRes = 90 - angleYRes;
				}
			if (deltaZ < 0)
				{
					angleYRes = angleYRes+90;
				}
			if ((deltaX > 0) && (deltaZ > 0))
				{
					angleYRes = 90-angleYRes;
				}
		}
		if ((deltaX < 0) && (deltaZ < 0))
			{
				angleYRes = angleYRes+90;
			}
		
		float deltaFinal = sqrt(pow(deltaXZ,2) + pow(deltaY,2));
		float angleXRes  = acos(deltaXZ / deltaFinal);
		
		if (deltaY > 0) 
		{
			(angleXRes = -angleXRes);
		};
		
		vector<float> foo = { angleXRes, angleYRes, 0 };
		
		return foo;
	};	
	//Prediction Functions ---------------------------------------------------------------------------------------------
	static float PredFn(float IprimaryVal, float IsecondVal, float IPrimaryWght, float maxPrimaryCnst, float maxSecondCnst)
	{
		float primarVar = IprimaryVal;
		float secondVar = IsecondVal;

		float primaryWVar = IPrimaryWght;

		float mP = maxPrimaryCnst;
		float mS = maxSecondCnst;

		float primarAres = absFn(primarVar, mP);
		float secondARes = absFn(secondVar, mS);

		float primaryRes = ((secondARes*(primarAres + primaryWVar))*mP);

		float primaryResLmt = binaryRectFn(primaryRes, -mP, mP);

		return primaryResLmt;
	};
	static float dstPredfn(float IsourcePos[3], float ItargetPos[3])
	{
		float deltaX = ItargetPos[0]-IsourcePos[0];
		float deltaY = ItargetPos[1]-IsourcePos[1];
		float deltaZ = ItargetPos[2]-IsourcePos[2];
		
		float deltaXY    = sqrt(pow(deltaX, 2) + pow(deltaY, 2));
		float deltaFinal = sqrt(pow(deltaXY,2) + pow(deltaZ, 2));

		return deltaFinal;
	};
	static float posPredFn(float ItltL[3], float IcurrPos[3], float IpredDist)
	{
		float posXvar       = IcurrPos[0];
		float posYvar       = IcurrPos[1];
		float posZvar       = IcurrPos[2];
		float knownAngleVar = ItltL[3];
		float hipVar        = IpredDist;

		float deltasVar[3]   = {0.0,0.0,0.0};
		float finalposRes[3] = {0.0,0.0,0.0};

		float deltYRes[2]  = {(angleTriFn(hipVar, -ItltL[0]))};
		float deltXZRes[2] = {(angleTriFn(deltYRes[1], ItltL[1]))};

		float deltaRes[3] = {deltXZRes[1],deltYRes[1],deltXZRes[2]};
		
		finalposRes[0] = deltaRes[0] + posXvar;
		finalposRes[1] = deltaRes[1] + posYvar;
		finalposRes[2] = deltaRes[2] + posZvar;

		return (finalposRes[0], finalposRes[1], finalposRes[2]);
	};	
	static float tltfPredFn(float IpastVal[3], float IcurrVal[3])
	{
		float deltaX = IcurrVal[0] - IpastVal[0];
		float deltaY = IcurrVal[1] - IpastVal[1];
		float deltaZ = IcurrVal[2] - IpastVal[2];
		
		float deltaXZ    = sqrt(pow(deltaX, 2) + pow(deltaZ, 2));
		float angleYRes  = acos(deltaX/ deltaXZ);
		
		if ((deltaX > 0) || (deltaZ > 0))
		{
			if (deltaX < 0)
				{
					angleYRes = 90 - angleYRes;
				}
			if (deltaZ < 0)
				{
					angleYRes = angleYRes+90;
				}
			if ((deltaX > 0) && (deltaZ > 0))
				{
					angleYRes = 90-angleYRes;
				}
		}
		if ((deltaX < 0) && (deltaZ < 0))
			{
				angleYRes = angleYRes+90;
			}
		
		float deltaFinal = sqrt(pow(deltaXZ,2) + pow(deltaY,2));
		float angleXRes  = acos(deltaXZ / deltaFinal);
		
		if (deltaY > 0)
		{
			angleXRes = -angleXRes;
		}
	
		return (angleXRes,angleYRes,0);
	};	
	//Wind Calculation Functions ---------------------------------------------------------------------------------------
	static double wndFinlTltFn(vector<float> IlayersArr, float maxWndCnst)
	{
		int arrSize = IlayersArr.size();
		float foo = 0;

		for (int a = 0; a < arrSize; ++a)
		{
			foo += IlayersArr[a];
		}
		float layersRes = foo/arrSize;
		
		float wndFRes = binaryRectFn(layersRes, -1.0, 1.0) * maxWndCnst;

		return wndFRes;
	};
	static double wndFinlFn(vector<float> IlayersArr, float maxWndCnst)
	{
		int arrSize = IlayersArr.size();
		float foo = 0;

		for (int a = 0; a < arrSize; ++a)
		{
			foo += IlayersArr[a];
		}
		float layersRes = foo/arrSize;

		float wndFRes = binaryRectFn(layersRes, 0, 1.0) * maxWndCnst;

		return wndFRes;
	};
};