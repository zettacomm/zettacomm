<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="zetta.*" %>
<%!
  public String makeButton(String channel, String imgURL) {
	String retval;
	retval = "<a href=\"javascript:{}\" onclick=\"changeChannel('"+channel+"');\"><img width=\"48\" src=\"" + imgURL + "\" alt=\"" + channel + "\" title=\"" + channel + "\"></img></a>";
	return retval;
  } 

%>
<%
	String video, chat;
	String[] path = request.getPathInfo().split("/");
	out.println("<!-- "+path.length+" "+request.getPathInfo()+" -->");
	video = "warden"; chat = "#zetta";		//defaults (TODO: add default stuff here
	if (path.length >= 2) { //we have options and or commands, path[0] is null because of split
		int myIndex;
		for (myIndex = 1; myIndex < path.length; myIndex++) { //parse path. commands: -option, -option/value, channelname
			if (path[myIndex].substring(0,1).equals("-")) { //command
				if(path[myIndex].equals("-channel")) { // -channel/channelname
					if(myIndex < (path.length - 1)) {
						myIndex++; //advance to option
						video = path[myIndex];
					}
				}
				if(path[myIndex].equals("-chat")) { // -chat/chatroomname
					if(myIndex < (path.length - 1)) {
						myIndex++; //advance to option
						chat = "#" + path[myIndex];
					}
				}
			}
			else { //is channel name
				video = path[myIndex];
			}
			
		}
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">"
<head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /></head>
<body style="background: #000; border: none; padding: 0px">

<script type="text/javascript">
function getViewableSize() {
	var myWidth = 0, myHeight = 0;
	var retval=new Array();
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

function setElemWidth(elemId, width) {
	var myElem=document.getElementById(elemId);
	myElem.style.width = width+"px";
}
function setElemHeight(elemId, height) {
	var myElem=document.getElementById(elemId);
	myElem.style.height = height+"px";

}
function getMaxVideoboxSize() { //assume 4:3 always 
	var view = getViewableSize();
	var mywidg = getMaxLivestreamWidgetSize()
	var retval=new Array();
	retval['width'] = mywidg['width']+10;
	retval['height']= view['height'];
	return retval;

}

function getMaxLivestreamWidgetSize() {
	var view = getViewableSize(), retval=new Array;
	retval['height']=view['height']-100; //leave plenty of room
	retval['width']=Math.floor(retval['height']*(1200/980))+25;
	if ((view['width']-retval['width'])<480) { //make chatbox atleast 480 across
		retval['width'] = view['width'] - 500;
		retval['height'] = Math.floor(retval['width']*(980/1200));
	}
	return retval;
}

function getMaxChatboxSize() {
	var view = getViewableSize(), retval=new Array();
	var maxVidSize= getMaxVideoboxSize();
	retval['height'] = view['height']; //leaveroom for whatever
	retval['width'] = view['width'] - maxVidSize['width'] - 10; //assume padding of 10
	return retval;
}

function changeChannel(channelName){
	var myStream = document.getElementById("livestreamWidget");	
	var mywidg = getMaxLivestreamWidgetSize();
	myStream.setAttribute("src", "/stream/"+channelName+"/"+Math.floor(mywidg.width)+"/"+Math.floor(mywidg.height)); //only send integer sizes

}

function resizeLivestreamWidget(channelName, width, height) {
	var myStream = document.getElementById("livestreamWidget");	
	myStream.setAttribute("src", "/stream/" + channelName + "/" + Math.floor(width) + "/" + Math.floor(height)); //only send integer sizes

}

function resizeVideobox() {	//also resize livestreamWidget iframe
	var videoBox=document.getElementById("videoBox");
	var livestreamWidget=document.getElementById("livestreamWidget");
	var maxSize = getMaxVideoboxSize();
	var maxVidSize=getMaxLivestreamWidgetSize();
	videoBox.style.width = maxSize['width']+"px";
	videoBox.style.height = maxSize['height']+"px";
	livestreamWidget.style.width = maxVidSize['width']+"px";
	livestreamWidget.style.height = (maxVidSize['height']+10)+"px";
	resizeLivestreamWidget("<%= video %>",maxVidSize['width'],maxVidSize['height']);
	}

	function resizeChatbox() {	//also resize mibbitWidget iframe
	var chatBox=document.getElementById("chatBox");
	var mibbitWidget=document.getElementById("mibbitWidget");
	var mywidg=getMaxLivestreamWidgetSize();
	var maxSize = getMaxChatboxSize();
	chatBox.style.width=(maxSize['width']-25)+"px";
	chatBox.style.height = maxSize['height']+"px";	
	mibbitWidget.style.width = (maxSize['width']-15)+"px";
	mibbitWidget.style.height = (mywidg['height']+10)+"px";
}

</script>

<div id="videoBox" style="float: left; width: 500px;">
<iframe id="livestreamWidget" src="/stream/<%= video %>" height="500" width="500" scrolling="no" frameborder="no"></iframe>
	<!-- <%= request.getPathInfo() %>-->
	<div id="channelSelector">
<%
	PersistenceManager pm = PMF.get().getPersistenceManager();
	String query = "select from " + Channel.class.getName() + " order by rank asc";
    List<Channel> channels = (List<Channel>) pm.newQuery(query).execute();
    if (channels.isEmpty()) {
		out.println("No channels Found!");
    } 
	else {
		for (Channel c : channels) {	
			out.println(makeButton(c.getName(),c.getImgURL()));
		}
	}
%>
	</div>
</div>

<div id="chatBox" style="float: left; width: 480px; padding: 0px">
<iframe id="mibbitWidget" width="480" height="500" padding="0" frameborder="no" src="http://widget.mibbit.com/?settings=1a6ed251be8ef8641a9bcc07054e5851&server=irc.epic-chat.net&channel=<%= java.net.URLEncoder.encode(chat, "UTF-8") %>"></iframe>
<div style="color: white" >subscribe to our <a href="http://twitter.com/statuses/user_timeline/51882610.rss">rss feed</a></div>
</div>
<script type="text/javascript">resizeVideobox(); resizeChatbox();</script>
</body>
</html>
 