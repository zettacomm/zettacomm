import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class Test extends HttpServlet {
 public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
      throws ServletException, IOException {
      
    PrintWriter out = response.getWriter();
	out.println(request.getPathInfo()); //this is the one i want
	out.println(request.getPathTranslated());
	out.println(request.getRequestURI());
	out.println(request.getRequestURL());

  }
}