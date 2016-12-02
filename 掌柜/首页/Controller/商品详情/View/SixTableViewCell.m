//
//  SixTableViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "SixTableViewCell.h"

@implementation SixTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self inintTab];
    }
    return self;
}
-(void)inintTab{
    CGFloat a = MUT_WIDTH;
    NSString * str = @"继续拖动，查看图文详情页";
    CGSize contenSize=[str boundingRectWithSize:CGSizeMake(WIDTH-30*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12*a]} context:nil].size;
    _line1 = [[UIImageView alloc] initWithFrame:CGRectMake(15*a,30*a,(WIDTH-contenSize.width-40*a)/2 ,1)];
    _line1.image = [UIImage imageNamed:@"20.png"];
    [self.contentView addSubview:_line1];
    _line2 = [[UIImageView alloc] initWithFrame:CGRectMake(20*a+contenSize.width+_line1.frame.size.width,30*a,(WIDTH-contenSize.width-40*a)/2 ,1)];
    _line2.image = [UIImage imageNamed:@"20.png"];
    [self.contentView addSubview:_line2];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20*a+_line1.frame.size.width,30*a-contenSize.height/2, contenSize.width,contenSize.height)];
    _label1.text = str;
    _label1.font = [UIFont systemFontOfSize:12*a];
    [self.contentView addSubview:_label1];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
