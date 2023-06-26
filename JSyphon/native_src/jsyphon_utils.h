#include <jni.h>

#ifndef _Included_jsyphon_JSyphon_utils
#define _Included_jsyphon_JSyphon_utils
#ifdef __cplusplus
extern "C" {
#endif
JNIEXPORT jstring JNICALL _NSStringToJavaString(JNIEnv *, NSString *);
JNIEXPORT NSString* JNICALL _JavaStringToNSString(JNIEnv *, jstring);
#ifdef __cplusplus
}
#endif
#endif