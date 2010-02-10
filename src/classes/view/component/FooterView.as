package view.component {
	import layout.model.IViewRectangle;
	import layout.model.events.LayoutEvent;

	import flash.utils.Dictionary;
	import flash.geom.Point;

	import com.senocular.display.Layout;

	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author projects
	 */
	public class FooterView extends Sprite {

		public var gfx:Sprite;

		public function onLayoutReposition (event:Event)
		{
			trace ("FOOTER MOVED!! "  + event.target);

			if (gfx.stage)
			{
			  removeChild(gfx);
			}

			var viewRect:IViewRectangle = IViewRectangle(event.target);

			  this.x = viewRect.x;
			  this.y = viewRect.y;


		}

		public function onLayoutResize (event:Event)
		{
			trace ("FOOTER RESIZED!! "  + event.target);

			if (gfx.stage)
			{
			  removeChild(gfx);
			}

			var viewRect:IViewRectangle = IViewRectangle(event.target);

			this.scaleX = this.scaleY = 1;

			this.graphics.clear();
			this.graphics.lineStyle(1, 0x000000);
			this.graphics.beginFill(0xFFCC00);
			this.graphics.drawRoundRect(0, 0, viewRect.width, viewRect.height, 20);
			this.graphics.endFill();

		}



	}
}
