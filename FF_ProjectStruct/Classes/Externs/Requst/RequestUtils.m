//
//  RequestUtils.m
//  WealthCloud
//
//  Created by fanxiaobin on 2017/4/25.
//  Copyright © 2017年 caifumap. All rights reserved.
//

#import "RequestUtils.h"
#import "NSString+MD5.h"

@implementation RequestUtils

+ (RequestUtils *)manager{
    RequestUtils *utils = [[RequestUtils alloc] init];
    return utils;
}


+ (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure{
    
    NSString * sign = [self stringWithDic:parameters];
    
    NSString * md5String = [NSString MD5ForLower32Bate:sign];
    NSString *encodedValue = [md5String stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary * dic =[NSMutableDictionary dictionaryWithDictionary:parameters];
    NSDate * date =  [NSDate date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss SSS";//指定转date得日期格式化形式
    [dic setObject:encodedValue forKey:@"sign"];
    [dic setObject:[dateFormatter stringFromDate:date] forKey:@"randKey"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",
                  @"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    
    [manager POST:URLString  parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HiddenLoadingHUD;
        NSLog(@"--- res =  %@",[responseObject descriptionWithLocale:responseObject]);
        
        if ([responseObject[@"error"] integerValue] == 0) {
            
            success(responseObject);
            
        }else{
            
            AlertError(responseObject[@"msg"]);
            failure(nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HiddenLoadingHUD;
        AlertError(error.localizedDescription);
        failure(error);
    }];

}
+(NSString*)stringWithDic:(NSDictionary*)dic{
    NSArray *keyArray = [dic allKeys];
    
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
        
    }];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        [valueArray addObject:[dic objectForKey:sortString]];
    }
    NSMutableArray *signArray = [NSMutableArray array];
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArray[i],valueArray[i]];
        [signArray addObject:keyValueStr];
    }
    NSString *sig = [signArray componentsJoinedByString:@"&"];
   NSString * sign=  [NSString stringWithFormat:@"%@caifumap@app",sig];
    
    return sign;
}

+ (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^) (NSError *error))failure{
    NSString * sign = [self stringWithDic:parameters];
    NSString * md5String = [NSString MD5ForLower32Bate:sign];
    
   NSString *encodedValue = [md5String stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary * dic =[NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSDate * date =  [NSDate date];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat=@"yyyyMMddhhmmssSSS";//指定转date得日期格式化形式
    [dic setObject:encodedValue forKey:@"sign"];
    [dic setObject:[dateFormatter stringFromDate:date] forKey:@"randKey"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",
                  @"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;

    
    [manager GET:URLString parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"--- res =  %@",[responseObject descriptionWithLocale:responseObject]);
        
        if ([responseObject[@"error"] integerValue] == 0) {
            success(responseObject);
        }else{
            AlertError(responseObject[@"msg"]);
           

            failure(nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AlertError(error.localizedDescription);
        failure(error);
    }];

}

//上传图片
-(void)imagePost:(NSString*)urlString success:(void (^)(id))suc failed:(void (^)(NSError *))fail parems:(NSDictionary *)source imageArray:(NSMutableArray*)imageArray{
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager] ;
    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",
                  @"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    //获取token
    manager.requestSerializer.timeoutInterval = 15;

    [manager POST:urlString parameters:source constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArray.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(imageArray[i],0.8) name:@"imgFile" fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"error"] integerValue] == 0) {
            
             NSLog(@"error=========%@",responseObject);
            suc(responseObject);
            
        }else{
            AlertError(responseObject[@"msg"]);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AlertError(error.localizedDescription);

        NSLog(@"error=========%@",error);
        fail(error);
    }];
    
}


@end
