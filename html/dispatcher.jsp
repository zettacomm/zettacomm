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