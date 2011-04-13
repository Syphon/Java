JSyphon - a Syphon implementation for LWJGL 2.7

Setup:

Please download the LWJGL binaries and place the uncompressed folders in this directory, so you have something like:

Readme.txt
bin
lwjgl-2.7.x
native_libs
native_src
src

JSyphon has been tested against 2.7.1, full release.

Getting Started:

Compile the XCode Project to build the native JSyphon bundle for JWJGL. Build "JSyphon.bundle", which includes the Syphon framework, and the JNI code to run in your java app. The compiled "JSyphon.bundle" is copied into the "native_libs" folder, where you can then load it in Java using System.load or System.loadLibrary depending on your path setups.

To experiment with the JSyphon examples, we provide an Eclipse project which you can import into your workspace, and experiment with "ServerTest.java" and "ClientTest.java" (client coming soon). You will probably have to manually edit the System.Load command to ensure it finds the "JSyphon.bundle"

Initial JSyphon implementation by Skye Book and Anton Marini.