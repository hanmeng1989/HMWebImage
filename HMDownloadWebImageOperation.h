//
//  HMDownloadWebImageOperation.h
//  HMWebImage
//
//  Created by 韩萌 on 16/5/27.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HMDownloadWebImageOperation;

// 定义block
typedef void(^completionBlock)(HMDownloadWebImageOperation *operation);

@interface HMDownloadWebImageOperation : NSOperation

/**
 *  从网络下载的图片
 */
@property (nonatomic,strong) UIImage *image;

/**
 *  图片下载地址
 */
@property (nonatomic,copy) NSString *urlString;

/**
 *  图片下载完成后的回调block
 */
@property (nonatomic,copy) completionBlock block;


/**
 *  自定义操作的实例化方法
 *
 *  @param urlStr           图片下载地址
 *  @param completionHandle 图片下载完成后的回调函数
 *
 *  @return 图片下载操作
 */
+ (instancetype)downloadWebImageWithUrlString:(NSString *)urlStr completionHandle:(completionBlock)completionHandle;

@end
