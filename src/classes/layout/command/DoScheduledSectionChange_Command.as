package layout.command {
	import layout.model.StateName;
	import org.robotlegs.utilities.statemachine.StateEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class DoScheduledSectionChange_Command extends Command {

		public var queuedState : StateName;//Object;

		override public function execute ():void
		{
			trace ("DoScheduledSectionChange_Command " + queuedState.get());
			if (queuedState.get()) {
				//this backflip sets queued state to null BEFORE the event goes out.
				var state:String = queuedState.get();
				queuedState.set(null);
				eventDispatcher.dispatchEvent( new StateEvent(StateEvent.ACTION, state));
			}
		}
	}
}
