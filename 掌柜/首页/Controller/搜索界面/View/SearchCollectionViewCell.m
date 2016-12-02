//
//  SearchCollectionViewCell.m
//  掌柜
//
//  Created by yubing on 2016/11/14.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell
+ (CGSize) getSizeWithText:(NSString*)text;
{
    CGFloat a = MUT_WIDTH;
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24*a) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    if (size.width>290*a) {
        size.width=290*a;
        return CGSizeMake(size.width-100, 24*a);
    }else{
    return CGSizeMake(size.width+21, 24*a);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_searchImg.layer setMasksToBounds:YES];
    [_searchImg.layer setCornerRadius:12.0];
    [_searchImg setBackgroundColor:[UIColor colorWithWhite:0.957 alpha:1.000]];
}

@end
