//should break into a few separate classes i guess.
/* all size functions should return an array with 'width' and 'height' as elements. */
function zettaClass () {
	this.setElemWidth = function (elemId, width) {
		var myElem=document.getElementById(elemId);
		myElem.style.width = width+"px";	/*a little DOM is a wonderful thing*/
	}

	this.setElemHeight = function (elemId, height) {
		var myElem=document.getElementById(elemId);
		myElem.style.height = height+"px";
	}

	this.getViewableSize = function () {
	/*
	test for existence of different vars to determine viewable size of browser window that is usable to us
	(i.e. minus menubars and status bars and so forth)
	*/
		var myWidth = 0, myHeight = 0;
		var retval = new Array();
		if( typeof( window.innerWidth ) == 'number' ) {
			//Non-IE
			myWidth = window.innerWidth;
			myHeight = window.innerHeight;
		} else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
			//IE 6+ in 'standards compliant mode'
			myWidth = document.documentElement.clientWidth;
			myHeight = document.documentElement.clientHeight;
		} else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
			//IE 4 compatible
			myWidth = document.body.clientWidth;
			myHeight = document.body.clientHeight;
		}
		/* report a somewhat arbitrarily smaller size just in case of browser/livestream weirdness */
		retval['width'] = myWidth-25; 
		retval['height'] = myHeight-25;
		return retval;
	}

	this.getMaxLivestreamWidgetSize = function () {
	/*
	returns the maximum size we allow the livestream widget to be.
	it is calculated based on the (viewable height - space for buttons) x (scaling factor * height)
	unless remaining width is too small for chatbox in which case we base widget size on (viewable width - chatbox size).
	we use scaling factor of 1200:980 because livestream widget is not square and seldom does make sense.
	
	*/
		var view = this.getViewableSize(), retval=new Array;
		retval['height']=view['height']-100; //leave plenty of room for buttons and such underneath
		retval['width']=Math.floor(retval['height']*(1200/980))+25;
		if ((view['width']-retval['width'])<480) { //make chatbox atleast 480 across
			retval['width'] = view['width'] - 500;
			retval['height'] = Math.floor(retval['width']*(980/1200));	//scale height to match new smaller width
		}
		return retval;
	}

	this.getMaxVideoboxSize = function () { //assume 4:3 always 
		/* this calculates the size of the div that wraps the livestream widget */
		var view = this.getViewableSize();
		var mywidg = this.getMaxLivestreamWidgetSize()
		var retval=new Array();
		retval['width'] = mywidg['width']+10;	//div needs to be just a touch wider than widget for padding and such
		retval['height'] = view['height'];
		return retval;
	}

	this.getMaxChatboxSize = function () {
		/* determines the maximum chat div size based on what width's left over from videobox */
		var view = this.getViewableSize(), retval=new Array();
		var maxVidSize = this.getMaxVideoboxSize();
		retval['height'] = view['height']; 
		retval['width'] = view['width'] - maxVidSize['width'] - 10; //assume padding of 10
		return retval;
	}
	
	this.changeChannel = function (channelName) {
		/* changes iframe src to new channel. 
			src = channel/X/Y where X and Y are taken from the max widget size
			we do this to make sure we always get a proper sized stream
			Is called by the channel buttons
		*/
		var myStream = document.getElementById("livestreamWidget");	
		var mywidg = this.getMaxLivestreamWidgetSize();
		myStream.setAttribute("src", "/stream/"+channelName+"/"+Math.floor(mywidg.width)+"/"+Math.floor(mywidg.height)); //only send integer sizes
	}	

	this.resizeLivestreamWidget = function (channelName, width, height) {
		/* does more or less the same thing as changeChannel except forces the size instead of calculating it*/
		var myStream = document.getElementById("livestreamWidget");	
		myStream.setAttribute("src", "/stream/" + channelName + "/" + Math.floor(width) + "/" + Math.floor(height)); //only send integer sizes
	}
	
	this.resizeVideobox = function (channelName) {	//also resize livestreamWidget iframe
		/*
			resizes the the whole videobox div to it's largest and final size while also resizing livestream widget.
		*/
		var videoBox = document.getElementById("videoBox");
		var livestreamWidget = document.getElementById("livestreamWidget");
		var maxSize = this.getMaxVideoboxSize();
		var maxVidSize = this.getMaxLivestreamWidgetSize();
		videoBox.style.width = maxSize['width']+"px";
		videoBox.style.height = maxSize['height']+"px";
		livestreamWidget.style.width = maxVidSize['width']+"px";
		livestreamWidget.style.height = (maxVidSize['height']+10)+"px";
		this.resizeLivestreamWidget(channelName,maxVidSize['width'],maxVidSize['height']);
		}
	
	this.resizeChatbox = function () {	//also resize mibbitWidget iframe
		/*
			brings chatbox (and contained mibbit widget) up to it's final size
		*/
		var chatBox=document.getElementById("chatBox");
		var mibbitWidget=document.getElementById("mibbitWidget");
		var mywidg=this.getMaxLivestreamWidgetSize();
		var maxSize = this.getMaxChatboxSize();
		chatBox.style.width=(maxSize['width']-25)+"px";
		chatBox.style.height = maxSize['height']+"px";	
		mibbitWidget.style.width = (maxSize['width']-15)+"px";	//pad the right side of the screen a bit
		mibbitWidget.style.height = (mywidg['height']+10)+"px";	//line up bottom of chat and video widget
	}	
	
}





	