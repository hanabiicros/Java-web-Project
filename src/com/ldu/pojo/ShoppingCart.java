package com.ldu.pojo;

public class ShoppingCart {

	private Integer id;

    private Integer goodsId;

    private Integer userId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	@Override
	public String toString() {
		return "ShoppingCart [id=" + id + ", goodsId=" + goodsId + ", userId=" + userId + "]";
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
}
