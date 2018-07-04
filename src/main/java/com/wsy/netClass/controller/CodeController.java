package com.wsy.netClass.controller;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.wsy.netClass.until.AjaxResult;
import com.wsy.netClass.until.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
@RequestMapping("/code")
public class CodeController {

	@RequestMapping("/getCodeImage")
	public void getCodeImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String numStr = request.getParameter("num");
		CommonUtil.MyImage m = null;
		if(null == numStr){
			numStr = "0";
		}
		int num = 0;
		try {
			num = Integer.parseInt(numStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		switch (num) {
			case 0:
				String codeStr = request.getParameter("codeStr");
				if(null == codeStr){
					codeStr = CommonUtil.randomCode();
				}
				//用自己的字符串来生成图片
				m = CommonUtil.getImage(null, codeStr, true);
				break;
			case 1:
				//使用中文验证码,有干扰线
				m = CommonUtil.getImage(null, 4, true, true);	
				break;
			case 2:
				//使用中文验证码,没有干扰线
				m = CommonUtil.getImage(null, 4, true, false);
				break;
			case 3:
				//使用数字和字母(4个)验证码,有干扰线
				m = CommonUtil.getImage(null, 4, false, true);
				break;
			case 4:
				//使用数字和字母(4个)验证码,没有干扰线
				m = CommonUtil.getImage(null, 4, false, false);
				break;
			default:
				//使用数字和字母验证码,有干扰线
				m = CommonUtil.getImage(null, num, false, true);
				break;
		}
		System.out.println("code=" + m.getCode());
		request.getSession().setAttribute("code", m.getCode());
		ServletOutputStream out = response.getOutputStream();
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(m.getImage());
	}
	
	@RequestMapping("/getCodeStr")
	@ResponseBody
	public AjaxResult getCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		AjaxResult ar = new AjaxResult();
		String code = (String) request.getSession().getAttribute("code");
		ar.setSuccess(true);
		ar.setMsg("获取code成功");
		ar.setObj(code);
		return ar;
	}
	
}
