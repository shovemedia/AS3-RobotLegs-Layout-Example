package layout.command {
	import layout.service.SkinXmlLoader;

	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class LoadSkinConfigCommand extends Command {
		public var service:SkinXmlLoader;

		override public function execute():void
		{
			service.load();
		}
	}
}
