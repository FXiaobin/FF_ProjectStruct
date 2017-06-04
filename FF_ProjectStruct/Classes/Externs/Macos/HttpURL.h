//
//  HttpURL.h
//  ProjectTree
//
//  Created by lovepinyao on 16/8/24.
//  Copyright © 2016年 lovepinyao. All rights reserved.
//

#ifndef HttpURL_h
#define HttpURL_h

#import <Foundation/Foundation.h>


//系统会根据当前工程的版本类型（debug、release）来自动判断选择哪个SEVERY_API
#ifdef DEBUG
//Debug状态下的测试API

#else
//Release状态下的线上API


#endif



//登录成功通知
#define LOGIN_SUCCESS_NOTIFICATION      @"LOGIN_SUCCESS_NOTIFICATION"

//重置密码成功
#define RESET_PASSWORD_SUCCESS_NOTIFICATION @"RESET_PASSWORD_SUCCESS_NOTIFICATION"


#endif /* HttpURL_h */
