//
//  SearchCollectionViewCell.h
//  掌柜
//
//  Created by yubing on 2016/11/14.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchCollectionViewCell;
@protocol SelectCollectionCellDelegate <NSObject>
- (void)selectButttonClick:(SearchCollectionViewCell *)cell;
@end
@interface SearchCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchImg;

@property (weak, nonatomic) id<SelectCollectionCellDelegate> selectDelegate;
+ (CGSize) getSizeWithText:(NSString*)text;
@end
