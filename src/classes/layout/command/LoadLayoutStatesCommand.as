package layout.command {
	import flash.utils.getQualifiedClassName;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.events.Event;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class LoadLayoutStatesCommand extends Command {

		public var url:String;

		public static const LAYOUT_STATES_LOADED:String = "LAYOUT_STATES_LOADED";

		override public function execute():void
		{
			var urlLoader:URLLoader = new URLLoader()
			urlLoader.addEventListener(Event.COMPLETE, onLoadComplete)
			urlLoader.load (new URLRequest(url))
		}

		private function onLoadComplete(event:Event):void {
			trace ("loaded " + new XML(event.target.data) )

			injector.mapValue(XML, new XML(event.target.data), "layoutStates");
			//start the state machine
			eventDispatcher.dispatchEvent( new Event(LAYOUT_STATES_LOADED) );
		}
	}
}
