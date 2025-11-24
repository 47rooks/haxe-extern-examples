#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#ifdef __linux__
class CallbackExamples
#elif _WIN32
class __declspec(dllexport) CallbackExamples
#else
#error "Unknown platform"
#endif
{
private:
	int (*m_fn)(int, int);

public:
	CallbackExamples(int (*fn)(int, int)) : m_fn{fn} {}

	int invoke(int p1, int p2);
};
