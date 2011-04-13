package jsyphon.test;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.IntBuffer;

import jsyphon.JSyphonServer;

import org.lwjgl.LWJGLException;
import org.lwjgl.opengl.Display;
import org.lwjgl.opengl.DisplayMode;
import org.lwjgl.opengl.GL11;
import org.lwjgl.opengl.GL31;

/**
 * 
 */

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
		} catch (LWJGLException e) {
			e.printStackTrace();
			System.exit(0);
		}

		// init OpenGL here

		server.initWithName("df");
		//IntBuffer dims = ByteBuffer.allocateDirect(16).order(ByteOrder.nativeOrder()).asIntBuffer();

		//IntBuffer dims = IntBuffer.allocate(16);

		IntBuffer intBuff = ByteBuffer.allocateDirect(4).order(ByteOrder.nativeOrder()).asIntBuffer();

		ByteBuffer dummy = null;

		while (!Display.isCloseRequested()) {

			// This captures all of the drawing done by LWJGL
			/*server.bindToDrawFrameOfSize(Display.getDisplayMode().getWidth(), Display.getDisplayMode().getHeight());

			// render OpenGL here
			GL11.glClear(GL11.GL_COLOR_BUFFER_BIT);

			GL11.glPointSize(40f);
			GL11.glBegin(GL11.GL_POINTS);
			GL11.glVertex3f(0.0f, 0.0f, 0.0f);
			GL11.glEnd();

			server.unbindAndPublish();
			 */


			// This copies the back buffer of LWJGL

			// render OpenGL here
			GL11.glClear(GL11.GL_COLOR_BUFFER_BIT);
			
			GL11.glPointSize(40f);
			GL11.glBegin(GL11.GL_POINTS);
			GL11.glVertex3f(0.0f, 0.0f, 0.0f);
			GL11.glEnd();

			//dims.clear();
			//dims.rewind();
			//GL11.glGetInteger(GL11.GL_VIEWPORT, dims);

			// Its highly recommended you use RECTANGLE textures
			int target = GL11.GL_TEXTURE_2D; // GL31.GL_TEXTURE_RECTANGLE or GL11.GL_TEXTURE_2D
			
			GL11.glEnable(target);

			GL11.glGenTextures(intBuff);

			//GL11.glBindTexture(GL31.GL_TEXTURE_RECTANGLE, intBuff.get(0));
			GL11.glBindTexture(target, intBuff.get(0));

			//GL11.glTexImage2D(GL11.GL_TEXTURE_2D, 0, GL11.GL_RGBA8, dims.get(2), dims.get(3), 0, GL11.GL_RGBA, GL11.GL_UNSIGNED_BYTE, dummy);
			GL11.glTexImage2D(target, 0, GL11.GL_RGBA8, 800, 600, 0, GL11.GL_RGBA, GL11.GL_UNSIGNED_BYTE, dummy);

			//GL11.glCopyTexSubImage2D(GL11.GL_TEXTURE_2D, 0, 0, 0, dims.get(0), dims.get(1), dims.get(2), dims.get(3));
			GL11.glCopyTexSubImage2D(target, 0, 0, 0, 0, 0, 800, 600);

			//server.publishFrameTexture(intBuff.get(0), GL11.GL_TEXTURE_2D, 0, 0, dims.get(2), dims.get(3), dims.get(2), dims.get(3), false);
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
