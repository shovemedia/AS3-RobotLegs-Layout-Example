package view.component {
	import view.events.RemoteImageEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.display.Sprite;

	/**
	 * @author projects
	 */

	public class RemoteImage extends Sprite {

	  public var imageUrl:String;

	  private var loader : Loader;

		private function loadContent():void
		{
			loader = new Loader();

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 				completeHandler);
            loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, 	httpStatusHandler);
            loader.contentLoaderInfo.addEventListener(Event.INIT, 					initHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 			ioErrorHandler);
            loader.contentLoaderInfo.addEventListener(Event.OPEN, 					openHandler);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 		progressHandler);
            loader.contentLoaderInfo.addEventListener(Event.UNLOAD, 					unLoadHandler);

			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.checkPolicyFile = true;
            loader.load(new URLRequest(imageUrl), loaderContext);
		}

		protected function completeHandler(event:Event):void {
			dispatchEvent( new RemoteImageEvent(RemoteImageEvent.LOADED, this))
			addChild(loader);
		}


		protected function httpStatusHandler(event:HTTPStatusEvent):void {
            dispatchEvent(event);
        }

        protected function initHandler(event:Event):void {
            dispatchEvent(event);
        }

        protected function ioErrorHandler(event:IOErrorEvent):void {
			dispatchEvent(event);
        }

        protected function openHandler(event:Event):void {
            dispatchEvent(event);
        }

        protected function progressHandler(event:ProgressEvent):void {
			//var __progress:Number = Math.floor((event.bytesLoaded / event.bytesTotal) * 100);
			dispatchEvent(event);
        }

        protected function unLoadHandler(event:Event):void {
            dispatchEvent(event);
        }

	}
}
