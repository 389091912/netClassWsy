package com.wsy.netClass.dao;

import java.util.List;

import com.wsy.netClass.entity.GoldPoints;


public interface GoldPointsDao {
	/**
	 *	签到添加经验值
	 */
	public void update(Integer id, Integer pointCount);
	
	/**
	 * 查询用户的积分
	 * @param goldPoints
	 * @return
	 */
	public List<GoldPoints> selectByUser(GoldPoints goldPoints);
	
	/**
	 * 查询当前用户的积分呢
	 * @param goldPoints
	 * @return
	 */
	public GoldPoints selectPointAndGold(GoldPoints goldPoints);
	
	/**
	 * 用户积分兑换
	 * @param goldPoints
	 */
	public void insertGoldPoints(GoldPoints goldPoints);
	
	
	/**
	 * 根据 ID 查询 用户的 金币
	 * @param userId
	 * @return
	 */
	public GoldPoints selectGpByUserId(Integer userId);
	
	/**
	 * 根据 id 修改用户 金币状况
	 * @param goldPoints
	 */
	public void updateGpByUserId(GoldPoints goldPoints);
	
}
