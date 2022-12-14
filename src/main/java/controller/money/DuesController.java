package controller.money;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.StudyGroup;
import model.Dues;
import model.Member;
import model.service.MoneyManager;

public class DuesController implements Controller{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      if (request.getMethod().equals("POST")) {
    	  HttpSession session = request.getSession();
    	  StudyGroup group = (StudyGroup) session.getAttribute("studyGroup");
    	  request.setCharacterEncoding("utf-8");
    	  Dues dues = new Dues(
    			  null,
    			  group.getGroupId(),
    			  request.getParameter("duesDate"),
    			  Integer.parseInt(request.getParameter("price")),
    			  request.getParameter("userName")
    			  );
    	  try {
    		  session = request.getSession();
    		  MoneyManager manager = MoneyManager.getInstance();
    		  manager.addDues(dues);
    		  
    		  return "redirect:/group/money/dues";
	      }catch (SQLException se) {
	    	  se.printStackTrace();
	    	  return "/group/money/dues";
	      }catch (Exception e) {
	          e.printStackTrace();
	          return "/group/money/dues";
	      }
      }

	  HttpSession session = request.getSession();
      MoneyManager manager = MoneyManager.getInstance();
      StudyGroup group = (StudyGroup) session.getAttribute("studyGroup");
      List<Dues> list = manager.getDuesList(group.getGroupId());
      
      request.setAttribute("list", list);

	  request.setAttribute("groupId", group.getGroupId());
      return "/group/money/dues.jsp";

   }

}