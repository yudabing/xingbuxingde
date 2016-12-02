//
//  ShopViewController.m
//  掌厨
//
//  Created by yubing on 16/10/31.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()
@property (nonatomic,assign) int flag;
@end
@implementation ShopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _flag = 1;
    if (_flag==1) {
    [self.view removeFromSuperview];
    }
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
