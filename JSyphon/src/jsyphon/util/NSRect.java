/**
 * 
 */
package jsyphon.util;

/**
 * @author Skye Book
 *
 */
public class NSRect{

	private NSPoint origin;
	private NSSize size;

	/**
	 * 
	 */
	public NSRect(int startX, int xLength, int startY, int yLength) {
		this(new NSPoint(startX, startY), new NSSize(xLength, yLength));
	}
	
	public NSRect(NSPoint origin, NSSize size){
		this.origin=origin;
		this.size=size;
	}
	
	/**
	 * @return the origin
	 */
	public NSPoint getOrigin() {
		return origin;
	}

	/**
	 * @param origin the origin to set
	 */
	public void setOrigin(NSPoint origin) {
		this.origin = origin;
	}

	/**
	 * @return the size
	 */
	public NSSize getSize() {
		return size;
	}

	/**
	 * @param size the size to set
	 */
	public void setSize(NSSize size) {
		this.size = size;
	}
}
