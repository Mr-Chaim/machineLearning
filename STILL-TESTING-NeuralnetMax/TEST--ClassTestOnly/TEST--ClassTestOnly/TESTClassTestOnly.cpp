// TESTClassTestOnly.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "layer.h"
#include "mathLibrary.h"
#include <iostream>
#include <string>
#include <sstream>


int testLayers()
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
    return 0;
}
int testMath()
{
	mathLibrary math;
	cout << "Eulers Number: " << math.eulersN() << endl;
	cout << "Abs Test: " << math.absFn(2.151, 10.0) << endl;
	return 0;
}
int main()
{
	testLayers();
	return 0;
}

