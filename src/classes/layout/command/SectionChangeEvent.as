package layout.command {
	import flash.events.Event;

	/**
	 * @author projects
	 */
	public class SectionChangeEvent extends Event
	{
		public static const SCHEDULE:String = "SCHEDULE";
		public static const COMPLETE:String = "COMPLETE";

		public var action : String;

		public function SectionChangeEvent (type:String, action:String=null)
		{
			this.action = action;
			super (type);
		}
	}
}
