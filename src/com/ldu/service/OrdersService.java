package com.ldu.service;

import java.util.List;

import com.ldu.pojo.Orders;

public interface OrdersService {
	
	public List<Orders> getOrdersByUserId(Integer user_id);
	
	public List<Orders> getOrdersByUserAndGoods(Integer user_id);

	public void addOrders(Orders orders);

	public void deliverByOrderNum(Integer id);

	public void receiptByOrderNum(Integer id);

	public int getOrdersNum();

	public List<Orders> getPageOrders(int pageNum, int pageSize);

	public Orders getOrdersById(int ordersId);


	public void updateByPrimaryKey(Integer id, Orders orders);

	public void deleteOrdersByPrimaryKeys(int parseInt);

	public List<Orders> getPageOrdersByOrders(String orderInformation, Integer orderState, int pageNum,
											  int pageSize);

}
