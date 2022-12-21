package model;

public class Memo {

	String memoId;
	String userId;
	String groupId;
	String memoContents;
	
	public Memo() {
		super();
	}
	
	public Memo(String memoId, String memoContents) {
		super();
		this.memoId = memoId;
		this.memoContents = memoContents;
	}
	
	public Memo(String userId, String groupId, String memoContents) {
		super();
		this.userId = userId;
		this.groupId = groupId;
		this.memoContents = memoContents;
	}

	public Memo(String memoId, String userId, String groupId, String memoContents) {
		super();
		this.memoId = memoId;
		this.userId = userId;
		this.groupId = groupId;
		this.memoContents = memoContents;
	}

	public String getMemoId() {
		return memoId;
	}

	public void setMemoId(String memoId) {
		this.memoId = memoId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getMemoContents() {
		return memoContents;
	}

	public void setMemoContents(String memoContents) {
		this.memoContents = memoContents;
	}

	@Override
	public String toString() {
		return "memo [memoId=" + memoId + ", userId=" + userId + ", groupId=" + groupId + ", memoContents="
				+ memoContents + "]";
	}
	
}
