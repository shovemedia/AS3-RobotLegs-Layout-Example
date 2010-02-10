package layout.command {
	import layout.service.LayoutXmlLoader;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class LoadLayoutConfigCommand extends Command {

		public var service:LayoutXmlLoader;

		override public function execute():void
		{
			trace ("LoadLayoutConfigCommand " + service) ;
			service.load();
		}
	}
}
