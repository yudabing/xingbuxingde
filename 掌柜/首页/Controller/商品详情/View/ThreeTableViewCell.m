//
//  ThreeTableViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "ThreeTableViewCell.h"

@implementation ThreeTableViewCell

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
    CGFloat  a = MUT_WIDTH;
    _BgView = [[UIView alloc] initWithFrame:CGRectMake(0,10*a,WIDTH,30*a)];
    _BgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_BgView];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(10*a,7.5*a,120*a,15*a)];
    _label1.text = @"选择尺码，颜色";
    _label1.font = [UIFont systemFontOfSize:14];
    [_BgView addSubview:_label1];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(290*a,10*a,10*a,10*a)];
    _imageView1.image = [UIImage imageNamed:@"enter.png"];
    [_BgView addSubview:_imageView1];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
