package layout.model {
	import flash.geom.Point;
	import flash.events.EventDispatcher;

	import org.robotlegs.mvcs.Actor;

	import flash.geom.Rectangle;

	import layout.model.events.LayoutEvent;

	import com.senocular.display.Layout;

	/**
	 * @author projects
	 */
	public class BlendedViewRectangle extends EventDispatcher implements IViewRectangle {

		private var layout1:Layout;
		private var layout2:Layout;

		private var rect1:Rectangle;
		private var rect2:Rectangle;

		private var blendPercentage : Number;

		private var _id:String;

	  	private var layout1Listener:Boolean
	  	private var layout2Listener:Boolean

		public function setLayouts (layout1:Layout, layout2:Layout):void {
			trace('BlendedViewRectangle.setLayouts: ' + (layout1 ) + "  " + layout2);
			this.layout1 = layout1;
			this.layout2 = layout2;

			rect1 = new Rectangle();
			rect2 = new Rectangle();

		  layout1.addEventListener(LayoutEvent.POSITION_CHANGED, onLayoutPositionChanged);
		  layout1.addEventListener(LayoutEvent.SIZE_CHANGED, onLayoutSizeChanged);
		  layout2.addEventListener(LayoutEvent.POSITION_CHANGED, onLayoutPositionChanged);
		  layout2.addEventListener(LayoutEvent.SIZE_CHANGED, onLayoutSizeChanged);

		  layout1.dispatchEvent(new LayoutEvent(LayoutEvent.POSITION_CHANGED));
		  layout1.dispatchEvent(new LayoutEvent(LayoutEvent.SIZE_CHANGED));
		  layout2.dispatchEvent(new LayoutEvent(LayoutEvent.POSITION_CHANGED));
		  layout2.dispatchEvent(new LayoutEvent(LayoutEvent.SIZE_CHANGED));
		}

		public function getLayout1() : Layout {
			return layout1;
		}
		public function getLayout2() : Layout {
			return layout2;
		}

		public function set id(id:String):void
		{
			_id = id;
		}
		public function get id():String
		{
			return _id;
		}

		public function setBlendPercentage(percent:Number):void {
			if (blendPercentage != percent) {
				blendPercentage = percent;
			}

			dispatchEvent(new LayoutEvent(LayoutEvent.POSITION_CHANGED));
			dispatchEvent(new LayoutEvent(LayoutEvent.SIZE_CHANGED));
		}

		public function get x():Number
		{
		  return rect1.x + blendPercentage * (rect2.x - rect1.x);
		}
		public function get y():Number
		{
		  return rect1.y + blendPercentage * (rect2.y - rect1.y);
		}

		public function get width():Number
		{
		  //trace ("blended w " + _id + " " + rect1.width + " " + rect2.width)
		  return rect1.width + blendPercentage * (rect2.width - rect1.width);
		}
		public function get height():Number
		{
		  //trace ("blended h " + _id + " " + rect1.height + " " + rect2.height)
		  return rect1.height + blendPercentage * (rect2.height - rect1.height);
		}

		private function onLayoutSizeChanged(event : LayoutEvent) : void {
			//trace('onLayoutSizeChanged  ' + layout1Listener + " " + layout2Listener);

			if (Layout(event.target) == layout1) {
				//trace ("set rect1");
				rect1.width = layout1.rect.width;
				rect1.height = layout1.rect.height;
			}

			if (Layout(event.target) == layout2)
			{
				//trace ("set rect2");
				rect2.width = layout2.rect.width;
				rect2.height = layout2.rect.height;
			}

			if (!layout1Listener && !layout2Listener)
			{
			  dispatchEvent(event.clone());
			}
		}

		private function onLayoutPositionChanged(event : LayoutEvent) : void {
			//trace('onLayoutPositionChanged  ' + layout1Listener + " " + layout2Listener);

				var registrationPoint : Point;

				if (Layout(event.target) == layout1) {
					//trace ("set rect1");
					registrationPoint = layout1.getGlobalPoint();
					rect1.x = registrationPoint.x;
					rect1.y = registrationPoint.y;
				}

				if (Layout(event.target) == layout2)
				{
					//trace ("set rect2");
					registrationPoint = layout2.getGlobalPoint();
					rect2.x = registrationPoint.x;
					rect2.y = registrationPoint.y;
				}


			if (!layout1Listener && !layout2Listener)
			{
			  dispatchEvent(event.clone());
			}
		}


	}
}
