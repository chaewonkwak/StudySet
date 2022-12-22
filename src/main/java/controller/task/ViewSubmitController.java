package controller.task;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Member;
import model.Submit;
import model.SubmitComment;
import model.Task;
import model.service.CommentManager;
import model.service.TaskManager;

public class ViewSubmitController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Member loginmember = (Member) session.getAttribute("loginmember");

		CommentManager cmanager = CommentManager.getInstance();
		TaskManager manager = TaskManager.getInstance();

		Task task = (Task) session.getAttribute("task");
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		// userName = new String(userName.getBytes("ISO8859_1"), "UTF-8");
		String taskId = request.getParameter("taskId");
		Submit submit = manager.getSubmit(taskId, userId);
		System.out.println("글작성자ID, 이름 " + userId + ", " + userName);
		request.setAttribute("submit", submit);
		request.setAttribute("userId", userId);
		request.setAttribute("userName", userName);

//comment 불러오기
		List<SubmitComment> list = null;
	      try {
	         list = cmanager.getSubmitCommentList(submit.getSubmitId());
	         request.setAttribute("list", list);
	      } catch (Exception e) {
	         response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	         out.println("<script>alert('과제를 제출하시길 바랍니다.'); location.href='/StudySet/group/task/detail?taskId=" + task.getTaskId()+"';</script>");
	         out.flush();
	         return "redirect:group/task/detail";
	      }

//comment 작성
		if (request.getMethod().equals("POST")) {
			request.setCharacterEncoding("utf-8");
			String commentContents = request.getParameter("commentContents");
			String annonymous = request.getParameter("annonymous");
			String submitId = submit.getSubmitId();
			String commentDate = request.getParameter("commentDate");
			char anno = annonymous == null ? 'N' : 'Y';
			SubmitComment comment = new SubmitComment(null, loginmember.getUserId(), commentContents, anno, submitId,
					commentDate);

			try {
				System.out.println("commentDate:" + commentDate);
				userName = request.getParameter("userName");
				 userName = URLEncoder.encode(userName, "UTF-8");
				// userName = new String(userName.getBytes("ISO8859_1"), "UTF-8");
				cmanager.addSubmitComment(comment, submitId);
				return "redirect:/group/task/submit?userId=" + userId + "&userName=" + userName + "&taskId="
						+ task.getTaskId();
			} catch (Exception e) {
				// e.printStackTrace();
				return "/group/task/detail";
			}
		}

		return "/group/task/view.jsp";
	}
}
