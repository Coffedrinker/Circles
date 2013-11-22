package 
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	//TODO: gamemode switch *done*
	//TODO: cirklarna rör sig i små cirklar
	//TODO: cirklarna rör sig mot varandra och bildar klusterde stoppar när de rör vid varann...
	//TODO: cirklarna glider omkring på stagen. studsar mot kanterna *done*
	/**
	 * ...
	 * @author Jacob
	 */
	public class Main extends Sprite 
	{
		private var pointsTrue:Boolean;
		private var points:int = 0;
		private var circles:Array = new Array;
		private var scoreboard:TextField = new TextField;
		private var gameMode:int = 0;
		
		private var debug:TextField = new TextField;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.addChild(scoreboard);
			scoreboard.text = String(points);
			stage.addChild(debug);
			debug.y = 10;
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyCommands);
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
		}
		
		private function gameLoop(e:Event):void 
		{
			switch (gameMode) 
			{
				case 0:
					
				break;
				
				case 1:
					for each (var addCircle:MyCircle in circles) 
					{
						addCircle.x += addCircle.xSpeed;
						addCircle.y += addCircle.ySpeed;
						
						if (addCircle.x >780 || addCircle.x<0) 
						{
							addCircle.xSpeed *= -1;
						}
						if (addCircle.y >580||addCircle.y<0) 
						{
							addCircle.ySpeed *= -1;
						}
					}
				break;
				case 2:
					for each (var addCircle:MyCircle in circles) 
					{
						if (addCircle.x + addCircle.y >0) 
						{
							var closest:MyCircle = new MyCircle;
							
							for (var i:int = 0; i < circles.length; i++) 
							{
								if (addCircle.x -circles[i].x != 0 && addCircle.y -circles[i].y != 0 && circles[i].x+circles[i].y > 0 ) 
								{
									if (((addCircle.x-closest.x)*(addCircle.x -closest.x)) + ((addCircle.y -closest.y)*(addCircle.y -closest.y)) > ((addCircle.x-circles[i].x)*(addCircle.x-circles[i].x)) + ((addCircle.y -circles[i].y)*(addCircle.y-circles[i].y)))
									{
										closest = circles[i];
									}
								}
							}
							if (!addCircle.hitTestObject(closest))
							{
								if (addCircle.x != closest.x) 
								{
									addCircle.x += (Math.abs(closest.x - addCircle.x)) / (closest.x -addCircle.x);
								}
								if (addCircle.y != closest.y) 
								{
									addCircle.y += (Math.abs(closest.y - addCircle.x)) / (closest.y - addCircle.y);
								}
							}
						}
					}
				break;
				case 3:
					
				break;
				
			}
			debug.text = String(gameMode);
		}
		
		private function keyCommands(e:KeyboardEvent):void 
		{
			
			if (e.keyCode == Keyboard.SPACE) 
			{
				if (circles.length>0) 
				{
					removeCircles(circles);
				}
				
				for (var i:int = 0; i < 20; i++) 
				{
					var addCircle:MyCircle = new MyCircle(false);
					
					if (i == 0) 
					{
						
						addCircle.points = false;
						
						randomX(addCircle);
						randomY(addCircle);
						
						addChild(addCircle);
						
						addCircle.addEventListener(MouseEvent.CLICK, addScore);
						
						circles.push(addCircle);
					}	
					else 
					{
						addCircle.points = true;
						
						randomX(addCircle);
						randomY(addCircle);
						
						addChild(addCircle);
						
						addCircle.addEventListener(MouseEvent.CLICK, addScore);
						
						circles.push(addCircle);
					}
					points = 0;
					scoreboard.text = String(points);
				}
			}
			if (e.keyCode == 49) 
			{
				removeCircles(circles);
				scoreboard.text = "0";
				gameMode = 1;
				
			}
			else if (e.keyCode == 50) 
			{
				removeCircles(circles);
				scoreboard.text = "0";
				gameMode = 2;
			}
			if (e.keyCode == 51) 
			{
				removeCircles(circles);
				scoreboard.text = "0";
				gameMode = 3;
			}
			if (e.keyCode == 48)
			{
				removeCircles(circles);
				scoreboard.text = "0";
				gameMode = 0;
			}
		}
		private function addScore(m:Event):void 
		{
			
			
			if (m.target.points == true) 
			{
				var p:int = circles.indexOf(m.target);
				circles[p].x = -10000;
				circles[p].y = -10000;
				points ++;
				}
			else 
			{
				points = 0;
				removeCircles(circles);
			}
			
			scoreboard.text = String(points);
		}
		private function removeCircles(p:Array):void 
		{
			for each (var addCircle:MyCircle in p) 
			{
				removeChild(addCircle);
			}
			circles.length = 0;
		}
		private function randomX(s:Sprite):void 
		{
			s.x =  Math.random() * 780;
			
		}
		private function randomY(f:Sprite):void 
		{
			f.y = Math.random() * 580;
		}
	}
	
}