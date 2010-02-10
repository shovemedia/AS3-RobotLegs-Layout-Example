package layout.service {
	import layout.model.SkinModel;
	import layout.service.events.SkinServiceEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author projects
	 */
	public class SkinXmlLoader extends Actor
	{

		public var url : String;

		public var model: SkinModel;

		private var loaded : Boolean;

		static private var basicSkinProperties:Array =
		[ "layout", "class", "useDefaultResize", "useDefaultReposition"];

		public function SkinXmlLoader()
		{
		}

		public function load():void
		{
			var urlLoader:URLLoader = new URLLoader()
			urlLoader.addEventListener(Event.COMPLETE, parseContent)
			urlLoader.load (new URLRequest(url))
		}

		public function parseContent(e:Event):void
		{
			var rootSkin:XML = new XML(e.target.data);

			trace ("parse skin 1")

			var viewList:XMLList = rootSkin.view;

			for each (var viewXml:XML in viewList)
			{
				//trace (viewXml)
				var layoutId:String = viewXml.@layout;
				var viewClassName:String = viewXml.@['class'];

				//trace ("new skin view: " + layoutId + " " + viewClassName)
				model.setViewClassnameByLayoutId(layoutId, viewClassName);

				// Use default resize listener?
				if (String(viewXml.@useDefaultResize).toLowerCase() == "true")
				{
					model.setUseDefaultResize(layoutId, true);
				}
				// Use default reposition listener?
				if (String(viewXml.@useDefaultReposition).toLowerCase() == "true")
				{
					model.setUseDefaultReposition(layoutId, true);
				}


				var attributes:XMLList = viewXml.attributes();
				var skinData:Object = model.getDataByLayout(layoutId);
				for each(var attribute:XML in attributes)
				{
				  var attributeName:String = String(attribute.name());

				  if (basicSkinProperties.indexOf( attributeName ) == -1)
				  {
					skinData[attributeName] = String(attribute);
				  }
				}


			}


			loaded = true;

			dispatch(new SkinServiceEvent(SkinServiceEvent.LOADED, model));
		}
	}
}
