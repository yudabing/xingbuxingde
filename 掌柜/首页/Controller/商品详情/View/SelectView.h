//
//  SelectView.h
//  掌柜
//
//  Created by yubing on 2016/11/25.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"
#import "BuyCountView.h"
@interface SelectView : UIView
@property(nonatomic, retain)UIView *whiteView;
@property(nonatomic, retain)UIImageView *img;
@property(nonatomic, retain)UILabel *lb_price;
@property(nonatomic, retain)UILabel *lb_stock;
@property(nonatomic, retain)UILabel *lb_detail;
@property(nonatomic, retain)UILabel *lb_line;

@property(nonatomic, retain)UIScrollView *mainscrollview;

@property(nonatomic, retain)TypeView *sizeView;
@property(nonatomic, retain)TypeView *colorView;
@property(nonatomic, retain)BuyCountView *countView;

@property(nonatomic, retain)UIButton *bt_sure;
@property(nonatomic, retain)UIButton *bt_cancle;
@property(nonatomic, retain)UIButton *bt_add;

@property(nonatomic) int stock;

@end
