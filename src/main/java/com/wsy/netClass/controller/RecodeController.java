package com.wsy.netClass.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageInfo;
import com.wsy.netClass.constant.Constant;
import com.wsy.netClass.constant.ResponseCodeConstant;
import com.wsy.netClass.entity.GoldPoints;
import com.wsy.netClass.entity.User;
import com.wsy.netClass.exception.PointException;
import com.wsy.netClass.service.GoldPointsService;
import com.wsy.netClass.until.ParameterUtil;
import com.wsy.netClass.until.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;

@Controller
@RequestMapping("/recode")
public class RecodeController {

	@Autowired
	private GoldPointsService goldPointsService;

	@RequestMapping("/findAllByUser")
	public String findAllByUser(HttpServletRequest request,HttpServletResponse response){
		   String pageNo=request.getParameter("pageNo");
		   String pageSize=request.getParameter("pageSize");
		   if(ParameterUtil.isNull(pageNo)){
				pageNo= Constant.PAGE_NO_DEFAULT;
			}
			if(ParameterUtil.isNull(pageSize)){
				pageSize=Constant.PAGE_SIZE_DEFAULT;
			}
			User user=(User) request.getAttribute("user");
			GoldPoints goldPoints=new GoldPoints();
//			System.out.println(user.getId()+"+++++++++...");
			goldPoints.setUserId(1);
			GoldPoints goldPoint=goldPointsService.findPointAndGold(goldPoints);
			PageInfo<GoldPoints> pageGoldPoints=goldPointsService.findAllByUser(Integer.parseInt(pageNo), goldPoints);
			request.setAttribute("pageGoldPoints", pageGoldPoints);
		return "front_record";
		
	}
	
	@RequestMapping("/modifyPoint")
	@ResponseBody
	public ResponseResult modifyPoint(HttpServletRequest request, HttpServletResponse response) {
		//分页查询积分操作数据和用户当前积分和金币
        ResponseResult result = new ResponseResult();
        String point= request.getParameter("point");

		try{
			GoldPoints goldPoints=new GoldPoints();
			User user=(User) request.getAttribute("user");
			
			goldPoints.setUserId(1);;
			goldPoints.setPointCount(Integer.parseInt(point));
			goldPointsService.modifyGoldPoints(goldPoints);
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_SUCCESS );

		}catch(PointException e){
            result.setResponseCode( ResponseCodeConstant.RESPONSE_CODE_FAIL );
            result.setMessage( e.getMessage() );
			e.printStackTrace();
			/*request.setAttribute("errorMsg", e.getMessage());*/
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
