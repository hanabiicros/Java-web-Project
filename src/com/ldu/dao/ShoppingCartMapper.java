package com.ldu.dao;

import java.util.List;

import com.ldu.pojo.ShoppingCart;

public interface ShoppingCartMapper {

	/**
     * 查询登录用户购物车中的所有商品
     * @param user_id
     * @return
     */
    public List<ShoppingCart> getShoppingCartByUserId(Integer user_id);
    
    /**
     * 根据用户id和关注id删除购物车中的商品
     * @param id 关注id
     * @param user_id 用户id
     */
    
    public void deleteShoppingCartByUserIdAndGoodsId(Integer goods_id, Integer user_id);

    /**
     * 添加到购物车
     * @param goods_id
     * @param user_id
     */
	public void addShoppingCartByUserIdAndGoodsId(Integer goods_id, Integer user_id);
}
