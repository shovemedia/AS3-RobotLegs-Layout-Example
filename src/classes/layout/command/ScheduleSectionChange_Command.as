package layout.command {
	import layout.model.Lock;
	import layout.model.StateName;
	import org.robotlegs.utilities.statemachine.StateEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author projects
	 */
	public class ScheduleSectionChange_Command extends Command {
		public var event:SectionChangeEvent;

		public var queuedState:StateName;//Object;

		public var transitionLock:Lock;//Object;

		override public function execute ():void
		{
			trace ("ScheduleSectionChange_Command " + event + " " + event.action );
			if (queuedState.get() != event.action)
			{
				queuedState.set(event.action);

				if (!transitionLock.isLocked())
				{
					trace ("NO LOCK: PROCEED!")
					eventDispatcher.dispatchEvent (new StateEvent("ENTERED_SECTION"));
				}
				else
				{
					trace ("LOCKED: WAIT!")
				}
			}
		}
	}
}