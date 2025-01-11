#pragma once

class __declspec(dllexport) CallbackExamples
{
private:
	int (*m_fn)(int, int);

public:
	CallbackExamples(int (*fn)(int, int)) : m_fn{ fn } {}

	int invoke(int p1, int p2);
};