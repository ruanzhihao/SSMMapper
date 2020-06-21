package com.java.ssm.cotroller;

import java.io.IOException;
import java.util.List;

import com.alibaba.fastjson.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.java.ssm.entity.User;
import com.java.ssm.service.UserDaoService;
import javax.servlet.http.HttpServletResponse;

@Controller
public class UserController {
	@Autowired
	private UserDaoService userDaoService;

	@RequestMapping(value = "saveUser")
	public void insertUser(String userName,String userPassword,String email, String sign,HttpServletResponse response)throws IOException {
		User user = new User();
		user.setEmail(email);
		user.setUserName(userName);
		user.setUserPassword(userPassword);
		user.setSign(sign);
		int i = userDaoService.insertUserService(user);
		response.getWriter().print(i);
	}



@RequestMapping(value = "selectAllUserJson")
	public void selectAllUserJson(HttpServletResponse response) throws IOException {
		List<User> list = userDaoService.selectAllUserService();
		System.out.println(list);
		System.out.println(JSONArray.toJSON(list));
		response.getWriter().print(JSONArray.toJSON(list));
	}

@RequestMapping(value = "deleteUser/{id}")
public void  deleteUser(@PathVariable Integer id,HttpServletResponse response) throws IOException {
	int i=userDaoService.deleteUser(id);
	response.getWriter().print(i);
}

	@RequestMapping(value = "updateUser")
	@ResponseBody
	public void updateUser(Long id,String userName,String userPassword,String email, String sign,HttpServletResponse response)throws IOException {
		User user=new User();
		user.setId(id);
		user.setSign(sign);
		user.setUserPassword(userPassword);
		user.setUserName(userName);
		user.setEmail(email);
	    int row=userDaoService.updateUser(user);
		System.out.println(row);
		response.getWriter().print(row);
	}


	@RequestMapping(value = "selectUserById/{id}")
	public void selectUser(@PathVariable Integer id,HttpServletResponse response)throws IOException {
		User user = userDaoService.selectUserService(id);
		response.getWriter().print(JSONArray.toJSON(user));
	}
}
