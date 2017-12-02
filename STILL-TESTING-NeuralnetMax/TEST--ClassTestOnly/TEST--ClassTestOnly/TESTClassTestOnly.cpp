// TESTClassTestOnly.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "layer.h"
#include "mathLibrary.h"
#include <iostream>
#include <string>
#include <sstream>
#include <vector>
using std::vector;
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
	cout << "Randon Float Number: " << mathLibrary::randonGenFn(-100.0, 100.0) << endl;
	cout << "Randon Int Number:   " << mathLibrary::ranIntGenFn(1, 20) << endl;
	cout << "Eulers Number:       " << mathLibrary::eulersN() << endl;
	cout << "Abs Test:            " << mathLibrary::absFn(2.151, 10.0) << endl;
	cout << "Abs Limit:           " << mathLibrary::absLimitFn(12.2, 10.2, 0.012, 15.0) << endl;
	cout << "Angle Triangulation: " << mathLibrary::angleTriFn(20.0, 35.0) << endl;
	cout << "Weight:              " << testArray[iNodes-1][oNodes-2] << endl;
	
}
int main()
{
	testMath();
	return 0;
}

