# Haxe extern examples and experiments

- [Haxe extern examples and experiments](#haxe-extern-examples-and-experiments)
  - [Projects](#projects)
  - [VSCode Configuration Notes](#vscode-configuration-notes)
  - [Compiling C++ Only with HXCPP](#compiling-c-only-with-hxcpp)
  - [Setting the C++ version for HXCPP](#setting-the-c-version-for-hxcpp)
  - [References](#references)

The base platform for this repo is Windows at the moment. I'm not averse to
having Linux, Mac code in here I just don't have those platforms readily 
available.

cpp externs are in the `cpp/` folder. They are generally built in Visual
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

## VSCode Configuration Notes

These notes are basically about configuring VSCode `launch.json` and
`tasks.json` for debugging Haxe and externs. In general you cannot run a
single debugger and move from the Haxe level to the c++ level seamlessly. But
you can configure a Haxe level debugger like hxcpp-debugger to work at the
Haxe level and the VSCode native debugger to handle debugging in c++. As your
Haxe program targetting cpp will compile to c++ if you know which location
in the c++ you need to start from this can be all you need.

This assumes that you have the VSCode Haxe Extension Pack extension installed.
You will also need the hxcpp-debugger and hxcpp-debug-server libraries.

Example launch.json
```
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
      {
        "name": "Run hxcpp",
        "type": "hxcpp",
        "request": "launch",
        "program": "${workspaceFolder}/export/cpp/Main-debug.exe"
      },
      {
        "name": "Dbg hxcpp",
        "type": "hxcpp",
        "request": "launch",
        "preLaunchTask": "Run-debugee",
        "program": "${workspaceFolder}/export/cpp/Main-debug.exe"
      },
      {
          "name": "Dbg VSC",
          "type": "cppvsdbg",
          "request": "launch",
          "program": "${workspaceFolder}/export/cpp/Main-debug.exe",
          "args": [],
          "stopAtEntry": false,
          "cwd": "${fileDirname}",
          "environment": [],
          "console": "externalTerminal",
          "symbolOptions": {
            "searchPaths": [
              "${workspaceFolder}/export/cpp",
              "${workspaceFolder}/extlib/cpp/mylib/x64/Debug"
            ],
            "searchMicrosoftSymbolServer": false
          }
      }
    ]
}
```

The `Run hxcpp` configuration is just to run the debug exe. The presumption
is that you have already built it the exe.

The `Debug hxcpp` runs the hxcpp debugger to debug cpp target code at the 
Haxe level. The significant fields are

|Option|Description|
|-|-|
|name|this is the name that appears in the `Run and Debug` pulldown menu.|
|type|must be cppvsdbg for the internal native debugger.|
|program|the particular program you are debugging.|
|args| any args it must be launched with.|
|cwd|because of the way windows finds DLLs it can help to copy them into the 
|directory|containing the exe and then run it from there. Hence setting cwd to this value is useful.|
|symbolOptions|needed to find the debugging symbols.|
|searchPaths|this should be set to a list of directories that contain pdb files. In the example here that is, and the external library, respectively.|

With these configurations in place VSCode Run-> Start Debugging can work with
either a Haxe hxcpp debugger or directly in c++ with the native debugger. You
just select the launch configuration in the Run and Debug pull down menu in
the debug view.

Refer to the VSCode documentation on launchers and tasks for more details at
https://code.visualstudio.com/docs/cpp/launch-json-reference.

## Compiling C++ Only with HXCPP

Sometimes it is helpful to modify the C++ the Haxe compiler generates and then
recompile it without regenerating it. This can be a good debugging technique
to test out C++ constructs or add additional debug prints.

To do this go to the output directory where the code is generated and find
the C++ file you want and modify it. Now there will be a generated Build.hxml
in that output hierarchy. So you go to that directory and run

```
haxelib run hxcpp Build.hxml
```
Make sure you have set any required environment variables in your shell so 
the build can resolve DLLs and so on. I do this from Powershell rather than
VSCode though in theory I expect you could figure out a task configuration
to do this.

The exe is then run as normal.

Note, of course, as soon as rerun the regular haxe based build you will lose
these changes, so either copy them somewhere if you will need to reuse them
or make sure you're done before you next build.

## Setting the C++ version for HXCPP

There are two compiler flags which can set the Haxe compiler to produce 
different versions of C++. 

`-D HXCPP_CPP11=1` for C++ 11
`-D HXCPP_CPP17=1` for C++ 17

I don't know what happens if you specify both and I have not compared
example code output for cases where it would matter. I am recording these
here, like so much else, so I don't forget it. I believe the default is
C++ 11.

## References

[Hugh Sanderson's talk on CPP externs](https://haxe.io/roundups/wwx/c++-magic/)

[Stackoverflow post on externs referring to Hugh's example](https://stackoverflow.com/questions/35620851/access-c-class-from-haxe-using-extern)