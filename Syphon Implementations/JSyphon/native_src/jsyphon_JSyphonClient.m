#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper 
#import <JavaVM/jni.h>

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <OpenGL/CGLMacro.h>

static SyphonClient* _myClient;


JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_initWithServerDescriptionAndOptions(JNIEnv * env, jobject jobj, jobject jdesc, jobject jopts)
{
    JNF_COCOA_ENTER(env);

    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
    [JNFDefaultCoercions addMapCoercionTo:coecer];

    NSDictionary* desc = [coecer coerceJavaObject:jdesc withEnv:env];
    
    _myClient = [[SyphonClient alloc] initWithServerDescription:desc options:nil newFrameHandler:NULL];
    
    [pool drain];
    JNF_COCOA_EXIT(env);
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonClient_isValid(JNIEnv * env, jobject jobj)
{
    jboolean val = JNI_FALSE;
    
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    if([_myClient isValid])
        val = JNI_TRUE;
    
    [pool drain];
    JNF_COCOA_EXIT(env);
    
    return val;
}

JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonClient_serverDescription(JNIEnv * env, jobject jobj)
{
    jobject serverdesc = NULL;
    
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    NSDictionary* desc = [_myClient serverDescription];
    
    JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
    [JNFDefaultCoercions addMapCoercionTo:coecer];
    
    serverdesc = [coecer coerceNSObject:desc withEnv:env];
    
    [pool drain];
    JNF_COCOA_EXIT(env);

    return serverdesc;
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonClient_hasNewFrame(JNIEnv * env, jobject jobj)
{
    jboolean val = JNI_FALSE;
    
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    if([_myClient hasNewFrame])
        val = JNI_TRUE;
    
    [pool drain];
    JNF_COCOA_EXIT(env);
    
    return val;    
}

JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonClient_newFrameImageForContext(JNIEnv * env, jobject jobj)
{
    return NULL;
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_stop(JNIEnv * env, jobject jobj)
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	JNF_COCOA_ENTER(env);	
	
	[_myClient stop];
	
	JNF_COCOA_EXIT(env);
	[pool drain];    
}

