package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import model.Payment;

public class PaymentDAO {

	private JDBCUtil jdbcUtil = null;
	
	public PaymentDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}
	
	public List<Payment> getList(String gid){
		String sql = "SELECT * FROM PAYMENT WHERE groupId = ? ";                        
		jdbcUtil.setSqlAndParameters(sql, new Object[]{gid});	// JDBCUtil에 query문과 매개 변수 설정
		
		try {
			ResultSet rs = jdbcUtil.executeQuery();		// query 실행
			List<Payment> paymentList = new ArrayList<Payment>();	// payment 리스트 생성
			while (rs.next()) {
				Payment payment = new Payment(		
						gid,
						rs.getString("paymentDate"),
						rs.getInt("price"),
						rs.getString("paymentDescription"),
						rs.getString("paymentId"));
				paymentList.add(payment);			// List에 Payment 객체 저장
			}		
			return paymentList;					
				
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			jdbcUtil.close();		// resource 반환
		}
		return null;
	}

	//회비 지출내역 작성
	public int add(Payment payment) throws SQLException, ParseException {
		
		String sql = "insert into payment values(?, ?, ?, ?, 'p'||LPAD(Sequence_paymentId.nextval, 7, '0')";

		
		Object[] param = new Object[] { 
				payment.getGroupId(), payment.getPaymentDate(), payment.getPrice(),
				payment.getPaymentDescription(), payment.getPaymentId() };				
		
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
