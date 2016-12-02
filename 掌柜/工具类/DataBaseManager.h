//
//  DataBaseManager.h
//  文怡家常菜
//
//  Created by qf on 16/7/29.
//  Copyright © 2016年 qf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject
@property (nonatomic,retain) FMDatabase * dataBase;
+(DataBaseManager*)shareManager;
-(void)insertDataWithArray:(NSArray*)array;
-(NSMutableArray*)selectDataBase;
-(void)deleteData;
//搜索
-(void)insertSearchDataWithStr:(NSString *)str;
-(NSMutableArray *)selectSearchResult;
-(void)deleteSearch:(NSString*)str;
-(void)deleteAllSearch;
@end
