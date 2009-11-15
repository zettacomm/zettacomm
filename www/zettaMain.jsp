<%!
  public String makeButton(String channel, String imgURL) {
	String retval;
	retval = "<a href=\"javascript:{}\" onclick=\"document.getElementById(\'livestreamWidget\').src = \'/stream/" + channel + "\';\"><img width=\"64\" src=\"" + imgURL + "\" alt=\"" + channel + "\" title=\"" + channel + "\"></img></a>";
	return retval;
  } 

%>
<%
	String video, chat;
	String[] path = request.getPathInfo().split("/");
	out.println("<!-- "+path.length+" "+request.getPathInfo()+" -->");
	video = "warden"; chat = "#zetta"; //defaults
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
<body style="background: #000">
<div id="videobox" style="float: left; width: 500px; border: 0px">
<iframe id="livestreamWidget" src="/stream/<%= video %>" height="500" width="500" scrolling="no" frameborder="no"></iframe>
	<!-- <%= request.getPathInfo() %>-->
	<div id="channelSelector">
<%= makeButton("warden","http://i33.tinypic.com/34zg27l.jpg") %>
<%= makeButton("extrazz","http://i33.tinypic.com/2pt5pvt.jpg") %>
<%= makeButton("cartoonblam","http://i36.tinypic.com/119tct0.jpg") %>
<%= makeButton("booooom","http://i33.tinypic.com/2v7tett.jpg") %>
<%= makeButton("sonikku","http://i34.tinypic.com/1zh1it5.jpg") %>
</div>
</div>
<div id="chatbox" style="float: left; width: 480px; border: 0px">
<iframe width="480" height="500" frameborder="no" src="http://widget.mibbit.com/?settings=1a6ed251be8ef8641a9bcc07054e5851&server=irc.epic-chat.net&channel=<%= java.net.URLEncoder.encode(chat, "UTF-8") %>"></iframe>
<div style="color: white" >subscribe to our <a href="http://twitter.com/statuses/user_timeline/51882610.rss">rss feed</a></div>
</div>
</body>
</html>
 