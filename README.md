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

* Build jsyphon.jar, by running ```ant dist``` inside the ant folder. The resulting jar file will be placed inside the jar folder.

* Generate the headers by running the script native_src/gen_headers.sh

* Compile the XCode Project to build the native JSyphon JNI libray, named "libJSyphon.jnilib", which includes the Syphon framework, and the JNI code to run in your java app. The compiled "libJSyphon.jnilib" is copied into the "native_libs" folder, where you can then load it in Java using System.load or System.loadLibrary depending on your path setups. We suggest System.loadLibrary.

* To experiment with the JSyphon examples, we provide an Eclipse project which you can import into your workspace, and experiment with "ServerTest.java" and "ClientTest.java". 

Acknowledgments
====

Initial JSyphon implementation by Skye Book and Anton Marini.

Finishing up implementation of JSyphonClient, server listing, ClientTest example by Andres Colubri.
