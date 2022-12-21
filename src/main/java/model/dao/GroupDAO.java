package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import model.StudyGroup;
import model.Join;
import model.Member;

public class GroupDAO {
	private JDBCUtil jdbcUtil = null;

	public GroupDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	
	// 스터디 그룹 생성과 그룹 생성자 그룹에 가입 처리 트랜잭션
	public int create(StudyGroup studyGroup, String userId) throws SQLException {
		
		String sql = "INSERT INTO StudyGroup VALUES (" + "'g'||LPAD(Sequence_gId.nextval, 7, '0')" + ", ?, ?, ?, ?)";
		Object[] param = new Object[] {studyGroup.getGroupName(), studyGroup.getGroupCategory(),
				studyGroup.getGroupDescription(), studyGroup.getCode() };
		
		String sql2 = "INSERT INTO JOIN (userId, groupId, groupName) VALUES(?, 'g'||LPAD(Sequence_gId.currval,  7, '0'), ?)";
		Object[] param2 = new Object[] { userId, studyGroup.getGroupName() };
		
		try {	
			jdbcUtil.setSqlAndParameters(sql, param); 
			int result = jdbcUtil.executeUpdate();	//Study Group 테이블에 insert 
		
			jdbcUtil.setSqlAndParameters(sql2, param2);	//Join 테이블에 insert
			result = jdbcUtil.executeUpdate();
			return result;
			
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();
		}		
		return 0;	
	}

	// 그룹 이름으로 검색
	public StudyGroup search(String groupName) throws SQLException {
		String sql = "SELECT * " + "FROM STUDYGROUP " + "WHERE groupName = ? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupName }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			if (rs.next()) { // 학생 정보 발견
				StudyGroup group = new StudyGroup( 
						rs.getString("groupId"), groupName, rs.getInt("groupCategory"),
						rs.getString("groupDescription"), rs.getString("code"));
				return group;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	//그룹 아이디로 그룹 검색
	public StudyGroup searchById(String groupId) throws SQLException {
		String sql = "SELECT * " + "FROM STUDYGROUP " + "WHERE groupId = ? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			if (rs.next()) { 
				StudyGroup group = new StudyGroup( // User 객체를 생성하여 학생 정보를 저장
						groupId, rs.getString("groupName"), rs.getInt("groupCategory"),
						rs.getString("groupDescription"), rs.getString("code"));
				return group;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	// 모든 그룹 리스트 가져오기. 그룹이름 반환
	public List<StudyGroup> getGroupList() {
		String sql = "SELECT groupName " + "FROM StudyGroup";
		jdbcUtil.setSqlAndParameters(sql, null); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<StudyGroup> groupList = new ArrayList<StudyGroup>();
			while (rs.next()) {
				StudyGroup studyGroup = new StudyGroup(rs.getString("groupName"));
				groupList.add(studyGroup);
			}
			return groupList;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	// user가 가입한 그룹 가져오기
	public List<Join> getMyGroup(String userId) {
		String sql = "SELECT *" + " FROM JOIN" + " WHERE userId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { userId });

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<Join> groupList = new ArrayList<Join>();
			while (rs.next()) {
				Join join = new Join(rs.getString("userId"), rs.getString("groupId"), rs.getString("groupName"));
				groupList.add(join);
			}
			return groupList;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	// 그룹 이름, 코드가 일치하는 그룹이 있는지 체크-> 일치 groupId반환/ 불일치 null반환
	public String check(String groupName, String code) throws SQLException {
		String sql = "SELECT groupId " + "FROM STUDYGROUP WHERE groupName = ? and code = ? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupName, code }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			if (rs.next()) {
				String gId = rs.getString(1);
				return gId;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	//그룹 가입
	public int addMember(Join join) throws SQLException {
		String sql = "INSERT INTO JOIN (userId, groupId, groupName) VALUES(?, ?, ?)";
		Object[] param = new Object[] { join.getUserId(), join.getGroupId(), join.getGroupName() };
		jdbcUtil.setSqlAndParameters(sql, param);

		try {
			int result = jdbcUtil.executeUpdate();
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close();
		}
		return 0;
	}
	
	//해당 그룹에 이미 가입했는지 체크
	public boolean alreadyJoin(String userId, String groupId) throws SQLException {
		String sql = "SELECT count(*) FROM JOIN WHERE userId=? and groupId = ?";      
		jdbcUtil.setSqlAndParameters(sql, new Object[] {userId, groupId});	// JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			if (rs.next()) {
				int count = rs.getInt(1);
				return (count == 1 ? true : false);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return false;
	}
	
	public List<Member> searchMemberByName(String memberName, String groupId)throws SQLException {
		String sql = "SELECT * FROM JOIN j, MEMBER m WHERE j.userId = m.userId and m.userName = ? and j.groupId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memberName, groupId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery();
			List<Member> findMembers = new ArrayList<>();
			while (rs.next()) { 
				Member member = new Member(		
						rs.getString("userId"),
						rs.getString("userName"),
						rs.getString("pwd"),
						rs.getString("phone"),
						rs.getString("birth"),
						rs.getString("email"));
				findMembers.add(member);
			}
			return findMembers;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();
		}
		return null;
	}

	public List<Member> getMember(String groupId)throws SQLException {
		String sql = "SELECT * FROM JOIN j, MEMBER m WHERE j.userId = m.userId and j.groupId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupId });

		try {
			ResultSet rs = jdbcUtil.executeQuery(); 
			List<Member> groupMembers = new ArrayList<>();
			while (rs.next()) { 
				Member member = new Member(		
						rs.getString("userId"),
						rs.getString("userName"),
						rs.getString("pwd"),
						rs.getString("phone"),
						rs.getString("birth"),
						rs.getString("email"));
				groupMembers.add(member);
			}
			return groupMembers;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	// 이름에 해당하는 모든 그룹 리스트 가져오기
	public List<Join> getGroupList(String groupName, String userId) {
		String sql = "SELECT * FROM Join where groupName like ? and userId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] {"%"+groupName+"%",  userId}); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<Join> joinList = new ArrayList<Join>();
			while (rs.next()) {
				Join join = new Join(rs.getString("userID"), rs.getString("groupId"), rs.getString("groupName"));
				joinList.add(join);
			}
			return joinList;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	public int memberCount(String groupId) {
		String sql = "SELECT COUNT(*) FROM GROUP where groupId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] {groupId}); 
		
		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			int count = rs.getInt(1);
			return count;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return -1;
	}
	
//	public List<Member> getMemberList(String memberName, String groupName) throws SQLException  {
//		String sql = "select distinct phone, email from member, join where member.userid = join.userid and userName = ? and groupName= ?";
//		jdbcUtil.setSqlAndParameters(sql, new Object[] {memberName,  groupName}); // JDBCUtil에 query문과 매개 변수 설정
//
//		try {
//			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
//			List<Member> memberList = new ArrayList<Member>();
//			while (rs.next()) {
//				Member mem = new Member(null, null, null, rs.getString("phone"), null, rs.getString("email"));
//				memberList.add(mem);
//			}
//			return memberList;
//
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			jdbcUtil.close(); // resource 반환
//		}
//		return null;
//	}
}
