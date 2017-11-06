package jp.okawa.php;

import haxe.crypto.Base64;
import haxe.crypto.Md5;
import sys.FileSystem;
import sys.io.File;
import php.Lib;

class Mail {
	
	private var _name     : String;
	private var _from     : String;
	private var _ccList   : Array<String>;
	private var _bccList  : Array<String>;
	private var _headers  : String;
	private var _files    : Map<String,String>;
	private var _boundary : String;
	
	private static inline var CRLF:String = '\r\n';
	
	/* =======================================================================
		Constructor
	========================================================================== */
	public function new():Void {
		
		_from     = 'test@example.com';
		_boundary = Md5.encode(Std.string(Std.random(0x3fffffff)));
		
	}

		/* =======================================================================
			Send
		========================================================================== */
		public function send(to:String,subject:String,message:String):Bool {

			return Lib.mail(getTo(to.split(',')),subject,getBody(message),getHeaders());

		}

		/* =======================================================================
			Set Name
		========================================================================== */
		public function setName(value:String):Void {

			_name = value;

		}

		/* =======================================================================
			Set From
		========================================================================== */
		public function setFrom(value:String):Void {

			_from = value;

		}

		/* =======================================================================
			Set Cc
		========================================================================== */
		public function setCc(array:Array<String>):Void {

			_ccList = getMailaddresses(array);

		}

		/* =======================================================================
			Set Bcc
		========================================================================== */
		public function setBcc(array:Array<String>):Void {

			_bccList = getMailaddresses(array);

		}

		/* =======================================================================
			Set Headers
		========================================================================== */
		public function setHeaders(value:String):Void {

			_headers = value;

		}

		/* =======================================================================
			Set Files
		========================================================================== */
		public function setFiles(map:Map<String,String>):Void {

			_files = map;

		}

	/* =======================================================================
		Get To
	========================================================================== */
	private function getTo(array:Array<String>):String {

		var mailaddresses:Array<String> = getMailaddresses(array);

		if (mailaddresses != null) {
			return mailaddresses.join(',');
		}

		if (_ccList == null) return null;

		_ccList.shift();
		return _ccList[0];
		
	}

	/* =======================================================================
		Get Header
	========================================================================== */
	private function getHeaders():String {

		var results:Array<String> = [

			'X-Mailer: PHP5',
			'From: ' + getFrom(),
			'Return-Path: ' + getFrom(),
			getCc() + getBcc() + 'MIME-Version: 1.0',
			'Content-Transfer-Encoding: 7bit'

		];

		if (_files == null) {
			results.push('Content-Type: text/plain; charset="utf-8"');
		} else {
			results.push('Content-Type: multipart/mixed; boundary="$_boundary"');
		}

		if (_headers != null) results.push(_headers);

		return results.join(CRLF);
		
	}

	/* =======================================================================
		Get Body
	========================================================================== */
	private function getBody(message:String):String {

		if (_files == null) return message;

		var results:Array<String> = [

			'--$_boundary',
			'Content-Type: text/plain; charset="utf-8"',
			'Content-Transfer-Encoding: 7bit$CRLF',
			message

		];

		for (path in _files.keys()) {

			if (!FileSystem.exists(path)) continue;

			var filename:String = _files[path];

			results.push([

				'',
				'--$_boundary',
				'Content-Type: application/octet-stream; name="$filename"',
				'Content-Disposition: attachment; filename="$filename"',
				'Content-Transfer-Encoding: base64$CRLF',
				Base64.encode(File.getBytes(path)),

			].join(CRLF));

		}

		results.push('--$_boundary--');

		return results.join(CRLF);
		
	}

	/* =======================================================================
		Get From
	========================================================================== */
	private function getFrom():String {

		return _name == null ? _from : _name + '<$_from>';
		
	}

	/* =======================================================================
		Get Cc
	========================================================================== */
	private function getCc():String {

		if (_ccList == null || _ccList.length == 0) return '';
		return 'Cc: ' + _ccList.join(',') + CRLF;
		
	}

	/* =======================================================================
		Get Bcc
	========================================================================== */
	private function getBcc():String {

		if (_bccList == null) return '';
		return 'Bcc: ' + _bccList.join(',') + CRLF;
		
	}

	/* =======================================================================
		Get Mailaddresses
	========================================================================== */
	public function getMailaddresses(array:Array<String>):Array<String> {

		var results : Array<String> = [];

		for (mailaddress in array) {

			if (~/.+@.+\..+/.match(mailaddress)) {
				results.push(mailaddress);
			}

		}

		return (results.length == 0) ? null : results;

	}

}