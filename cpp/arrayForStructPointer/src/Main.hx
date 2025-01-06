package;

import ArrayExamples;
import BasicTypes;
// import cpp.Reference;
// import haxe.ds.StringMap;
import utest.Runner;
import utest.ui.Report;

/**
 * Main is an example of using the statically linked extern class Hello.
 * 
 * FIXME Most of these tests are trying to get a std::string to be returned
 *       from c++. This is so far not working. I will come back to this once
 *       I have simpler cases going.
 */
class Main {
	static function testArrayExamples():Void {
		trace('started');

		var std = StdString.create("my std::string");
		trace(std.value.size());
		trace('x=${new String(std.value.c_str())}');
		trace('x=${std.value.c_str()}');
		var std2 = StdString.ofStdString(cpp.StdString.ofString(new String(std.value.c_str())));
		std.destroy();
		trace('std2=${new String(std2.value.c_str())}');

		// var x:StdString = cast "hello world";
		// trace('x=${x.value.toString()}');
		// trace('x=${x} len=${x.size()}');
		trace('test 1');
		var arry = [1, 2, 3, 4];
		final ae:ArrayExamples = ArrayExamples.create();
		// var suffixTest = ae.appendToString(x);
		// trace('suffix rtn=${suffixTest}');

		var s = StdString.ofStdString(ae.simpleIntPointer(cpp.Pointer.ofArray(arry).raw, arry.length));
		// trace(s.get_ref().toString());
		// trace(s.value.toString());
		trace('mystr=${ae.getMyStr()}');
		trace('s=${new String(s.value.c_str())}');
		// trace(s);

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
		// testArrayExamples();

		utest.UTest.run([new TestBasicTypes()]);
	}
}

// Avoids generating dynamic accessors.

@:unreflective
// Marks an extern class as using struct access(".") not pointer("->").
@:structAccess
@:include("string")
@:native("std::string")
extern class StdString {
	@:native("new std::string")
	public static function create(inString:String):cpp.Pointer<StdString>;
	@:native("new std::string")
	public static function ofStdString(inString:cpp.StdString):cpp.Pointer<StdString>;
	public function size():Int;
	public function find(str:String):Int;
	public function c_str():String;
}
