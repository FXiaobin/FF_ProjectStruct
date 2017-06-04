//
//  RequestUtils.h
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/25.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface RequestUtils : NSObject

+ (RequestUtils *)manager;

+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;

+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure;


-(void)imagePost:(NSString*)urlString success:(void (^)(id))suc failed:(void (^)(NSError *))fail parems:(NSDictionary *)source imageArray:(NSMutableArray*)imageArray;



@end


