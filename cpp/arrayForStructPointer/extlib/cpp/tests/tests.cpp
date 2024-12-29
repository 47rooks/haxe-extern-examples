#include "pch.h"
#include "CppUnitTest.h"
#include "arrayexamples.h"
#include <iostream>

using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace tests
{
	TEST_CLASS(tests)
	{
	public:
		
		TEST_METHOD(testSimpleCall)
		{
			std::cout << "hello from test code" << std::endl;
			int arry[10]{ 1, 23, 44, 5, 3, 45, 67, 8, 0, 19 };
			ArrayExamples ae;
			std::string rv = ae.simpleIntPointer(arry, 10);
			std::cout << rv << std::endl;
			Assert::AreEqual("1,23,44,5,3,45,67,8,0,19",
				             rv.c_str());
		}

		TEST_METHOD(testSentinelTermination)
		{
			std::cout << "hello from test code" << std::endl;
			int arry[3]{ 1, 23, NULL };
			ArrayExamples ae;
			std::string rv = ae.simpleIntPointer(arry, 0);
			std::cout << rv << std::endl;
			Assert::AreEqual("1,23", rv.c_str());
		}
	};
}
