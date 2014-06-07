package jsyphon;

import java.util.HashMap;

import jsyphon.JSyphonImage;

public class JSyphonClient
{
  private long ptr;
  
  static
  {
    System.loadLibrary("JSyphon");    
  }
  
  // public API
  
	public JSyphonClient() { }
	
  public void init() {
    ptr = init(null);
  }
  
  public void setApplicationName(String appName) {
    setApplicationName(ptr, appName);
  }
  
  public void setServerName(String serverName) {
    setServerName(ptr, serverName);
  }
  
  public boolean isValid() {
    return isValid(ptr);
  }

  public HashMap<String, String> serverDescription() {
    return serverDescription(ptr);
  }
  
  public boolean hasNewFrame() {
    return hasNewFrame(ptr);
  }
  
  public HashMap<String, Object> newFrameDataForContext() {
    return newFrameDataForContext(ptr);  
  }
  
  public void stop() {
    stop(ptr);
  }
  
  public JSyphonImage newFrameImageForContext() {
    HashMap<String, Object> dict = newFrameDataForContext();
    Long name = (Long)dict.get("name");
    Double width = (Double)dict.get("width");
    Double height = (Double)dict.get("height");
    return new JSyphonImage(name.intValue(), width.intValue(), height.intValue());
  }	

	// Native method declarations
	public native long init(HashMap<String, Object> options);
	
	public native void setApplicationName(long ptr, String appName);
	
	public native void setServerName(long ptr, String serverName);
	
	public native boolean isValid(long ptr);

  public native HashMap<String, String> serverDescription(long ptr);
	
  public native boolean hasNewFrame(long ptr);
  
  public native HashMap<String, Object> newFrameDataForContext(long ptr);
  
  public native void stop(long ptr);
  
//	public JSyphonImage newFrameImageForContext() {
//	  HashMap<String, Object> dict = newFrameDataForContext();
//	  Long name = (Long)dict.get("name");
//	  Double width = (Double)dict.get("width");
//	  Double height = (Double)dict.get("height");
//	  return new JSyphonImage(name.intValue(), width.intValue(), height.intValue());
//	}
}
