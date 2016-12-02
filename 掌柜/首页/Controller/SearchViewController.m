//
//  SearchViewController.m
//  掌柜
//
//  Created by yubing on 16/11/4.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultViewController.h"
#import "SelectCollectionLayout.h"
#import "SearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "DetailViewController.h"
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionReusableViewButtonDelegate>{
    UITextField * searchTextField;
}
@property (nonatomic,retain) DataBaseManager * manager;
@property (nonatomic,retain) UITableView * tableView;
@property (nonatomic,retain) UIView * BgView;
@property (nonatomic,retain) NSMutableArray * mArr;
@property (nonatomic,retain) UIImageView * imgView;
@property (nonatomic,assign) int a;
@property (nonatomic,assign) int onClikIndex;
@property (nonatomic,retain) NSMutableArray * allDataArray;
@property (nonatomic,retain) NSMutableArray * searchArray;
@property (nonatomic,retain) UIView * tabBgView;
@property (nonatomic,retain) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray *sectionArray;//热搜
@property (nonatomic,retain) NSMutableArray * sumArray;
@property (nonatomic,retain) NetWorkingManager * Netmanager;
@property (nonatomic,retain) NSMutableArray * modelArray;
@end
static NSString *const cxSearchCollectionViewCell = @"SearchCollectionViewCell";
static NSString *const headerViewIden = @"HeadViewIden";

@implementation SearchViewController
-(void)viewWillAppear:(BOOL)animated{
    //接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tzAction:) name:@"tz" object:nil];
    [searchTextField becomeFirstResponder];
    }
-(NSMutableArray *)mArr{
    if (_mArr==nil) {
        _mArr = [[NSMutableArray alloc] init];
    }
    return _mArr;
}
-(NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}
-(NSMutableArray *)sumArray{
    if (_sumArray==nil) {
        _sumArray = [[NSMutableArray alloc] init];
    }
    return _sumArray;
}
-(NSMutableArray *)modelArray{
    if (_modelArray==nil) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}
-(NetWorkingManager *)Netmanager{
    if (_Netmanager==nil) {
        _Netmanager = [NetWorkingManager shareManager];
    }
    return _Netmanager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _a = MUT_WIDTH;
    _mArr = [[NSMutableArray alloc] init];
    _manager = [DataBaseManager shareManager];
    [self createCollectionView];
    [self search];
   //[_manager deleteAllSearch];
    
    
   
   
}
#pragma -mark 回调通知
- (void)tzAction:(NSNotification *)sender {
    [searchTextField resignFirstResponder];
    self.searchStr = sender.userInfo[@"key"];
    searchTextField.text = self.searchStr;
    [self showTabelView:self.searchStr];
    }
// 移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma -mark 创建collectionViewCell
-(void)createCollectionView{
    [self prepareData];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //设置头部视图的大小
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,60,WIDTH, HEIGHT-100*_a) collectionViewLayout:layout];
    [_collectionView setCollectionViewLayout:[[SelectCollectionLayout alloc] init] animated:NO];
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [_collectionView registerNib:[UINib nibWithNibName:@"SearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
}
- (void)prepareData{
    _mArr = [_manager selectSearchResult];
    NSArray * arr =@[@"dadasd",@"qweew",@"qeweqeqeqeqeqeq",@"qweqw",@"1e1e",@"qweqw",@"ddqwqeqw"];
    _sectionArray = [NSMutableArray arrayWithArray:arr];
    _sumArray = [NSMutableArray arrayWithArray:_sectionArray];
    for (NSString * str in _mArr) {
        [_sumArray addObject:str];
    }
}
#pragma -mark 创建tableView
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60*_a, WIDTH, HEIGHT-60*_a) style:UITableViewStylePlain];
    //不显示多余的cell
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1001;
    [self.view addSubview:_tableView];
    _searchArray = [[NSMutableArray alloc] init];
    _tabBgView.userInteractionEnabled = YES;
    self.view.userInteractionEnabled= YES;
}
-(void)btnAtion{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)search{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,20,WIDTH,40)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,10,60,20);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn addTarget:self action:@selector(btnAtion) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
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
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:255/255.0 green:70/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchAtion) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [self.view addSubview:view];
    //添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
    tap.delegate =self;
    [self.view addGestureRecognizer:tap];
}
#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return _sectionArray.count;
    }else{
        return _mArr.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
    if (indexPath.section==0) {
        cell.searchLabel.text = _sectionArray[indexPath.row] ;
    }else{
        cell.searchLabel.text = _mArr[_mArr.count-indexPath.row-1];
        cell.searchLabel.tag = indexPath.row;
        //长按
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dealLongPress:)];
        longPress.minimumPressDuration = 0.3;
        [cell.searchImg addGestureRecognizer:longPress];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAtion:)];
        [cell.searchImg addGestureRecognizer:tap];
        cell.searchImg.userInteractionEnabled = YES;
        cell.searchImg.tag =100+indexPath.row;

    }
       return cell;
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
        return 2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setText:@"热门搜索"];
            [view setImage:@"caixiang_05.png"];
            view.delectButton.hidden = YES;
        }else{
            [view setText:@"搜索历史"];
            [view setImage:@"search.png"];
            view.delectButton.hidden = NO;
        }
        reusableview = view;
    }
    return reusableview;
}
- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [SearchCollectionViewCell getSizeWithText:_sectionArray[indexPath.row]];
    }else{
        return [SearchCollectionViewCell getSizeWithText:_mArr[_mArr.count-indexPath.row-1]];
    }
    //return CGSizeMake(80, 24);
}


#pragma -mark tabelView代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID =@"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5,WIDTH-20,40)];
        label.tag =101;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];

    }
    UILabel * label = [cell.contentView viewWithTag:101];
    if (_searchArray.count>0) {
      label.text = [_searchArray objectAtIndex:indexPath.row];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultViewController * svc = [SearchResultViewController new];
    svc.searchStr = _searchArray[indexPath.row];
    svc.modelArr = [NSMutableArray arrayWithObject:_modelArray[indexPath.row]];
    [self deleterepeat:svc.searchStr];
    [self.navigationController pushViewController:svc animated:NO];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    else {
        return YES;
    }
}
#pragma -mark 清空
-(void)delectData:(SelectCollectionReusableView *)view{
    [self popup:@"确定清空历史记录"];
    self.flag =0;
}
#pragma -mark 手势
-(void)pushAtion:(UITapGestureRecognizer*)tap{
//    int index =(int)[tap view].tag;
//    SearchResultViewController * svc = [SearchResultViewController new];
//    svc.searchStr = _mArr[(int)_mArr.count-index+99];
//    [self.navigationController pushViewController:svc animated:NO];
    DetailViewController * dvc = [DetailViewController new];
    [self.navigationController pushViewController:dvc animated:NO];
}
-(void)dealLongPress:(UILongPressGestureRecognizer*)longPress{
    [searchTextField resignFirstResponder];
    UILongPressGestureRecognizer * longPress1 = longPress;
    _onClikIndex =(int)[longPress1 view].tag-100;
    if(longPress.state == UIGestureRecognizerStateBegan)
    {
        [self popup:@"确定删除该历史记录"];
        self.flag =1;
    }

}
#pragma -mark 弹出框
-(void)popup:(NSString*)str{
    _BgView = [UIView new];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    _BgView = [[UIView alloc] initWithFrame:CGRectMake(0,20,WIDTH,HEIGHT)];
    [_BgView setBackgroundColor:[UIColor colorWithRed:0.3
                                                green:0.3
                                                 blue:0.3
                                                alpha:0.5]];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_BgView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake((WIDTH-200*_a)/2,HEIGHT/2-70*_a,200*_a,100*_a)];
    view.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    [_BgView addSubview:view];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(3*_a,10*_a,200*_a,50)];
    label.text = str;
    label.font = [UIFont systemFontOfSize:16];
    [view addSubview:label];
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(5*_a,60*_a,(200-15)*_a/2,35);
    cancelBtn.backgroundColor = [UIColor lightGrayColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(canceAtion) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(10*_a+(200-15)*_a/2,60*_a,(200-15)*_a/2,35);
    okBtn.backgroundColor = [UIColor redColor];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okAtion) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:okBtn];
    UITapGestureRecognizer * back = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAtion)];
    [_BgView addGestureRecognizer:back];
    
}
#pragma -mark button的点击事件
-(void)backAtion{
    _BgView.hidden = YES;
}
-(void)canceAtion{
    _BgView.hidden = YES;
}
-(void)okAtion{
    if (self.flag==0) {
        [_manager deleteAllSearch];
        [_mArr removeAllObjects];
    }else{
        int index =(int)_mArr.count-_onClikIndex-1;
        [_manager deleteSearch:_mArr[index]];
        [_mArr removeObjectAtIndex:index];

    }
    [_collectionView reloadData];
    _BgView.hidden = YES;
}

#pragma -mark 键盘回收
-(void)onClick:(UITapGestureRecognizer*)tap{
    [searchTextField resignFirstResponder];
}

#pragma -mark UITextFieldDelegate代理方法
//点击return
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self searchOnclik];
        return YES;
}
-(void)searchAtion{
    [self searchOnclik];
}
-(void)searchOnclik{
    [searchTextField becomeFirstResponder];
    SearchResultViewController * svc = [SearchResultViewController new];
    svc.searchStr = searchTextField.text;
    svc.modelArr = [NSMutableArray arrayWithArray:_modelArray];
    [self deleterepeat:svc.searchStr];
    [self.navigationController pushViewController:svc animated:NO];

}
-(void)deleterepeat:(NSString*)string{
    for (NSString * str in _mArr) {
        if ([string isEqualToString:str]) {
        [_manager deleteSearch:string];
        }
    }
    [_manager insertSearchDataWithStr:string];
}
//编辑改变
-(void)textFieldDidChange:(UITextField*) TextField{
    [self createTableView];
    [searchTextField becomeFirstResponder];
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tianbigao.tk/zgApi/api/Product/getProduct/name/%@",TextField.text];
    NSLog(@"%@",[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
    NetWorkingManager * manager = [NetWorkingManager shareManager];
    [manager getSearchDataWithUrl:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                           AndSuccess:^(id object) {
        [_searchArray removeAllObjects];
                               _modelArray =[NSMutableArray arrayWithArray:object];
        for (SearchModel * model in object) {
            [_searchArray addObject:model.name];
                               }
        [_tableView reloadData];

    } AndDataWithUrl:^(NSError *error) {
        
    }];
        //通知主线程刷新
            if (TextField.text.length==0) {                 [_searchArray removeAllObjects];
                [self createCollectionView];
                for (UIView *subviews in [self.view subviews]) {
                    if (subviews.tag==1001) {
                        [subviews removeFromSuperview];
                    }
                }
            }
            [_tableView reloadData];
        }

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsety = scrollView.contentOffset.y;
    if(contentOffsety>-20){
        //NSLog(@"%d",contentOffsety);
    [searchTextField resignFirstResponder];
    }
}
-(void)showTabelView:(NSString*)searchStr{
    [self createTableView];
    [searchTextField becomeFirstResponder];
    NetWorkingManager * manager = [NetWorkingManager shareManager];
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tianbigao.tk/zgApi/api/Product/getProduct/name/%@",searchStr];
    [manager getSearchDataWithUrl:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                       AndSuccess:^(id object) {
                           [_searchArray removeAllObjects];
                           for (SearchModel * model in object) {
                               _modelArray =[NSMutableArray arrayWithArray:object];
                               [_searchArray addObject:model.name];
                           }
                           [_tableView reloadData];
                           
                       } AndDataWithUrl:^(NSError *error) {
                           
                       }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    _tableView.hidden = YES;
    return YES;
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
