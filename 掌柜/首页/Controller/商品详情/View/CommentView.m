//
//  CommentView.m
//  掌柜
//
//  Created by yubing on 2016/11/24.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "CommentView.h"
#import "FourTableViewCell.h"
@interface CommentView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation CommentView
-(NSMutableArray *)commentArr{
    if (_commentArr == nil) {
        _commentArr = [[NSMutableArray alloc] init];
    }
    return _commentArr;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[FourTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.bounces = false;
    [self addSubview:_tableView];
}
#pragma -mark UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil ) {
        cell = [[FourTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140 * MUT_WIDTH;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
