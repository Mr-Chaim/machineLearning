#include "stdafx.h"


class constantValues : public constantConstrctor
{
public:
	void initStandardValues()
	{
		setMaxAbsoluteDistance(500.0);
		setMaxWind(10.0);
		setMaxDirection(100.0);
		setMaxSpeed(5.0);
		setMaxAceleration(10.0);
		setMaxTilt(25.0);
		setMaxWindTilt(25.0);
	}
	void manualInitiValues()
	{
		cout << "Max Absolute Distance: " << endl;
		cin >> mAbsI;
		setMaxAbsoluteDistance(mAbsI);

		cout << "Max Wind force: " << endl;
		cin >> mWI;
		setMaxWind(mWI);

		cout << "Max Max Delta: " << endl;
		cin >> mDI;
		setMaxDirection(mDI);

		cout << "Max Speed: " << endl;
		cin >> mSI;
		setMaxSpeed(mSI);

		cout << "Max Aceleration: " << endl;
		cin >> mAI;
		setMaxAceleration(mAI);

		cout << "Max Tilt: " << endl;
		cin >> mTI;
		setMaxTilt(mTI);

		cout << "Max Wind Tilt: " << endl;
		cin >> mWTI;
		setMaxWindTilt(mWTI);
	}
private:
	float mAbsI, mWI, mDI, mSI, mAI, mTI, mWTI;
};