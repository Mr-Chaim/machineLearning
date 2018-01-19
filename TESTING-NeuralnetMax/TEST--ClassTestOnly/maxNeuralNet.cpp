// TESTClassTestOnly.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


using std::vector;
using std::stringstream;
using namespace std;
using namespace TESTClassTestOnly;
using namespace System;
using namespace System::Windows::Forms;


void mainCalculation()
{
	_constantValues newC;
	float testVal[] = { 12.23, 43.32, 42.23 };
	float testVal2[] = { -52.24, 78.32, 141.23 };
	float testFloat[1] = { 23.212 };
	float testMaxValue = newC._maxD;
	int nodeType = 1;
	float *testPointer1;
	testPointer1 = testVal;

	_nodeTemplate distNode(nodeType, testVal, testVal2, 'X', newC._maxD);
	_nodeTemplate movNode(2, testVal, testVal2, 'X', newC._maxM);
	_nodeTemplate tiltNode(3, testVal, testVal2, 'Y', newC._maxT);

	distNode.update();
	movNode.update();
	tiltNode.update();

};

[STAThreadAttribute]
int main()
{
	/*
	_constantValues newC;
	
	float val1 = mathLibrary::randonGenFn(1.0 , 200.0);
	float val2 = mathLibrary::randonGenFn(1.0, 200.0);
	float val3 = mathLibrary::randonGenFn(1.0, 200.0);
	float val4 = mathLibrary::randonGenFn(1.0, 200.0);
	float val5 = mathLibrary::randonGenFn(1.0, 200.0);
	float val6 = mathLibrary::randonGenFn(1.0, 200.0);

	float val7 = mathLibrary::randonGenFn(1.0, 200.0);


	float testVal[] = { val1, val2, val3 };
	float testVal2[] = { val4, val5, val6 };
	float testFloat[1] = { val7 };
	float testMaxValue = newC._maxD;
	int nodeType = 1;
	float *testPointer1;
	testPointer1 = testVal;

	_nodeTemplate distNode(nodeType, testVal, testVal2, 'X', newC._maxD);
	_nodeTemplate movNode(2, testVal, testVal2, 'X', newC._maxM);
	_nodeTemplate tiltXNode(3, testVal, testVal2, 'X', newC._maxT);
	_nodeTemplate tiltYNode(3, testVal, testVal2, 'Y', newC._maxT);
	_nodeTemplate tiltZNode(3, testVal, testVal2, 'Z', newC._maxT);

	distNode.update();
	movNode.update();
	tiltXNode.update();
	tiltYNode.update();
	tiltZNode.update();
	*/
	//Enabling Windows XP visual effects before any controls are created

	Application::EnableVisualStyles();
	Application::SetCompatibleTextRenderingDefault(false);
	
	//Create Main winwo and run it
	
	Application::Run(gcnew nnWindow());

	return 0;
};
