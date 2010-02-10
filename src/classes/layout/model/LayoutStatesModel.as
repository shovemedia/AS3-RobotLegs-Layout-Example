package layout.model {
	import com.senocular.display.Layout;

	/**
	 * @author projects
	 */
	public class LayoutStatesModel {
		private var layoutModelsByState:Array;

		private var viewRectangles : Array;

		public function LayoutStatesModel() {
			layoutModelsByState = new Array();
			viewRectangles = new Array();
		}

		public function addState(state:String, layoutModel:LayoutModel):void
		{
			layoutModelsByState[state] = layoutModel;
		}

		public function getLayout(state:String):LayoutModel
		{
			return layoutModelsByState[state];
		}

		public function setStageLayout(stageLayout:Layout):void
		{
			trace ('setStageLayout');
			for each (var layoutModel:LayoutModel in layoutModelsByState)
			{
				trace (layoutModel);
			  stageLayout.addChild(layoutModel.getMainLayout());
			}
		}

		public function addViewRectangle(viewRectangle:IViewRectangle):void
		{
			viewRectangles.push(viewRectangle);
		}

		public function getViewRectangles():Array
		{
			return viewRectangles;
		}
	}
}
