package jsyphon;

import java.util.ArrayList;
import java.util.HashMap;

public class JSyphonServerList {
//  public JSyphonServerList() 
//  {
//    System.out.println("New JSyphon Instance");
//  }
//  
  //Load the library
  static
  {
//    System.out.println("Loading JSyphon");
//    System.out.println("Java Library Path: " + System.getProperty("java.library.path"));
    System.loadLibrary("JSyphon");    
//    System.out.println("JSyphon Loaded");
  }
  
  static public native ArrayList<HashMap<String, String>> getList();
}
