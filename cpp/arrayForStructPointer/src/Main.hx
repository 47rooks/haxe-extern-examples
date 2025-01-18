package;

import ArrayExamples;
// import cpp.Reference;
// import haxe.ds.StringMap;
import haxe.xml.Access;
import utest.Runner;
import utest.ui.Report;

/**
 * Main is a UTest driver module only. Remnant code here will be moved to
 * unit test classes in due course.
 * 
 * FIXME Most of these tests are trying to get a std::string to be returned
 *       from c++. This is so far not working. I will come back to this once
 *       I have simpler cases going.
 */
class Main {
	static function testArrayExamples():Void {
		trace('started');

		trace('test 1');
		var arry = [1, 2, 3, 4];
		final ae:ArrayExamples = ArrayExamples.create();
		// var suffixTest = ae.appendToString(x);
		// trace('suffix rtn=${suffixTest}');

		trace('test 2');
		var arr2 = new Array();
		arr2.push(456);
		arr2.push(345);
		arr2.push(734);
		var str = ae.simpleIntPointer(cpp.Pointer.ofArray(arr2).raw, arr2.length);
		trace('call finished');
		// trace(str.get_value());
		trace(str);
		// trace('s=${new String(s.size())}');

		// trace('test 3');
		// arr2.push(0);
		// s = ae.simpleIntPointer(cpp.Pointer.ofArray(arr2).raw, 0);
		// trace('call finished');
		// trace('s=${s.toString()}');
	}

	public static function main() {
		trace('running');
		utest.UTest.run([
			new TestClassConstruction(),
			new TestBasicTypes(),
			new TestCallbackExamples(),
			new TestStringExamples(),
			new TestStdStringExamples(),
			new TestHeaderCodeExamples()
		]);
		// testArrayExamples();
	}
}

// Avoids generating dynamic accessors.
// @:unreflective
// // Marks an extern class as using struct access(".") not pointer("->").
// @:structAccess
// @:include("string")
// @:native("std::string")
// extern class StdString {
// 	@:native("new std::string")
// 	public static function create(inString:String):cpp.Pointer<StdString>;
// 	@:native("new std::string")
// 	public static function ofStdString(inString:cpp.StdString):cpp.Pointer<StdString>;
// 	public function size():Int;
// 	public function find(str:String):Int;
// 	public function c_str():String;
// }
