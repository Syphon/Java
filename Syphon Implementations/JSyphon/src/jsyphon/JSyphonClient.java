package jsyphon;
import java.util.Dictionary;

import jsyphon.JSyphonImage;

public class JSyphonClient
{
	public JSyphonClient()
	{
	}
	
	//Load the library
	static
	{
		System.out.println("Loading JSyphon");
		System.out.println("Java Library Path: " + System.getProperty("java.library.path"));
		System.loadLibrary("JSyphon");		
		System.out.println("JSyphon Loaded");
	}

	//Native method declarations
	public native void initWithServerDescriptionAndOptions(Dictionary<String, String> description, Dictionary<String, String> options);

	public native boolean isValid();
	
	public native Dictionary<String, String> serverDescription();
	
	public native boolean hasNewFrame();
	
	public native JSyphonImage newFrameImageForContext();

	public native void stop();

}
