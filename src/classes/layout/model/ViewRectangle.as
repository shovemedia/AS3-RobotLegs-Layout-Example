package layout.model {
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.robotlegs.mvcs.Actor;

	import com.senocular.display.Layout;

	import layout.model.events.LayoutEvent;

	/**
	 * @author projects
	 */
	public class ViewRectangle extends EventDispatcher implements IViewRectangle {

		private var layout : Layout;
		private var rect : Rectangle;
		private var _id : String;

		public function ViewRectangle()
		{
			rect = new Rectangle();
		}

		public function setLayout (layout:Layout):void
		{
		  this.layout = layout;

		  layout.addEventListener(LayoutEvent.POSITION_CHANGED, onLayoutPositionChanged);
		  layout.addEventListener(LayoutEvent.SIZE_CHANGED, onLayoutSizeChanged);
		}
		public function getLayout():Layout
		{
			return layout;
		}


		public function set id(id:String):void
		{
			_id = id;
		}
		public function get id():String
		{
			return _id;
		}

		public function get x():Number
		{
		  return rect.x;
		}
		public function get y():Number
		{
		  return rect.y;
		}
		public function get width():Number
		{
		  return rect.width;
		}
		public function get height():Number
		{
		  return rect.height;
		}

		private function onLayoutSizeChanged(event : LayoutEvent) : void {
			rect.width = layout.rect.width;
			rect.height = layout.rect.height;

			dispatchEvent(event.clone());
		}

		private function onLayoutPositionChanged(event : LayoutEvent) : void {
			var registrationPoint : Point = layout.getGlobalPoint();
			rect.x = registrationPoint.x;
			rect.y = registrationPoint.y;

			dispatchEvent(event.clone());
		}
	}
}
