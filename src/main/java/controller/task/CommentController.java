package controller.task;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Member;
import model.Submit;
import model.Task;
import model.service.CommentManager;
import model.service.TaskManager;
import java.net.URLEncoder;
public class CommentController implements Controller {

   @Override
   public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      HttpSession session = request.getSession();
		
      Task task = (Task) session.getAttribute("task");
      String taskId = task.getTaskId();
      String userId = request.getParameter("userId");
      String userName = request.getParameter("userName");
      String submitCommentId = request.getParameter("commentId");
      userName = URLEncoder.encode(userName, "UTF-8");
      System.out.println(taskId + userId + userName + submitCommentId);
      
     request.setCharacterEncoding("utf-8");
     CommentManager manager = CommentManager.getInstance();
     manager.removeMemoComment(submitCommentId);
     
     return "redirect:/group/task/submit?userId=" + userId + "&userName=" + userName + "&taskId=" + taskId+"&success=1";
   }
}