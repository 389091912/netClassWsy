package com.wsy.netClass.service.impl;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.dao.GoldPointsDao;
import com.wsy.netClass.entity.GoldPoints;
import com.wsy.netClass.exception.PointException;
import com.wsy.netClass.service.GoldPointsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GoldPointsServiceImpl implements GoldPointsService {

	@Autowired
	private GoldPointsDao goldPointsDao;


	@Override
	public PageInfo<GoldPoints> findAllByUser(int pageNo, GoldPoints goldPoints) {
		// TODO Auto-generated method stub

		
		PageHelper.startPage(pageNo, Constant.PAGE_SIZE);
		List<GoldPoints> list = goldPointsDao.selectByUser(goldPoints);
		PageInfo<GoldPoints> pageGoldpoints = new PageInfo<GoldPoints>(list);
		
		return pageGoldpoints;
	}

	@Override
	public void modifyGoldPoints(GoldPoints goldPoints) throws PointException, ParseException {

		Integer point=goldPoints.getPointCount();

		GoldPoints goldPoint01=goldPointsDao.selectPointAndGold(goldPoints);

		Integer pointCount=goldPoint01.getPointCount();

		if(point>=10){
			Integer i=point/10;
			if(pointCount>=(10*i)){

				goldPoints.setInfo("消耗积分");
				goldPoints.setPointCount(-(10*i));
				goldPoints.setGoldCount(0);
                SimpleDateFormat df = new SimpleDateFormat( "yyyy-MM-dd hh : mm :ss " );
                Calendar date1 = Calendar.getInstance();
                date1.getTime();
				goldPointsDao.insertGoldPoints(goldPoints);

                GoldPoints points = new GoldPoints();
                points.setInfo("积分兑换金币所得");
                points.setPointCount(0);
                points.setGoldCount(i);
                points.setUserId( goldPoints.getUserId()  );
				goldPointsDao.insertGoldPoints(points);
				
			}else{
				throw new PointException("积分不足");
			}
			
		}else{
			throw new PointException("积分输入有误");
		}
		
		
		
	}

	@Override
	public GoldPoints findPointAndGold(GoldPoints goldPoints) {

		
		return goldPointsDao.selectPointAndGold(goldPoints);
	}

	@Override
	public void modifyById(Integer id, Integer pointCount) {

		try {
			goldPointsDao.update(id, pointCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}


	
}
