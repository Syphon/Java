#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper 
#import <JavaVM/jni.h>

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <OpenGL/CGLMacro.h>

static SyphonServer* _myServer;

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_initWithName (JNIEnv * env, jobject jobj, jstring name)
{
	JNF_COCOA_ENTER(env);
    
    CGLContextObj cgl_ctx = CGLGetCurrentContext();

    NSString* sname = JNFJavaToNSString(env, name);

	_myServer = [[SyphonServer alloc] initWithName:sname context:cgl_ctx options:nil];
    
	JNF_COCOA_EXIT(env);

	return;
}

JNIEXPORT jstring JNICALL Java_jsyphon_JSyphonServer_getName (JNIEnv * env, jobject jobj)
{
	jstring name = NULL;
	
	JNF_COCOA_ENTER(env);
    
	name = JNFNSToJavaString(env, [_myServer name]);
	
	JNF_COCOA_EXIT(env);
	
	return name;
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_hasClients(JNIEnv * env, jobject jobj)
{
    jboolean hasClients = JNI_FALSE;
    BOOL tf = NO;
    
    JNF_COCOA_ENTER(env);
    tf = [_myServer hasClients];
    
    JNF_COCOA_EXIT(env);
    
    if(tf)
        hasClients = JNI_TRUE;
    
    return hasClients;
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_publishFrameTexture(JNIEnv * env, jobject jobj, jint texID, jint texTarget, jint xPos, jint yPos, jint width, jint height, jint sizeX, jint sizeY, jboolean isFlipped)
{
	JNF_COCOA_ENTER(env);
	
	// Put Code Here
	NSRect rect = NSMakeRect(xPos, yPos, width, height);
	NSSize size = NSMakeSize(sizeX, sizeY);
	
	GLuint textureID = texID ;
	GLuint textureTarget = texTarget;
    [_myServer publishFrameTexture:textureID textureTarget:textureTarget imageRegion:rect textureDimensions:size flipped:(isFlipped == JNI_TRUE)];
	
	JNF_COCOA_EXIT(env);
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_bindToDrawFrameOfSize(JNIEnv * env, jobject jobj, jint sizeX, jint sizeY)
{
    jboolean jbool = JNI_FALSE;
    BOOL tf = NO;
    
	JNF_COCOA_ENTER(env);
	
	NSSize size = NSMakeSize(sizeX, sizeY);
	
	tf = [_myServer bindToDrawFrameOfSize:size];
	
	JNF_COCOA_EXIT(env);
    
    if(tf)
        jbool = JNI_TRUE;
    
    return jbool;
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_unbindAndPublish(JNIEnv * env, jobject jobj)
{
	JNF_COCOA_ENTER(env);
	
	[_myServer unbindAndPublish];
	
	JNF_COCOA_EXIT(env);
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_stop(JNIEnv * env, jobject jobj)
{
	JNF_COCOA_ENTER(env);	
	
	[_myServer stop];
	
	JNF_COCOA_EXIT(env);
}