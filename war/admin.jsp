<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="zetta.*" %>

<html>
	<head><title>Zetta Admin Panel</title></head>
	<body>
<%
    Channel chan;
	PersistenceManager pm = PMF.get().getPersistenceManager();
	if (request.getMethod().equals("POST")) {
		String action = request.getParameter("action");
		if ( action.equals("post")) {                       //update
			chan = pm.getObjectById(Channel.class, request.getParameter("name"));
			chan.setRank(Integer.parseInt(request.getParameter("rank")));
			chan.setImgURL(request.getParameter("imgURL"));
//			pm.makePersistent(chan);
			out.println("UPDATE "+chan.getName()+chan.getImgURL());
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
	pm = PMF.get().getPersistenceManager();
	String query = "select from " + Channel.class.getName() + " order by rank asc";
    List<Channel> channels = (List<Channel>) pm.newQuery(query).execute();
    if (channels.isEmpty()) {
%>
	<p>No Channels Found!</p>
<%
    } 
	else {
		for (Channel c : channels) {
%>
			<form method="POST" action="/admin">
				<input type="hidden" name="action" value="post">
				<input type="hidden" name="name" value="<%= c.getName() %>">
				Name:<%= c.getName() %>
				Rank:<input type="text" name="rank" value="<%= c.getRank() %>">
				Image URL:<input type="text" name="imgURL" value="<%= c.getImgURL() %>">
				<input type="submit" name="update" value="update">
			</form>
			<form method="POST" action="/admin">
				<input type="hidden" name="action" value="delete">
				<input type="hidden" name="name" value="<%= c.getName() %>">
				<input type="submit" name="delete" value="delete">
			</form>
<%
		}
	}
	pm.close(); // commit to db and no more reads.
%>

	<form method="POST" action="/admin">
	<input type="hidden" name="action" value="put">
	Name:<input type="text" name="name" value="livestreamChannelName"><br />
	Rank:<input type="text" name="rank" value="32767"><br />
	image Url:<input type="text" name="imgURL" value="http://"><br />
	<input type="submit" name="add" value="add">
	</form>
	<!-- <%= request.getMethod() %> -->
	<body>
	
</html>

