package;

import cpp.Function;
import cpp.NativeString;
import utest.Assert;

class TestStringExamples extends utest.Test {
	function testStringLifeCycle():Void {
		var ns = NativeString.c_str("Hello World!");
		var se = StringExamples.create(ns);
		var s:String = NativeString.fromPointerLen(se.value.getString(), 12);
		Assert.equals("Hello World!", s);
		se.destroy();
	}

	function testModString():Void {
		var ns = NativeString.c_str("");
		var se = StringExamples.create(ns);
		se.value.setString(NativeString.c_str("Goodbye!"));
		var s:String = NativeString.fromPointer(se.value.getString());
		Assert.equals("Goodbye!", s);
		se.destroy();
	}
}
