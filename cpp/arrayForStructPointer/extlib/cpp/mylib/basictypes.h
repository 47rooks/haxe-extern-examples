#pragma once

/// <summary>
/// BasicTypes is a simple test class for basic types. There are no
/// structures or classes returned or passed.
/// </summary>
class __declspec(dllexport) BasicTypes
{
private:
	int m_i;
	bool m_b;

public:
	BasicTypes(int i, bool b) : m_i{i}, m_b{b} {}

	int getInt();

	int *getIntPtr();

	int &getIntRef();

	bool getBool();

	bool *getBoolPtr();

	bool &getBoolRef();

	int sum(int a, int b);

	void sumOutParam(int a, int b, int *out);
};
