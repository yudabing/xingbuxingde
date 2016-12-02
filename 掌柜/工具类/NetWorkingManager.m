//
//  NetWorkingManager.m
//  掌柜
//
//  Created by yubing on 16/11/2.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "NetWorkingManager.h"

@implementation NetWorkingManager
+(NetWorkingManager *)shareManager{
    NetWorkingManager * manager = [NetWorkingManager new];
    return manager;
}
-(void)getDataWithUrl:(NSString *)url AndSuccess:(successBlock)success AndFailure:(failureBlock)failure{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/html",@"text/plain",@"text/javascript", nil];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * dataArray = [ParseManager parseGoodsListWithArray:responseObject[0]];
        success(dataArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)getSearchDataWithUrl:(NSString *)urlStr AndSuccess:(successBlock)success AndDataWithUrl:(failureBlock)failure{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/html",@"text/plain",@"text/javascript", nil];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * dataArray = [ParseManager parseSearchListWithArray:responseObject];
    success(dataArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)getDetailDataWithUrl:(NSString *)urlStr AndSuccess:(successBlock)success AndDataWithUrl:(failureBlock)failure{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/html",@"text/plain",@"text/javascript", nil];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * dataArray = [ParseManager parseDetailInfoWithArray:responseObject];
        success(dataArray);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
@end
