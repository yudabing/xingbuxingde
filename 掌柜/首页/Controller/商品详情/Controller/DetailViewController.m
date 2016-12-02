//
//  DetailViewController.m
//  掌柜
//
//  Created by yubing on 2016/11/21.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "DetailViewController.h"
#import "MyOrderTopTabBar.h"
#import "OneTableViewCell.h"
#import "TowTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "FourTableViewCell.h"
#import "FiveTableViewCell.h"
#import "SixTableViewCell.h"
#import "CommentView.h"
#import "SelectView.h"
#import <WebKit/WebKit.h>
#import "DetailModel.h"
#define url http://cont.app.autohome.com.cn/autov4.6/content/news/newscontent-n896162-t0.json
#define BottomH 40*MUT_WIDTH
#define NaviBarH 50
@interface DetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,MyOrderTopTabBarDelegate>
@property (nonatomic,retain) UIScrollView * myScrollView;
@property (nonatomic,retain) UITableView * tableView;
@property (nonatomic,retain) UITableView * tableView1;
@property (nonatomic,retain) UIImageView * naviBarV;
@property (nonatomic,retain) UIView * backView;
@property (nonatomic,retain) UIView * backV;
@property (nonatomic,retain) UIButton * backBtn;
@property (nonatomic,retain) UIButton * shopBtn;
@property (nonatomic,weak) MyOrderTopTabBar * TopTabBar;
@property (nonatomic,assign) CGFloat a;
@property (nonatomic,retain) CommentView * comView;
@property (nonatomic,assign) BOOL show;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,retain) SelectView * selectView;
@property (nonatomic,retain) WKWebView * webView;
@property (nonatomic,retain) NSMutableArray * dataArray;
@end
@implementation DetailViewController
@synthesize secondPageView;

-(UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] init];
        _myScrollView.delegate = self;
        _myScrollView.frame = CGRectMake(0,20,WIDTH,HEIGHT-BottomH-20);
        _myScrollView.userInteractionEnabled = YES;
        _myScrollView.pagingEnabled = YES;//进行分页
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.tag = 0 ;
        _myScrollView.bounces = false;
        [self.view addSubview:_myScrollView];
        
        _comView = [[CommentView alloc] initWithFrame:CGRectMake(WIDTH,NaviBarH,WIDTH,HEIGHT-BottomH-NaviBarH)];
        [self.view addSubview:_comView];
        
        }
    return _myScrollView;
}
-(UITableView *)tabelView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT-BottomH-20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = 1;
        //_tableView.bounces = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OneTableViewCell class] forCellReuseIdentifier:@"oneCell"];
        [_tableView registerClass:[TowTableViewCell class] forCellReuseIdentifier:@"towCell"];
        [_tableView registerClass:[ThreeTableViewCell class] forCellReuseIdentifier:@"threeCell"];
        [_tableView registerClass:[FourTableViewCell class] forCellReuseIdentifier:@"fourCell"];
        [_tableView registerClass:[FiveTableViewCell class] forCellReuseIdentifier:@"fiveCell"];
         [_tableView registerClass:[SixTableViewCell class] forCellReuseIdentifier:@"sixCell"];
            }
  
    return _tableView;
}
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:42];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _a = MUT_WIDTH;
    [self getData];
    [self initView];
    self.automaticallyAdjustsScrollViewInsets = false;
    }
-(void)getData{
    DetailModel * model = self.modelArray[0];
    if (model.pic_more !=nil) {
        NSLog(@"===1212%@",self.modelArray);
        self.dataArray = self.modelArray;
        [_tableView reloadData];
    }else{
     NSLog(@"%@",[NSString stringWithFormat:@"http://www.tianbigao.tk/zgApi/Api/Product/details/id/%@",self.ID]);
    NetWorkingManager * manager = [NetWorkingManager new];
    [manager getDetailDataWithUrl:[NSString stringWithFormat:@"http://www.tianbigao.tk/zgApi/Api/Product/details/id/%@",self.ID] AndSuccess:^(id object) {
        //DetailModel * model = object[0];
        _dataArray = object;
        [_tableView reloadData];
        } AndDataWithUrl:^(NSError *error) {
        
    }];
    }
}
-(void)initView{
    UIView * firstPageView = [[UIView alloc] init];
    firstPageView.frame = CGRectMake(0,0,WIDTH,self.myScrollView.frame.size.height);
    firstPageView.backgroundColor = [UIColor lightGrayColor];
    [self.myScrollView addSubview:firstPageView];
    [firstPageView addSubview:self.tabelView];
    _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self refresh];
    }];

    _naviBarV = [[UIImageView alloc] initWithFrame:CGRectMake(0,20, WIDTH,NaviBarH)];
    _naviBarV.userInteractionEnabled = YES;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(10*_a,5,40,40)];
    _backView.layer.cornerRadius = 20;
    _backView.layer.masksToBounds= YES;
    self.backView.backgroundColor =  color(47.0,40.0,42.0,0.5);
    [_naviBarV addSubview:_backView];
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"waimai_add_address_arrow@3x.png"] forState:UIControlStateNormal];
    _backBtn.frame = CGRectMake(12.5,10,15,20);
    [_backBtn addTarget:self action:@selector(buttonAtion) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAtion)];
    [_backView addGestureRecognizer:tap];

    [_backView addSubview:_backBtn];
    
    _backV = [[UIView alloc] initWithFrame:CGRectMake(260*_a,5,40,40)];
    _backV.layer.cornerRadius = 20;
    _backV.layer.masksToBounds= YES;
    _backV.userInteractionEnabled = YES;
    self.backV.backgroundColor =  color(47.0,40.0,42.0,0.5);
    [_naviBarV addSubview:_backV];
    _shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shopBtn setBackgroundImage:[UIImage imageNamed:@"tb_cart_recommend_cart@2x.png"] forState:UIControlStateNormal];
    _shopBtn.frame = CGRectMake(10,10,20, 20);
    [_shopBtn addTarget:self action:@selector(buttonAtion) forControlEvents:UIControlEventTouchUpInside];
    [_backV addSubview:_shopBtn];
    
    //_naviBarV.backgroundColor = [UIColor redColor];
    [self.view addSubview:_naviBarV];
    //初始化第二个页面
    [self addSecondPageTopTabBar];
    [self initBottomView];
    // 设置scrollview内容区域大小
    self.myScrollView.contentSize = CGSizeMake(WIDTH, (HEIGHT - BottomH-20)*2);
    [self initSelectView];

}
-(void)refresh{
    NSLog(@"===as=ssa");
    NSOperationQueue* Queue = [[NSOperationQueue alloc] init];
    [Queue addOperationWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.myScrollView.contentOffset = CGPointMake(0,HEIGHT-BottomH-20);
            } completion:^(BOOL finished) {
                self.myScrollView.scrollEnabled = YES;
                [_tableView.mj_footer endRefreshing];
            }];
        });
    }];

}
-(void)initSelectView{
    _selectView = [[SelectView alloc] initWithFrame:CGRectMake(0,HEIGHT,WIDTH,HEIGHT-20)];
    [self.view addSubview:_selectView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_selectView addGestureRecognizer:tap];
    [_selectView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_selectView.bt_sure addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}
//hidden selectView
-(void)dismiss
{
    CGRect selectView = self.selectView.frame;
    [SelectView animateWithDuration:0.2 animations:^{
        self.selectView.frame= CGRectMake(0,HEIGHT, selectView.size.width, selectView.size.height);
        [_selectView setBackgroundColor:[UIColor colorWithRed:0
                                          green:0
                                          blue:0
                                          alpha:0.8]];
    }];
    
}

-(void)addSecondPageTopTabBar{
    secondPageView = [[UIView alloc] init];
    secondPageView.frame = CGRectMake(0, HEIGHT -BottomH-20, WIDTH, HEIGHT - BottomH-20);
    secondPageView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.5];
    NSArray * array = @[@"图文详情",@"产品参数",@"店铺推荐"];
    MyOrderTopTabBar * tabBar = [[MyOrderTopTabBar alloc] initWithArray:array];
    tabBar.frame = CGRectMake(0,50, WIDTH,50);
    tabBar.backgroundColor = [UIColor grayColor];
    tabBar.delegate = self;
    self.TopTabBar = tabBar;
    [secondPageView addSubview:tabBar];
    //secondPageView.tag = 1;
    [self.myScrollView addSubview:secondPageView];
    [self initWebView];
   }
-(void)endRefresh{
    NSLog(@"cnm");
    [_tableView1.mj_footer endRefreshing];
}
/**
 添加底部购买按钮和加入购物车按钮的view
 */
-(void)initBottomView{
    UIView* view = [[UIView alloc] init];
    view.frame = CGRectMake(0,CGRectGetMaxY(self.myScrollView.frame), WIDTH, BottomH);
    view.backgroundColor = [UIColor whiteColor];
    NSArray * titleArr = @[@"联系卖家",@"进入店铺",@"收藏店铺"];
    NSArray * imgArr = @[@"11.png",@"12.png",@"13.png"];
    for (int i =0;i<3;i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10*_a+(40*_a+2)*i,5*_a, 23*_a,20*_a);
        [btn setBackgroundImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:8*_a];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(45*_a,-10*_a,5*_a, -10*_a);
        [view addSubview:btn];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((40*_a+1)*(i+1),0,0.5,BottomH)];
        imageView.image = [UIImage imageNamed:@"entry_bg.png"];
        [view addSubview:imageView];
    }
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(120*_a+3,0,99*_a,BottomH);
    [btn1 setTitle:@"加入购物车" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor orangeColor];
    [view addSubview:btn1];
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(219*_a+3,0,99*_a,BottomH);
    [btn2 setTitle:@"立即购买" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    [view addSubview:btn2];
    [self.view addSubview:view];
    }

#pragma -- <UIScrollViewDelegate>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if(scrollView.tag == 1){
        // NSLog(@"%f",scrollView.contentOffset.y);
        //scrollView.bounces = (scrollView.contentOffset.y <20) ? NO : YES;
        if(scrollView.contentOffset.y<0){
            scrollView.contentOffset = CGPointMake(0,0);
        }else if(scrollView.contentOffset.y>=0){
      self.naviBarV.backgroundColor = color(255.0,255.0,255.0, scrollView.contentOffset.y/(300*MUT_WIDTH-40));
      self.backView.backgroundColor =  color(47.0,40.0,42.0, 0.5-scrollView.contentOffset.y/(HEIGHT-BottomH-300));
      self.backV.backgroundColor =  color(47.0,40.0,42.0, 0.5-scrollView.contentOffset.y/(HEIGHT-BottomH-300));
            _y = scrollView.contentOffset.y;
        }
      if (scrollView.contentOffset.y>=300*MUT_WIDTH-40*_a) {
          _naviBarV.image = [UIImage imageNamed:@"2015002.png"];
      }else{
        _naviBarV.image = [UIImage imageNamed:@""];
        self.naviBarV.backgroundColor = color(255.0,255.0,255.0, scrollView.contentOffset.y/(300*MUT_WIDTH-40*_a));
      }
        }else{
 //           NSLog(@"=====%f",scrollView.contentOffset.y);
//            
//            if(scrollView.contentOffset.y == HEIGHT-BottomH-20){
//                scrollView.contentOffset = CGPointMake(0,HEIGHT-BottomH-20);
//                //scrollView.scrollEnabled = NO;
//            }else if (scrollView.contentOffset.y == -NaviBarH && !scrollView.isDragging){
//                [UIView animateWithDuration:0.3 animations:^{
//                    scrollView.contentOffset = CGPointMake(0,20);
//                }];
//            }else;
        }
}
#pragma 点击button
-(void)buttonAtion{
    if (_show) {
        if (_y/(300*MUT_WIDTH-40)<=1) {
    _naviBarV.image = [UIImage imageNamed:@""];
    self.naviBarV.backgroundColor = color(255.0,255.0,255.0, _y/(300*MUT_WIDTH-40));
        }else{
            _naviBarV.image = [UIImage imageNamed:@"2015002.png"];
        }
    CGRect rightRect = self.comView.frame;
    self.comView.frame= CGRectMake(rightRect.origin.x + rightRect.size.width, rightRect.origin.y, rightRect.size.width, rightRect.size.height);
        _show = NO;

    }else{
    [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)showComment{
    //弹出右部视图
    CGRect rightRect = self.comView.frame;
    [CommentView animateWithDuration:0.5 animations:^{
            self.comView.frame= CGRectMake(0, rightRect.origin.y, rightRect.size.width, rightRect.size.height);
            _show = YES;
    _naviBarV.image = [UIImage imageNamed:@"2015002.png"];
    }];
}
-(void)initWebView{
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,100,WIDTH,secondPageView.frame.size.height-100) configuration:config];
    [secondPageView addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cont.app.autohome.com.cn/autov4.6/content/news/newscontent-n896162-t0.json"]]];
}

#pragma -- MyOrderTopTabBarDelegate(顶部标题栏delegate)
-(void)tabBar:(MyOrderTopTabBar *)tabBar didSelectIndex:(NSInteger)index{
    if (index == 0) {
        [secondPageView addSubview:_webView];
    }else
    if (index == 1){
        _tableView1= [[UITableView alloc] initWithFrame:CGRectMake(0,100,WIDTH,secondPageView.frame.size.height-100) style:UITableViewStylePlain];
        _tableView1.delegate = self;
        _tableView1.dataSource = self;
        _tableView1.tag = 2;
        _tableView1.bounces = false;
        [secondPageView addSubview:_tableView1];
                
    }
}
#pragma mark -- UITableView DataSource && Delegate
//返回表格分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==1) {
    return 6;
    }
    else{
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
    if (indexPath.row==0) {
        return 426.666667 * MUT_WIDTH;
    }else if(indexPath.row==1){
        return 30 * MUT_WIDTH;
    }else if (indexPath.row==2){
        return 50 * MUT_WIDTH;
    }else if (indexPath.row==3){
        return 140 * MUT_WIDTH;
    }else if (indexPath.row==4){
        return 200 * MUT_WIDTH;
    }else{
        return 60 * MUT_WIDTH;
    }
    }else{
        return 100;
    }
}
//定制单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
    if (indexPath.row==0) {
        OneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[OneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"oneCell"];
        }
        [cell pushDataWithArr:self.dataArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row==1){
        TowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"towCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[TowTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"towCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:0.3];
        return cell;
    }else if (indexPath.row==2){
        ThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[ThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"threeCell"];
        }
        cell.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.2];
        return cell;
    }else if (indexPath.row==3){
        FourTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fourCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[FourTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"fourCell"];
        }
        [cell.allmsgBtn addTarget:self action:@selector(showComment) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==4){
        FiveTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"fiveCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[FiveTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"fiveCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.2];
        return cell;
    }else{
        SixTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"sixCell" forIndexPath:indexPath];
        if (cell==nil) {
            cell = [[SixTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sixCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.5];
        return cell;
    }
    }else{
        static NSString * cellID = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
        return cell;
    }
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==2) {
        [self showSelectView];
    }
}
//显示选择尺寸视图
-(void)showSelectView{
    CGRect selectView = self.selectView.frame;
    [SelectView animateWithDuration:0.5 animations:^{
        self.selectView.frame= CGRectMake(0,20, selectView.size.width, selectView.size.height);
    [_selectView setBackgroundColor:[UIColor colorWithRed:0
                                                    green:0
                                                     blue:0
                                                    alpha:0.8]];
    }];
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
