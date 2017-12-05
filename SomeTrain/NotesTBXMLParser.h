//
//  NotesTBXMLParser.h
//  SomeTrain
//
//  Created by listome on 2016/11/24.
//  Copyright © 2016年 listome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonMod.h"
@interface NotesTBXMLParser : NSObject<NSXMLParserDelegate>
//添加属性
@property (nonatomic, strong) NSXMLParser *par;
@property (nonatomic, strong) PersonMod *person;
//存放每个person
@property (nonatomic, strong) NSMutableArray *list;
//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;

//声明parse方法，通过它实现解析
-(void)parse;
@end
