package controller.memo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.Member;
import model.StudyGroup;
import model.Memo;
import model.service.GroupManager;
import model.service.MemoManager;

public class MemoDetailController implements Controller{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		StudyGroup group = (StudyGroup) session.getAttribute("studyGroup");
		MemoManager manager = MemoManager.getInstance();
		GroupManager gmanager = GroupManager.getInstance();
		Memo memo = manager.getMemo(request.getParameter(""));
		List<Member> list = gmanager.getMember(group.getGroupId());
		request.setAttribute("group", group);
		session.setAttribute("memo", memo);
		session.setAttribute("list", list);
		return "/group/memo/detail.jsp";
	}
	
}
