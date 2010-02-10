package layout.command {
	import layout.model.LayoutModel;
	import layout.model.LayoutStatesModel;
	import layout.model.BlendedViewRectangle;
	import layout.model.events.LayoutEvent;

	import com.senocular.display.Layout;

	import layout.model.ViewRectangle;

	import flash.events.IEventDispatcher;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class AddNewViewRectangleForLayoutId extends Command {

		public var event:LayoutEvent;

		public var layoutStates:LayoutStatesModel;
		//public var layout:Layout;

		override public function execute():void
		{
			trace("AddNewLayout")

		  	//injector.mapValue(IEventDispatcher, eventDispatcher);

		  	//var viewRectangle:ViewRectangle = new ViewRectangle();
			var viewRectangle:BlendedViewRectangle = new BlendedViewRectangle();

			viewRectangle.id = event.id;

			injector.injectInto(viewRectangle);
			//injector.unmap(IEventDispatcher);

			//viewRectangle.setLayout(event.layout);
			viewRectangle.setLayouts(event.layout, event.layout);

			layoutStates.addViewRectangle(viewRectangle);
		}
	}
}
