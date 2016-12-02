//
//  GoodsClassifyCellTwo.m
//  掌柜
//
//  Created by yubing on 2016/11/10.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "GoodsClassifyCellTwo.h"

@implementation GoodsClassifyCellTwo
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
    CGFloat a = MUT_WIDTH;
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH,30*a)];
        [self.contentView addSubview:_view];
        UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30*a, WIDTH,0.4)];
        line1.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line1];
        UIImageView * line2 = [[UIImageView alloc] initWithFrame:CGRectMake(128*a,30*a+0.4,0.4,170*a)];
        line2.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line2];
        UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(192*a+0.4,30*a+0.4,0.4,170*a)];
        line3.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line3];
        UIImageView * line4 = [[UIImageView alloc] initWithFrame:CGRectMake(256*a+0.9,30*a+0.4,0.4,170*a)];
        line4.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line4];
        UIImageView * line5 = [[UIImageView alloc] initWithFrame:CGRectMake(0,115*a+0.4,WIDTH,0.4)];
        line5.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line5];
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,30*a+0.4,128*a,85*a)];
        _imageView1.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(128*a+0.4,30*a+0.4,64,85*a)];
        _imageView2.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(192*a+0.8,30*a+0.4,64,85*a)];
        _imageView3.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(256*a+1.3,30*a+0.4,64,85*a)];
        _imageView4.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0,115*a+0.8,128*a,85*a)];
        _imageView5.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(128*a+0.4,115*a+0.8,64,85*a)];
        _imageView6.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(192*a+0.8,115*a+0.8,64,85*a)];
        _imageView7.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        _imageView8 = [[UIImageView alloc] initWithFrame:CGRectMake(256*a+1.3,115*a+0.8,64,85*a)];
        _imageView8.image = [UIImage imageNamed:@"AppIcon@3x.png"];
        
        [self.contentView addSubview:_imageView1];
        [self.contentView addSubview:_imageView2];
        [self.contentView addSubview:_imageView3];
        [self.contentView addSubview:_imageView4];
        [self.contentView addSubview:_imageView5];
        [self.contentView addSubview:_imageView6];
        [self.contentView addSubview:_imageView7];
        [self.contentView addSubview:_imageView8];
    }
    return self;
}
@end
