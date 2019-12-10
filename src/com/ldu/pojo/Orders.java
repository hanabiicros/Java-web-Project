package com.ldu.pojo;

import java.util.List;

/**
 * 订单
 *
 */
public class Orders {
	private Integer id;

	private Integer userId;
    
	private List<Goods> goods;
	
	private Integer goodsNum;
    
    private Float orderPrice;

    private Integer orderState;
    
    private String orderInformation;

    private String orderDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}



	

	public List<Goods> getGoods() {
		return goods;
	}

	public void setGoods(List<Goods> goods) {
		this.goods = goods;
	}

	public Float getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(Float orderPrice) {
		this.orderPrice = orderPrice;
	}

	public Integer getOrderState() {
		return orderState;
	}

	public void setOrderState(Integer orderState) {
		this.orderState = orderState;
	}

	public String getOrderInformation() {
		return orderInformation;
	}

	public void setOrderInformation(String orderInformation) {
		this.orderInformation = orderInformation;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public Integer getGoodsNum() {
		return goodsNum;
	}

	public void setGoodsNum(Integer goodsNum) {
		this.goodsNum = goodsNum;
	}

	@Override
	public String toString() {
		return "Orders [id=" + id + ", userId=" + userId + ", goods=" + goods + ", goodsNum=" + goodsNum
				+ ", orderPrice=" + orderPrice + ", orderState=" + orderState + ", orderInformation=" + orderInformation
				+ ", orderDate=" + orderDate + "]";
	}


	

	

}
