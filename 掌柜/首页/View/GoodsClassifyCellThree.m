//
//  GoodsClassifyCellThree.m
//  掌柜
//
//  Created by yubing on 2016/11/10.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "GoodsClassifyCellThree.h"

@implementation GoodsClassifyCellThree
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
    CGFloat a = MUT_WIDTH;
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0,0,WIDTH,30*a)];
        [self.contentView addSubview:_view];
        UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30*a, WIDTH,0.4)];
        line1.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line1];
        UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a, 30*a,0.4,170*a)];
        line2.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line2];
        UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,115*a+0.4,WIDTH,0.4)];
        line3.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line3];
        UIImageView * line4 = [[UIImageView alloc] initWithFrame:CGRectMake(80*a,115*a+0.8,0.4,85*a)];
        line4.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line4];
        UIImageView * line5 = [[UIImageView alloc] initWithFrame:CGRectMake(240*a+0.4,115*a+0.8,0.4,85*a)];
        line5.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line5];

        

        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,30*a+0.4,160*a,85*a)];
        _imageView1.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a+0.4,30*a+0.4,160*a,85*a)];
        _imageView2.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0,115*a+0.8,80*a,84*a)];
        _imageView3.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(80*a+0.4,115*a+0.8,80*a-0.4,84*a)];
        _imageView4.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a+0.4,115*a+0.8,80*a,84*a)];
        _imageView5.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(240*a+0.8,115*a+0.8,80*a,84*a)];
        _imageView6.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
        [self.contentView addSubview:_imageView3];
        [self.contentView addSubview:_imageView4];
        [self.contentView addSubview:_imageView5];
        [self.contentView addSubview:_imageView6];

    }
    return self;
}
@end
