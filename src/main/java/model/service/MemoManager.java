package model.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import model.Join;
import model.StudyGroup;
import model.Memo;
import model.dao.*;

public class MemoManager {
	private static MemoManager memoManager = new MemoManager();
	private MemoDAO memoDao;

	private MemoManager() {
		try {
			memoDao = new MemoDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static MemoManager getInstance() {
		return memoManager;
	}

	public int addMemo(Memo memo, String groupId, String userId) throws SQLException, ParseException {
		return memoDao.addMemo(memo, groupId, userId);
	}

	public List<Memo> getList(String groupId, String userId) throws SQLException {
		List<Memo> memoList = memoDao.getList(groupId, userId);
		return memoList;
	}

	public Memo getMemo(String memoId) throws SQLException {
		Memo memo = memoDao.getMemo(memoId);
		return memo;
	}

}