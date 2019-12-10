package com.ldu.dao;

import java.util.List;

import com.ldu.pojo.OrdersGoods;

public interface OrdersGoodsMapper {

	public void addOrdersGoods(OrdersGoods ordersGoods);
	
	public List<Integer> getOrdersGoodsByOrdersId(Integer ordersId);
}
