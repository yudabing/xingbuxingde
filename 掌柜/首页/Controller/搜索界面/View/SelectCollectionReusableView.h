//
//  SelectCollectionReusableView.h
//  掌柜
//
//  Created by yubing on 2016/11/14.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectCollectionReusableView;
@protocol UICollectionReusableViewButtonDelegate<NSObject>
- (void)delectData:(SelectCollectionReusableView *)view;
@end
@interface SelectCollectionReusableView : UICollectionReusableView

@property (weak,nonatomic) UIButton *delectButton;
@property (weak, nonatomic) id<UICollectionReusableViewButtonDelegate> delectDelegate;

- (void) setText:(NSString*)text;

- (void) setImage:(NSString *)image;


@end
