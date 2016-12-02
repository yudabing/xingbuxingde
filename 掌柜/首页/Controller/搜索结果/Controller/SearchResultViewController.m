//
//  SearchResultViewController.m
//  掌柜
//
//  Created by yubing on 2016/11/13.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DetailViewController.h"
#import "SearchModel.h"

@interface SearchResultViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextField * searchTextField;
}
@property (nonatomic,retain) UITableView * tableView;
@property (nonatomic,assign) int a;
@property (nonatomic,retain) NSMutableArray * dataArray;
@end

@implementation SearchResultViewController
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _a = MUT_WIDTH;
    [self getData];
    [self search];
    [self initBtn];
    [self creatTableView];
    if (self.modelArr.count>0) {
        self.dataArray = [NSMutableArray arrayWithArray:self.modelArr];
        [_tableView reloadData];
    }else{
    [self getData];
    }
}
-(void)getData{
    NetWorkingManager * manager = [NetWorkingManager shareManager];
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tianbigao.tk/zgApi/api/Product/getProduct/name/%@",self.searchStr];
    NSLog(@"%@",[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
    [manager getSearchDataWithUrl:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                       AndSuccess:^(id object) {
                           for (SearchModel * model in object) {
                            [self.dataArray addObject:model];
                           }
                           [_tableView reloadData];
                           
                       } AndDataWithUrl:^(NSError *error) {
                           
                       }];
}
-(void)creatTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, HEIGHT-60) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    
}
-(void)initBtn{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,25,60, 30);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
-(void)search{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,20,WIDTH,40)];
    view.backgroundColor = [UIColor whiteColor];
    UIImage * tfbg=[UIImage imageNamed:@"search4.png"];
    tfbg=[tfbg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 30, 30)];
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(60,5 ,WIDTH-120,30)];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,20,5,0)];
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0,5,40,40)];
    UIImageView * rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,15,15)];
    rightImg.image = [UIImage imageNamed:@"search1.png"];
    [rightView addSubview:rightImg];
    searchTextField.text = self.searchStr;
    searchTextField.leftView = leftView;
    searchTextField.rightView = rightView;
    searchTextField.placeholder = @"搜索";
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.rightViewMode = UITextFieldViewModeAlways;
    searchTextField.delegate = self;
    [searchTextField setBackground:tfbg];
    //设置键盘
    searchTextField.returnKeyType = UIReturnKeySearch;
    [view addSubview:searchTextField];
    [searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH-50,10,50,30);
   // [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:255/255.0 green:70/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [view addSubview:button];
    [self.view addSubview:view];
    //添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
    //[self.view addGestureRecognizer:tap];
    
}
#pragma -mark tableView代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID =@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*_a,10*_a,80*_a,80*_a)];
        imageView.tag = 101;
        [cell.contentView addSubview:imageView];
        
        UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(110*_a,15*_a,WIDTH-120*_a,40*_a)];
        nameLab.tag = 102;
        nameLab.font = [UIFont systemFontOfSize:14];
        nameLab.numberOfLines = 0;
        [cell.contentView addSubview:nameLab];
        
        UILabel * priceLab = [[UILabel alloc] initWithFrame:CGRectMake(110*_a,70*_a,80*_a,20*_a)];
        priceLab.tag = 103;
        priceLab.font = [UIFont systemFontOfSize:12];
        priceLab.textColor = [UIColor redColor];
        [cell.contentView addSubview:priceLab];

    }
    SearchModel * model = _dataArray[indexPath.row];
    UIImageView * imageView = [cell.contentView viewWithTag:101];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    UILabel * nameLab = [cell.contentView viewWithTag:102];
    nameLab.text = model.name;
    UILabel * priceLab = [cell.contentView viewWithTag:103];
    priceLab.text = [NSString stringWithFormat:@"¥ %@",model.price];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
#pragma -mark 键盘回收

-(void)onClick:(UITapGestureRecognizer*)tap{
    [searchTextField resignFirstResponder];
}
-(void)btnAction{
    [self back];
}
#pragma -mark 编辑时返回上一页
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self back];
    return YES;
}
-(void)back{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tz" object:nil userInfo:@{@"key":self.searchStr}];
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchModel * model = _dataArray[indexPath.row];
    DetailViewController * dvc = [DetailViewController new];
    dvc.ID = model.ID;
    [self.navigationController pushViewController:dvc animated:NO];
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
