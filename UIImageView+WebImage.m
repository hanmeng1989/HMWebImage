//
//  UIImageView+WebImage.m
//  HMWebImage
//
//  Created by 韩萌 on 16/5/27.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "HMWebImageManager.h"

@implementation UIImageView (WebImage)

- (void)hm_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage{
    
    // 0.显示图片，在没有图片的时候，先显示占位图片
    self.image = placeholderImage;
    
    // 1.下载图片
    // 提供一个管理类HMWebImageManager，用来负责协调图片的（缓存、下载）
    
    // 1.1 实例化管理对象
    HMWebImageManager *manager = [HMWebImageManager sharedManager];
    
    // 1.2 管理图片
    [manager setupWithUrlString:urlString setupImageHandle:^(UIImage *image) {
        self.image = image;
    }];
}

@end
