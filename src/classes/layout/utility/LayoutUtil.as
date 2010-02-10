package layout.utility {

	import com.senocular.display.Layout;

	/**
	 * @author projects
	 */
	public class LayoutUtil {

		public static var defaultPropertySet:Array /* of String property names */ =
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

		public static function diff (layout1:Layout, layout2:Layout, propertySet:Array=null):Object
		{
			if (propertySet == null)
			{
				propertySet = defaultPropertySet
			}

			var delta:Object = new Object()

			for (var i:String in propertySet)
			{
				var prop:String = propertySet[i]
				//trace (i + " " + prop +  "  " +  f1[prop] + " " + f2[prop])

				if (layout1[prop] != layout2[prop])
				{
					delta[prop] = layout2[prop] - layout1[prop];
				}
			}

			return delta;
		}

	}
}
