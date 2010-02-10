package layout.service.events {
	import layout.model.LayoutStatesModel;

	import flash.events.Event;

	/**
	 * @author projects
	 */
	public class LayoutServiceEvent extends Event {

		public static const LOADED:String = "LOADED";

		public var model:LayoutStatesModel

		public function LayoutServiceEvent (type:String, model:LayoutStatesModel)
		{
			this.model = model
			super(type);
		}
	}
}
