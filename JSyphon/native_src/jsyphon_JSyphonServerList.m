#import "jsyphon_imports.h"

JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonServerList_getList(JNIEnv * env, jobject jobj)
{
	jobject serverlist = nil;

	//JNF_COCOA_ENTER(env);

	NSArray *servers = [[SyphonServerDirectory sharedDirectory] servers];
	NSMutableArray *output = [NSMutableArray arrayWithCapacity:[servers count]];

	for (NSDictionary *description in servers)
	{
		NSDictionary *simple = [NSDictionary dictionaryWithObjectsAndKeys:[description objectForKey:SyphonServerDescriptionNameKey], @"Name",
								 [description objectForKey:SyphonServerDescriptionAppNameKey], @"App Name", nil];
		[output addObject:simple];
	}

	jclass jc_arrayListClass = (*env)->FindClass(env, "java/util/ArrayList");
	CHECK_NULL_RETURN(jc_arrayListClass, NULL);
	jmethodID jm_arrayListCons = (*env)->GetMethodID(env, jc_arrayListClass, "<init>", "()V");
	CHECK_NULL_RETURN(jm_arrayListCons, NULL);
	jmethodID jm_listAdd = (*env)->GetMethodID(env, jc_arrayListClass, "add", "(Ljava/lang/Object;)Z");
	CHECK_NULL_RETURN(jm_listAdd, NULL);
	serverlist = (*env)->NewObject(env, jc_arrayListClass, jm_arrayListCons);
	CHECK_NULL_RETURN(serverlist, NULL);

	//JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
	//[JNFDefaultCoercions addMapCoercionTo:coecer];

	ADD(serverlist, servers);
	ADDNULL(serverlist);

	//JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
	//[JNFDefaultCoercions addMapCoercionTo:coecer];

	//serverlist = [coecer coerceNSObject:servers withEnv:env];	

	//JNF_COCOA_EXIT(env);

	return serverlist;

}