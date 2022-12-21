package model.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import model.Join;
import model.Member;
import model.StudyGroup;
import model.dao.GroupDAO;

public class GroupManager {
	private static GroupManager groupManager = new GroupManager();
	private GroupDAO groupDao;

	private GroupManager() {
		try {
			groupDao = new GroupDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static GroupManager getInstance() {
		return groupManager;
	}

	public GroupDAO getGroupDAO() {
		return this.groupDao;
	}

	// 그룹 생성이랑 그룹 생성한 사람 그 그룹에 가입시키는 트랜잭션
	public int create(StudyGroup newGroup, String userId) throws SQLException, ExistingGroupException {
		StudyGroup studyGroup = null;

		String gid = check(newGroup.getGroupName(), newGroup.getCode());
		if (gid != null)
			throw new ExistingGroupException();
		return groupDao.create(newGroup, userId);
	}

	// 이미 가입한 그룹인지 체크 + 그룹 가입 처리
	public int addMember(Join join) {
		try {
			if (groupDao.alreadyJoin(join.getUserId(), join.getGroupId())) // 이미 가입한 그룹일 경우 0 리턴
				return 0;
			else
				return groupDao.addMember(join);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	// 회원이 가입한 그룹 리스트
	public List<Join> getUserGroupList(String userId) throws SQLException {
		List<Join> userGroupList = new ArrayList<>();
		userGroupList = groupDao.getMyGroup(userId);
		return userGroupList;
	}

	// 그룹이름으로 회원이 가입한 그룹 검색(그룹 이름이 같은 경우를 고려하여 List 타입으로 반환)
	public List<Join> getGroupList(String groupName, String userId) throws SQLException {
		List<Join> joinList = new ArrayList<>();
		joinList = groupDao.getGroupList(groupName, userId);
		return joinList;
	}

	// 그룹 이름으로 그룹 검색
	public StudyGroup getGroup(String groupName) throws SQLException {
		StudyGroup group = groupDao.search(groupName);
		return group;
	}

	// 그룹 아이디로 그룹 검색
	public StudyGroup getGroupById(String groupId) throws SQLException {
		StudyGroup group = groupDao.searchById(groupId);
		return group;
	}

	// 멤버 이름으로 해당 그룹원 검색
	public List<Member> search(String memberName, String groupId) throws SQLException {
		List<Member> memberList = new ArrayList<>();
		try {
			memberList = groupDao.searchMemberByName(memberName, groupId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return memberList;
	}

	// 그룹 이름과 그룹원 이름으로 검색
//	public List<Member> searchByName(String memberName, String groupName) throws SQLException{
//		List<Member> memberList = new ArrayList<>();
//		try {
//			memberList = groupDao.getMemberList(memberName, groupName);
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return memberList;
//	}
	// 그룹에 가입시 해당하는 코드가 맞는지 체크
	public String check(String groupName, String code) throws SQLException {
		return groupDao.check(groupName, code);
	}

	// 그룹원 리스트->과제 제출 연결
	public List<Member> getMember(String groupId) throws SQLException {
		List<Member> memberList = new ArrayList<>();
		try {
			memberList = groupDao.getMember(groupId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return memberList;
	}

	public int getMemberCount(String groupId) throws SQLException {
		int count;
		count = groupDao.memberCount(groupId);
		return count;
	}
}