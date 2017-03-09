//
//  MyNewsObj.h
//  newsListDemo
//
//  Created by 梁家伟 on 17/3/8.
//  Copyright © 2017年 itcast. All rights reserved.
//
/*
 
 "id": "567846",
 "type_id": "4",
 "title": "微信增仅向朋友展示半年的朋友圈功能 原因在这里",
 "summary": "雷帝网乐天3月8日报道近期，微信增加了“仅向朋友展示半年的朋友圈”功能，引发了一部分网友的关注。对此...",
 "img": "http://news.coolban.com/Upload/thumb/170308/80-60-13005112D-0.jpg",
 "src_img": "http://g.hiphotos.baidu.com/news/w%3D638/sign=247bf6996bd0f703e6b296df30fb5148/0d338744ebf81a4cff674c47de2a6059242da6e3.jpg",
 "sitename": "百家自媒体",
 "addtime": "1488953785",
 "use_thumb": false
 
 */
#import <Foundation/Foundation.h>

@interface MyNewsObj : NSObject
/**
 新闻id
 */
@property(nonatomic,copy)NSString* id;

/**
 新闻类型id
 */
@property(nonatomic,copy)NSString* type_id;

/**
 新闻标题
 */
@property(nonatomic,copy)NSString* title;

/**
 新闻summary
 */
@property(nonatomic,copy)NSString* summary;
/**
 新闻img
 */
@property(nonatomic,copy)NSString* img;
/**
 新闻图片
 */
@property(nonatomic,copy)NSString* src_img;
/**
 新闻来源
 */
@property(nonatomic,copy)NSString* sitename;
/**
 新闻发布时间
 */
@property(nonatomic,copy)NSString* addtime;
/**
 是否使用缩略图
 */
@property(nonatomic,assign)BOOL use_thumb;
@end
