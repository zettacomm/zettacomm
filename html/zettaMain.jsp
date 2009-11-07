<%!
  public String makeButton(String channel, String imgURL) {
	String retval;
	retval = "<a href=\"javascript:{}\" onclick=\"document.getElementById(\'livestreamWidget\').src = \'/stream/" + channel + "\';\"><img width=\"64\" src=\"" + imgURL + "\" alt=\"" + channel + "\" title=\"" + channel + "\"></img></a>";
	return retval;
  } 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">"
<head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /></head>
<body style="background: #000">
<div id="videobox" style="float: left; width: 520px; border: 0px">
<iframe id="livestreamWidget" src="/stream
<%	if ((request.getPathInfo() == null ) || (request.getPathInfo().equals("/"))) { //wtf browser, man
		out.println("/warden");
		}
	else {
		out.println(request.getPathInfo()); 
	}
	
	%>" height="500" width="510" scrolling="no" frameborder="no"></iframe>
	<!-- <%= request.getPathInfo() %>-->
	<div id="channelSelector">
<%= makeButton("warden","http://i33.tinypic.com/34zg27l.jpg") %>
<%= makeButton("extrazz","http://i33.tinypic.com/2pt5pvt.jpg") %>
<%= makeButton("cartoonblam","http://i36.tinypic.com/119tct0.jpg") %>
<%= makeButton("booooom","http://i33.tinypic.com/2v7tett.jpg") %>
<%= makeButton("sonikku","http://i34.tinypic.com/1zh1it5.jpg") %>
</div>
</div>
<div id="chatbox" style="float: left; width: 500px; border: 0px">
<iframe width="500" height="500" frameborder="no" src="http://widget.mibbit.com/?settings=1a6ed251be8ef8641a9bcc07054e5851&server=irc.epic-chat.net&channel=%23zetta"></iframe>
</div>
</body>
</html>
 