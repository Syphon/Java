# was x86_64 but let's use real arch to build on arm64 as well
ARCH=`uname -m`
OS=`uname -s`

ln -s Syphon-Framework ../../Syphon
ln -s Syphon ../native_libs/libSyphon.dylib
# macOS ARM: if OS is Darwin and arch is ARM, use `javac -h` on the .java files directly
if [ "$OS" = "Darwin" ] && ([ "$ARCH" = "arm64" ] || [ "$ARCH" = "aarch64" ]); then
  echo "macOS ARM64 detected"

  # we may need to link to libjli.dylib, eg /Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/MacOS/libjli.dylib
  gcc -arch $ARCH -o ../native_libs/JSyphon.so -shared \
    -L../native_libs/ \
    -L/Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/MacOS \
    -I../../ \
    -I/Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/microsoft-17.jdk/Contents/Home/include/darwin \
    -I../jdk/src/java.desktop/macosx/native/libosxapp -I../jdk/src/java.base/share/native/libjava -I../jdk/src/java.base/unix/native/libjava \
    -framework Cocoa -framework Foundation -framework OpenGL \
    jsyphon_utils.m jsyphon_JSyphonServer.m -lc -ljli -lSyphon

  install_name_tool -change @loader_path/../Frameworks/Syphon.framework/Versions/A/Syphon "`pwd`/../native_libs/Syphon.framework/Versions/A/Syphon" ../native_libs/libJSyphon.jnilib
else
  gcc -arch $ARCH -o ../native_libs/JSyphon.so -shared -I/System/Library/Frameworks/JavaVM.framework/Headers \
    -F../native_libs/ -F/System/Library/Frameworks/JavaVM.framework/Frameworks/ \
    -framework Cocoa -framework Foundation -framework OpenGL -framework JavaVM -framework Syphon -framework JavaNativeFoundation \
    jsyphon_JSyphonServer.m -lc
  install_name_tool -change @loader_path/../Frameworks/Syphon.framework/Versions/A/Syphon "`pwd`/../native_libs/Syphon.framework/Versions/A/Syphon" ../native_libs/JSyphon.so
fi

