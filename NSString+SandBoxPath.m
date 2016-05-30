//
//  NSString+SandBoxPath.m
//  HMWebImage
//
//  Created by 韩萌 on 16/5/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "NSString+SandBoxPath.h"

@implementation NSString (SandBoxPath)


- (NSString *)sandBoxFilePath{

    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    filePath = [filePath stringByAppendingPathComponent:self.lastPathComponent];
    
    return filePath;
}


@end
