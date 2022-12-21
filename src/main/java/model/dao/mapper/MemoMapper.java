package model.dao.mapper;

import java.util.List;
import model.Memo;


public interface MemoMapper {
	
	public int addMemo(Memo memo, String userId, String groupId);
	
	public List<Memo> getList(String groupId, String userId);
	
	public Memo getMemo(String memoId);

}

