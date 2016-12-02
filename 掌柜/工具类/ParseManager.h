//
//  ParseManager.h
//  掌柜
//
//  Created by yubing on 16/11/2.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseManager : NSObject
+(NSMutableArray*)parseGoodsListWithArray:(NSMutableArray*)mArr;
+(NSMutableArray*)parseSearchListWithArray:(NSMutableArray*)mArr;
+(NSMutableArray*)parseDetailInfoWithArray:(NSMutableArray*)mArr;
@end
