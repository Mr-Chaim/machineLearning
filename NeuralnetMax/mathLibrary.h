#pragma once
#include <iostream>
#include <vector>
#include <cmath>
#include <stdlib.h>
#include <time.h>
#include <iomanip> // setprecision
#include <sstream> // stringstream

using std::vector;
using namespace std;

class mathLibrary
{
public:
//Basic Math Functions ---------------------------------------------------------------------------------------------------------------------

	const double eulersN()
	{

		double result = std::exp(1.0);

		return result;
	}
	float absFn(float inputValue, float maxValue)
	{
					
		float iVar = inputValue;
		float maxVar = maxValue;
		float absRes = iVar/maxVar;
		
		return absRes;
	}
	float absLimitFn(float inputCurrValue, float inputPastValue, float iWeight, float maxConstant)
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
	}
	float angleTriFn( float iHipotenuse, float iSingleAngle)
	{
		
		float hipAVar = iHipotenuse;
		float angAVar = iSingleAngle;
		float angCCnst = 90.0;

		float angBRes = 180 - (angAVar + angCCnst);
		float sideBres = (sin(angBRes) * hipAVar);
		float sideCres = (sin(angAVar) * hipAVar);

		return (sideCres,sideBres);
	}
	std::vector<std::vector<float>> arrayGenFn(int iLevelOne, int iLeveltwo)
	{
			
		int nNodesPrim = iLevelOne;
		int nNodesSeco = iLeveltwo;

		vector<vector<float>> iArr(nNodesPrim);
		for ( int a=1; a < nNodesPrim; a+1){
			vector<float> iArr2(nNodesSeco);
			for ( int b=2; b < nNodesSeco; b+1){
				float foo = randonGenFn(-1.0, 1.0);
				iArr2.push_back(foo);	
			}
			iArr.push_back(iArr2);
			iArr2.clear();
		}
		
		return iArr;
	}
	bool binaryFn(float inputValue, float ilowValue, float ihighValue)
	{
		
		bool foo = 0;
		float iVar = inputValue;
		float lowV = ilowValue;
		float higV = ihighValue;

		if ((iVar > lowV) && (iVar < higV)){
			foo = 1;
		}

		return foo;
	}
	float binaryRectFn(float inputValue, float ilowValue, float ihighValue)
	{
			
		float iVar = inputValue;
		float lowV = ilowValue;
		float higV = ihighValue;
		float foo = (1.0 * (iVar/(abs(iVar))));

		if ((iVar > lowV) && (iVar < higV)){
			foo = iVar;
		}

		return foo;
	}
	int constrainFn(float inputValue, int iNLayers, int iMinValue)
	{
			
		float iVar = inputValue;
		int nLayer = iNLayers;
		int minVal = iMinValue;
		int finalRes = 0;
		int halfL    = 0;
		float lmtRes = 0.0;
		float intRes = 0.0;

		if (minVal < 0)
		{
			halfL = static_cast<int>(nLayer/2);
			lmtRes = binaryRectFn(iVar, minVal, 1);
			intRes = ((lmtRes*halfL)+halfL);
		}
		else 
		{
			lmtRes = binaryRectFn(iVar, minVal, 1);
			intRes = ((lmtRes*nLayer)+nLayer);
		}
		finalRes = static_cast<int>(binaryRectFn(intRes, 0, nLayer));
			
		return finalRes;
	}
	float randonGenFn(float iMinValue, float iMaxValue)
	{
		
		float minVar = iMinValue;
		float maxVar = iMaxValue;
		srand(time(NULL));
		float valRes = (((rand() % 200)-100)/100);

		return valRes;
	}
	float sigmoidFn(float inputValue)
	{
		
		double E = eulersN();
		float iVar = inputValue;
		float sigRes = 1.0/(1.0 * pow(E,-iVar));
		
		return sigRes;
	}
	stringstream twoDecFn(float inputValue, int iPrecision)
	{
		float iVar = inputValue;
		int decVar = iPrecision;
		stringstream nDecFloat;
		nDecFloat << fixed << setprecision(decVar) << iVar;
		
		return nDecFloat;
	}

// Weight Calculations ------------------------------------------------------------------------------------------------------------------------------------------------------------

	float calcWeightFn(float iCurrVal, float iPredVal, float iPastW)
	{
		
		float currVar = sigmoidFn(iCurrVal);
		float predVar = sigmoidFn(iPredVal);
		float pastW = iPastW;
		float calcR = (pastW+(currVar-predVar)/2);
		float newWRes = binaryRectFn(calcR, -1.0, 1.0);
		
		return newWRes;
	}
	int getWeightPosFn(float iPrimVal, float iSecVal, float iMaxPrim, float iMaxSec, int nLayers, int iPriMinVal, int iSecMinVal) //Remember that tlt is an angle so it should not be imput as a float
	{
		
		float curVar = iPrimVal;
		float secVar = iSecVal;
		
		float mPCnst = iMaxPrim;
		float mSCnst = iMaxSec;

		int priMin = iPriMinVal;
		int secMin = iSecMinVal;

		float absPrimRes = absFn(curVar, mPCnst);
		float absSecRes = absFn(secVar, mSCnst);

		float absPrimLmt = binaryRectFn(absPrimRes, -1.0, 1.0);
		float absSecLmt = binaryRectFn(absSecRes, -1.0, 1.0);

		int posPrimRes = constrainFn(absPrimRes, nLayers, priMin);
		int posSecRes = constrainFn(absSecRes, nLayers, secMin);
		
		return (posPrimRes,posSecRes);
	}
	int getWndFWeightPosFn(float IpriValue, float IsecValue, float ItltValue, float ImaxPriValue, float ImaxSecValue, float ImaxTlt, int nLayers, int iPriMinVal, int iSecMinVal) //Remember that tlt is an angle so it should not be imput as a float
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
	}
	float getWeightFn(int IWeightArr[], int Iposition[])
	{
		
		int position1 = Iposition[1];
		int position2 = Iposition[2];
		float weightVar = IWeightArr[position1][position2];

		return weightVar;
	}
	float weightUpdtFn(float IpriVal, float IsecVal, float IValPPred, float IpastWeight, float maxVal1, float maxVal2)
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
		
		float resCurr = priA;
		float resPred = ( abs(secA) - 1) - pPrA;
		
		float newWRes = calcWeightFn(resCurr, resPred, PastW);

		return newWRes;
	}
	float tltWeightUpdateFn(float IpriVal, float IsecVal, float IValPPred, float IpastWeight, float maxVal1, float maxVal2)
	{
	
		float priVar   = IpriVal;
		float SecVar   = IsecVal;
		float pPredVar = IValPPred;
		float PastW    = IpastWeight;

		float maxPri = maxVal1
		float maxSec = maxVal2

		float priA = absFn(priVar, maxPri);
		float secA = absFn(SecVar, maxSec);
		float pPrA = absFn(pPredVar, maxPri);
		
		float priLmt = binaryRectFn(priA, -1.0, 1.0);
		float secLmt = binaryRectFn(secA, -1.0, 1.0);
		float pPrLmt = binaryRectFn(pPrA, -1.0, 1.0);
		float PastW  = binaryRectFn(PastW, -1.0, 1.0);
		
		float resCurr = (priA * secLmt);
		float resPred = (pPrA * secLmt);
		
		float newWRes = calcWeightFn(resPred, resCurr, PastW);

		return newWRes;
	}
	float wndWUpdateFn(float IwndFPast, float IdstF, float IdstS, float ItltF, float IpastWeight, float maxW, float maxABS, float maxD, float maxT)//Remember that tlt is an angle so it should not be imput as a float
	{
	
		float wndPVar = IwndFPast;
		float dstFVar = IdstF;
		float dstSVar = IdstS;
		float tltYVar = ItltF;
		
		float maxW   = maxW;
		float maxAbs = maxABS;
		float maxD   = maxD;
		float maxT   = maxT;

		float wndPW = IpastWeight

		float wndPAbs = absFn(wndPVar, maxW);

		float dstFAbs = absFn(dstFVar, maxAbs);
		float dstPabs = absFn(dstSVar, maxD);

		float tltYAbs = absFn(tltYVar, maxT);
		
		float dstFLmt = binaryRectFn(dstFAbs, -1.0, 1.0);
		float dstPLmt = binaryRectFn(dstPabs, -1.0, 1.0);
		float tltYLmt = binaryRectFn(tltYAbs, -1.1, 1.1);

		float currRes = ((dstFLmt+dstPLmt)/2);
		float predRes = ((dstFLmt+dstPLmt)/2) - (abs tltYLmt);

		float newWRes = calcWeightFn(currRes, predRes, wndPW);
		
		return newWRes;
	}

//Position Functions -----------------------------------------------------------------------------------------------
	float dstFfn(float IsourcePos[], float ItargetPos[])
	{
		float deltaX = ItargetPos[0]-IsourcePos[0];
		float deltaY = ItargetPos[1]-IsourcePos[1];
		float deltaZ = ItargetPos[2]-IsourcePos[2];
		
		float deltaXY    = sqrt(pow(deltaX, 2) + pow(deltaY, 2));
		float deltaFinal = sqrt(pow(deltaXY,2) + pow(deltaZ, 2));

		return deltaFinal;
	}
	float movementFn(float IPastVal, float ICurrVal)
	{
		float currVar = ICurrVal;
		float pastVar = IPastVal;

		float derVar = (pastVar-currVar);
		
		return derVar;
	}
	float tltFFn(float IpastVal[], float IcurrVal[])
	{

		float deltaX = IcurrVal[0] - IpastVal[0];
		float deltaY = IcurrVal[1] - IpastVal[1];
		float deltaZ = IcurrVal[2] - IpastVal[2];
		
		float deltaXY    = sqrt(pow(deltaX, 2) + pow(deltaZ, 2));
		float angleYRes  = acos(deltaX/deltaXZ);
		
		if (deltaX > 0) or (deltaZ > 0)
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
		
		if deltaY > 0 do (angleXRes = -angleXRes)
	
		return (angleXRes,angleYRes,0);
	}
//Prediction Functions ---------------------------------------------------------------------------------------------
	float PredFn(float IprimaryVal, float IsecondVal, float IPrimaryWght, float maxPrimaryCnst, float maxSecondCnst)
	{
		float primarVar = IprimaryVal;
		float secondVar = IsecondVal;

		float primaryWVar = IPrimaryWght;

		float mP = maxPrimaryCnst;
		float mS = maxSecondCnst;

		float primarAres = absFn(primarVar, maxPCnst);
		float secondARes = absFn(secondVar, maxSCnst);

		float primaryRes = ((secondARes*(primarAres + primaryWVar))*maxPCnst);

		float primaryResLmt = binaryRectFn(primaryRes, -maxPCnst, maxPCnst)

		return primaryResLmt;
	}
	float dstPredfn(float IsourcePos[], float ItargetPos[])
	{
		float deltaX = ItargetPos[0]-IsourcePos[0];
		float deltaY = ItargetPos[1]-IsourcePos[1];
		float deltaZ = ItargetPos[2]-IsourcePos[2];
		
		float deltaXY    = sqrt(pow(deltaX, 2) + pow(deltaY, 2));
		float deltaFinal = sqrt(pow(deltaXY,2) + pow(deltaZ, 2));

		return deltaFinal;
	}
	float posPredFn(float ItltL[], float IcurrPos[], float IpredDist)
	{
		float posXvar       = IcurrPos[0];
		float posYvar       = IcurrPos[1];
		float posZvar       = IcurrPos[2];
		float knownAngleVar = ItltL;
		float hipVar        = IpredDist;

		deltasVar   = [0,0,0];
		finalposRes = [0,0,0];

		deltYRes  = mathClass.angleTriFn hipVar -knownAngleVar[1]
		deltXZRes = mathClass.angleTriFn deltYRes[2] knownAngleVar[2]

		deltaRes = [deltXZRes[1],deltYRes[1],deltXZRes[2]] 
		
		finalPosRes[1] = deltaRes[1] + posXvar
		finalPosRes[2] = deltaRes[2] + posYvar
		finalPosRes[3] = deltaRes[3] + posZvar

		return finalPosRes
	}
	float tltFFn(float IpastVal[], float IcurrVal[])
	{

		float deltaX = IcurrVal[0] - IpastVal[0];
		float deltaY = IcurrVal[1] - IpastVal[1];
		float deltaZ = IcurrVal[2] - IpastVal[2];
		
		float deltaXY    = sqrt(pow(deltaX, 2) + pow(deltaZ, 2));
		float angleYRes  = acos(deltaX/deltaXZ);
		
		if (deltaX > 0) or (deltaZ > 0)
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
		
		if deltaY > 0 do (angleXRes = -angleXRes)
	
		return (angleXRes,angleYRes,0);
	}
//Wind Calculation Functions ---------------------------------------------------------------------------------------
};

