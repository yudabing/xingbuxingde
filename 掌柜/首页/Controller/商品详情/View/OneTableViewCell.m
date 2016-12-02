//
//  OneTableViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "OneTableViewCell.h"
#import "HeaderView.h"
#import "DetailModel.h"
@implementation OneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // cell页面布局
        //[self initTab];
        
    }
    return self;
}
-(void)pushDataWithArr:(NSMutableArray*)marr{
    self.dataArray = [NSArray arrayWithArray:marr];
    if (self.dataArray.count>0) {
        [self initTab];
    }
}
-(void)initTab{
       DetailModel * model = _dataArray[0];
        CGFloat a = MUT_WIDTH;
        _scrV = [[UIView alloc] initWithFrame:CGRectMake(0, 0,WIDTH,300*a)];
        _scrV.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_scrV];
        HeaderView * headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0,0, WIDTH,300*a)];
        NSArray * picArr = [model.pic_more componentsSeparatedByString:@","];
        [headerView getScrollDataWithArr:picArr AndWithStr:@"0"];
        [_scrV addSubview:headerView];
        NSString * str = model.name;
        CGSize contenSize=[str boundingRectWithSize:CGSizeMake(240*a, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13*a]} context:nil].size;
        _infoLab = [[UILabel alloc] initWithFrame:CGRectMake(10*a, 305*a,240*a,contenSize.height)];
        _infoLab.text = str;
        _infoLab.font = [UIFont systemFontOfSize:13*a];
        _infoLab.numberOfLines = 0;
        [self.contentView addSubview:_infoLab];
        
        _line = [[UIImageView alloc] initWithFrame:CGRectMake(255*a, 308*a,1,40*a)];
        _line.image = [UIImage imageNamed:@"entry_bg.png"];
        [self.contentView addSubview:_line];
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(280*a,310*a,15*a,20*a);
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(40*a,-5*a,0,-5*a);
    _shareBtn.titleLabel.font = [UIFont systemFontOfSize:8*a];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_shareBtn];
    
        NSArray * priceArr = [model.price componentsSeparatedByString:@"."];
        _currentLab1 = [[UILabel alloc] initWithFrame:CGRectMake(10*a,350*a,15*a,20*a)];
        _currentLab1.text = @"¥";
        _currentLab1.textColor = [UIColor redColor];
        _currentLab1.font = [UIFont boldSystemFontOfSize:12*a];
        [self.contentView addSubview:_currentLab1];
    
      CGSize size =[priceArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15*a]}];
        _currentLab2 = [[UILabel alloc]initWithFrame:CGRectMake(20*a,350*a,size.width+20*a,20*a)];
        _currentLab2.text = [NSString stringWithFormat:@"%@.",priceArr[0]];
        _currentLab2.textColor = [UIColor redColor];
        _currentLab2.font = [UIFont boldSystemFontOfSize:15*a];
        [self.contentView addSubview:_currentLab2];
        _currentLab3 = [[UILabel alloc] initWithFrame:CGRectMake(25*a+size.width,350*a,30*a,20*a)];
        _currentLab3.text = priceArr[1];
        _currentLab3.textColor = [UIColor redColor];
        _currentLab3.font = [UIFont boldSystemFontOfSize:12*a];
        [self.contentView addSubview:_currentLab3];
        
        _marketLab = [[UILabel alloc] initWithFrame:CGRectMake(10*a,380*a,80*a,15*a)];
        _marketLab.text = @"市价 ¥60";
        _marketLab.textColor = [UIColor lightGrayColor];
        _marketLab.font = [UIFont systemFontOfSize:12*a];
        [self.contentView addSubview:_marketLab];
//        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,_marketLab.frame.size.height/2,_marketLab.frame.size.width,1)];
//    view.backgroundColor = [UIColor lightGrayColor];
//        [_marketLab addSubview:view];
    
//        _payLab = [[UILabel alloc] initWithFrame:CGRectMake(235*a, 380*a,80*a,15*a)];
//        _payLab.text = @"523251人付款";
//        _payLab.textColor = [UIColor lightGrayColor];
//        _payLab.font = [UIFont systemFontOfSize:12*a];
//        [self.contentView addSubview:_payLab];
    
    _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectBtn.frame = CGRectMake(277*a,350*a,20*a,20*a);
    [_collectBtn setTitle:@"宝贝收藏" forState:UIControlStateNormal];
    [_collectBtn setBackgroundImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    _collectBtn.titleEdgeInsets = UIEdgeInsetsMake(35*a,-10*a,0,-10*a);
    _collectBtn.titleLabel.font = [UIFont systemFontOfSize:8*a];
    [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_collectBtn];
    
        _expressLab = [[UILabel alloc] initWithFrame:CGRectMake(10*a, 405*a,100*a,15*a)];
        _expressLab.textColor = [UIColor lightGrayColor];
        _expressLab.text = @"快递：免运费";
        _expressLab.font = [UIFont systemFontOfSize:13*a];
        [self.contentView addSubview:_expressLab];
        
        _salesLab = [[UILabel alloc] initWithFrame:CGRectMake(150*a, 405*a,100*a,15*a)];
        _salesLab.textColor = [UIColor lightGrayColor];
        _salesLab.text = @"月销556240笔";
        _salesLab.font = [UIFont systemFontOfSize:13*a];
        [self.contentView addSubview:_salesLab];
        
        _addressLab = [[UILabel alloc] initWithFrame:CGRectMake(260*a,405*a,60*a,15*a)];
        _addressLab.textColor = [UIColor lightGrayColor];
        _addressLab.text = @"广西柳州";
        _addressLab.font = [UIFont systemFontOfSize:13*a];
        [self.contentView addSubview:_addressLab];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
