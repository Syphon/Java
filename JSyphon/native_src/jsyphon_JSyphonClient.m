#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper 
#import <JavaVM/jni.h>

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <SyphonNameboundClient.h>

#import <OpenGL/CGLMacro.h>

// pass options in case they are needed in the future...
JNIEXPORT jlong JNICALL Java_jsyphon_JSyphonClient_init(JNIEnv * env, jobject jobj, jobject options)
{
    jlong ptr = 0;
    
    JNF_COCOA_ENTER(env);

    CGLContextObj cgl_ctx = CGLGetCurrentContext();
    if (cgl_ctx)
    {
        SyphonNameboundClient* client = [[SyphonNameboundClient alloc] initWithContext:cgl_ctx];

        ptr = ptr_to_jlong(client);
    }

    JNF_COCOA_EXIT(env);
    
	return ptr;    
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_setApplicationName(JNIEnv * env, jobject jobj, jlong ptr, jstring appName)
{
    JNF_COCOA_ENTER(env);
    
    NSString* name = JNFJavaToNSString(env, appName);
		  
    SyphonNameboundClient* client = jlong_to_ptr(ptr);
    [client setAppName:name];
    
    JNF_COCOA_EXIT(env);    
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_setServerName(JNIEnv * env, jobject jobj, jlong ptr, jstring serverName)
{
    JNF_COCOA_ENTER(env);
        
    NSString* name = JNFJavaToNSString(env, serverName);
		
    if([name length] == 0)
        name = nil;
    
    SyphonNameboundClient* client = jlong_to_ptr(ptr);
	[client setName:name];
    
    JNF_COCOA_EXIT(env);      
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonClient_isValid(JNIEnv * env, jobject jobj, jlong ptr)
{
    jboolean val = JNI_FALSE;
    
    JNF_COCOA_ENTER(env);
    
    
    SyphonNameboundClient* boundClient = jlong_to_ptr(ptr);
	[boundClient lockClient];
	SyphonClient *client = [boundClient client];
	
    if([client isValid])
        val = JNI_TRUE;
    
	[boundClient unlockClient];
    
    JNF_COCOA_EXIT(env);
    
    return val;
}

JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonClient_serverDescription(JNIEnv * env, jobject jobj, jlong ptr)
{
    jobject serverdesc = nil;
    
    JNF_COCOA_ENTER(env);

    SyphonNameboundClient* boundClient = jlong_to_ptr(ptr);
	[boundClient lockClient];
	SyphonClient *client = [(SyphonNameboundClient*)boundClient client];
	
    NSDictionary* desc = [client serverDescription];
    
    JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
    [JNFDefaultCoercions addMapCoercionTo:coecer];
    
    serverdesc = [coecer coerceNSObject:desc withEnv:env];
    
	[boundClient unlockClient];
	
    JNF_COCOA_EXIT(env);

    return serverdesc;
}


JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonClient_hasNewFrame(JNIEnv * env, jobject jobj, jlong ptr)
{
    jboolean val = JNI_FALSE;
    
    JNF_COCOA_ENTER(env);
    
    SyphonNameboundClient* boundClient = jlong_to_ptr(ptr);
	[boundClient lockClient];
	SyphonClient *client = [(SyphonNameboundClient*)boundClient client];
	
    if([client hasNewFrame])
        val = JNI_TRUE;
    
	[boundClient unlockClient];
	
    JNF_COCOA_EXIT(env);
    
    return val;    
}

JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonClient_newFrameDataForContext(JNIEnv * env, jobject jobj, jlong ptr)
{
	jobject imgdata = nil;
	
	JNF_COCOA_ENTER(env);
	
    SyphonNameboundClient* boundClient = jlong_to_ptr(ptr);
	[boundClient lockClient];
	SyphonClient *client = [(SyphonNameboundClient*)boundClient client];
	
    SyphonImage* img = [client newFrameImage];    
    
	NSSize texSize = [img textureSize];

	NSNumber *name = [NSNumber numberWithInt:[img textureName]];
	NSNumber *width = [NSNumber numberWithFloat:texSize.width];
	NSNumber *height = [NSNumber numberWithFloat:texSize.height];
	
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
						 name, @"name", 
						 width, @"width", 
						 height, @"height", 
						 nil];
	
	
	JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
    [JNFDefaultCoercions addMapCoercionTo:coecer];
    
    imgdata = [coecer coerceNSObject:dic withEnv:env];
	
	[img release];
	
	[boundClient unlockClient];
	
	JNF_COCOA_EXIT(env);
	
	return imgdata;	
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonClient_stop(JNIEnv * env, jobject jobj, jlong ptr)
{
    JNF_COCOA_ENTER(env);
  
    SyphonNameboundClient* boundClient = jlong_to_ptr(ptr);
    [boundClient lockClient];
	SyphonClient *client = [(SyphonNameboundClient*)boundClient client];
	
    [client stop];
    
	[boundClient unlockClient];

    JNF_COCOA_EXIT(env);
}

// Commented out until we figure out how to properly coerce arbitrary objects from Objective-C to Java
/*
 JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonClient_newFrameImageForContext(JNIEnv * env, jobject jobj)
 {
 jobject frameimg = nil;
 
 JNF_COCOA_ENTER(env);
 
 [(SyphonNameboundClient*)mClient lockClient];
 SyphonClient *client = [(SyphonNameboundClient*)mClient client];
 
 SyphonImage* img = [client newFrameImageForContext:CGLGetCurrentContext()];
 
 JNFTypeCoercer *coercer = [[[JNFTypeCoercer alloc] init] autorelease];
 
 // TODO: we need to implement a coercion between SyphonImage and JSyphonImage:
 // https://developer.apple.com/library/mac/#documentation/CrossPlatform/Reference/JNFTypeCoercer_Class/Reference/JNFTypeCoercer.html
 // https://developer.apple.com/library/mac/#documentation/CrossPlatform/Reference/JNFTypeCoercion_Protocol/Reference/NSView.html
 // https://developer.apple.com/library/mac/#documentation/CrossPlatform/Reference/JNFDefaultCoercions_Class/Reference/JNFDefaultCoercions.html
 // http://cr.openjdk.java.net/~michaelm/7113349/1/jdk/new/src/macosx/native/apple/applescript/NS_Java_ConversionUtils.m.html
 //[coercer addCoercion:[[[JNFVectorCoercion alloc] init] autorelease] forNSClass:[SyphonImage class] javaClass:@"jsyphon/JSyphonImage"];
 //frameimg = [coecer coerceNSObject:img withEnv:env];
 
 [(SyphonImage*)img release];
 
 [(SyphonNameboundClient*)mClient unlockClient];
 
 JNF_COCOA_EXIT(env);
 
 return frameimg;
 }
 */
