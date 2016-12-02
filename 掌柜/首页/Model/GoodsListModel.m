//
//  GoodsListModel.m
//  掌柜
//
//  Created by yubing on 16/11/4.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel
-(void)setValue:(id)value forKey:(NSString *)key{
    if([value isKindOfClass:[NSNumber class]]){
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
        
    } else if([value isKindOfClass:[NSNull class]]){
        [self setValue:nil forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
