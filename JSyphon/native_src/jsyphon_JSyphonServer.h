/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class jsyphon_JSyphonServer */

#ifndef _Included_jsyphon_JSyphonServer
#define _Included_jsyphon_JSyphonServer
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     jsyphon_JSyphonServer
 * Method:    initWithName
 * Signature: (Ljava/lang/String;Ljava/util/HashMap;)J
 */
JNIEXPORT jlong JNICALL Java_jsyphon_JSyphonServer_initWithName
  (JNIEnv *, jobject, jstring, jobject);

/*
 * Class:     jsyphon_JSyphonServer
 * Method:    getName
 * Signature: (J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_jsyphon_JSyphonServer_getName
  (JNIEnv *, jobject, jlong);

/*
 * Class:     jsyphon_JSyphonServer
 * Method:    hasClients
 * Signature: (J)Z
 */
JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_hasClients
  (JNIEnv *, jobject, jlong);

/*
 * Class:     jsyphon_JSyphonServer
 * Method:    publishFrameTexture
 * Signature: (JIIIIIIIIZ)V
 */
JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_publishFrameTexture
  (JNIEnv *, jobject, jlong, jint, jint, jint, jint, jint, jint, jint, jint, jboolean);

/*
 * Class:     jsyphon_JSyphonServer
 * Method:    bindToDrawFrameOfSize
 * Signature: (JII)Z
 */
JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_bindToDrawFrameOfSize
  (JNIEnv *, jobject, jlong, jint, jint);

/*
 * Class:     jsyphon_JSyphonServer
 * Method:    unbindAndPublish
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_unbindAndPublish
  (JNIEnv *, jobject, jlong);

/*
 * Class:     jsyphon_JSyphonServer
 * Method:    stop
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_stop
  (JNIEnv *, jobject, jlong);

#ifdef __cplusplus
}
#endif
#endif
