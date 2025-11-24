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

var moduleFCalled:Bool = false;

function moduleF():Void {
	trace('moduleF called');
	moduleFCalled = true;
}

class TestCallbackExamples extends utest.Test {
	public static var staticFCalled:Bool = false;

	public static function staticF():Void {
		trace('TestCallbackExamples::staticF called');
		staticFCalled = true;
	}

	// FIXME remove the cpp.Function use
	function testInvoke():Void {
		var ce = CallbackExamples.create(Function.fromStaticFunction(add));
		Assert.equals(220, ce.invoke(100, 120));
	}

	function testCbkClosure():Void {
		var called = false;

		CallbackExamples.foo_wrapped(() -> {
			trace('Hello, World!');
			called = true;
		});
		Assert.isTrue(called);
	}

	function testCbkStatic():Void {
		staticFCalled = false;
		CallbackExamples.foo_wrapped(staticF);
		Assert.isTrue(staticFCalled);
	}

	function testCbkMember():Void {
		var tc = new TestClass();

		CallbackExamples.foo_wrapped(tc.memberF);
		Assert.isTrue(TestClass.memberFCalled);
	}

	function testCbkModuleF():Void {
		moduleFCalled = false;
		CallbackExamples.foo_wrapped(moduleF);
		Assert.isTrue(moduleFCalled);
	}
}

private class TestClass {
	public static var memberFCalled:Bool = false;

	public function new() {}

	public function memberF():Void {
		trace('TestClass::memberF called');
		memberFCalled = true;
	}
}
