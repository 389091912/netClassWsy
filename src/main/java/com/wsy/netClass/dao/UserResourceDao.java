package com.wsy.netClass.dao;

import java.util.Date;
import java.util.List;


import com.wsy.netClass.entity.UserResource;

public interface UserResourceDao {
		
	/**
	 * 根据 userID 和 resourceId 判断 用户是否已购买  

	 * @return 返回null 便要支付购买
	 */
	public UserResource selectUrByAndId(UserResource userResource);

	public List<UserResource> selectUserResource(UserResource userResource);





	/**
	 * 添加 用户购买 信息
	 * @param userResource
	 */
	public void insertUr(UserResource userResource);

	/**
	 * 跟新用户 查看资源 时间
	 *
	 */
	public void updateUpdateByTwoId(UserResource userResource);
	
	
}
