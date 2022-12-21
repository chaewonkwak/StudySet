package controller.memo;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.service.CommentManager;
import model.Member;
import model.Memo;
import model.MemoComment;

public class CommentController implements Controller {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      HttpSession session = request.getSession();
      Member loginmember = (Member) session.getAttribute("loginmember");
      String userId = request.getParameter("userId");
      Memo memo = (Memo) request.getAttribute("memo");
      CommentManager manager = CommentManager.getInstance();
      if (request.getMethod().equals("POST")) {
         String commentContents = request.getParameter("commentContents");
         String annonymous = request.getParameter("annonymous");
         String memoId = request.getParameter(memo.getMemoId());
         String commentDate = request.getParameter("commentDate");

         char anno = annonymous == null ? 'N' : 'Y';

         MemoComment comment = new MemoComment(null, userId, memoId, commentContents, anno, commentDate);
         try {
            manager.addMemoComment(comment, memoId);
            return "redirect:/group/memo/detail";
         } catch (SQLException se) {
            se.printStackTrace();
            return "/group/memo/detail";
         } catch (Exception e) {
            e.printStackTrace();
            return "/group/memo/detail";
         }
      }
      
      return "/group/memo/detail";
   }
}