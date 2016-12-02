//
//  ParseManager.m
//  掌柜
//
//  Created by yubing on 16/11/2.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "ParseManager.h"
#import "DetailModel.h"

@implementation ParseManager
+(NSMutableArray*)parseGoodsListWithArray:(NSMutableArray*)mArr{
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in mArr) {
        GoodsListModel * model = [GoodsListModel new];
        model.name = dict[@"name"];
        model.price =  dict[@"price"];
        model.pic = dict[@"pic"];
        model.sales = dict[@"sales"];
        model.pic_more = dict[@"pic_more"];
        model.ID = dict[@"id"];
        [dataArray addObject:model];
    }
    return dataArray;
}
+(NSMutableArray *)parseSearchListWithArray:(NSMutableArray *)mArr{
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary * dict  in mArr) {
        SearchModel * model = [SearchModel new];
        model.name = dict[@"name"];
        model.pic = dict[@"pic"];
        model.price = dict[@"price"];
        model.ID = dict[@"id"];
        [dataArray addObject:model];
    }
    return dataArray;
}
+(NSMutableArray *)parseDetailInfoWithArray:(NSMutableArray *)mArr{
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary * dict  in mArr) {
        DetailModel * model = [DetailModel new];
        model.name = dict[@"name"];
        model.pic_more = dict[@"pic_more"];
        model.price = dict[@"price"];
        [dataArray addObject:model];
    }
    return dataArray;
}
@end
