import utest.Assert;

class TestBasicTypes extends utest.Test {
	function testGetInt():Void {
		var bt = BasicTypes.create();
		Assert.equals(10, bt.getInt());
	}

	function testGetIntPtr():Void {
		var bt = BasicTypes.create();

		// Note that here we must immediately capture the referent int
		// from the pointer. This is not a general requirement but applies
		// in this case because the value returned in C++ is a pointer to
		// a temporary int. The temporary will be destoryed as soon as
		// the expression referring to it completes. So if we just assigned
		// the pointer to a variable and then in a later statement tried to
		// deference it the value will have been destroyed and the pointer
		// is just a 'dangling' pointer. For this reason we dereference the
		// pointer with the `[0]` index. If anyone were to make a C++ API
		// like this they would have to document it or callers would not know
		// and would likely have a bug.
		var i = bt.getIntPtr()[0];
		trace('i=${i}');
		Assert.equals(11, i);
	}

	function testGetIntRef():Void {
		var bt = BasicTypes.create();
		// The line below extracts the value from the Reference by a simple
		// cast. This works because the Reference is simply a typedef for the
		// type.
		var i:Int = bt.getIntRef();
		Assert.equals(12, i);
	}

	function testGetBool():Void {
		var bt = BasicTypes.create();
		Assert.isFalse(bt.getBool());
	}

	function testGetBoolPtr():Void {
		var bt = BasicTypes.create();
		// This is the same case as in `BasicTypes.getIntPtr()`.
		var v = bt.getBoolPtr()[0];
		trace('v=${v}');
		Assert.isFalse(v);
	}

	function testGetBoolRef():Void {
		var bt = BasicTypes.create();
		var v:Bool = bt.getBoolRef();
		Assert.isTrue(v);
	}
}
