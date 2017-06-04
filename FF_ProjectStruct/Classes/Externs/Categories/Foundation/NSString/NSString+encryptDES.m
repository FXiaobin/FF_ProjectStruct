//
//  NSString+encryptDES.m
//  SP2P_6.1
//
//  Created by Jerry on 14/11/27.
//  Copyright (c) 2014年 EIMS. All rights reserved.
//

#import "NSString+encryptDES.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define KGIV                          @"07654321"
#define DESkey  @"1A5AD74E-12D5-4E0F-BDA5-FEC0D08FEED6"

@implementation NSString (encryptDES)

/*
 * 给字符串md5加密
 */
- (NSString*)md5
{
    const char *ptr = [self UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}


/*
 
 加密
 
 */
+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key{
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData* data = [src dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    plainTextBufferSize = [data length];
    vplainText = (const void *)[data bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *)[key UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return [ConverUtil NSDataToHexString:myData];
}


/*
 
 解密
 
 */
+ (NSString *)decrypt3DES:(NSString *)src key:(NSString *)key{
    const void *vplainText;
    size_t plainTextBufferSize;
    NSData *EncryptData = [ConverUtil hexStrToNSData:src];
    plainTextBufferSize = [EncryptData length];
    vplainText = [EncryptData bytes];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *)[key UTF8String];
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *dataBuf = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return [[NSString alloc] initWithData:dataBuf
                                 encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]
    ;
}

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText {
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [DESkey UTF8String];
    const void *vinitVec = (const void *) [KGIV UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [ConverUtil base64Encoding:myData];
    return result;
}


@end
