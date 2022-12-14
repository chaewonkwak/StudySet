package controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Member;
import model.dao.MemberDAO;
import model.service.ExistingUserException;
import model.service.MemberManager;

public class RegisterUserController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(RegisterUserController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	if (request.getMethod().equals("GET")) {	
    		try {
    			MemberManager manager = MemberManager.getInstance();
    			String id = request.getParameter("userId");
    			if(manager.existMember(id)) {
                    request.setAttribute("ExistId", false);
                    request.setAttribute("id", id);
    			}
    			return "/user/join.jsp";
    	        
    		} catch (ExistingUserException e) {
                request.setAttribute("registerFailed", true);
                request.setAttribute("ExistId", true);
    			return "/user/join.jsp";
    		}
	    }	
    	
    	Member member = new Member(
			request.getParameter("userId"),
			request.getParameter("name"),
			request.getParameter("password"),
			request.getParameter("phone"),
			request.getParameter("birth"),
			request.getParameter("email"));
		
		
        log.debug("Create User : {}", member);

		try {
			MemberManager manager = MemberManager.getInstance();
			manager.createMember(member);
	        return "redirect:/main";	
	        
		} catch (ExistingUserException e) {	
            request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("member", member);
			return "/user/join.jsp";
		}
    }
}

