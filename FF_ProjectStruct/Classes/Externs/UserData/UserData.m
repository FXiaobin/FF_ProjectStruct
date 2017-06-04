//
//  UserData.m
//  FF_ProjectStruct
//
//  Created by fanxiaobin on 2017/6/1.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "UserData.h"

@implementation UserData

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.birthDay = [aDecoder decodeObjectForKey:@"birthDay"];
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.birthDay forKey:@"birthDay"];
}

@end
