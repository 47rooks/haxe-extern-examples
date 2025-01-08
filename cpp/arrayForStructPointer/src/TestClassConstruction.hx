package;

import ClassConstruction.ClassConstructionPtrOfPtrToType;
import ClassConstruction.ClassConstructionPtrOfType;
import ClassConstruction.ClassConstructionRefOfType;
import utest.Assert;

class TestClassConstruction extends utest.Test {
	function testClassConstruction():Void {
		// This is stack allocated so there is no destroy() call.
		// This is much nicer for access as it looks just like regular Haxe
		// as there is no need to call .value to dereference the pointer as
		// there is in the pointer based modelling
		var bt = ClassConstruction.create();
		Assert.equals(10, bt.getInt());
	}

	function testClassConstructionPtrOfType():Void {
		// This is heap allocated and we call destroy() when we are done
		var bt = ClassConstructionPtrOfType.create();
		// Note .value to dereference the pointer.
		Assert.equals(10, bt.value.getInt());
		bt.destroy();
	}

	function testClassConstructionPtrOfPtrToType():Void {
		// This is heap allocated and we call destroy() when we are done
		var bt = ClassConstructionPtrOfPtrToType.create();
		Assert.equals(10, bt.value.getInt());
		bt.destroy();
	}

	function testClassConstructionRefOfType():Void {
		// This is stack allocated so there is no destroy() call
		var bt = ClassConstructionRefOfType.create();
		Assert.equals(10, bt.getInt());
	}
}
