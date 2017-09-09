Java
====

JSyphon - a Java Native Interface for Syphon. It has been tested with JOGL via Processing, and LWJGL.


Getting Started:
====

* After cloning the repository, use ```git submodule update --init``` to pull in the <a href="https://github.com/Syphon/Syphon-Framework">Syphon-Framework</a> and <a href="https://github.com/Syphon/Shared">Shared</a> repos

* Update the Syphon-Framework and Shaded submodules:

```bash
cd Syphon-Framework/
git pull origin master
cd ../Shared/
git pull origin master
cd ..
git add Syphon-Framework
git add Shared
git commit java -m "Updated Syphon submodules"
```

* Change into the JSyphon subfolder: 

```cd JSyphon```

* Build jsyphon.jar, by running ```ant dist``` inside the ant folder:

```bash
cd ant
ant dist
cd ..
```

The resulting jsyphon.jar file will be placed inside the jar folder.

* Generate the headers changing into the native_src folder and running the script gen_headers.sh script:

```bash
cd native_src
./gen_headers.sh
cd ..
```

* Open the JSyphon XCode project inside native_src, and build it. This will generate two files: the Syphon framework binary, named simply "Syphon", and the JSyphon JNI library, named "libJSyphon.jnilib". They will be placed inside the "native_libs" folder, where you can then load it in Java using System.load or System.loadLibrary depending on your path setups. We suggest System.loadLibrary.

* To experiment with the JSyphon examples, we provide an Eclipse project which you can import into your workspace, and experiment with "ServerTest.java" and "ClientTest.java". 

Acknowledgments
====

Initial JSyphon implementation by Skye Book and Anton Marini.

Finishing up implementation of JSyphonClient, server listing, ClientTest example by Andres Colubri.
