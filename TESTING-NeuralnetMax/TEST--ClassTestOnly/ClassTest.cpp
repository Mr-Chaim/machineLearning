// TESTClassTestOnly.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "layer.h"
#include "mathLibrary.h"
#include <iostream>
#include <string>
#include <iomanip> // setprecision
#include <sstream> // stringstream
#include <vector>
using std::vector;
using std::stringstream;
using namespace std;

void testLayers()
{
	
	layer test;
	string typeNumber;
	cout << "Enter type: " << endl;
	getline(cin,typeNumber);
	stringstream testN(typeNumber);
	int x = 0; 
	testN >> x;
	test.initType(x);
	cout << "Type of layer: " << test.type << endl;
	cout << "Insert layerName: " << endl;
	getline(cin, test.layerName);
	cout << "Layer name: " << test.layerName << endl;
}
void testMath()
{
	int iNodes = 10;
	int oNodes = 10;
	srand(time(NULL));
	//mathLibrary::initRand;

	vector<vector<float>> testArray = mathLibrary::arrayGenFn(iNodes, oNodes);
	vector<int> positions = mathLibrary::getWeightPosFn(0.54, 0.9, iNodes, oNodes, -1, 0);

	cout << "Randon Float Number: " << std::setprecision(5) << mathLibrary::randonGenFn(-1.0, 1.0) << endl;
	cout << "Randon Int Number:   " << mathLibrary::ranIntGenFn(-10000, 10000) << endl;
	cout << "Eulers Number:       " << mathLibrary::eulersN() << endl;
	cout << "Abs Test:            " << mathLibrary::absFn(2.151, 10.0) << endl;
	cout << "Abs Limit:           " << mathLibrary::absLimitFn(12.2, 10.2, 0.012, 15.0) << endl;
	cout << "Angle Triangulation: " << mathLibrary::angleTriFn(20.0, 35.0) << endl;
	cout << "Weight Test:         " << testArray[iNodes-1][oNodes-2] << endl;
	cout << "Binary Function:     " << mathLibrary::binaryFn(0.5, -1.0, 1.0) << endl;
	cout << "Binary Rectifier:    " << mathLibrary::binaryRectFn(0.5, -1.0, 1.0) << endl;
	cout << "Constrain Function:  " << mathLibrary::constrainFn(0.5, iNodes, -1) << endl;
	cout << "Sigmoid Function:    " << mathLibrary::sigmoidFn(-0.5) << endl;
	cout << "Two dec Precision:   " << mathLibrary::nDecFn(1.04545554645, 10) << endl;
	cout << "Weight Calculation:  " << mathLibrary::calcWeightFn(0.2545, 0.12424, 0.45454) << endl;
	cout << "Weight Position:     " << positions[0] << "," << positions[1] << endl;
	cout << "Get weight Function: " << mathLibrary::getWeightFn(testArray, positions) << endl;
	cout << "Weight Upd Function: " << mathLibrary::weightUpdtFn(0.512, 0.321, 0.155, 0.123, -1, 0, -1) << endl;
	cout << "Tilt Weight updt:    " << mathLibrary::tltWeightUpdateFn(0.542, 0.547, 0.784, 0.241) << endl;
}
int main()
{
	testMath();
	return 0;
}

