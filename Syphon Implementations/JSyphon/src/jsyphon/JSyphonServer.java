package jsyphon;
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

public class JSyphonServer
{
	public JSyphonServer()
	{
		System.out.println("New JSyphon Instance");
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
	
	// TODO: move this to the constuctor?
	public native void initWithName(String name);

	public native String getName();

	public native boolean hasClients();

	public native void publishFrameTexture(int texID, int texTarget, int posX, int posY, int width, int height, int sizeX, int sizeY, boolean isFlipped);

	public void publishFrameTexture(int texID, int texTarget, NSRect rect, NSSize size, boolean isFlipped)
	{
		publishFrameTexture(texID, texTarget, rect.getOrigin().getX(), rect.getOrigin().getY(), rect.getSize().getX(), rect.getSize().getY(), size.getX(), size.getY(), isFlipped);
	}

	public boolean bindToDrawFrameOfSize(NSSize size)
	{
		return bindToDrawFrameOfSize(size.getX(), size.getY());
	}

	public native boolean bindToDrawFrameOfSize(int sizeX, int sizeY);

	public native void unbindAndPublish();

	public native void stop();
}