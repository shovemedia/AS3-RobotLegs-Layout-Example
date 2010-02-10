package {
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author projects
	 */

	public class SiteMediator extends Mediator {

		public var view:Site;

		public function SiteMediator()
		{
			trace ("new SiteMediator");
		}

		override public function onRegister():void
		{
			trace ("SiteMediator onRegister: " + view  )
		}


	}
}
