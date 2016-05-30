//
//  HMDownloadWebImageOperation.m
//  HMWebImage
//
//  Created by 韩萌 on 16/5/27.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMDownloadWebImageOperation.h"
#import "NSString+SandBoxPath.h"

@implementation HMDownloadWebImageOperation


+(instancetype)downloadWebImageWithUrlString:(NSString *)urlStr completionHandle:(completionBlock)completionHandle{

    HMDownloadWebImageOperation *op = [[HMDownloadWebImageOperation alloc] init];
    
    // 图片下载地址
    op.urlString = urlStr;
    
    // 图片下载完成后的回调
    op.block = completionHandle;

    return op;
}

- (void)main{

    @autoreleasepool {
        
        NSLog(@"开始下载图片");
        
        // 1.获取图片下载地址URL
        NSURL *url = [NSURL URLWithString:self.urlString];
        
        // 2.根据URL下载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 2.1 如果图片存在，保存到沙盒中
        if (data) {
            [data writeToFile:[self.urlString sandBoxFilePath] atomically:YES];
        }
        
        // 3.将二进制数据转换为图片
        UIImage *image = [UIImage imageWithData:data];
        
        self.image = image;
        
        // 4.图片下载完成之后的回调
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.block) {
                self.block(self);
            }
        });
    }
}

@end
