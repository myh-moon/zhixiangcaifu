//
//  DataBase.m
//  FifthShopKeeper
//
//  Created by 开发者 on 15/6/8.
//  Copyright (c) 2015年 duowei~SongBo. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase
static FMDatabase *_db;

+ (FMDatabase *)openDatabase
{
    NSString *documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"DB.sqlite"];
    _db = [FMDatabase databaseWithPath:documentPath];
    
//    NSLog(@"\n--------dataBase-------%@",documentPath);
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_table (ID integer PRIMARY KEY AUTOINCREMENT, page TEXT,identifier TEXT, array blob, is_fixed TEXT, dict blob);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
    return _db;
}

+ (void)closeDatabase
{
    BOOL result = [_db close];
    if (result) {
        _db = nil;
    }
}

+ (void)saveDataWithDictionary:(NSDictionary *)dictionary page:(NSString *)page fix:(NSString *)fix
{
    FMDatabase *database = [self openDatabase];
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
        //查询有没有重复的帖子 如果重复就不写入
        FMResultSet *resultSet = [database executeQuery:@"SELECT * FROM t_table WHERE is_fixed = ? AND page = ?;",fix,page];
        if (![resultSet next]) {//如果返回值为0 说明数据库中没有存储 那么久存入
            [database executeUpdate:@"INSERT INTO t_table(page,is_fixed,dict) VALUES(?,?,?);", page,fix,data];
        }
    [self closeDatabase];
}

+ (NSDictionary *)cachesDatasWithPage:(NSString *)page fix:(NSString *)fix
{
    FMDatabase *database = [self openDatabase];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    FMResultSet *resultSet = [database executeQuery:@"SELECT * FROM t_table WHERE is_fixed = ? AND page = ?;",fix,page];
    while ([resultSet next]) {
        NSData *statusData = [resultSet objectForColumnName:@"dict"];
        dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
    }
    [self closeDatabase];
    return dictionary;
}

+(void)saveDataWithArray:(NSArray *)array identifier:(NSString *)identifier
{
    FMDatabase *database = [self openDatabase];
    // 把statusDict字典对象序列化成NSData二进制数据
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    //查询有没有重复的帖子 如果重复就不写入
    FMResultSet *resultSet = [database executeQuery:@"SELECT * FROM t_table WHERE identifier = ?;",identifier];
    if (![resultSet next]) {//如果返回值为0 说明数据库中没有存储 那么久存入
        [database executeUpdate:@"INSERT INTO t_table(identifier,array) VALUES(?,?);",identifier,data];
    }
    [self closeDatabase];
}

+(NSArray *)cachesDataWithIdentifier:(NSString *)identifier
{
    FMDatabase *database = [self openDatabase];
    NSArray *array = [[NSArray alloc] init];
    FMResultSet *resultSet = [database executeQuery:@"SELECT * FROM t_table WHERE identifier = ?;",identifier];
    while ([resultSet next]) {
        NSData *statusData = [resultSet objectForColumnName:@"array"];
        array = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
    }
    [self closeDatabase];
    return array;
}
@end
