package com.ldu.service;

import java.util.List;

import com.ldu.pojo.ShoppingCart;

public interface ShoppingCartService {

	/**
     * 根据用户的id，查询出该用户购物车中的所有商品
     * @param user_id
     * @return
     */
    public List<ShoppingCart> getShoppingCartByUserId(Integer user_id);
    
    /**
     * 根据用户id和关注id删除我的购物车中的商品
     * @param id
     * @param user_id 用户id
     */
    public void deleteShoppingCartByUserIdAndGoodsId(Integer goods_id, Integer user_id);

    /**
     * 添加到购物车
     * @param id
     * @param user_id 用户id
     */
	public void addShoppingCartByUserIdAndId(Integer goods_id, Integer user_id);

}
