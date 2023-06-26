#import "jsyphon_imports.h"

JNIEXPORT jstring JNICALL _NSStringToJavaString(JNIEnv* env, NSString *str) {
    if (str == NULL) {
       return NULL;
    }
    jsize len = [str length];
    unichar *buffer = (unichar*)calloc(len, sizeof(unichar));
    if (buffer == NULL) {
       return NULL;
    }
    NSRange crange = NSMakeRange(0, len);
    [str getCharacters:buffer range:crange];
    jstring jStr = (*env)->NewString(env, buffer, len);
    free(buffer);
    CHECK_EXCEPTION();
    return jStr;
}

JNIEXPORT NSString* JNICALL _JavaStringToNSString(JNIEnv *env, jstring jstr) {
    if (jstr == NULL) {
        return NULL;
    }
    jsize len = (*env)->GetStringLength(env, jstr);
    const jchar *chars = (*env)->GetStringChars(env, jstr, NULL);
    if (chars == NULL) {
        return NULL;
    }
    NSString *result = [NSString stringWithCharacters:(UniChar *)chars length:len];
    (*env)->ReleaseStringChars(env, jstr, chars);
    return result;
}