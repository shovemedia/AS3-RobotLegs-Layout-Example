package view.events {
	import view.component.RemoteImage;

	import flash.events.Event;

	/**
	 * @author projects
	 */
	public class RemoteImageEvent extends Event {

		public static const LOADED:String = "LOADED";

		public var remoteImage : RemoteImage;

		public function RemoteImageEvent (type:String, remoteImage:RemoteImage)
		{
			this.remoteImage = remoteImage
			super(type)
		}

		override public function clone ():Event
		{
			return new RemoteImageEvent(this.type, this.remoteImage);
		}
	}
}
