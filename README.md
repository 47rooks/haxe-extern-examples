# Haxe extern examples and experiments

The base platform for this repo is Windows at the moment. I'm not averse to
having Linux, Mac code in here I just don't have those platforms readily 
available.

cpp externs are in the extlib/cpp/ folder. They are generally built in Visual
Studio 2022, and will have both a lib (DLL) project and a test project in the
one solution.

These will then be wrapped by a Haxe class or classes and a Visual Studio Code
project.

## Projects

Under this directory there is a directory per target for which examples have
been created. The plan is to cover at least examples for cpp, hl and perhaps js.
There is no great plan to cover all possible types and structures but rather
to provide a representative sample and document techniques so that as cases
come up is it easy to write code to handle them.