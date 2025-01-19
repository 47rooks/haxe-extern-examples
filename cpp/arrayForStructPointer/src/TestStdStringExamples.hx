package;

import utest.Assert;

@:include("string")
@:structAccess
@:unreflective
@:native("std::string")
extern class StdString {
	@:native("new std::string")
	public static function create(s:String):cpp.Pointer<StdString>;
	public function size():Int;
	public function c_str():String;
}

class TestStdStringExamples extends utest.Test {
	function testStringLifeCycle():Void {
		var s = StdString.create("My test string");
		trace(s.value.size());
		var hxs = new String(s.value.c_str());
		trace('string is ${hxs}');
		s.destroy();
		Assert.equals("My test string", hxs);
	}
}
