JSyphon - a Java Native Interface for Syphon

Setup:

Currently JSyphon has been tested with JOGL via Processing, and LWJGL.

The Test package for JSyphon relies on LWJGL, so if you want to use our test class, be sure to download the LWJGL binaries and place the uncompressed folders in this directory, so you have something like:

Readme.txt
bin
lwjgl-2.7.x
native_libs
native_src
src

Getting Started:

Compile the XCode Project to build the native JSyphon JNI libray, named "libJSyphon.jnilib". Build "libJSyphon.jnilib", which includes the Syphon framework, and the JNI code to run in your java app. The compiled "libJSyphon.jnilib" is copied into the "native_libs" folder, where you can then load it in Java using System.load or System.loadLibrary depending on your path setups. We suggest System.loadLibrary.

To experiment with the JSyphon examples, we provide an Eclipse project which you can import into your workspace, and experiment with "ServerTest.java" and "ClientTest.java" (client coming soon). 

Initial JSyphon implementation by Skye Book and Anton Marini.