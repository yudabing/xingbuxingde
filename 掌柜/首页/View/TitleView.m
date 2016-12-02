//
//  TitleView.m
//  掌柜
//
//  Created by yubing on 16/11/5.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "TitleView.h"
@interface TitleView ()
@end
@implementation TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(5,3,50,25)];
    label.text = @"分类";
    [self addSubview:label];
}

@end
