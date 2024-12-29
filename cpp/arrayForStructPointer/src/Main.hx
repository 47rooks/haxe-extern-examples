package;

import ArrayExamples;
import cpp.StdString;
import haxe.ds.StringMap;

/**
 * Main is an example of using the statically linked extern class Hello.
 */
class Main {
	static function main() {
		trace('started');

		trace('test 1');
		var arry = [1, 2, 3, 4];
		final ae:ArrayExamples = ArrayExamples.create();
		var s = ae.simpleIntPointer(cpp.Pointer.ofArray(arry).raw, arry.length);
		trace(s.toString());

		trace('test 2');
		var arr2 = new Array();
		arr2.push(456);
		arr2.push(345);
		arr2.push(734);
		var str = cast(ae.simpleIntPointer(cpp.Pointer.ofArray(arr2).raw, arr2.length), StdString);
		trace('call finished');
		trace(str.size());
		trace(str);
		// trace('s=${new String(s.size())}');

		// trace('test 3');
		// arr2.push(0);
		// s = ae.simpleIntPointer(cpp.Pointer.ofArray(arr2).raw, 0);
		// trace('call finished');
		// trace('s=${s.toString()}');
	}
}
