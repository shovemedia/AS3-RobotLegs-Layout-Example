package layout.model.events {
	import com.senocular.display.Layout;

	import flash.events.Event;

	/**
	 * @author projects
	 */
	public class LayoutEvent extends Event {
		public static const CREATE:String = "CREATE";
		public static const ALIGNS_CHANGED:String = "ALIGNS_CHANGED";
		public static const POSITION_CHANGED:String = "POSITION_CHANGED";
		public static const SIZE_CHANGED:String = "SIZE_CHANGED";

		public var layout:Layout;

		public var id:String;

		public function LayoutEvent (type:String, layout:Layout = null, id:String = null)
		{
			this.layout = layout;
			this.id = id;
			super(type);
		}

		override public function clone():Event
		{
			return new LayoutEvent(type, layout, id);
		}
	}
}
