package jsyphon;

import java.util.HashMap;
import jsyphon.JSyphonImage;

public class JSyphonClient
{
	public JSyphonClient() { }
	
	static
	{
		System.loadLibrary("JSyphon");		
	}

	//Native method declarations
	public native void init();
	
	public native void setApplicationName(String appName);
	
	public native void setServerName(String serverName);
	
	public native boolean isValid();

  public native HashMap<String, String> serverDescription();
	
  public native boolean hasNewFrame();
  
  public native HashMap<String, Object> newFrameDataForContext();
  
  public native void stop();
  
	public JSyphonImage newFrameImageForContext() {
	  HashMap<String, Object> dict = newFrameDataForContext();
	  Long name = (Long)dict.get("name");
	  Double width = (Double)dict.get("width");
	  Double height = (Double)dict.get("height");
	  return new JSyphonImage(name.intValue(), width.intValue(), height.intValue());
	}
}
