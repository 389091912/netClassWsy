package com.wsy.netClass.service;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.entity.GoldPoints;
import com.wsy.netClass.exception.PointException;

import java.text.ParseException;


public interface GoldPointsService {
	
	public PageInfo<GoldPoints> findAllByUser(int pageNo, GoldPoints goldPoints);
	
	public GoldPoints findPointAndGold(GoldPoints goldPoints);
	
	public void modifyGoldPoints(GoldPoints goldPoints) throws PointException, ParseException;
	
	public void modifyById(Integer id, Integer pointCount);
}
