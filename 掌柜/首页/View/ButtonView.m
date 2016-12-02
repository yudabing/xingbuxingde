//
//  ButtonView.m
//  掌柜
//
//  Created by yubing on 16/11/1.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "ButtonView.h"
@interface ButtonView()
@end
@implementation ButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self getButton];
    }
    return self;
}
-(void)getButton{
    CGFloat  a = MUT_HEIGHT;
    NSArray * arr=@[@"掌柜推荐",@"一元抢购",@"掌付宝",@"附近店铺",@"掌柜明星榜",@"新手上路"];
    for (int i =0;i<6;i++) {
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake((i%3)*WIDTH/3+30*a,(i/3)*80*a+15*a,50*a,50*a)];
        image.image =[UIImage imageNamed:[NSString stringWithFormat:@"icon%d-1.png",i+1]];
        image.userInteractionEnabled = YES;
        image.tag =100+i;
        [self addSubview:image];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake((i%3)*WIDTH/3+25*a,(i/3)*80*a+65*a, 60*a, 20*a)];
        label.textAlignment=1;
        label.font=[UIFont systemFontOfSize:11*a];
        label.text=arr[i];
        [self addSubview:label];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap)];
        [image addGestureRecognizer:tap];
    }
    
}
-(void)photoTap{
    NSLog(@"按钮事件");
}
@end
