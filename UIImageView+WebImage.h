//
//  UIImageView+WebImage.h
//  HMWebImage
//
//  Created by 韩萌 on 16/5/27.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

/**
 *  一句话下载并且显示图片
 *
 *  @param urlString        图片下载地址
 *  @param placeholderImage 占位图片
 */
- (void)hm_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

@end









