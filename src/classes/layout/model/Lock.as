package layout.model {

	/**
	 * @author projects
	 */
	public class Lock {
		private var value:Boolean;

		public function isLocked() : Boolean {
			return value;
		}

		public function setLock(value : Boolean) : void {
			this.value = value;
		}
	}
}
