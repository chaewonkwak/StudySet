package controller.memo;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Member;
import model.StudyGroup;
import model.Memo;
import model.service.MemoManager;

public class UploadMemoController implements Controller {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      HttpSession session = request.getSession();
      StudyGroup group = (StudyGroup) session.getAttribute("group");
      Member member = (Member) session.getAttribute("loginmember");
      // Memo memo = (Memo) session.getAttribute("memo");
      String userId = request.getParameter("userId");
      Memo memo = null;
      
      // 메모 작성
      if (request.getMethod().equals("POST")) {
         request.setCharacterEncoding("utf-8");
         memo = new Memo( member.getUserId(), group.getGroupId(), 
               request.getParameter("submitContents"));

         MemoManager manager = MemoManager.getInstance();
         manager.addMemo(memo, group.getGroupId(), userId);
         return "redirect:/group/memo";
      }
      MemoManager manager = MemoManager.getInstance();

      memo = manager.getMemo(request.getParameter("memoId"));
      session.setAttribute("memo", memo);
      return "/group/memo.jsp";
   }
}