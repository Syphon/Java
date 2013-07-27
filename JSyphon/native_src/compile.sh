gcc -arch x86_64 -o ../native_libs/JSyphon.so -shared -I/System/Library/Frameworks/JavaVM.framework/Headers \
-F../native_libs/ -F/System/Library/Frameworks/JavaVM.framework/Frameworks/ \
  -framework Cocoa -framework Foundation -framework OpenGL -framework JavaVM -framework Syphon -framework JavaNativeFoundation \
jsyphon_JSyphonServer.m -lc 

install_name_tool -change @loader_path/../Frameworks/Syphon.framework/Versions/A/Syphon "`pwd`/../native_libs/Syphon.framework/Versions/A/Syphon" ../native_libs/JSyphon.so 