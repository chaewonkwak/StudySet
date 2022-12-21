package model.dao;
// MyBatis

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import model.Memo;
import model.dao.mapper.MemoMapper;

public class MemoDAO {
	private SqlSessionFactory sqlSessionFactory;

	public MemoDAO() {
		String resource = "mybatis-config.xml";
		InputStream inputStream;
		
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			throw new IllegalArgumentException(e);
		}
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
	}
	
	public int addMemo(Memo memo, String userId, String groupId) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			int result = sqlSession.getMapper(MemoMapper.class).addMemo(memo, userId, groupId);
			if (result > 0) {
				sqlSession.commit();
			} 
			return 0;
		} finally {
			sqlSession.close();
		}
	}
	
	public Memo getMemo(String memoId) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.getMapper(MemoMapper.class).getMemo(memoId);			
		} finally {
			sqlSession.close();
		}
	}
	
	public List<Memo> getList(String groupId, String userId) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			return sqlSession.getMapper(MemoMapper.class).getList(groupId, userId);			
		} finally {
			sqlSession.close();
		}
	}

	
	/**
	
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.util.ArrayList;
	import java.util.List;
	
	public class MemoDAO {
	
	private JDBCUtil jdbcUtil = null;
	
	public ScheduleDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}
	
	// 메모 작성
	public int addMemo(Memo memo, String userId, String groupId) throws SQLException, ParseException {
		String sql = "INSERT INTO MEMO VALUES( 'm'||SEQUENCE_MEMOID.NEXTVAL, ?, ?, ? )";
		
		Object[] param = new Object[] { userId, groupId, memo.getMemoContents() };
		
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
	
	// 메모리스트 가져오기 (모든 원소 다 가져오나?) + 매개변수 userId
	public List<Memo> getList(String groupId, String userId) {
		String sql = "SELECT * FROM MEMO WHERE groupId = ? AND userId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { groupId, userId });
		
		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			List<Memo> memoList = new ArrayList<Memo>();
			while (rs.next()) {
				Memo memo = new Memo(
						rs.getString("memoId"), 
						rs.getString("userId"),
						rs.getString("groupId"), 
						rs.getString("memoContents"));
				memoList.add(memo);
			}
			return memoList;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	// 메모 가져오기 (매개변수: memoId)
	public Memo getMemo(String memoId) {
		String sql = "SELECT * FROM MEMO WHERE memoId = ?";
		jdbcUtil.setSqlAndParameters(sql, new Object[] { memoId });
		
		try {
			ResultSet rs = jdbcUtil.executeQuery(); // query 실행
			
			if (rs.next()) {
				Memo memo = new Memo(
						rs.getString("memoId"), 
						rs.getString("userId"),
						rs.getString("groupId"), 
						rs.getString("memoContents"));
				return memo;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close(); // resource 반환
		}
		return null;
	}
	
	
	// 메모 삭제
	
	// 메모 수정
	**/
}
