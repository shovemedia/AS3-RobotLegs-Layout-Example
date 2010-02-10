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
	public class ENTERING_SECTION_Command extends Command {

		public var event:StateEvent;

		public var transitionLock:Lock;//Object;

		override public function execute():void{

			trace ("ENTERING_SECTION_Command ");

			if (!event)
			{
				trace ("ERROR: NO STATE CHANGE EVENT!")
				return;
			}

			trace (event.target);
			trace (event.action);
			trace (event.data);

			if (transitionLock.isLocked())
			{
				//cancel the current state change!
				trace ("LOCKED: CANCEL CURRENT TRANSITION!");
				dispatch(new StateEvent(StateEvent.CANCEL));
			}

		}


	}
}
