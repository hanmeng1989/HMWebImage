//
//  HMWebImageManager.m
//  HMWebImage
//
//  Created by 韩萌 on 16/5/27.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMWebImageManager.h"
#import "HMDownloadWebImageOperation.h"
#import "NSString+SandBoxPath.h"

@interface HMWebImageManager ()

/**
 *  非主队列
 */
@property (nonatomic,strong) NSOperationQueue *queue;

/**
 *  内存缓存
 */
@property (nonatomic,strong) NSMutableDictionary *images;

/**
 *  操作缓存
 */
@property (nonatomic,strong) NSMutableDictionary *operations;

@end

@implementation HMWebImageManager

- (void)setupWithUrlString:(NSString *)urlString setupImageHandle:(setupImageBlock)setupImageHandle{

    // 0.先检查图片缓存中是否存在图片
    UIImage *image = self.images[urlString];
    
    if (image) { // 若内存缓存中存在图片，则直接显示
        NSLog(@"直接显示内存缓存中的图片");
        
        if (setupImageHandle) {
            
            setupImageHandle(image);
        }
        
        return;
    }
    
    // 1.检查沙盒cache中是否存在图片
    UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:[urlString sandBoxFilePath]];
    
    if (sandBoxImage) {  // 若沙盒cache中存在图片，则直接显示
        NSLog(@"从沙盒中获取图片");
        
        // 1.1 显示图片
        if (setupImageHandle) {
            
            setupImageHandle(image);
        }

        // 1.2 将图片存储到内存缓存
        [self.images setObject:sandBoxImage forKey:urlString];
        
        // 返回
        return;
    }
    
    // 2.检查操作缓存中操作是否存在
    HMDownloadWebImageOperation *op = self.operations[urlString];
    
    if (op) {   // 若操作存在，则返回
        NSLog(@"图片正在下载，请耐心等待……");
        return;
    }
    
    // 2.1 创建下载图片的操作
    // op: 刚开始创建的操作，这个时候图片还没有下载完毕
    // operation: 图片已经下载完毕之后的操作
    op = [HMDownloadWebImageOperation downloadWebImageWithUrlString:urlString completionHandle:^(HMDownloadWebImageOperation *operation) {
        
        // 2.1.1 显示图片
        if (setupImageHandle) {
            
            setupImageHandle(operation.image);
        }
        
        // 2.1.2 移除操作缓存中的操作
        [self.operations  removeObjectForKey:urlString];
        
        // 2.1.3 将图片添加到内存缓存
        if (operation.image) {
            [self.images setObject:operation.image forKey:urlString];
        }
        
    }];
    
    // 2.2 异步执行操作（添加到操作队列中）
    [self.queue addOperation:op];
    
    // 2.3 将操作添加到操作缓存
    [self.operations setObject:op forKey:urlString];
}


+(instancetype)sharedManager{

    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

/**
 *  非主队列懒加载
 */
- (NSOperationQueue *)queue{

    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        
}
    return _queue;
}

/**
 *  内存缓存懒加载
 */
- (NSDictionary *)images{

    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

/**
 *  操作缓存懒加载
 */
- (NSDictionary *)operations{

    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;

}
@end
