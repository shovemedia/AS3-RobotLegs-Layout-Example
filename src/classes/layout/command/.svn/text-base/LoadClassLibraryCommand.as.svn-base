package layout.command {
	import layout.service.ClassLibraryLoader;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class LoadClassLibraryCommand extends Command {
		public var service:ClassLibraryLoader;

		override public function execute():void
		{
			trace ("LoadClassLibraryCommand");
			service.load();
		}
	}
}
