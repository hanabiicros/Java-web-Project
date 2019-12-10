package com.ldu.pojo;

public class OrdersGoods {

	private Integer id;
	@Override
	public String toString() {
		return "OrdersGoods [id=" + id + ", goodsId=" + goodsId + ", ordersId=" + ordersId + "]";
	}
	private Integer goodsId;
	private Integer ordersId;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}
	public Integer getOrdersId() {
		return ordersId;
	}
	public void setOrdersId(Integer ordersId) {
		this.ordersId = ordersId;
	}
}
