package layout.command {

	import org.robotlegs.mvcs.Command;
	import org.robotlegs.utilities.statemachine.FSMInjector;
	import org.robotlegs.utilities.statemachine.StateEvent;
	import org.robotlegs.utilities.statemachine.StateMachine;

	/**
	 * @author projects
	 */
	public class ConfigureLayoutStateCommand extends Command {

		public var FSM_XML : XML;

		public var stateMachine:StateMachine;


		override public function execute():void
		{
			var fsmInjector:FSMInjector = new FSMInjector( FSM_XML );

			//map the commands for the state machine.
			commandMap.mapEvent( SectionChangeEvent.SCHEDULE, ScheduleSectionChange_Command, SectionChangeEvent);
			commandMap.mapEvent( "ENTERING_SECTION", ENTERING_SECTION_Command, StateEvent);
			commandMap.mapEvent( StateEvent.CHANGED, DO_SECTION_CHANGE_Command, StateEvent);
			commandMap.mapEvent( "ENTERED_SECTION", DoScheduledSectionChange_Command, StateEvent);

			//injecting the state machine into the FSMInjector
			fsmInjector.inject(stateMachine);

			//start the state machine
			//eventDispatcher.dispatchEvent( new StateEvent(StateEvent.ACTION, "GOTO_SECTION_1"));
		}

	}
}

