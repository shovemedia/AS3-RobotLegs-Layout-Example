package layout.command {
	import layout.model.Lock;

	import org.robotlegs.utilities.statemachine.StateMachine;
	import flash.events.Event;

	import caurina.transitions.Tweener;

	import com.senocular.display.Layout;

	import layout.model.BlendedViewRectangle;
	import layout.model.ViewRectangle;
	import layout.model.LayoutModel;
	import layout.model.LayoutStatesModel;
	import org.robotlegs.utilities.statemachine.StateEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class DO_SECTION_CHANGE_Command extends Command {

		public var event:StateEvent;

		public var layoutState:LayoutStatesModel;

		public var stateMachine:StateMachine;

		public var transitionLock:Lock;//Object;

		public var blend:Number;


		private var viewRectangles : Array;

		override public function execute():void{

			trace ("DO_SECTION_CHANGE_Command ");

			if (!event)
			{
				trace ("ERROR: NO STATE CHANGE EVENT!")
				return;
			}

			trace ("event.target " + event.target);
			trace ("event.action " + event.action);
			trace ("event.data " + event.data);

			var oldState:String = stateMachine.currentStateName;
			var layoutModel:LayoutModel = layoutState.getLayout(event.action);

			if (!layoutModel)
			{
				trace ("ERROR: NO LAYOUT STATE FOR: " + event.action);
				return;
			}

			var first:Boolean = false

			viewRectangles = layoutState.getViewRectangles();
			var len:int = viewRectangles.length;
			for (var i:int=0; i<len; i++)
			{
			  var viewRectangle:BlendedViewRectangle = viewRectangles[i];

			  //swap old / new
			  var tempLayout:Layout = viewRectangle.getLayout2();
			    var layoutId:String = viewRectangle.id;

				trace ("tempLayout " + tempLayout)
			    trace ("layoutId " + layoutId);

				var newLayout:Layout = layoutModel.getLayoutById(layoutId);

			    if (tempLayout == newLayout)
				{
					//first time!
					first = true;
				}

			    viewRectangle.setLayouts(tempLayout, newLayout);

			  //can remove?
			  viewRectangle.setBlendPercentage(0);
			}

			if (!first)
			{
			  //reset blend -- can remove?
			  blend = 0;
			  transitionLock.setLock(true);
			  Tweener.addTween(this, { blend:1, time:5, delay:0, transition:"easeinoutquad", onUpdate:this.onUpdate, onComplete:this.onComplete });
			}
			else
			{
			  blend = 1;
			  onUpdate();
			  onComplete();
			}
		}

		private function onUpdate():void
		{
			var len:int = viewRectangles.length;
			//trace ("onupdate "  + blend);

			for (var i:int=0; i<len; i++)
			{
			  var viewRectangle:BlendedViewRectangle = viewRectangles[i];
			  viewRectangle.setBlendPercentage(blend);
			}
		}

		private function onComplete():void
		{
		  transitionLock.setLock(false);
		  dispatch (new StateEvent("ENTERED_SECTION"));
		}
	}
}
