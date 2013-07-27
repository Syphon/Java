package jsyphon;

public class JSyphonImage
{
  private int name;
  private int width;
  private int height;
  
  public JSyphonImage(int name, int width, int height) {
    this.name = name;
    this.width = width;
    this.height = height;
  }
  
  public int textureName() {
    return name;
  }
  
  public int textureWidth() {
    return width;
  }
  
  public int textureHeight() {
    return height;
  }  
  
  /*
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
	*/
}
