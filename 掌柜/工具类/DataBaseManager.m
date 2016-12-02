//
//  DataBaseManager.m
//  文怡家常菜
//
//  Created by qf on 16/7/29.
//  Copyright © 2016年 qf. All rights reserved.
//

#import "DataBaseManager.h"
#import "SearchModel.h"
@implementation DataBaseManager

+(DataBaseManager *)shareManager{
    static DataBaseManager * manager;
    if (manager==nil) {
        manager =[DataBaseManager new];
        [manager createDataBase];
    }
    return manager;
}
#pragma mark 创建数据库
-(void)createDataBase{
    
    NSString * dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _dataBase = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/zhanggui.db",dbPath]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@/zhanggui.db",dbPath]);
    BOOL b = [_dataBase open];
    if (!b) {
        NSLog(@"打开数据库失败");
    }else{
        NSString * sql = @"create table if not exists zhanggui (Id integer primary key autoincrement,name text,pic text,sales text,price text)";
        BOOL b = [_dataBase executeUpdate:sql];
        if (!b) {
            NSLog(@"创建失败");
        }
        NSString * sql1 = @"create table if not exists GoodsSearch (Id integer primary key autoincrement,search text)";
        BOOL  c = [_dataBase executeUpdate:sql1];
        if (!c) {
            NSLog(@"创建失败");
        }
        
    }
}
#pragma mark 插入失败
-(void)insertDataWithArray:(NSArray *)array{
        for (GoodsListModel * item in array) {
        NSString * sql = @"insert into zhanggui (name,pic,price,sales) values (?,?,?,?)";
        BOOL b = [_dataBase executeUpdate:sql,item.name,item.pic,item.sales,item.price];
        if (!b) {
            NSLog(@"插入失败");
        }
    }
}
-(void)insertSearchDataWithStr:(NSString *)str{
    NSString * sql1 =@"insert into GoodsSearch (search) values (?)";
    BOOL c = [_dataBase executeUpdate:sql1,str];
    if (!c) {
        NSLog(@"插入失败");
    }
}
#pragma mark 查询数据
-(NSMutableArray *)selectDataBase{
    NSMutableArray * marr = [[NSMutableArray alloc] init];
    NSString *sql = @"select * from zhanggui";
    FMResultSet * set = [_dataBase executeQuery:sql];
    while (set.next) {
        GoodsListModel * model = [GoodsListModel new];
        model.name = [set stringForColumn:@"name"];
        model.pic = [set stringForColumn:@"pic"];
        model.price = [set stringForColumn:@"price"];
        model.sales = [set stringForColumn:@"sales"];
        [marr addObject:model];
    }
    return marr;
}
-(NSMutableArray *)selectSearchResult{
    NSMutableArray * arr = [NSMutableArray new] ;
    NSString * sql1 = @"select * from GoodsSearch";
    FMResultSet * set = [_dataBase executeQuery:sql1];
    while (set.next) {
    NSString * str = [set stringForColumn:@"search"];
    [arr addObject:str];
    }
    return arr;
}
#pragma mark 删除数据
-(void)deleteData{
    NSString * sql = @"delete  from zhanggui";
    BOOL b =[_dataBase executeUpdate:sql];
    if (!b) {
        NSLog(@"删除失败");
    }
}
-(void)deleteSearch:(NSString*)str{
    NSString * sql1 = @"delete  from GoodsSearch where search =?";
    BOOL c =[_dataBase executeUpdate:sql1,str];
    if (!c) {
        NSLog(@"删除失败");
    }
}
-(void)deleteAllSearch{
    NSString * sql1 = @"delete  from GoodsSearch";
    BOOL c =[_dataBase executeUpdate:sql1];
    if (!c) {
        NSLog(@"删除失败");
    }
}
@end
