package org.asc.services
{
	import mx.rpc.IResponder;

	public class GenericResponder implements IResponder
	{
		private var resultHandler : Function;
		private var faultHandler : Function;

		public function GenericResponder( resultHandler : Function, faultHandler : Function = null )
		{
			this.resultHandler = resultHandler;
			this.faultHandler = faultHandler;
		}

		public function result( data:Object ):void
		{
			resultHandler(data);
		}

		public function fault( info:Object ):void
		{
			if( faultHandler != null ) {
				faultHandler( info )
			}
		}

	}
}