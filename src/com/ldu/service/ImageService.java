package com.ldu.service;

import java.util.List;

import com.ldu.pojo.Image;

/**
 * 
 */
public interface ImageService {
    int insert(Image record);
    
    int insertOther(Image record);
    /**
     * 通过商品id获取该商品的图片
     * @param goodsId
     * @return
     */
    public List<Image> getImagesByGoodsPrimaryKey(Integer goodsId);

    /**
     * 通过商品Id删除商品
     * @param goodsId
     * @return
     */
    int deleteImagesByGoodsPrimaryKey(Integer goodsId);
}