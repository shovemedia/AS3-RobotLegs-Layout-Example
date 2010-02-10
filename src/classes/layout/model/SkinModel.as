package layout.model {
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author projects
	 */
	public class SkinModel extends Actor {
		private var viewClassnameByLayoutId : Array;
		private var useDefaultResizeByLayoutId : Array;
		private var useDefaultRepositionByLayoutId : Array;
		private var dataByLayout : Array;

		public function SkinModel()
		{
			viewClassnameByLayoutId = new Array();
			useDefaultResizeByLayoutId = new Array();
			useDefaultRepositionByLayoutId = new Array();
			dataByLayout = new Array();
		}

		public function setViewClassnameByLayoutId(layoutId:String, viewClassname:String):void {
			trace('SkinModel.setViewClassnameByLayoutId: ' + layoutId + " " + viewClassname);
			viewClassnameByLayoutId[layoutId] = viewClassname;
		}

		public function getViewClassnameByLayoutIds():Array
		{
			return viewClassnameByLayoutId;
		}

		public function setUseDefaultResize(layoutId:String, bool:Boolean):void
		{
			useDefaultResizeByLayoutId [layoutId] = bool;
		}
		public function getUseDefaultResize(layoutId:String):Boolean
		{
			return useDefaultResizeByLayoutId [layoutId];
		}


		public function setUseDefaultReposition(layoutId:String, bool:Boolean):void
		{
			useDefaultRepositionByLayoutId [layoutId] = bool;
		}
		public function getUseDefaultReposition(layoutId:String):Boolean
		{
			return useDefaultRepositionByLayoutId [layoutId];
		}

		public function getDataByLayout(layoutId:String):Object
		{
			if (!dataByLayout[layoutId])
			{
			  dataByLayout[layoutId] = new Object();
			}
			return dataByLayout[layoutId];
		}

	}
}
