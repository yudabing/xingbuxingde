//
//  MyOrderTopTabBar.h
//  掌柜
//
//  Created by yubing on 2016/11/21.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrderTopTabBar;
@protocol MyOrderTopTabBarDelegate <NSObject>
@optional
-(void)tabBar:(MyOrderTopTabBar *)tabBar didSelectIndex:(NSInteger)index;
@end

@interface MyOrderTopTabBar : UIView

@property (nonatomic,weak) id<MyOrderTopTabBarDelegate> delegate;
/**
 静态方法初始化
 */
+(instancetype)tabbar;
/**
 使用数组初始化
 */
-(instancetype)initWithArray:(NSArray*)array;
-(void)AddTarBarBtn:(NSString *)name;//添加顶部标题项的名字
-(void)TabBtnClick:(UIButton *)sender;//监听tabbar的点击
@end
