package controller.group;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Join;
import model.Member;
import model.StudyGroup;
import model.service.ExistingGroupException;
import model.service.GroupManager;

public class GroupController implements Controller{

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
     
      if (request.getMethod().equals("POST")) { //POST: 새로운 그룹 생성
    	  request.setCharacterEncoding("utf-8");
         StudyGroup group = new StudyGroup(
        		 null,
               request.getParameter("groupName"),
               Integer.parseInt(request.getParameter("groupCategory")),
               request.getParameter("groupDescription"),
               request.getParameter("code")
               );
         try {
        	 HttpSession session = request.getSession();
        	 Member m = (Member) session.getAttribute("loginmember");
             GroupManager gManager = GroupManager.getInstance();
             int result = gManager.create(group, m.getUserId());
             if(result==0) //create 실패하면
            	 return "redirect:/user/group/list";
            return "redirect:/user/group/list?registerSuccess=true";
         }catch(ExistingGroupException e) {
             return "redirect:/user/group/list?registerSuccess=false";
         }
      }
      
      //GET: 그룹 선택 후 그룹 메인으로 리다이렉트
      HttpSession session = request.getSession();
      GroupManager manager = GroupManager.getInstance();
      StudyGroup studyGroup = manager.getGroupById(request.getParameter("groupId"));
      session.setAttribute("studyGroup", studyGroup);
     
      return "redirect:/group/main";
   }
}