package layout.model {
	import org.robotlegs.mvcs.Actor;
	import layout.model.events.LayoutEvent;

	import com.senocular.display.Layout;

	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * @author projects
	 */
	public class LayoutModel
	{
		private var layouts					:	Array;
		private var layoutsById				:	Array;
		private var alignPairsByNullLayout	:	Dictionary;
		private var mainLayout 				:	Layout;
		private var dataByLayout			:	Dictionary;

		private var viewRectangles : Array;

		public function LayoutModel() {
			trace ("NEW LayoutXmlLoader")
			layoutsById = new Array();
			dataByLayout = new Dictionary();

			alignPairsByNullLayout = new Dictionary();

			layouts = new Array();
			viewRectangles = new Array();
		}

		// STAGE

		public function setMainLayout (layout:Layout):void
		{
			mainLayout = layout;
		}
		public function getMainLayout ():Layout
		{
			return mainLayout;
		}




		public function getLayouts():Array
		{
			return layouts;
		}

		public function addLayout(layout:Layout):void {
			trace('LayoutModel.addLayout: ' + layout );
			layouts.push(layout);
		}

//		public function addViewRectangle(viewRectangle:ViewRectangle):void
//		{
//			viewRectangles.push(viewRectangle);
//		}
//
//		public function getViewRectangles():Array
//		{
//			return viewRectangles;
//		}



		public function getLayoutById(id:String):Layout
		{
			var layout:Layout = Layout(layoutsById[id]);
			return layout;
		}

		public function setLayoutById(id:String, layout:Layout):void
		{
			layoutsById[id] = layout;
		}

		public function getDataByLayout(layout:Layout):Object
		{
			if (!dataByLayout[layout])
			{
			  dataByLayout[layout] = new Object();
			}
			return dataByLayout[layout];
		}



		//ALIGN

		public function setAlignPairsByNullLayout(alignPairData:Object, layout:Layout):void
		{
			alignPairsByNullLayout[layout] = alignPairData;
		}

		public function updateHorizontalAlign (event:LayoutEvent):void
		{
			//trace ("update H ALIGN! " + event.target);

			var layoutData:Object = alignPairsByNullLayout[event.target];

			var localPoint:Point = layoutData.localNull.getGlobalPoint()
			var remotePoint:Point = layoutData.remoteNull.getGlobalPoint()

			//trace ([layoutData.remoteNull.rect,  layoutData.localNull.rect]);

			//compute delta from local null to remote null
			var nullDelta:Number = remotePoint.x - localPoint.x;

			//trace ("null x delta " + nullDelta)


				//var localDelta:Number = nullDelta - layoutData.local.x;

				if (nullDelta)
				{
				  trace ("dx " + nullDelta);
				  layoutData.local.x += nullDelta;

				  layoutData.local.draw();//dispatchEvent( new Event(Event.CHANGE) );
				}


		}

		public function updateVerticalAlign (event:LayoutEvent):void
		{
			//trace ("update V ALIGN! " + event.target);

			var layoutData:Object = alignPairsByNullLayout[event.target];

			var localPoint:Point = layoutData.localNull.getGlobalPoint()
			var remotePoint:Point = layoutData.remoteNull.getGlobalPoint()

			//trace ([layoutData.remoteNull.rect,  layoutData.localNull.rect]);

			//compute delta from local null to remote null
			var nullDelta:Number = remotePoint.y - localPoint.y;

			//trace ("null y delta " + nullDelta)


				if (nullDelta)
				{
				  trace ("dy " + nullDelta);
				  layoutData.local.y += nullDelta;

				  //dispatch(new LayoutEvent(LayoutEvent.ALIGNS_CHANGED, layoutData.local));


				  layoutData.local.draw();//dispatchEvent( new Event(Event.CHANGE));
				  //trace (" mark invalid")
				}
		}

	}
}
