package com.ldu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ldu.dao.OrdersGoodsMapper;
import com.ldu.pojo.OrdersGoods;
import com.ldu.service.OrdersGoodsService;

@Service("ordersGoodsService")
public class OrdersGoodsServiceImpl implements OrdersGoodsService{

	
	@Resource
	private OrdersGoodsMapper ordersGoodsMapper;
	
	@Override
	public void addOrdersGoods(OrdersGoods ordersGoods) {
		// TODO Auto-generated method stub
		
		ordersGoodsMapper.addOrdersGoods(ordersGoods);
	}

	@Override
	public List<Integer> getOrdersGoodsByOrdersId(Integer ordersId) {
		// TODO Auto-generated method stub
		List<Integer> goodsIds = ordersGoodsMapper.getOrdersGoodsByOrdersId(ordersId);
		return goodsIds;
	}
	
	
}
