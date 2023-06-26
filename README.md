Java
====

JSyphon - a Java Native Interface for Syphon. It has been tested with JOGL via Processing, and LWJGL.


Getting Started:
====

* Just run `install.sh` and all the following will be done! If anything fails, you'll need to investigate further, or follow the instructions below to install one by one.

```sh
sh -x install.sh
```

Installing Manually:
====

* After cloning the repository, use `git submodule update --init` to pull in the <a href="https://github.com/Syphon/Syphon-Framework">Syphon-Framework</a> and <a href="https://github.com/Syphon/Shared">Shared</a> repos

* Update the Syphon-Framework and Shaded submodules:

```sh
cd Syphon-Framework/
git pull origin main
cd ../Shared/
git pull origin master
cd ..
git add Syphon-Framework
git add Shared
git commit -m "Updated Syphon submodules"
```

* Change into the JSyphon subfolder:

```sh
cd JSyphon
```

* Ensure you have ant installed, such as installing from [MacPorts](https://www.macports.org/install.php) or [Homebrew](https://docs.brew.sh/Installation):

```sh
ant -version || brew install ant || sudo port install apache-ant
```

* Build jsyphon.jar, by running `ant dist` inside the ant folder:

```sh
cd ant
ant dist
cd ..
```

The resulting jsyphon.jar file will be placed inside the jar folder.

* Generate the headers changing into the native_src folder and running the script gen_headers.sh script:

```sh
cd native_src
./gen_headers.sh
cd ..
```

* On ARM macOS (Apple Silicon), you'll want a [Microsoft OpenJDK](https://learn.microsoft.com/en-us/java/openjdk/download) build downloaded and installed for the platform and may need to update the `microsoft` paths in `JSyphon/native_src/compile.sh` and `JSyphon/JSyphon.xcodeproj/project.pbxproj` to point to the correct include directory (currently pointing to v17)

```sh
if [ `uname -m` = "arm64" ]; then
  if ls /Library/Java/JavaVirtualMachines/microsoft-*.jdk 1> /dev/null 2>&1; then
    echo Microsoft OpenJDK found;
  else
    curl -L https://aka.ms/download-jdk/microsoft-jdk-17.0.7-macOS-aarch64.pkg > microsoft-jdk-17.0.7-macOS-aarch64.pkg && open microsoft-jdk-17.0.7-macOS-aarch64.pkg;
  fi
fi
```

* On ARM macOS (Apple Silicon), you'll likely need a more recent openjdk for headers:

```sh
git clone --depth=1 https://github.com/openjdk/jdk/
```

* Open the JSyphon XCode project inside native_src, and build it. This will generate a debug version of the library, which will print several messages at runtime. You need to archive it to create a release version without debug mesages. 

You can also build/archive the project from the command line (it requires the Command Line Tools Package, see [here](https://developer.apple.com/library/content/technotes/tn2339/_index.html) for more info) with the following line for building:

```sh
xcodebuild -scheme libJSyphon build -project native_src/JSyphon.xcodeproj
```

and this other one for archiving:

```sh
xcodebuild -scheme libJSyphon archive -project native_src/JSyphon.xcodeproj
```

The build step (either from the IDE or the command line) will generate two files: the Syphon framework binary, named simply "Syphon", and the JSyphon JNI library, named "libJSyphon.jnilib". They will be placed inside the "native_libs" folder, where you can then load it in Java using System.load or System.loadLibrary depending on your path setups. We suggest System.loadLibrary.

* To experiment with the JSyphon examples, we provide an Eclipse project which you can import into your workspace, and experiment with "ServerTest.java" and "ClientTest.java". 

Acknowledgments
====

Initial JSyphon implementation by Skye Book and Anton Marini.

Finishing up implementation of JSyphonClient, server listing, ClientTest example by Andres Colubri.

Porting to Apple Silicon (macOS ARM64) + install.sh by [samy kamkar](https://github.com/samyk).
