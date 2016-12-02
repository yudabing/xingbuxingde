//
//  NetWorkingManager.h
//  掌柜
//
//  Created by yubing on 16/11/2.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^successBlock)(id object);
typedef void(^failureBlock)(NSError * error);
@interface NetWorkingManager : NSObject
+(NetWorkingManager*)shareManager;
-(void)getDataWithUrl:(NSString*) url AndSuccess:(successBlock)success AndFailure:(failureBlock)failure;
-(void)getSearchDataWithUrl:(NSString*) urlStr AndSuccess:(successBlock) success AndDataWithUrl:(failureBlock)failure;
-(void)getDetailDataWithUrl:(NSString*) urlStr AndSuccess:(successBlock) success AndDataWithUrl:(failureBlock)failure;
@end
