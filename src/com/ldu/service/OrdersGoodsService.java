package com.ldu.service;


import java.util.List;

import com.ldu.pojo.OrdersGoods;

public interface OrdersGoodsService {

	public void addOrdersGoods(OrdersGoods ordersGoods);
	
	public List<Integer> getOrdersGoodsByOrdersId(Integer ordersId);
}
