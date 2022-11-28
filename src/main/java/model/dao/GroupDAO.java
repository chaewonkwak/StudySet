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
		jdbcUtil.setSqlAndParameters(sql, param); // JDBCUtil 에 insert문과 매개 변수 설정
		
		String sql2 = "INSERT INTO JOIN (userId, groupId, groupName) VALUES(?, 'g'||LPAD(Sequence_gId.currval,  7, '0'), ?)";
		Object[] param2 = new Object[] { userId, studyGroup.getGroupName() };
		try {				
			int result = jdbcUtil.executeUpdate();	// insert 문 실행
			jdbcUtil.setSqlAndParameters(sql2, param2);
			result = jdbcUtil.executeUpdate();
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {		
			jdbcUtil.commit();
			jdbcUtil.close();	// resource 반환
		}		
		return 0;	
	}

	// 그룹이름으로 검색
	public StudyGroup search(String groupName) throws SQLException {
		String sql = "SELECT * " + "FROM STUDYGROUP " + "WHERE groupName = ? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupName }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			if (rs.next()) { // 학생 정보 발견
				StudyGroup group = new StudyGroup( // User 객체를 생성하여 학생 정보를 저장
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

	// 그룹 이름, 코드로 가입 -> 일치 true반환/ 불일치 false반환
	public boolean check(String groupName, String code) throws SQLException {
		String sql = "SELECT count(*) " + "FROM STUDYGROUP WHERE groupName = ? and code = ? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupName, code }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			if (rs.next()) {
				int count = rs.getInt(1);
				return (count == 1 ? true : false);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return false;
	}

	//그룹 가입
	public int addMember(Join join) throws SQLException, ParseException {
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
	
	public List<Member> searchMemberByName(String memberName, String groupId)throws SQLException {
		String sql = "SELECT * FROM JOIN j, MEMBER m WHERE j.userId = m.userId and m.userName = ? and j.groupId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memberName, groupId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<Member> findMembers = new ArrayList<>();
			while (rs.next()) { // 학생 정보 발견
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
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

}