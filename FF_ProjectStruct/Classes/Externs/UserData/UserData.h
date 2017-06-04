//
//  UserData.h
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject<NSCoding>

@property  (nonatomic,strong) NSString *username;

@property  (nonatomic,strong) NSString *userId;

@property  (nonatomic,strong) NSString *sex;

@property  (nonatomic,strong) NSString *birthDay;




@end
