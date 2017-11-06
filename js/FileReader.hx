package jp.okawa.js;

import js.Browser.window;
import js.html.Blob;
import js.html.DragEvent;
import js.html.ProgressEvent;
import js.html.FileReader as NativeFileReader;
import js.jquery.JQuery;
import js.jquery.Event;
 
class FileReader {

	public var onLoaded  : String->Void;
	private var _jParent : JQuery;

	/* =======================================================================
		Constractor
	========================================================================== */
	public function new(jParent:JQuery,html:String='<button></button><input type="file">'):Void {

		_jParent = jParent;
		_jParent.append(html);

		var jBtn    = _jParent.find('button');
		var jSubmit = _jParent.find('input[type="file"]');

		new JQuery(window).on({ drop:onDrop, dragenter:onEnter, dragover:onOver });
		jBtn.on('click',jSubmit.click);
		jSubmit.on({ 'change':onChange });

	}

	/* =======================================================================
		Read
	========================================================================== */
	private function read(file:Blob):Void {

		var reader : NativeFileReader = new NativeFileReader();
		reader.onload = function(event:Dynamic):Void {

			cancel(event);
			var base64 : String = event.currentTarget.result;
			if (onLoaded != null) onLoaded(base64);

		};

		reader.readAsDataURL(file);

	}

	/* =======================================================================
		On Change
	========================================================================== */
	private function onChange(event:Event):Void {

		var file : Blob = untyped event.originalEvent.target.files[0];
		read(file);

	}

	/* =======================================================================
		On Drop
	========================================================================== */
	private function onDrop(event:Event):Bool {

		var file : Blob = untyped event.originalEvent.dataTransfer.files[0];
		read(file);
		return false;

	}

	/* =======================================================================
		On Enter
	========================================================================== */
	private function onEnter(event:Event):Bool {

		cancel(event);
		return false;

	}

	/* =======================================================================
		On Over
	========================================================================== */
	private function onOver(event:Event):Bool {

		cancel(event);
		return false;

	}

	/* =======================================================================
		Cancel
	========================================================================== */
	private function cancel(event:Event):Void {

		event.preventDefault();
		event.stopPropagation();

	}

}