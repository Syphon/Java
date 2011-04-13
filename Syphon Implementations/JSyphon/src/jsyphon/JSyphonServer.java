package jsyphon;
import jsyphon.util.NSRect;
import jsyphon.util.NSSize;




/**
 * 
 * @author Skye Book
 *
 */
public class JSyphonServer {


	public JSyphonServer() {
	}



	//Load the library
	static {
		System.out.println("laoding native class");

		System.out.println("java path: " + System.getProperty("java.library.path"));

		System.load("/SVNRepositories/Syphon Implementations/JSyphon/native_libs/JSyphon.bundle/Contents/MacOS/JSyphon");

		System.out.println("Class loaded");
	}



	//Native method declaration
	public native void initWithName(String name);

	public native String getName();

	public native boolean hasClients();

	public native void publishFrameTexture(int texID, int texTarget, int posX, int posY, int width, int height, int sizeX, int sizeY, boolean isFlipped);

	public void publishFrameTexture(int texID, int texTarget, NSRect rect, NSSize size, boolean isFlipped){
		publishFrameTexture(texID, texTarget, rect.getOrigin().getX(), rect.getOrigin().getY(),
				rect.getSize().getX(), rect.getSize().getY(),
				size.getX(), size.getY(), isFlipped);
	}

	public boolean bindToDrawFrameOfSize(NSSize size){
		return bindToDrawFrameOfSize(size.getX(), size.getY());
	}

	public native boolean bindToDrawFrameOfSize(int sizeX, int sizeY);

	public native void unbindAndPublish();

	public native void stop();
}