//
//  FourTableViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell

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
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(10*a,10*a, 60*a,15*a)];
    _label1.text = @"宝贝评价";
    _label1.font = [UIFont systemFontOfSize:13*a];
    [self.contentView addSubview:_label1];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(70*a, 10*a,40*a,15*a)];
    _label2.text = @"(1212)";
    _label2.font = [UIFont systemFontOfSize:13*a];
    [self.contentView addSubview:_label2];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10*a, 30*a,20*a, 20*a)];
    _imageView1.backgroundColor = [UIColor grayColor];
    _imageView1.layer.cornerRadius = 10*a;
    _imageView1.layer.masksToBounds= YES;
    [self.contentView addSubview:_imageView1];
    
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(35*a,35*a,80*a,10*a)];
    _label3.text = @"skdhaldksks";
    _label3.font = [UIFont systemFontOfSize:11*a];
    [self.contentView addSubview:_label3];
    
    //_imageView2
    NSString * str = @"非常好！！！很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢！！！";
    CGSize contenSize=[str boundingRectWithSize:CGSizeMake(WIDTH-30*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*a]} context:nil].size;
    _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(15*a,60*a,WIDTH-30*a,contenSize.height)];
    _infoLab.text = str;
    _infoLab.numberOfLines = 0;
    _infoLab.font = [UIFont systemFontOfSize:12*a];
    [self.contentView addSubview:_infoLab];
    
    _allmsgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allmsgBtn.frame = CGRectMake(WIDTH/2-40*a,70*a+contenSize.height,80*a,25*a);
    [_allmsgBtn setBackgroundImage:[UIImage imageNamed:@"7.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:_allmsgBtn];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
