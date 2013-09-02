package jsyphon.test;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.IntBuffer;

import jsyphon.JSyphonServer;

import org.lwjgl.LWJGLException;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;
import org.lwjgl.opengl.GL11;

/**
 * @author Skye Book
 *
 */
public class ServerTest {

	private JSyphonServer server;

	/**
	 * @throws LWJGLException 
	 * 
	 */
	public ServerTest() throws LWJGLException {
		server=new JSyphonServer();
	}

	public void start() {
		try {
			Display.setDisplayMode(new DisplayMode(800,600));
			Display.create();
			Display.setTitle("ServerTest");
		} catch (LWJGLException e) {
			e.printStackTrace();
			System.exit(0);
		}

		server.initWithName("Server Test");
		
    IntBuffer intBuff = ByteBuffer.allocateDirect(4).order(ByteOrder.nativeOrder()).asIntBuffer();

    ByteBuffer dummy = null;

    while (!Display.isCloseRequested()) {
      // This copies the back buffer of LWJGL

      // render OpenGL here
      GL11.glClear(GL11.GL_COLOR_BUFFER_BIT);
      
      GL11.glPointSize(40f);
      GL11.glBegin(GL11.GL_POINTS);
      GL11.glVertex3f(0.0f, 0.0f, 0.0f);
      GL11.glEnd();

      // Its highly recommended you use RECTANGLE textures
      int target = GL11.GL_TEXTURE_2D; // GL31.GL_TEXTURE_RECTANGLE or GL11.GL_TEXTURE_2D
      
      GL11.glEnable(target);

      GL11.glGenTextures(intBuff);

      GL11.glBindTexture(target, intBuff.get(0));

      GL11.glTexImage2D(target, 0, GL11.GL_RGBA8, 800, 600, 0, GL11.GL_RGBA, GL11.GL_UNSIGNED_BYTE, dummy);

      GL11.glCopyTexSubImage2D(target, 0, 0, 0, 0, 0, 800, 600);

      server.publishFrameTexture(intBuff.get(0), target, 0, 0, 800, 600, 800, 600, false);
      
      GL11.glDeleteTextures(intBuff.get(0));

      intBuff.clear();
      intBuff.rewind();

      // Always call this so LWJGL can swap buffers, etc.
      Display.update();
    }

    server.stop();
    Display.destroy();
	}

	/**
	 * @param args
	 * @throws LWJGLException 
	 */
	public static void main(String[] args) throws LWJGLException {
		ServerTest t = new ServerTest();
		t.start();
	}
}
