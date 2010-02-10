package {
	import org.robotlegs.mvcs.Context;

	import flash.display.Sprite;

	/**
	 * @author projects
	 */
	public class Site extends Sprite {
		private static var context : Context;

		public function Site ()
		{
			context = new SiteContext(this);
		}
	}
}
