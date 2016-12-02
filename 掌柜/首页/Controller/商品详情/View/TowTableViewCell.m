//
//  TowTableViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "TowTableViewCell.h"

@implementation TowTableViewCell

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
    
    _imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(10*a,10*a, 110*a,10*a)];
    _imageView4.image = [UIImage imageNamed:@"3.png"];
    [self.contentView addSubview:_imageView4];
    
    _imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(140*a,10*a, 100*a,10*a)];
    _imageView5.image = [UIImage imageNamed:@"4.png"];
    [self.contentView addSubview:_imageView5];
    
    _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(290*a,7.5*a,15*a,15*a)];
    _imageView3.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageView3];
    
    

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
