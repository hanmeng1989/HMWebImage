//
//  HMWebImageManager.h
//  HMWebImage
//
//  Created by 韩萌 on 16/5/27.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^setupImageBlock)(UIImage *image);

@interface HMWebImageManager : NSObject

/**
 *  操作管理类：协调UIImageView的显示和图片的缓存；一般对应管理类来说，只有一个对象比较好。
 *  如果有多个对象，每一个对象都需要管理图片缓存：相当于一个对象管理一张图片
 *  如果将管理类做成一个单例对象：相当于一个对象管理多张图片
 */

// 单例方法
+ (instancetype)sharedManager;

// 提供一个管理图片的方法
- (void)setupWithUrlString:(NSString *)urlString setupImageHandle:(setupImageBlock)setupImageHandle;

@end
