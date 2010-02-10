package {
	import layout.command.AddChildLayoutsToParentCommand;
	import layout.command.AddNewViewRectangleForLayoutId;
	import layout.command.ConfigureLayoutStateCommand;
	import layout.command.LinkLayoutToSkinCommand;
	import layout.command.LoadClassLibraryCommand;
	import layout.command.LoadLayoutConfigCommand;
	import layout.command.LoadLayoutStatesCommand;
	import layout.command.LoadSkinConfigCommand;
	import layout.model.IViewRectangle;
	import layout.model.LayoutStatesModel;
	import layout.model.Lock;
	import layout.model.SkinModel;
	import layout.model.StateName;
	import layout.model.events.LayoutEvent;
	import layout.service.ClassLibraryLoader;
	import layout.service.LayoutXmlLoader;
	import layout.service.SkinXmlLoader;
	import layout.service.events.ClassLibraryEvent;
	import layout.service.events.LayoutServiceEvent;

	import view.mediator.IMenuView;
	import view.mediator.MenuViewMediator;

	import com.senocular.display.Layout;

	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.statemachine.StateMachine;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.Dictionary;

	/**
	 * @author projects
	 */
	public class SiteContext extends Context {

		private var viewsByViewRectangle:Dictionary;
		private var stageLayout : Layout;

		public function SiteContext(contextView:DisplayObjectContainer)
		{
			viewsByViewRectangle = new Dictionary();


			var di_config:XML =
			<types>

			  <!-- MODEL -->


			  <!-- VIEWS -->
			  <type name="SiteMediator">
				<field name="view" />
			  </type>

			  <type name="view.mediator::MenuViewMediator">
				<field name="view" />
			  </type>

			  <type name="view.component::RemoteImage">
				<field name="imageUrl" injectionname="url" />
			  </type>


			  <!-- COMMANDS -->
			  <type name="layout.command::LoadLayoutConfigCommand">
			    <field name="service" />
			  </type>

			  <type name="layout.command::AddNewViewRectangleForLayoutId">
			    <field name="event" />
			   	<field name="layoutStates" />
			  </type>

			  <type name="layout.command::AddChildLayoutsToParentCommand">
			    <field name="model" />
			    <field name="parentLayout" injectionname="parentLayout" />
			  </type>

			  <type name="layout.command::LoadSkinConfigCommand">
			    <field name="service" />
			  </type>

			  <type name="layout.command::LoadClassLibraryCommand">
			    <field name="service" />
			  </type>

			  <type name="layout.command::LoadLayoutStatesCommand">
			  	<field name="url" injectionname="layoutStatesXmlUrl" />
			  </type>

			  <type name="layout.command::ConfigureLayoutStateCommand">
				<field name="FSM_XML" injectionname="layoutStates" />
				<field name="stateMachine" />
			  </type>

			  <type name="layout.command::LinkLayoutToSkinCommand">
			  	<field name="view" />
				<field name="layoutStatesModel" />
				<field name="skinModel" />
			    <field name="viewsByViewRectangle" injectionname="viewsByViewRectangle" />
			    <field name="layoutResizeCallback" injectionname="layoutResizeCallback" />
			    <field name="layoutRepositionCallback" injectionname="layoutRepositionCallback" />
			  </type>

			  <!-- STATE CHANGE COMMANDS -->
			  <type name="layout.command::ENTERING_SECTION_Command">
			    <field name="event" />
				<field name="transitionLock" injectionname="sectionTransitionLock" />
			  </type>

			  <type name="layout.command::DO_SECTION_CHANGE_Command">
			    <field name="event" />
				<field name="layoutState" />
				<field name="stateMachine" />
				<field name="transitionLock" injectionname="sectionTransitionLock" />
			  </type>

			  <type name="layout.command::ScheduleSectionChange_Command">
			    <field name="event" />
				<field name="queuedState" injectionname="queuedStateAction" />
				<field name="transitionLock" injectionname="sectionTransitionLock" />
			  </type>

			  <type name="layout.command::DoScheduledSectionChange_Command">
				<field name="queuedState" injectionname="queuedStateAction" />
			  </type>




			  <!-- SERVICES -->
			  <type name="layout.service::LayoutXmlLoader">
			    <field name="model" />
				<field name="url" injectionname="layoutXmlUrl" />
			  </type>

			  <type name="layout.service::SkinXmlLoader">
				<field name="model" />
				<field name="url" injectionname="skinXmlUrl" />
			  </type>

			  <type name="layout.service::ClassLibraryLoader">
				<field name="url" injectionname="classLibraryUrl" />
			  </type>

			</types>;




			trace ("CREATE INJECTOR w/ CUSTOM CONFIG");
			injector = new SwiftSuspendersInjector(di_config);


			super(contextView);
		}

		override public function startup():void
		{

			// SERVICES
			trace ("INJECTOR SERVICES");
			injector.mapSingleton(LayoutXmlLoader);
			injector.mapSingleton(SkinXmlLoader);
			injector.mapSingleton(ClassLibraryLoader);


			// VALUES
			trace ("INJECTOR VALUES");
			trace ("map context view " + contextView )
			injector.mapValue(Site, contextView)

			injector.mapValue(String, "skins/sampleViews.swf", "classLibraryUrl");
			injector.mapValue(String, "layouts/layoutStates.xml", "layoutXmlUrl");
			injector.mapValue(String, "skinConfigurations/sampleSkin.xml", "skinXmlUrl");
			injector.mapValue(String, "layouts/fsm.xml", "layoutStatesXmlUrl");

			injector.mapSingleton(LayoutStatesModel);
			injector.mapSingleton(SkinModel);
			injector.mapSingleton(StateMachine);

			injector.mapSingletonOf(Lock, Lock, "sectionTransitionLock");
			injector.mapSingletonOf(StateName, StateName, "queuedStateAction");

//			injector.mapValue(Boolean, transitionLock, "sectionTransitionLock");
//			injector.mapValue(String, queuedState, "queuedStateAction");
//

			injector.mapValue(Dictionary, viewsByViewRectangle, "viewsByViewRectangle");

			injector.mapValue(Function, defaultLayoutResizeHandler, "layoutResizeCallback");
			injector.mapValue(Function, defaultLayoutRepositionHandler, "layoutRepositionCallback");

			// COMMANDS
			trace ("COMMANDS");
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadLayoutConfigCommand);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadSkinConfigCommand);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadClassLibraryCommand);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadLayoutStatesCommand);

			commandMap.mapEvent(LayoutEvent.CREATE, AddNewViewRectangleForLayoutId);

			commandMap.mapEvent(LayoutServiceEvent.LOADED, AddChildLayoutsToParentCommand, LayoutServiceEvent);

			commandMap.mapEvent(ClassLibraryEvent.LOADED, LinkLayoutToSkinCommand, ClassLibraryEvent);

			commandMap.mapEvent(LoadLayoutStatesCommand.LAYOUT_STATES_LOADED, ConfigureLayoutStateCommand);



			// MEDIATORS
			trace ("VIEW MEDIATORS");
			MenuViewMediator;
			IMenuView;
			//injector.mapClass(IMenuView, instantiateClass)
			//mediatorMap.mapView(Site, SiteMediator);


			var stage:Stage = contextView.stage;

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			stageLayout = new Layout(stage, true);

			stageLayout.x = 0;
			stageLayout.y = 0;
			stageLayout.width = stage.stageWidth;
			stageLayout.height = stage.stageHeight;

			//trace (stage.stageWidth + " x " + stage.stageHeight)


			injector.mapValue(Layout, stageLayout, "parentLayout");

			trace ("INJECTOR CUSTOM CONFIG COMPLETE");

			super.startup();
		}

		private function defaultLayoutResizeHandler(event:LayoutEvent) : void
		{
			//trace (new Error().getStackTrace());
			var viewRect:IViewRectangle = IViewRectangle(event.target);

			var viewList:Array = viewsByViewRectangle[viewRect];

			for each (var view:DisplayObject in viewList)
			{
			  //trace (" * " + view)
			  view.width = viewRect.width;
			  view.height = viewRect.height;
			}
		}

		private function defaultLayoutRepositionHandler(event:LayoutEvent) : void
		{
			//trace (new Error().getStackTrace());
			var viewRect:IViewRectangle = IViewRectangle(event.target);

			var viewList:Array = viewsByViewRectangle[viewRect];

			for each (var view:DisplayObject in viewList)
			{
			  view.x = viewRect.x;
			  view.y = viewRect.y;
			}


		}

	}

}
