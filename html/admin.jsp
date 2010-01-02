<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="zetta.*" %>

<html>
	<head><title>Zetta Admin Panel</title></head>
	<body>
<%
    Channel chan; 	//chan is created by and kept track of by persistence manager. we can do gets and sets on it and then when we pm.close()
					//changes to the object are automatically saved to database.
	PersistenceManager pm = PMF.get().getPersistenceManager();
	if (request.getMethod().equals("POST")) {	// handle form input here
		String action = request.getParameter("action");
		if ( action.equals("post")) {                       //update
			chan = pm.getObjectById(Channel.class, request.getParameter("name"));
			chan.setRank(Integer.parseInt(request.getParameter("rank")));
			chan.setImgURL(request.getParameter("imgURL"));
//			pm.makePersistent(chan);
			out.println("UPDATE: "+chan.getName()+", "+chan.getRank()+", "+chan.getImgURL());
		}
		else if (action.equals("put")) {                    //add
			out.println("ADD");
			chan = new Channel(request.getParameter("name"), Integer.parseInt(request.getParameter("rank")), request.getParameter("imgURL"));
			pm.makePersistent(chan);
		}
		else if (action.equals("delete")) {                 //delete
			out.println("DELETE");
			chan = pm.getObjectById(Channel.class, request.getParameter("name"));
			pm.deletePersistent(chan);
		}
	}
	pm.close(); //won't commit without it. i know. dumb!
	pm = PMF.get().getPersistenceManager();	//form output starts here
	String query = "select from " + Channel.class.getName() + " order by rank asc";
    List<Channel> channels = (List<Channel>) pm.newQuery(query).execute();
    if (channels.isEmpty()) {
%>
	<p>No Channels Found!</p>
<%
    } 
	else {
%>
			<table padding=0 ><tr><td>Name</td><td>Rank</td><td>Image Url</td><td></td><td></td></tr>
<%
		for (Channel c : channels) {	//print update/delete row for each channel
%>

			<tr>
	 		<td valign="top">
			<form method="POST" action="/admin">
				<input type="hidden" name="action" value="post">
				<input type="hidden" name="name" value="<%= c.getName() %>">
				<%= c.getName() %>
			</td>
			<td valign="top">
				<input type="text" name="rank" value="<%= c.getRank() %>">
			</td>
			<td valign="top">
				<input type="text" name="imgURL" value="<%= c.getImgURL() %>">
			</td>
			<td valign="top">
				<input type="submit" name="update" value="update">
			</form>
			</td>
			<td valign="top">
			<form method="POST" action="/admin">
				<input type="hidden" name="action" value="delete">
				<input type="hidden" name="name" value="<%= c.getName() %>">
				<input type="submit" name="delete" value="delete">
			</form>
			</td>
			</tr>
<%
		}
%>
		</table>
<%
	}
	pm.close(); // commit to db and no more reads.
// rest of file is to add new channel form
	%>
	<hr>
	<form method="POST" action="/admin">
	<input type="hidden" name="action" value="put">
	Name: <input type="text" name="name" value="ChannelName"><br />
	Rank (1-32767): <input type="text" name="rank" value="32767"><br />
	Image Url: <input type="text" name="imgURL" value="http://"><br />
	<input type="submit" name="add" value="add">
	</form>
	<body>
	
</html>

