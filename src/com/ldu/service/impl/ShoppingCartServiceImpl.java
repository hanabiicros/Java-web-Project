package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ldu.dao.ShoppingCartMapper;
import com.ldu.pojo.ShoppingCart;
import com.ldu.service.ShoppingCartService;

@Service("shoppingcartService")
public class ShoppingCartServiceImpl implements ShoppingCartService {
	@Resource
	 private ShoppingCartMapper shoppingcartMapper;

	 /**
	  * 根据用户id获取我的关注
	  */
	 public List<ShoppingCart> getShoppingCartByUserId(Integer user_id) {
		List<ShoppingCart> shoppingcartList = shoppingcartMapper.getShoppingCartByUserId(user_id);
				
       return shoppingcartList;
	}
	 
	 /*
	  * 根据用户id和关注id删除
	  */

	public void deleteShoppingCartByUserIdAndGoodsId(Integer goods_id, Integer user_id) {
		
		shoppingcartMapper.deleteShoppingCartByUserIdAndGoodsId(goods_id, user_id);
		
	}
	/*
	  * 添加我的关注
	  */
	public void addShoppingCartByUserIdAndId(Integer goods_id, Integer user_id) {
		
		shoppingcartMapper.addShoppingCartByUserIdAndGoodsId(goods_id,user_id);
		
	}

}
