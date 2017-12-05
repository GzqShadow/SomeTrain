//
//  MD5Obj.h
//  SomeTrain
//
//  Created by listome on 2017/4/27.
//  Copyright © 2017年 listome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Obj : NSObject
+(NSString *)md5HexDigest:(NSString *)input;
@end


@interface AESObj : NSObject
+(void)aseDiges:(NSString *)input;
@end


@interface Base64Obj : NSObject
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;
@end
