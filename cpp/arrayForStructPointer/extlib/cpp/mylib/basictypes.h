#pragma once

/// <summary>
/// BasicTypes is a simple test class for basic types. There are no
/// structures or classes returned or passed.
/// </summary>
#ifdef __linux__
class BasicTypes
#elif _WIN32
class __declspec(dllexport) BasicTypes
#else
#error "Unknown platform"
#endif
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
