#import "jsyphon_imports.h"

JNIEXPORT jlong JNICALL Java_jsyphon_JSyphonServer_initWithName (JNIEnv * env, jobject jobj, jstring name, jobject options)
{
    jlong ptr = 0;

    //JNF_COCOA_ENTER(env);

    CGLContextObj cgl_ctx = CGLGetCurrentContext();

    NSString* sname = JNFJavaToNSString(env, name);

    NSDictionary* sopt = nil;
    if (options != nil) {
        jclass jc_arrayListClass = (*env)->FindClass(env, "java/util/ArrayList");
        CHECK_NULL_RETURN(jc_arrayListClass, NULL);
        jmethodID jm_arrayListCons = (*env)->GetMethodID(env, jc_arrayListClass, "<init>", "()V");
        CHECK_NULL_RETURN(jm_arrayListCons, NULL);
        jmethodID jm_listAdd = (*env)->GetMethodID(env, jc_arrayListClass, "add", "(Ljava/lang/Object;)Z");
        CHECK_NULL_RETURN(jm_listAdd, NULL);
        ptr = (*env)->NewObject(env, jc_arrayListClass, jm_arrayListCons);
        CHECK_NULL_RETURN(ptr, NULL);

        //JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
        //  [JNFDefaultCoercions addMapCoercionTo:coecer];

        ADD(ptr, options);
        ADDNULL(ptr);

        //JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
        //[JNFDefaultCoercions addMapCoercionTo:coecer];
        //sopt = [coecer coerceJavaObject:options withEnv:env];
    }

    SyphonServer* server = [[SyphonServer alloc] initWithName:sname context:cgl_ctx options:nil];
    ptr = ptr_to_jlong(server);

    //JNF_COCOA_EXIT(env);

    return ptr;
}

JNIEXPORT jstring JNICALL Java_jsyphon_JSyphonServer_getName (JNIEnv * env, jobject jobj, jlong ptr)
{
	jstring name = NULL;
	
	JNF_COCOA_ENTER(env);
    
    SyphonServer* server = jlong_to_ptr(ptr);
	name = JNFNSToJavaString(env, [server name]);
	
	JNF_COCOA_EXIT(env);
	
	return name;
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_hasClients(JNIEnv * env, jobject jobj, jlong ptr)
{
    jboolean hasClients = JNI_FALSE;
    BOOL tf = NO;
    
    JNF_COCOA_ENTER(env);
    SyphonServer* server = jlong_to_ptr(ptr);
    tf = [server hasClients];
    
    JNF_COCOA_EXIT(env);
    
    if(tf)
        hasClients = JNI_TRUE;
    
    return hasClients;
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_publishFrameTexture(JNIEnv * env, jobject jobj, jlong ptr, jint texID, jint texTarget, jint xPos, jint yPos, jint width, jint height, jint sizeX, jint sizeY, jboolean isFlipped)
{
	JNF_COCOA_ENTER(env);
	
	// Put Code Here
	NSRect rect = NSMakeRect(xPos, yPos, width, height);
	NSSize size = NSMakeSize(sizeX, sizeY);
	
	GLuint textureID = texID ;
	GLuint textureTarget = texTarget;
    SyphonServer* server = jlong_to_ptr(ptr);
    [server publishFrameTexture:textureID textureTarget:textureTarget imageRegion:rect textureDimensions:size flipped:(isFlipped == JNI_TRUE)];
    
	JNF_COCOA_EXIT(env);
}

JNIEXPORT jboolean JNICALL Java_jsyphon_JSyphonServer_bindToDrawFrameOfSize(JNIEnv * env, jobject jobj, jlong ptr, jint sizeX, jint sizeY)
{
    jboolean jbool = JNI_FALSE;
    BOOL tf = NO;
    
	JNF_COCOA_ENTER(env);
	
	NSSize size = NSMakeSize(sizeX, sizeY);
	
    SyphonServer* server = jlong_to_ptr(ptr);
	tf = [server bindToDrawFrameOfSize:size];
	
	JNF_COCOA_EXIT(env);
    
    if(tf)
        jbool = JNI_TRUE;
    
    return jbool;
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_unbindAndPublish(JNIEnv * env, jobject jobj, jlong ptr)
{
	JNF_COCOA_ENTER(env);
    
    SyphonServer* server = jlong_to_ptr(ptr);
	[server unbindAndPublish];
	
	JNF_COCOA_EXIT(env);
}

JNIEXPORT void JNICALL Java_jsyphon_JSyphonServer_stop(JNIEnv * env, jobject jobj, jlong ptr)
{
	JNF_COCOA_ENTER(env);	
	
    SyphonServer* server = jlong_to_ptr(ptr);
	[server stop];
	
	JNF_COCOA_EXIT(env);
}