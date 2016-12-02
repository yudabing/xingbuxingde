//
//  OneTableViewCell.h
//  掌柜
//
//  Created by yubing on 2016/11/22.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewCell : UITableViewCell
-(void)pushDataWithArr:(NSMutableArray*)marr;
@property (nonatomic,retain) NSArray * dataArray;
@property (nonatomic,retain) UIView * scrV;
@property (nonatomic,retain) UILabel * infoLab;
@property (nonatomic,retain) UIImageView * line;
@property (nonatomic,retain) UIButton * shareBtn;
@property (nonatomic,retain) UILabel * currentLab1;
@property (nonatomic,retain) UILabel * currentLab2;
@property (nonatomic,retain) UILabel * currentLab3;
@property (nonatomic,retain) UILabel * marketLab;
@property (nonatomic,retain) UILabel * payLab;
@property (nonatomic,retain) UILabel * expressLab;
@property (nonatomic,retain) UILabel * salesLab;
@property (nonatomic,retain) UILabel * addressLab;
@property (nonatomic,retain) UIButton * collectBtn;
@end
