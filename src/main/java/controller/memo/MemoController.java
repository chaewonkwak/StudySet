package controller.memo;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.StudyGroup;
import model.Memo;
import model.Member;
import model.service.MemoManager;
import model.service.GroupManager;

public class MemoController implements Controller {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Member loginmember = (Member) session.getAttribute("loginmember");
		StudyGroup group = (StudyGroup) session.getAttribute("studyGroup");
		MemoManager manager = MemoManager.getInstance();
		GroupManager groupManager = GroupManager.getInstance();
		
		//멤버 별 메모 리스트
		
		//로그인 한 사람이 가장 앞에 뜨게
		List<Memo> listOfLoginMember = (List<Memo>)manager.getList(group.getGroupId(), loginmember.getUserId());
		
		//다른 멤버들
		int count = (int)groupManager.getMemberCount(group.getGroupId());
		for (int i = 0; i < count - 1; i++) {
			List<Memo> list = (List<Memo>)manager.getList(group.getGroupId(), loginmember.getUserId());
			request.setAttribute("list"+i, list);
		}
		request.setAttribute("studyGroup", group);
		request.setAttribute("loginmember", loginmember);
		request.setAttribute("count", count);
		request.setAttribute("listOfLoginMember", listOfLoginMember);
		return "/group/memo.jsp";
	}

}