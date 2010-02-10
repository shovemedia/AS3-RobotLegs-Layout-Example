package layout.service {
	import layout.service.events.ClassLibraryEvent;

	import org.robotlegs.mvcs.Actor;

	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * @author projects
	 */
	public class ClassLibraryLoader extends Actor
	{

		public var url : String;

		private var loaded : Boolean;

		private var classLoader : Loader;

		public function ClassLibraryLoader()
		{

		}

		public function load():void
		{
            classLoader = new Loader ();

            //var context:LoaderContext = new LoaderContext();
            var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);

            configureClassLoadListeners(classLoader.contentLoaderInfo);

            var request:URLRequest = new URLRequest(url);
            classLoader.load(request, context);

            trace ("ClassLibraryLoader load " + url);
        }

        private function configureClassLoadListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, dispatchLoadedEvent);
            //dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            //dispatcher.addEventListener(Event.INIT, initHandler);
            //dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            //dispatcher.addEventListener(Event.OPEN, openHandler);
            //dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            //dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
		}

		private function dispatchLoadedEvent(event : Event) : void {
			loaded = true;
			trace ("ClassLibraryLoader loaded " + url);
			dispatch (new ClassLibraryEvent(ClassLibraryEvent.LOADED));
		}
	}
}
