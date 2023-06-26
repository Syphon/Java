#ifndef _Included_jsyphon_JSyphon_imports
#define _Included_jsyphon_JSyphon_imports

#if defined(__arm64__)
// can get ARM-compatible JDK from https://learn.microsoft.com/en-us/java/openjdk/download
// headers will likely install into "/Library/Java/JavaVirtualMachines/microsoft-*.jdk/Contents/Home/include"
#import "jni.h"
#import "jni_md.h"
#import "JNIUtilities.h"
#import "jsyphon_utils.h"

#define JNF_COCOA_ENTER JNI_COCOA_ENTER
#define JNF_COCOA_EXIT  JNI_COCOA_EXIT
#define JNFJavaToNSString _JavaStringToNSString
#define JNFNSToJavaString _NSStringToJavaString

#define ADD(list, str) { \
    jobject localeObj = (*env)->NewStringUTF(env, [str UTF8String]); \
    (*env)->CallBooleanMethod(env, list, jm_listAdd, localeObj); \
    (*env)->DeleteLocalRef(env, localeObj); \
}

#define ADDNULL(list) (*env)->CallBooleanMethod(env, list, jm_listAdd, NULL)

#else
// non-ARM
#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper
#import <JavaVM/jni.h>
#endif

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <OpenGL/CGLMacro.h>

#endif
