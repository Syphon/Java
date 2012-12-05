#import <JavaVM/JavaVM.h>
#import <JavaNativeFoundation/JavaNativeFoundation.h>	// JNI Cocoa helper 
#import <JavaVM/jni.h>

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <Syphon/Syphon.h>

#import <OpenGL/CGLMacro.h>

JNIEXPORT jobject JNICALL Java_jsyphon_JSyphonServerList_getList(JNIEnv * env, jobject jobj)
{
    jobject serverlist = nil;
	
    JNF_COCOA_ENTER(env);    
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
    [[SyphonServerDirectory sharedDirectory] addObserver:nil forKeyPath:@"servers" options:0 context:nil];
	
	NSLog(@"Getting list of servers");
	NSArray *servers = [[SyphonServerDirectory sharedDirectory] servers];
	NSMutableArray *output = [NSMutableArray arrayWithCapacity:[servers count]];
    NSLog(@"Number of servers %i", [servers count]);	
	
	for (NSDictionary *description in servers)
	{
		NSLog(@"Adding server = %@", description);
		NSDictionary *simple = [NSDictionary dictionaryWithObjectsAndKeys:[description objectForKey:SyphonServerDescriptionNameKey], @"Name",
								[description objectForKey:SyphonServerDescriptionAppNameKey], @"App Name", nil];
		[output addObject:simple];
	}

    JNFTypeCoercer* coecer = [JNFDefaultCoercions defaultCoercer];
    [JNFDefaultCoercions addMapCoercionTo:coecer];
	
    serverlist = [coecer coerceNSObject:servers withEnv:env];	
	
	[pool drain];
    JNF_COCOA_EXIT(env);
	
    return serverlist;
	
}