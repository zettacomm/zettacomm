<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="zetta.*" %>

<html>
	<head><title>Zetta Admin Panel</title></head>
	<body>
<%
    PersistenceManager pm = PMF.get().getPersistenceManager();
    String query = "select from " + Channel.class.getName() + " order by rank asc";
    List<Channel> channels = (List<Channel>) pm.newQuery(query).execute();
    if (channels.isEmpty()) {
%>
	<p>No Channels Found!</p>
<%
    } else {
	for (Channel c : channels) {
%>
	<form method="POST" action="/admin.jsp">
	<input type="text" name="name" value="<%= c.getName() %>">
	<input type="text" name="rank" value="<%= c.getRank() %>">
	<input type="text" name="imgURL" value="<%= c.getImgURL() %>">
	<input type="submit" name="update" value="update">
	</form>
	<form method="DELETE" action="/admin.jsp">
	<input type="submit" name="delete" value="delete">
	</form>
<%
	}
	}
%>

	<form method="PUT" action="/admin.jsp">
	<input type="text" name="name" value="livestreamChannelName">
	<input type="text" name="rank" value="32767">
	<input type="text" name="imgURL" value="http://">
	<input type="submit" name="add" value="add">
	</form>
	<!-- <%= request.getMethod() %> -->
	<body>
	
</html>

