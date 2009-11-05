import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class ZettaMain extends HttpServlet {
 public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
      throws ServletException, IOException {
      
    PrintWriter out = response.getWriter();
//	out.println(request.getPathInfo()); //this is the one i want
	out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
	out.println("<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\" xml:lang=\"en\">");
	out.println("<head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=iso-8859-1\" /></head>");
	out.println("<body style=\"background: #000\">");
	out.println("<div id=\"videobox\" style=\"float: left; width: 520px; border: 0px\">");
	out.println("<iframe id=\"livestreamWidget\" src=\"/stream");
	if ((request.getPathInfo() == null ) || (request.getPathInfo().equals("/"))) { //wtf browser, man
		out.println("/warden");
		}
	else {
		out.println(request.getPathInfo()); 
	}
	
	out.println("\" height=\"500\" width=\"510\" scrolling=\"no\" frameborder=\"no\"></iframe>");
	out.println("<!-- "+request.getPathInfo()+"-->");
	out.println("<div id=\"channelSelector\">");
	out.println(makeButton("warden","http://i33.tinypic.com/34zg27l.jpg"));
	out.println(makeButton("cartoonblam","http://i36.tinypic.com/119tct0.jpg"));
	out.println(makeButton("booooom","http://i33.tinypic.com/2v7tett.jpg"));
	out.println(makeButton("sonikku","http://i34.tinypic.com/1zh1it5.jpg"));
	out.println("</div>");
	out.println("</div>");
	out.println("<div id=\"chatbox\" style=\"float: left; width: 500px; border: 0px\">");
	out.println("<iframe width=\"500\" height=\"500\" frameborder=\"no\" src=\"http://widget.mibbit.com/?settings=1a6ed251be8ef8641a9bcc07054e5851&server=irc.epic-chat.net&channel=%23zetta\"></iframe>");
	out.println("</div>");
	out.println("</body>");
	out.println("</html>");
  }
  public String makeButton(String channel, String imgURL) {
	return "<a onclick=\"document.getElementById(\'livestreamWidget\').src = \'/stream/" + channel + "\';\"><img width=\"64\" src=\"" + imgURL + "\" alt=\"" + channel + "\" title=\"" + channel + "\"></img></a>";
  } 
}