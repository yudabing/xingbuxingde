//
//  GoodsClassifyCellOne.m
//  掌柜
//
//  Created by yubing on 2016/11/9.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "GoodsClassifyCellOne.h"

@implementation GoodsClassifyCellOne
-(void)awakeFromNib{
    [super awakeFromNib];
}
-(instancetype)initWithFrame:(CGRect)frame{
    CGFloat a = MUT_WIDTH;
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*a,1.5*a,34*a,33*a)];
        [self.contentView addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"zgtt.png"];
        UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(60*a,3*a,0.6,30*a)];
        line1.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line1];
        UIImageView * line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,36*a,WIDTH,0.4)];
        line2.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line2];
        UIImageView * line3 = [[UIImageView alloc] initWithFrame:CGRectMake(80*a,36*a+0.4,0.4,220*a+0.4)];
        line3.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line3];
        UIImageView * line4 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a+0.4,36*a+0.4,0.4,300*a+0.8)];
        line4.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line4];
        UIImageView * line5 = [[UIImageView alloc] initWithFrame:CGRectMake(240*a+1.2,36*a+0.4,0.4,220*a+0.4)];
        line5.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:line5];
        UIImageView * line6 = [[UIImageView alloc] initWithFrame:CGRectMake(0,146*a+0.5,WIDTH,0.4)];
        line6.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line6];
        UIImageView * line7 = [[UIImageView alloc] initWithFrame:CGRectMake(0,256*a+1.1,WIDTH,0.4)];
        line7.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line7];
        
        UIImageView * line8 = [[UIImageView alloc] initWithFrame:CGRectMake(0,336*a+2,WIDTH,0.4)];
        line8.image = [UIImage imageNamed:@"entry_bg1.png"];
        [self.contentView addSubview:line8];



        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,36*a+0.4,80*a,110*a)];
        [self.contentView addSubview:_imageView1];

        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(80*a+0.4,36*a+0.4,80*a,110*a)];
        [self.contentView addSubview:_imageView2];
        
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a+0.8,36*a+0.4,80*a,110*a)];
        [self.contentView addSubview:_imageView3];
        
        _imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(240*a+1.6,36*a+0.4,80*a,110*a)];
        [self.contentView addSubview:_imageView4];
        
        _imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0,146*a+0.9,80*a,110*a)];
       [self.contentView addSubview:_imageView5];

        _imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(80*a+0.4,146*a+0.9,80*a,110*a)];
        [self.contentView addSubview:_imageView6];
        
        _imageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a+0.8,146*a+0.9,80*a,110*a)];
        [self.contentView addSubview:_imageView7];
        
        _imageView8 = [[UIImageView alloc] initWithFrame:CGRectMake(240*a+1.6,146*a+0.9,80*a,110*a)];
        [self.contentView addSubview:_imageView8];
        
        _imageView9 = [[UIImageView alloc] initWithFrame:CGRectMake(0,256*a+1.5,160*a,80*a)];
        [self.contentView addSubview:_imageView9];
        
        _imageView10 = [[UIImageView alloc] initWithFrame:CGRectMake(160*a+0.8,256*a+1.5,160*a,80*a)];
        [self.contentView addSubview:_imageView10];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,336*a+2.4,WIDTH,112.2*a)];
        _scrollView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_scrollView];
        
        _imageView1.image = [UIImage imageNamed:@"a1.png"];
        _imageView2.image = [UIImage imageNamed:@"a2.png"];
        _imageView3.image = [UIImage imageNamed:@"a3.png"];
        _imageView4.image = [UIImage imageNamed:@"a4.png"];
        _imageView5.image = [UIImage imageNamed:@"a5.png"];
        _imageView6.image = [UIImage imageNamed:@"a6.png"];
        _imageView7.image = [UIImage imageNamed:@"a7.png"];
        _imageView8.image = [UIImage imageNamed:@"a8.png"];
        _imageView9.image = [UIImage imageNamed:@"a9.png"];
        _imageView10.image = [UIImage imageNamed:@"a10.png"];

    }
    return self;
}
@end
