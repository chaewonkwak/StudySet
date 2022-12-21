package model.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import model.SubmitComment;
import model.MemoComment;
import model.Task;
import model.Memo;
import model.dao.CommentDAO;



public class CommentManager {
	private static CommentManager commentManager = new CommentManager();
	private CommentDAO commentDao;

	private CommentManager() {
		try {
			commentDao = new CommentDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static CommentManager getInstance() {
		return commentManager;
	}

	public int addSubmitComment(SubmitComment submitComment, String submitId) throws SQLException, ParseException {
		return commentDao.addSubmitComment(submitComment, submitId);
	}
	
	public List<SubmitComment> getSubmitCommentList(String submitId) throws SQLException {
		List<SubmitComment> commentList = commentDao.getSubmitCommentList(submitId);
		return commentList;
	}
	
	public int addMemoComment(MemoComment memoComment, String memoId) throws SQLException, ParseException {
		return commentDao.addMemoComment(memoComment, memoId);
	}
	
	public List<MemoComment> getMemoCommentList(String memoId) throws SQLException {
		List<MemoComment> commentList = commentDao.getMemoCommentList(memoId);
		return commentList;
	}

}