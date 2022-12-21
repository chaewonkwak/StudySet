package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import model.MemoComment;
import model.SubmitComment;

public class CommentDAO {
	private JDBCUtil jdbcUtil = null;

	public CommentDAO() {
		jdbcUtil = new JDBCUtil(); // JDBCUtil 객체 생성
	}

	// memo댓글 작성
	public int addMemoComment(MemoComment memoComment, String memoId) throws SQLException, ParseException {
		SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD");

		String sql = "INSERT INTO MemoComment VALUES( " + "'c'||LPAD(SEQUENCE_COMMENTID.nextval, 7, '0')" + ", ?, ?, ?, ?, SYSDATE )";

		Object[] param = new Object[] { memoComment.getUserId(), memoId, memoComment.getCommentContents(),
				memoComment.getAnnonymous(), memoComment.getMemoDate() };
		jdbcUtil.setSqlAndParameters(sql, param); // JDBCUtil 에 insert문과 매개 변수 설정

		try {
			int result = jdbcUtil.executeUpdate(); // insert 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}
		return 0;
	}

	// memo댓글 리스트 가져오기
	public List<MemoComment> getMemoCommentList(String memoId) {
		String sql = "SELECT * FROM MemoComment WHERE memoId = ? ";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memoId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<MemoComment> memoCommentList = new ArrayList<MemoComment>();
			while (rs.next()) {
				MemoComment memoComment = new MemoComment(
						rs.getString("commentId"), 
						rs.getString("userId"),
						rs.getString("memoId"), 
						rs.getString("commentContents"), 
						rs.getString("annonymous").charAt(0),
						rs.getString("memoDate"));
				memoCommentList.add(memoComment);
			}
			return memoCommentList;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}

	// submit 댓글 작성
	public int addSubmitComment(SubmitComment submitComment, String submitId) throws SQLException, ParseException {
		SimpleDateFormat formatter = new SimpleDateFormat("YYYYMMDD");
		String sql = "INSERT INTO SubmitComment VALUES('c'||LPAD(SEQUENCE_COMMENTID.nextval, 7, '0'), ?, ?, ?, ?, sysdate)";

		Object[] param = new Object[] { submitComment.getUserId(), submitComment.getCommentContents(),
				submitComment.getAnnonymous(), submitId};
		jdbcUtil.setSqlAndParameters(sql, param); // JDBCUtil 에 insert문과 매개 변수 설정

		try {
			int result = jdbcUtil.executeUpdate(); // insert 문 실행
			return result;
		} catch (Exception ex) {
			jdbcUtil.rollback();
			ex.printStackTrace();
		} finally {
			jdbcUtil.commit();
			jdbcUtil.close(); // resource 반환
		}
		return 0;
	}

	// submit댓글 리스트 가져오기
	public List<SubmitComment> getSubmitCommentList(String submitId) {
		String sql = "SELECT * FROM SubmitComment WHERE submitId = ? Order By commentDate";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { submitId }); // JDBCUtil에 query문과 매개 변수 설정

		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<SubmitComment> submitCommentList = new ArrayList<SubmitComment>();
			while (rs.next()) {
				SubmitComment submitComment = new SubmitComment(
						rs.getString("commentId"), 
						rs.getString("userId"),
						rs.getString("commentContents"), 
						rs.getString("annonymous").charAt(0), 
						rs.getString("submitId"),
						rs.getString("commentDate"));
				submitCommentList.add(submitComment);
			}
			return submitCommentList;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
}
