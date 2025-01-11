package;

import cpp.Function;
import utest.Assert;

/**
 * `add` is a callback function that will be invoked from the C++ side of the extern.
 * In this case it simply adds the two integers and returns the result.
 * @param a 
 * @param b 
 * @return Int a + b
 */
function add(a:Int, b:Int):Int {
	return a + b;
}

class TestCallbackExamples extends utest.Test {
	function testInvoke():Void {
		var ce = CallbackExamples.create(Function.fromStaticFunction(add));
		Assert.equals(220, ce.invoke(100, 120));
	}
}
