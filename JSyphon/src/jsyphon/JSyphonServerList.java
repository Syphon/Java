package jsyphon;

import java.util.ArrayList;
import java.util.HashMap;

public class JSyphonServerList {
  static
  {
    System.loadLibrary("JSyphon");    
  }
  
  static public native ArrayList<HashMap<String, String>> getList();
}
