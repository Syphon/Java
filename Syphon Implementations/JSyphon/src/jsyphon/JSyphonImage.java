package jsyphon;

public class JSyphonImage
{
	public JSyphonImage()
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
	public native int textureName();
	public native int textureWidth();
	public native int textureHeight();
	
	
}
