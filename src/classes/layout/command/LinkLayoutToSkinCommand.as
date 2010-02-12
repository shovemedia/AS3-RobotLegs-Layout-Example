package layout.command {
	import flash.utils.describeType;
	import layout.model.BlendedViewRectangle;
	import layout.model.ViewRectangle;
	import layout.model.LayoutStatesModel;
	import layout.model.events.LayoutEvent;
	import layout.model.LayoutModel;
	import layout.model.SkinModel;

	import com.senocular.display.Layout;

	import org.robotlegs.mvcs.Command;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * @author projects
	 */
	public class LinkLayoutToSkinCommand extends Command {

		public var view:Site;

		public var layoutStatesModel:LayoutStatesModel;

		public var skinModel:SkinModel;

		public var viewsByViewRectangle:Dictionary;

		public var layoutResizeCallback:Function;
		public var layoutRepositionCallback:Function;


		override public function execute():void
		{
			trace ("LinkLayoutToSkinCommand");
			var viewRects:Array = layoutStatesModel.getViewRectangles();

			//todo: CHANGE TO IViewRectangle;
			var viewRect:BlendedViewRectangle;

			var viewClassnameByLayoutId:Array = skinModel.getViewClassnameByLayoutIds();


			//GO in reverse so depth will match xml order
			var len:int = viewRects.length;
			//trace (len);
			for (var i:int=(len-1); i>=0; i--)
			{
				//trace (i + " of " + len);
				viewRect = viewRects[i];
				var layoutId:String = viewRect.id;//layoutModel.getDataByLayout(viewRect.getLayout1()).id;
				trace ("layoutId: " + layoutId);
				var className:String = viewClassnameByLayoutId[layoutId];
				if (className)
				{
					trace (" CREATE VIEW CLASS: " + className);
					var viewClass:Class = Class(getDefinitionByName(className));

					var skinView:DisplayObject = new viewClass();

					//Use default resize handler?
					if (skinModel.getUseDefaultResize(layoutId))
					{
						viewRect.addEventListener(LayoutEvent.SIZE_CHANGED, layoutResizeCallback);
					}
					//Use default reposition handler?
					if (skinModel.getUseDefaultReposition(layoutId))
					{
						viewRect.addEventListener(LayoutEvent.POSITION_CHANGED, layoutRepositionCallback);
					}

					var skinData:Object = skinModel.getDataByLayout(layoutId);
					if (skinData)
					{
						if (skinData.resizeHandler)
						{
					  	  viewRect.addEventListener(LayoutEvent.SIZE_CHANGED, skinView[skinData.resizeHandler]);
						}
						if (skinData.repositionHandler)
						{
					  	  viewRect.addEventListener(LayoutEvent.POSITION_CHANGED, skinView[skinData.repositionHandler]);
						}
						if (skinData.viewMediatorClassName)
						{
						  var viewMediatorClass:Class = Class(getDefinitionByName(skinData.viewMediatorClassName));
							trace ("View Mediator Class " + viewMediatorClass);

							//todo: Magic String?!
							//      pull 1st interface???
							var classInfo:XML = describeType(viewClass);
							//trace (classInfo);

							var viewInterfaceClassName:String = classInfo.factory.implementsInterface[0].@type;
							trace ("View Interface Class " + viewInterfaceClassName);


							var viewInterfaceClass:Class = Class(getDefinitionByName(viewInterfaceClassName));
							//injector.mapClass(viewInterfaceClass, viewClass);
							injector.mapValue(viewInterfaceClass, skinView);

							mediatorMap.mapView(viewClass, viewMediatorClass);
						}
					}


					if (!viewsByViewRectangle[viewRect])
					{
					  	viewsByViewRectangle[viewRect] = new Array();
					}

					var viewList:Array = viewsByViewRectangle[viewRect];
					viewList.push(skinView);

					view.addChild(skinView);
				}
			}

			for each (viewRect in viewRects)
			{
				viewRect.dispatchEvent(new LayoutEvent(LayoutEvent.SIZE_CHANGED));
				viewRect.dispatchEvent(new LayoutEvent(LayoutEvent.POSITION_CHANGED));
			}




			//

		}



	}
}
