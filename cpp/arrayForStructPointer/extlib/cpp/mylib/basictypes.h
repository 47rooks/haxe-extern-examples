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

	int sum(int a, int b);

	void sumOutParam(int a, int b, int* out);

	// FIXME Move to StringTypes.
	//const char* concat(const char* a, const char* b);
	//std::string concat(const char* a, const char* b);
};
