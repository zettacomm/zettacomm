<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="zetta.*" %>
<%!
	
public String makeButton(String channel, String imgURL) {	//returns string with html for channel buttons
	String retval;
	retval = "<a href=\"javascript:{}\" onclick=\"zetta.changeChannel('"+channel+"');\"><img width=\"48\" src=\"" + imgURL + "\" alt=\"" + channel + "\" title=\"" + channel + "\"></img></a>";
	return retval;
}

public String getDefaultChannelName() {	//return channel of lowest rank
	String retval;
	Channel myChannel;
	PersistenceManager pm = PMF.get().getPersistenceManager();
	String query = "select from " + Channel.class.getName() + " order by rank asc";
    List<Channel> channels = (List<Channel>) pm.newQuery(query).execute();
    if (channels.isEmpty()) {
		retval= "" ;
    } 
	else {
		myChannel = channels.get(0);	//get first channel from list
		retval = myChannel.getName();
	}
	pm.close();
	return retval;
}
	 

%>
<%
	String video, chat;
	String[] path = request.getPathInfo().split("/");
	video = getDefaultChannelName();	//defaults
	chat = "#zetta";
	//following code block processes url of the forms:
	// 	/
	//	/streamname
	//	/-channel/channelname
	//	/streamname/-chat/chatname
	//	/-channel/channelname/-chat/chatname
	// in order to set vars video and chat based on url
	// not the cleanest way to do it and prolly needs error handling but it works for now.
	// -option/value can be thought of as option=value
	
	if (path.length >= 2) { //we have options and or commands, path[0] is null because of split
		int myIndex;
		for (myIndex = 1; myIndex < path.length; myIndex++) { 	//parse path. commands: -option, -option/value, channelname
			if (path[myIndex].substring(0,1).equals("-")) { 	//options start with '-'
				if(path[myIndex].equals("-channel")) { 			// -channel/channelname
					if(myIndex < (path.length - 1)) {
						myIndex++; //advance to option value
						video = path[myIndex];	//consume value
					}
				}
				if(path[myIndex].equals("-chat")) { 			// -chat/chatroomname
					if(myIndex < (path.length - 1)) {
						myIndex++; //advance to option
						chat = "#" + path[myIndex];
					}
				}
			}
			else {	//is just a channel name
				video = path[myIndex];
			}
			
		}
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">"
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<link rel="stylesheet" type="text/css" href="/zetta.css" />
</head>
<body>
<div id="videoBox">
<iframe id="livestreamWidget" scrolling="no" src="/stream/<%= video %>"></iframe>
	<!-- <%= request.getPathInfo() %>-->
	<div id="channelSelector">
<%
	PersistenceManager pm = PMF.get().getPersistenceManager();	//let's make some buttons!
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
	pm.close();
%>
	</div>
</div>

<div id="chatBox">
<iframe id="mibbitWidget" scrolling="no" src="http://widget.mibbit.com/?settings=1a6ed251be8ef8641a9bcc07054e5851&server=irc.anonnet.org&channel=<%= java.net.URLEncoder.encode(chat, "UTF-8") %>"></iframe>
<div>
<a target="_blank" href="http://twitter.com/zettacomm"><img src="/images/twitter_32.png"></img></a>
<a target="_blank" href="http://twitter.com/statuses/user_timeline/51882610.rss"><img src="/images/feed_32.png"></img></a>
<a target="_blank" href="http://zettacomm.blogspot.com/"><img src="/images/blogger_32.png"></img></a>
<a target="_blank" href="http://zettacomm.wikidot.com/"><img src="/images/wiki_32.png"></img></a>
</div>
</div>
<script type="text/javascript"></script>
<script language="JavaScript" src="/zetta.js"></script>
<script type="text/javascript">zetta = new zettaClass(); zetta.resizeVideobox("<%= video %>"); zetta.resizeChatbox();</script>
</body>
</html>
 