package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Jacob
	 */
	public class MyCircle extends Sprite
	{
		public var points:Boolean;
		public var xSpeed:int = (Math.random() * 20) - 10;
		public var ySpeed: int = (Math.random() * 20 ) - 10;
		
		public function MyCircle(points:Boolean = true) 
		{
			this.graphics.beginFill(0xFF8040);
			this.graphics.drawCircle(0, 0, 20);
			this.graphics.endFill();
			
			
			this.points = points;
			this.xSpeed = xSpeed;
			this.ySpeed = ySpeed;
		}
		
	}

}