#include "pch.h"
#include "CppUnitTest.h"
#include "arrayexamples.h"
#include "basictypes.h"
#include "callbackexamples.h"

#include <iostream>
#include <string>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace tests
{
	TEST_CLASS(ArrayExamplesTest)
	{
	public:
		
		TEST_METHOD(testSimpleCall)
		{
			std::cout << "hello from test code - using refs" << std::endl;
			int arry[10]{ 1, 23, 44, 5, 3, 45, 67, 8, 0, 19 };
			ArrayExamples ae;
			std::string& rv{ ae.simpleIntPointer(arry, 10) };
			std::cout << rv.c_str() << std::endl;
			Assert::AreEqual("1,23,44,5,3,45,67,8,0,19",
				             rv.c_str());
		}

		TEST_METHOD(testSentinelTermination)
		{
			std::cout << "hello from test code - using refs" << std::endl;
			int arry[3]{ 1, 23, NULL };
			ArrayExamples ae;
			std::string& rv = ae.simpleIntPointer(arry, 0);
			std::cout << rv.c_str() << std::endl;
			Assert::AreEqual("1,23", rv.c_str());
		}

		TEST_METHOD(testAppendToString)
		{
			ArrayExamples ae;
			std::string inStr{ "this is my string" };
			std::string rv = ae.appendToString(inStr);
			std::cout << rv.c_str() << std::endl;
			Assert::AreEqual("this is my stringSUFFIX", rv.c_str());
		}

		TEST_METHOD(testGetMyStr)
		{
			ArrayExamples ae;
			std::string inStr{ "this is my string" };
			std::string rv = ae.getMyStr();
			std::cout << rv.c_str() << std::endl;
			Assert::AreEqual("This is my internal string", rv.c_str());
		}
	};

	TEST_CLASS(BasicTypesTests) {
	public:
		TEST_METHOD(testGetInt) {
			BasicTypes bt;
			Assert::AreEqual(10, bt.getInt());
		}

		TEST_METHOD(testGetIntPtr) {
			BasicTypes bt;
			Assert::AreEqual(11, *bt.getIntPtr());
		}

		TEST_METHOD(testGetIntRef) {
			BasicTypes bt;
			Assert::AreEqual(12, bt.getIntRef());
		}

		TEST_METHOD(testGetBool) {
			BasicTypes bt;
			Assert::IsFalse(bt.getBool());
		}

		TEST_METHOD(testGetBoolPtr) {
			BasicTypes bt;
			Assert::IsFalse(*bt.getBoolPtr());
		}

		TEST_METHOD(testGetBoolRef) {
			BasicTypes bt;
			Assert::IsTrue(bt.getBoolRef());
		}

		TEST_METHOD(testSum) {
			BasicTypes bt;
			Assert::AreEqual(8, bt.sum(3, 5));
		}

		TEST_METHOD(testSumOut) {
			BasicTypes bt;
			int rv;
			bt.sumOutParam(23, 7, &rv);
			Assert::AreEqual(30, rv);
		}


		// FIXME Move to StringTypesTests
		//TEST_METHOD(testConcat) {
		//	BasicTypes bt;
		//	const char* a = "Hello";
		//	const char* b = " World";
		//	//std::string exp{ "Hello World" };
		//	const char* exp = "Hello World";
		//	Assert::AreEqual(exp, bt.concat(a, b));
		//}

	};

	int add(int a, int b) {
		return a + b;
	}

	TEST_CLASS(CallbackExamplesTests) {
	public:
		TEST_METHOD(testInvoke) {

			CallbackExamples ce(add);
			Assert::AreEqual(27, ce.invoke(12, 15));
		}
	};
}
