#include <jni.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <OpenGL/CGLMacro.h>
#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper 

static SyphonServer* _myServer;

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_initWithName
  (JNIEnv * env, jobject jobj, jstring name)
{
	JNF_COCOA_ENTER(env);

	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	CGLContextObj cgl_ctx = CGLGetCurrentContext();

	_myServer = [[SyphonServer alloc] initWithName:@"HardCoded" context:cgl_ctx options:nil];


	[pool drain];
	JNF_COCOA_EXIT(env);

	return;
}

JNIEXPORT jstring JNICALL Java_jsyphon_JSyphonServer_getName
  (JNIEnv * env, jobject jobj){
	jstring name = NULL;
	
	JNF_COCOA_ENTER(env);
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		
	name = JNFNSToJavaString(env, [_myServer name]);
	
	[pool drain];
	JNF_COCOA_EXIT(env);
	
	return name;
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_hasClients
  (JNIEnv * env, jobject jobj){
	//jboolean hasClients = JNI_FALSE;
	//JNF_COCOA_ENTER(env);
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	
	/*
	if( [_myServer hasClients];
	
	if(hasClients
	){
		JNF_COCOA_EXIT(env);
		return JNI_TRUE;
	}
	
	[pool drain];
	JNF_COCOA_EXIT(env);
	*/
	//JNF_COCOA_EXIT(env);
	return JNI_TRUE;
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_publishFrameTexture
  (JNIEnv * env, jobject jobj, jint texID, jint texTarget, jint xPos, jint yPos, jint width, jint height, jint sizeX, jint sizeY, jboolean isFlipped){
	JNF_COCOA_ENTER(env);
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	// Put Code Here
	NSRect rect = NSMakeRect(xPos, yPos, width, height);
	NSSize size = NSMakeSize(sizeX, sizeY);
	
	GLuint textureID = texID ;
	GLuint textureTarget = texTarget;
	
	BOOL flipped = (isFlipped == JNI_TRUE) ? 1 : 0;
	
	[_myServer publishFrameTexture:textureID textureTarget:textureTarget imageRegion:rect textureDimensions:size flipped:flipped];
	
	[pool drain];
	JNF_COCOA_EXIT(env);
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_bindToDrawFrameOfSize
  (JNIEnv * env, jobject jobj, jint sizeX, jint sizeY){
	JNF_COCOA_ENTER(env);
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSSize size = NSMakeSize(sizeX, sizeY);
	
	[_myServer bindToDrawFrameOfSize:size];
	
	[pool drain];
	JNF_COCOA_EXIT(env);
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_unbindAndPublish
  (JNIEnv * env, jobject jobj){
	JNF_COCOA_ENTER(env);
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	[_myServer unbindAndPublish];
	
	[pool drain];
	JNF_COCOA_EXIT(env);
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_stop
  (JNIEnv * env, jobject jobj){
	JNF_COCOA_ENTER(env);
	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	[_myServer stop];
	
	[pool drain];
	JNF_COCOA_EXIT(env);
}