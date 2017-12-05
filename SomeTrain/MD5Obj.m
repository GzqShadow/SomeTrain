//
//  MD5Obj.m
//  SomeTrain
//
//  Created by listome on 2017/4/27.
//  Copyright © 2017年 listome. All rights reserved.
//

#import "MD5Obj.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5Obj
+(NSString *)md5HexDigest:(NSString *)input{
   
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%2s",result];
    }
    
    return ret;
    /*
     MD5是不可逆的只有加密没有解密，iOS代码加密使用方式如下
     
     NSString *userName = @"cerastes";
     
     NSString *password = @"hello Word";
     
     
     
     MD5加密
     
     NSString *md5 = [CJMD5 md5HexDigest:password];
     
     
     
     NSLog(@"%@",md5);
     */
 
}
@end
@implementation AESObj

+(void)aseDiges:(NSString *)input{
    /*
     NSString *encryptedData = [AESCrypt encrypt:userName password:password];//加密
     NSString *message = [AESCrypt decrypt:encryptedData password:password]; //解密
     NSLog(@"加密结果 = %@",encryptedData);
     NSLog(@"解密结果 = %@",message);
     */
    
}

@end


@implementation Base64Obj

/*
 BASE64加密iOS代码加密使用方法
 
 BASE64加密
 
 NSString *baseEncodeString = [GTMBase64 encodeBase64String:password];
 
 
 
 NSString *baseDecodeString = [GTMBase64 decodeBase64String:baseEncodeString];
 
 
 
 NSLog(@"baseEncodeString = %@",baseEncodeString);
 
 
 
 NSLog(@"baseDecodeString = %@",baseDecodeString);
 */
+ (NSString*)encodeBase64String:(NSString * )input {
   
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input {

    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   
    return base64String;
    
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    
//    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
   
//    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

@end


























