package zone {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.events.MouseEvent;

	import com.senocular.display.Layout;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.Sprite;

	/**
	 * @author projects
	 */
	public class RectangleView extends Sprite {

		private var layout:Layout;
		//private var rectangle:Rectangle;
		private var color : uint;
		private var id:String;

		private var gfx:Sprite;
		private var tf:TextField;

		public var debug:Boolean;

		private var __w : Number;
		private var __h : Number;
		protected var __x : Number;
		protected var __y : Number;



		public function RectangleView ()
		{
			this.addEventListener(MouseEvent.CLICK, onClick)

			gfx = new Sprite();
			addChild(gfx);

			tf = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;

			this.addChild(tf);

			this.mouseEnabled = false;
		}

		private function onClick(event : MouseEvent) : void {
			trace ([this.width, 'x',  this.height, ' layout: ', this.layout.width, 'x',  this.layout.height, ' layout rect: ', this.layout.rect.width, 'x',  this.layout.rect.height ])
			//this.layout.draw();
		}


		public function position(event:Event = null):void
		{
			trace (" ... position " + this)
			var rectangle:Rectangle = layout.rect;

			//this.x = rectangle.x
			//this.y = rectangle.y

		}

		public function draw(event:Event = null):void
		{
			//trace (" . " +   this)
			var rectangle:Rectangle = layout.rect;

			if (__w != rectangle.width || __h != rectangle.height)
			{
				//trace (" ... draw " +  [gfx.width, rectangle.width, gfx.height, rectangle.height])
				gfx.graphics.clear();
				gfx.graphics.beginFill(color, alpha);
				gfx.graphics.lineStyle(0,.5)
				gfx.graphics.drawCircle(2, 2, 2)

				gfx.graphics.drawRect(0, 0, rectangle.width, rectangle.height);

				gfx.graphics.lineStyle();
				gfx.graphics.endFill();

				__w = rectangle.width;
				__h = rectangle.height;
			}

			if (id)
			{
				tf.text =id;
			}

			if (__x != rectangle.x)
			{
			  //trace (" ... x")
			  __x = gfx.x = tf.x = rectangle.x;

			}

			if (__y != rectangle.y)
			{
			  //trace (" ... y")
			  __y = gfx.y = tf.y = rectangle.y;
			}

			//if (debug) trace (this + " " + rectangle);
		}


//		public function getRectangle() : Rectangle {
//			return rectangle;
//		}
//
//		public function setRectangle(rectangle : Rectangle) : void {
//			this.rectangle = rectangle;
//		}

		public function getId() : String {
			return id;
		}

		public function setId(id : String) : void {
			trace ("set id " + id)
			this.id = id;
		}

		public function getColor() : uint {
			return color;
		}

		public function setColor(color : uint) : void {
			this.color = color;
		}

		public function getLayout() : Layout {
			return layout;
		}

		public function setLayout(layout : Layout) : void {
			this.layout = layout;
		}

		public function getX() : Number {
			return __x;
		}
		public function getY() : Number {
			return __y;
		}


		//
		//
		//

		override public function toString():String
		{
			return "[RectangleView] " + this.name;
		}

	}
}
