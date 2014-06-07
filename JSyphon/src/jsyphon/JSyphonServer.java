package jsyphon;
import java.util.HashMap;

import jsyphon.util.NSRect;
import jsyphon.util.NSSize;

/*
JSyphonServer.java - 
Copyright 2011 -Skye Book (sbook) & Anton Marini (vade)

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

public class JSyphonServer {
  private long ptr;

  static {
    System.loadLibrary("JSyphon");    
  }
  
  // Public API
  
	public JSyphonServer() { }
	
  public void initWithName(String name) {
    ptr = initWithName(name, null);
  }

  public String getName() {
    return getName(ptr);
  }

  public boolean hasClients() {
    return hasClients(ptr);
  }

  public void publishFrameTexture(int texID, int texTarget, int posX, int posY, int width, int height, int sizeX, int sizeY, boolean isFlipped) {
    publishFrameTexture(ptr, texID, texTarget, posX, posY, width, height, sizeX, sizeY, isFlipped);
  }

  public void publishFrameTexture(int texID, int texTarget, NSRect rect, NSSize size, boolean isFlipped) {
    publishFrameTexture(ptr, texID, texTarget, rect.getOrigin().getX(), rect.getOrigin().getY(), rect.getSize().getX(), rect.getSize().getY(), size.getX(), size.getY(), isFlipped);
  }

  public boolean bindToDrawFrameOfSize(NSSize size) {
    return bindToDrawFrameOfSize(ptr, size.getX(), size.getY());
  }

  public boolean bindToDrawFrameOfSize(int sizeX, int sizeY) {
    return bindToDrawFrameOfSize(ptr, sizeX, sizeY);
  }

  public void unbindAndPublish() {
    unbindAndPublish(ptr);
  }

  public void stop() {
    stop(ptr);
  }
	
	// Native method declarations
	
	private native long initWithName(String name, HashMap<String, Object> options);

	private native String getName(long ptr);

	private native boolean hasClients(long ptr);

	private native void publishFrameTexture(long ptr, int texID, int texTarget, int posX, int posY, int width, int height, int sizeX, int sizeY, boolean isFlipped);

	private void publishFrameTexture(long ptr, int texID, int texTarget, NSRect rect, NSSize size, boolean isFlipped) {
		publishFrameTexture(ptr, texID, texTarget, rect.getOrigin().getX(), rect.getOrigin().getY(), rect.getSize().getX(), rect.getSize().getY(), size.getX(), size.getY(), isFlipped);
	}

	private boolean bindToDrawFrameOfSize(long ptr, NSSize size) {
		return bindToDrawFrameOfSize(ptr, size.getX(), size.getY());
	}

	private native boolean bindToDrawFrameOfSize(long ptr, int sizeX, int sizeY);

	private native void unbindAndPublish(long ptr);

	private native void stop(long ptr);
}