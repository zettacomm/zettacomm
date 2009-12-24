//should break into a few separate classes i guess.
function zettaClass () {
	this.setElemWidth = function (elemId, width) {
		var myElem=document.getElementById(elemId);
		myElem.style.width = width+"px";
	}

	this.setElemHeight = function (elemId, height) {
		var myElem=document.getElementById(elemId);
		myElem.style.height = height+"px";
	}

	this.getViewableSize = function () {
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
		retval['width']=myWidth-25;
		retval['height']=myHeight-25;
		return retval;
	}

	this.getMaxLivestreamWidgetSize = function () {
		var view = this.getViewableSize(), retval=new Array;
		retval['height']=view['height']-100; //leave plenty of room
		retval['width']=Math.floor(retval['height']*(1200/980))+25;
		if ((view['width']-retval['width'])<480) { //make chatbox atleast 480 across
			retval['width'] = view['width'] - 500;
			retval['height'] = Math.floor(retval['width']*(980/1200));
		}
		return retval;
	}

	this.getMaxVideoboxSize = function () { //assume 4:3 always 
		var view = this.getViewableSize();
		var mywidg = this.getMaxLivestreamWidgetSize()
		var retval=new Array();
		retval['width'] = mywidg['width']+10;
		retval['height']= view['height'];
		return retval;
	}

	this.getMaxChatboxSize = function () {
		var view = this.getViewableSize(), retval=new Array();
		var maxVidSize = this.getMaxVideoboxSize();
		retval['height'] = view['height']; //leaveroom for whatever
		retval['width'] = view['width'] - maxVidSize['width'] - 10; //assume padding of 10
		return retval;
	}
	
	this.changeChannel = function (channelName) {
		var myStream = document.getElementById("livestreamWidget");	
		var mywidg = this.getMaxLivestreamWidgetSize();
		myStream.setAttribute("src", "/stream/"+channelName+"/"+Math.floor(mywidg.width)+"/"+Math.floor(mywidg.height)); //only send integer sizes
	}	

	this.resizeLivestreamWidget = function (channelName, width, height) {
		var myStream = document.getElementById("livestreamWidget");	
		myStream.setAttribute("src", "/stream/" + channelName + "/" + Math.floor(width) + "/" + Math.floor(height)); //only send integer sizes
	}
	
	this.resizeVideobox = function (channelName) {	//also resize livestreamWidget iframe
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
		var chatBox=document.getElementById("chatBox");
		var mibbitWidget=document.getElementById("mibbitWidget");
		var mywidg=this.getMaxLivestreamWidgetSize();
		var maxSize = this.getMaxChatboxSize();
		chatBox.style.width=(maxSize['width']-25)+"px";
		chatBox.style.height = maxSize['height']+"px";	
		mibbitWidget.style.width = (maxSize['width']-15)+"px";
		mibbitWidget.style.height = (mywidg['height']+10)+"px";
	}	
	
}





	