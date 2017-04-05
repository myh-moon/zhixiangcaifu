//
//  DataBase.h
//  FifthShopKeeper
//
//  Created by 开发者 on 15/6/8.
//  Copyright (c) 2015年 duowei~SongBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface DataBase : NSObject

+ (FMDatabase *)openDatabase;
+ (void)closeDatabase;
/**
 *  缓存帖子字典数组到数据库中
 */
+ (void)saveDataWithDictionary:(NSDictionary *)dictionary page:(NSString *)page fix:(NSString *)fix;
/**
 *  根据参数读取数据库中的内容
 */
+ (NSDictionary *)cachesDatasWithPage:(NSString *)page fix:(NSString *)fix;

+(void)saveDataWithArray:(NSArray *)array identifier:(NSString *)identifier;

+(NSArray *)cachesDataWithIdentifier:(NSString *)identifier;

@end
