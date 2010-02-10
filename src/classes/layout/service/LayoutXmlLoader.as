package layout.service {
	import layout.model.LayoutModel;
	import layout.model.LayoutStatesModel;
	import layout.model.events.LayoutEvent;
	import layout.service.events.LayoutServiceEvent;

	import com.senocular.display.Layout;

	import org.robotlegs.mvcs.Actor;

	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author projects
	 */
	public class LayoutXmlLoader extends Actor
	{

		public var url : String;

		public var model:LayoutStatesModel;

		private var loaded : Boolean;
		private var layoutStates : Array;



		static private var layoutConstraintProperties:Array =
		[	"horizontalCenter", "percentHorizontalCenter", "minHorizontalCenter", "maxHorizontalCenter",
		    "verticalCenter", "percentVerticalCenter", "minVerticalCenter", "maxVerticalCenter",

		    "top", "percentTop", "offsetTop", "minTop", "maxTop",
		    "right", "percentRight", "offsetRight", "minRight", "maxRight",
		    "bottom", "percentBottom", "offsetBottom", "minBottom", "maxBottom",
			"left", "percentLeft", "offsetLeft", "minLeft", "maxLeft",

			"x", "percentX", "minX", "maxX",
			"y", "percentY", "minY", "maxY",
			"width", "percentWidth", "minWidth", "maxWidth",
			"height", "percentHeight", "minHeight", "maxHeight",

			"maintainAspectRatio"];

//		static private var alignConstraintProperties:Array =
//		[
//			"top", "percentTop", "offsetTop", "minTop", "maxTop",
//		    "right", "percentRight", "offsetRight", "minRight", "maxRight",
//		    "bottom", "percentBottom", "offsetBottom", "minBottom", "maxBottom",
//			"left", "percentLeft", "offsetLeft", "minLeft", "maxLeft"
//		];

		static private var horizontalAlignConstraintProperties:Array =
		[
		    "right", "percentRight",
			"left", "percentLeft"
		];

		static private var verticalAlignConstraintProperties:Array =
		[
		    "top", "percentTop",
			"bottom", "percentBottom"];







		public function LayoutXmlLoader()
		{
			layoutStates = new Array();
		}

		public function load():void
		{
			var urlLoader:URLLoader = new URLLoader()
			urlLoader.addEventListener(Event.COMPLETE, parseContent)
			urlLoader.load (new URLRequest(url))
		}

		public function parseContent(e:Event):void
		{
			var layoutList:XML = new XML(e.target.data);

			for each (var layoutXml:XML in layoutList)
			{
				var initialState:String;

				switch (String(layoutXml.name()))
				{
					case "layout":
					{
						initialState = "default";
						var layoutModel:LayoutModel = new LayoutModel();

						layoutModel.setMainLayout( parseLayout(layoutXml, layoutModel) );

						model.addState(initialState, layoutModel);

						var alignLayouts:XMLList = layoutXml.align;

						for each (var alignXml:XML in layoutList)
						{
						  //trace ("  [sub]" + childLayout);
						  //var alignLayout:Layout =
							parseAlign(alignXml, layoutModel);
						}

						model.addState(initialState, layoutModel);
						break;
					}
					case "layoutStates":
					{
						initialState = parseLayoutStates(layoutXml);
						break;
					}
				}

				// Publish CREATE EVENT for any layout containing an id
				// ONLY for the initial state.
				// For now, assume these layouts are present in all states.

				var layoutState:LayoutModel = model.getLayout(initialState);
				var layouts:Array = layoutState.getLayouts();
				var len:int = layouts.length;
				for (var i:int=0; i<len; i++)
				{
					var layout:Layout = layouts[i];
					var id:String = layoutState.getDataByLayout(layout).id;

					if (id)
					{
					  dispatch (new LayoutEvent(LayoutEvent.CREATE, layout, id));
					}
				}
			}



			loaded = true;

			trace ("LAYOUT SERVICE LOADED");

			dispatch (new LayoutServiceEvent(LayoutServiceEvent.LOADED, model));
		}



		private function parseLayoutStates(layoutStatesXml:XML):String
		{
			var initialState:String;

			for each (var stateXml:XML in layoutStatesXml.state)
			{
//				trace (layoutXml);
				trace ("-- -- --");
				trace (stateXml.layout);


				var state:String = stateXml.@name;

				trace ("NEW STATE: " + state);
				var layoutModel:LayoutModel = new LayoutModel();

				layoutModel.setMainLayout( parseLayout(stateXml.layout[0], layoutModel) );

				model.addState(state, layoutModel);

				if (!initialState)
				{
					initialState = state;
				}
				//layoutStates.push(layoutState);
			}

			return initialState;
		}


		private function parseLayout(layoutXml:XML, layoutModel:LayoutModel):Layout
		{
			trace ("NEW LAYOUT")
			var layout:Layout = new Layout( null, false);
			var layoutData:Object = layoutModel.getDataByLayout(layout);

			var attributes:XMLList = layoutXml.attributes();

			var len:int = attributes.length();
			for each(var attribute:XML in attributes)
			{
			  var attributeName:String = String(attribute.name());

			  if (layoutConstraintProperties.indexOf( attributeName ) != -1)
			  {
			   	trace ("layoutConstraintProperties " + attributeName + " :: " + attribute + ":" + typeof(Number(attribute)+1))
				layout[attributeName] = Number(attribute);
			  }
			  else
			  {


			  	//trace ("custom " + attributeName + " :: " + attribute)
			  	switch (attributeName)
			  	{

					case "alpha":
					case "color":
					  layoutData[attributeName] = Number(attribute);
					  break;

			  		case "id":
			  		  trace ("-- NEW ID " + attribute);
	  				  layoutModel.setLayoutById(String(attribute), layout);

			  		default:
			  		  layoutData[attributeName] = attribute;
			  		break;
			  	}

			  }
			}

			var childLayouts:XMLList = layoutXml.layout;

			for each (var childLayoutXml:XML in childLayouts)
			{
			  //trace ("  [sub]" + childLayout);
			  var childLayout:Layout = parseLayout(childLayoutXml, layoutModel);
			  layout.addChild(childLayout)
			}

			layoutModel.addLayout (layout);



			return layout
		}




		private function parseAlign(layoutXml:XML, layoutModel:LayoutModel):void
		{

			var alignNodes:XMLList = layoutXml.align;

			for each (var alignXml:XML in alignNodes)
			{
				trace ("align for id: " + layoutXml.@id + " ::  "  + alignXml )
				var localNode:XML = alignXml.local[0];
				var remoteNode:XML = alignXml.remote[0];

				var localNullLayout:Layout = parseLayout(localNode, layoutModel);
				var remoteNullLayout:Layout = parseLayout(remoteNode, layoutModel);

				localNullLayout.width = localNullLayout.height =
				remoteNullLayout.width = remoteNullLayout.height =
				  0;// 10; //2

				var localLayout:Layout = layoutModel.getLayoutById(String(layoutXml.@id));
				var remoteLayout:Layout = layoutModel.getLayoutById(String(remoteNode.@remoteId));

				var layoutData:Object = {local:localLayout, remote:remoteLayout, localNull:localNullLayout, remoteNull:remoteNullLayout}

				layoutModel.setAlignPairsByNullLayout(layoutData, localNullLayout);
				layoutModel.setAlignPairsByNullLayout(layoutData, remoteNullLayout);

				localLayout.addChild(localNullLayout);
				remoteLayout.addChild(remoteNullLayout);

				var isHorizontal:Boolean, isVertical:Boolean;
				isHorizontal = isVertical = false;

				var localAttributes:XMLList = localNode.attributes();//@*;
				var remoteAttributes:XMLList = remoteNode.attributes();//@*;

				//local only for now
				for each(var attributeItem:XML in localAttributes)
				{
					var attributeName:String = String(attributeItem.name());

					if (horizontalAlignConstraintProperties.indexOf( attributeName ) != -1) {
						isHorizontal = true;
						//trace ("IS HORIZONTAL! " + attributeName);
					}
				    else if (verticalAlignConstraintProperties.indexOf( attributeName ) != -1) {
						isVertical = true;
						//trace ("IS VERTICAL! " + attributeName);
					}
				}

				if (layoutXml.@debug == 1)
				{
					var id:String;

					var remoteDataByLayout:Object = layoutModel.getDataByLayout(remoteLayout);
					var localDataByLayout:Object = layoutModel.getDataByLayout(localLayout);
					var remoteNullDataByLayout:Object = layoutModel.getDataByLayout(remoteNullLayout);
					var localNullDataByLayout:Object = layoutModel.getDataByLayout(localNullLayout);

					id = "ALIGN_REMOTE_" + remoteDataByLayout.id;
					remoteNullDataByLayout.id = id;
					layoutModel.setLayoutById(id, remoteNullLayout);

					id = "ALIGN_LOCAL_" + localDataByLayout.id;
					localNullDataByLayout.id = id;
					layoutModel.setLayoutById(id, localNullLayout);
				}



				if (isHorizontal)
				{
					//LayoutConstraint.EVENT_REPOSITION
					remoteNullLayout.addEventListener(LayoutEvent.POSITION_CHANGED, layoutModel.updateHorizontalAlign);//, false, 100, true);
				}
				if (isVertical)
				{
					//LayoutConstraint.EVENT_REPOSITION
					remoteNullLayout.addEventListener(LayoutEvent.POSITION_CHANGED, layoutModel.updateVerticalAlign);//, false, 100, true);
				}

				if (isHorizontal && isVertical)
				{
				  trace ("ALIGN CONFIG ERROR: Horizontal OR Vertical -- NOT BOTH")
				}


			}

			var childLayouts:XMLList = layoutXml.layout;

			for each (var childLayoutXml:XML in childLayouts)
			{
			  parseAlign(childLayoutXml, layoutModel);
			}
		}




	}
}
