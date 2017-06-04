//
//  NSString+encryptDES.h
//  SP2P_6.1
//
//  Created by Jerry on 14/11/27.
//  Copyright (c) 2014年 EIMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConverUtil.h"

@interface NSString (encryMd5)

/*
 * 给字符串md5加密
 */
- (NSString *)md5;

@end


@interface NSString (encryptDES)

+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;
+ (NSString *)decrypt3DES:(NSString *)src key:(NSString *)key;

+ (NSString*)encrypt:(NSString*)plainText;

@end
