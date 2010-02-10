package view.mediator {
	import layout.command.SectionChangeEvent;

	import org.robotlegs.utilities.statemachine.StateEvent;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author projects
	 */
	public class MenuViewMediator extends Mediator {

		public var view:IMenuView;

		override public function onRegister():void
		{
			trace ("MenuViewMediator onRegister: " + view);

			//var view:IMenuView = IMenuView(contextView);

			view.section_1_btn.addEventListener(MouseEvent.CLICK, gotoSection1);
			view.section_2_btn.addEventListener(MouseEvent.CLICK, gotoSection2);
			view.section_3_btn.addEventListener(MouseEvent.CLICK, gotoSection3);

			view.section_1_btn.buttonMode = true;
			view.section_2_btn.buttonMode = true;
			view.section_3_btn.buttonMode = true;

		}

		private function gotoSection1(event:MouseEvent):void
		{
			trace ("goto 1");
			eventDispatcher.dispatchEvent( new SectionChangeEvent(SectionChangeEvent.SCHEDULE, "GOTO_SECTION_1"));
		}
		private function gotoSection2(event:MouseEvent):void
		{
			trace ("goto 2");
			eventDispatcher.dispatchEvent( new SectionChangeEvent(SectionChangeEvent.SCHEDULE, "GOTO_SECTION_2"));
		}
		private function gotoSection3(event:MouseEvent):void
		{
			trace ("goto 2");
			eventDispatcher.dispatchEvent( new SectionChangeEvent(SectionChangeEvent.SCHEDULE, "GOTO_SECTION_3"));
		}
	}
}
