//
//  FiveTableViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "FiveTableViewCell.h"

@implementation FiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initTab];
    }
    return self;
}
-(void)initTab{
    CGFloat a = MUT_WIDTH;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0,10*a, WIDTH,190*a)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(15*a,10*a,50*a,50*a)];
    _imageView1.backgroundColor = [UIColor grayColor];
    [_bgView addSubview:_imageView1];
    
    _shopLab = [[UILabel alloc] initWithFrame:CGRectMake(70*a,27.5*a,120*a,15*a)];
    _shopLab.text = @"雅科瑞男装旗舰店";
    _shopLab.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:_shopLab];
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(240*a,20*a,70*a,30*a)];
    _imageView2.backgroundColor = [UIColor redColor];
    [_bgView addSubview:_imageView2];
    NSArray * arr = @[@"全部宝贝",@"上新宝贝",@"关注人数"];
    NSArray * arr1 = @[@"1234",@"123",@"2333"];
    for (int i=0;i<3;i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0+(70*a+2)*i,70*a,70*a,60*a)];
        [_bgView addSubview:view];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((70*a+1)*(i+1),70*a,1,60*a)];
        imageView.image = [UIImage imageNamed:@"entry_bg.png"];
        [_bgView addSubview:imageView];
        CGSize contenSize=[arr[i] boundingRectWithSize:CGSizeMake(WIDTH-30*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11*a]} context:nil].size;
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake((70*a-contenSize.width)/2,40*a,contenSize.width,contenSize.height)];
        label1.text = arr[i];
        label1.font = [UIFont systemFontOfSize:11*a];
        label1.textColor = [UIColor lightGrayColor];
        [view addSubview:label1];
        
        CGSize contenSize1=[arr1[i] boundingRectWithSize:CGSizeMake(WIDTH-30*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*a]} context:nil].size;
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake((70*a-contenSize1.width)/2,10*a,contenSize1.width,contenSize1.height)];
        label2.text = arr1[i];
        label2.font = [UIFont systemFontOfSize:13*a];
        [view addSubview:label2];
    }
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(210*a+3,70*a,WIDTH-210*a+3,60*a)];
    [_bgView addSubview:view1];
    NSArray * arr2 = @[@"宝贝描述",@"卖家服务",@"物流服务"];
    NSArray * arr3 = @[@"4.9",@"4.9",@"4.9"];
    for (int i =0;i<3;i++) {
        CGSize contenSize=[arr2[i] boundingRectWithSize:CGSizeMake(WIDTH-30*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*a]} context:nil].size;
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(15*a,(60*a-contenSize.height*3)/4*(i+1)+contenSize.height*i, contenSize.width,contenSize.height)];
        label1.text = arr2[i];
        label1.font = [UIFont systemFontOfSize:12*a];
        label1.textColor = [UIColor lightGrayColor];
        [view1 addSubview:label1];
        
        CGSize contenSize1=[arr3[i] boundingRectWithSize:CGSizeMake(WIDTH-30*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*a]} context:nil].size;
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(20*a+contenSize.width,(60*a-contenSize1.height*3)/4*(i+1)+contenSize1.height*i, contenSize1.width,contenSize1.height)];
        label2.text = arr3[i];
        label2.font = [UIFont systemFontOfSize:13*a];
        label2.textColor = [UIColor redColor];
        [view1 addSubview:label2];
    }
    _classifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _classifyBtn.frame = CGRectMake(85*a,140*a,60*a,25);
    [_classifyBtn setBackgroundImage:[UIImage imageNamed:@"10.png"] forState:UIControlStateNormal];
    [_bgView addSubview:_classifyBtn];
    
    _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterBtn.frame = CGRectMake(175*a,140*a,60*a,25);
    [_enterBtn setBackgroundImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
    [_bgView addSubview:_enterBtn];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
