//
//  NSString+SandBoxPath.h
//  HMWebImage
//
//  Created by 韩萌 on 16/5/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SandBoxPath)

/**
 *  根据URL设置图片在沙盒中的存储路径
 */
- (NSString *)sandBoxFilePath;

@end
