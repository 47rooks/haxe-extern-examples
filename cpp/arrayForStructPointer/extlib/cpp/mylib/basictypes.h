#pragma once

/// <summary>
/// BasicTypes is a simple test class for basic types. There are no
/// structures or classes returned or passed.
/// </summary>
class __declspec(dllexport) BasicTypes
{
public:
	int getInt();

	int* getIntPtr();

	int& getIntRef();

	bool getBool();

	bool* getBoolPtr();

	bool& getBoolRef();
};
