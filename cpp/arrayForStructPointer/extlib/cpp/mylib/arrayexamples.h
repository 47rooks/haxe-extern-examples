#pragma once

#include <string>
//#define HX_WINDOWS
//#define HXCPP_M64
//#include "hxcpp.h"
//#include "hxString.h"

/// <summary>
/// This lua_State struct is a dummy for the real lua_State and contains
/// none of the complexity of the real struct because it should not
/// be required to test passing an array of <paramref name="luaL_Reg"/> structs.
/// </summary>
struct lua_State {
	const char* state_name;
};
typedef struct lua_State lua_State;
/// <summary>
/// The structs below are to simulate the Lua structures needed by the
/// luaL_setfuncs() function.
/// </summary>
//typedef struct luaL_Reg {
//	const char* name;
//	lua_CFunction func;
//} luaL_Reg;
//typedef int(*lua_CFunction)(lua_State* L);


/// <summary>
/// ArrayExamples is a collection of extern functions related to haxe Array
/// manipulation in cpp externs.
/// </summary>
class __declspec(dllexport) ArrayExamples
{
public:
	/// <summary>
	/// simpleIntPointer tests passing an array of ints to c++.
	/// </summary>
	/// <param name="a">A pointer to the input array</param>
	/// <param name="size">The number of elements in <paramref name="a"/>.</param>
	/// <returns>A string of all the elements of <paramref name="a"/>
	/// concatenated together.</returns>
	std::string simpleIntPointer(int* a, int size);

	std::string appendToString(std::string& in);

	//String simpleIntPointer2(int* a, int size);

	//const char * simpleIntPointer2(int* a, int size);

	//void luaL_RegPointer(const luaL_Reg* l);
	//void setfuncs();
	std::string& getMyStr();

private:
	std::string myStr{ "This is my internal string" };
};

/// <summary>
/// NamedFunc is a dummy struct for testing how to handle a Haxe Array of
/// these when passing to an extern.
/// </summary>
typedef struct NamedFunc {
	const char* name;
	int(*f)(const char* tag);
};

