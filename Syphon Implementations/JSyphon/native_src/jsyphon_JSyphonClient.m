#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper 
#import <JavaVM/jni.h>

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <SyphonNameboundClient.h>

#import <OpenGL/CGLMacro.h>


static SyphonClient* _myClient;

static SyphonNameboundClient* mClient;

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_init(JNIEnv * env, jobject jobj)
{
    JNF_COCOA_ENTER(env);
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    mClient = [[SyphonNameboundClient alloc] init]; 

    [pool drain];
    JNF_COCOA_EXIT(env);
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_setApplicationName(JNIEnv * env, jobject jobj, jstring appName)
{
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    NSString* name = JNFJavaToNSString(env, appName);
		        
	[(SyphonNameboundClient*)mClient setAppName:name];
		
    [pool drain];
    JNF_COCOA_EXIT(env);    
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_setServerName(JNIEnv * env, jobject jobj, jstring serverName)
{
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        
    NSString* name = JNFJavaToNSString(env, serverName);
		
    if([name length] == 0)
        name = nil;
        
	[(SyphonNameboundClient*)mClient setName:name];
		
	
    [pool drain];
    JNF_COCOA_EXIT(env);      
}



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

/*
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
*/


JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonClient_hasNewFrame(JNIEnv * env, jobject jobj)
{
    jboolean val = JNI_FALSE;
    
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
	[(SyphonNameboundClient*)mClient lockClient];
	SyphonClient *client = [(SyphonNameboundClient*)mClient client];
	
    if([client hasNewFrame])
        val = JNI_TRUE;
    
	[(SyphonNameboundClient*)mClient unlockClient];
	
    [pool drain];
    JNF_COCOA_EXIT(env);
    
    return val;    
}


JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonClient_newFrameImageForContext(JNIEnv * env, jobject jobj)
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	JNF_COCOA_ENTER(env);	
	
	JNF_COCOA_EXIT(env);
	[pool drain];	
	
	return NULL;	
}


/*
JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_stop(JNIEnv * env, jobject jobj)
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	JNF_COCOA_ENTER(env);	
	
	[_myClient stop];
	
	JNF_COCOA_EXIT(env);
	[pool drain];
}
 */


JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_stop(JNIEnv * env, jobject jobj)
{
  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
  JNF_COCOA_ENTER(env);
  
  [(SyphonNameboundClient*)mClient release];

  JNF_COCOA_EXIT(env);
  [pool drain];
}

/*
JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_stop(JNIEnv * env, jobject jobj)
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	JNF_COCOA_ENTER(env);	
	
	[_myClient stop];
	
	JNF_COCOA_EXIT(env);
	[pool drain];    
}
*/