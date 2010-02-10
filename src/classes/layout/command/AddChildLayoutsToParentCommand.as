package layout.command {
	import layout.model.LayoutStatesModel;

	import com.senocular.display.Layout;

	import org.robotlegs.mvcs.Command;

	import flash.events.Event;

	/**
	 * @author projects
	 */
	public class AddChildLayoutsToParentCommand extends Command {

		public var model:LayoutStatesModel;

		public var parentLayout:Layout;

		//public var stageLayoutChangeCallback:Function;

		override public function execute ():void
		{
			//var layout:Layout = model.getActiveLayout().getMainLayout();

			//trace ("ADD layout " + layout + i + " to " + parentLayout);
			//parentLayout.addChild(layout);

			model.setStageLayout(parentLayout);

			//force resize the stage (probably);
			parentLayout.target.dispatchEvent(new Event(Event.RESIZE));
		}
	}
}
