package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import model.Dues;

public class DuesDAO {

	private JDBCUtil jdbcUtil = null;
	
	public DuesDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}
	
	public List<Dues> getList(String gid){
		String sql = "SELECT * FROM PAYMENT WHERE groupId = ? ";                        
		jdbcUtil.setSqlAndParameters(sql, new Object[]{gid});	// JDBCUtil에 query문과 매개 변수 설정
		
		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			List<Dues> duesList = new ArrayList<Dues>();	// dues 리스트 생성
			while (rs.next()) {
				Dues dues = new Dues(		
						rs.getString("duesId"),
						rs.getString("userId"),
						gid,
						rs.getString("duesDate"),
						rs.getInt("price"));
				duesList.add(dues);			// List에 Dues 객체 저장
			}		
			return duesList;					
				
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}

	//새로운 회비 납부내역 작성
	public int add(Dues dues) throws SQLException, ParseException {
		
		String sql = "insert into payment values('d'||LPAD(Sequence_duesId.nextval, 7, '0'), ?, ?, ?, ?)";

		
		Object[] param = new Object[] { 
				dues.getDuesId(), dues.getUserId(), dues.getGroupId(),
				dues.getDuesDate(), dues.getPrice() };				
		
		jdbcUtil.setSqlAndParameters(sql, param);	// JDBCUtil 에 insert문과 매개 변수 설정
						
		try {				
			int result = jdbcUtil.executeUpdate();	// insert 문 실행
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
	
	
}
