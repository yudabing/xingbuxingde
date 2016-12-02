//
//  HomePageViewController.m
//  掌厨
//
//  Created by yubing on 16/10/31.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "HomePageViewController.h"
#import "HeaderView.h"
#import "ButtonView.h"
#import "GoodListCollectionViewCell.h"
#import "GoodsListModel.h"
#import "DataBaseManager.h"
#import "SearchViewController.h"
#import "GoodsClassifyCell.h"
#import "GoodsClassifyCell1.h"
#import "GoodsClassifyCell2.h"
#import "GoodsClassifyCell3.h"
#import "GoodsClassifyCellOne.h"
#import "GoodsClassifyCellTwo.h"
#import "GoodsClassifyCellThree.h"


@interface HomePageViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UITextField * textField;
}
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) HeaderView * headerView;
@property (nonatomic,strong) ButtonView * buttonView;
@property (nonatomic,strong) UILabel * label;
@property (nonatomic,retain) NSMutableArray * dataArray;
@property (nonatomic,assign) CGRect  targetRect;
@property (nonatomic,retain) DataBaseManager * manager;
@property (nonatomic,assign) CGFloat  a;
@property (nonatomic,assign) CGRect  rect;
@property (nonatomic,retain) NSMutableArray * scrPicArr;
@end
static NSString * headerViewIdentifier = @"hederview";
@implementation HomePageViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.delegate showButton];
}
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   self.navigationController.navigationBarHidden=YES;
   _a = MUT_HEIGHT;
   [self search];
   [self getScrollPic];
   [self creatTableView];
   [self netConnectionstate];
    NSLog(@"1121");
  }
-(void)getScrollPic{
    NSArray * arr = @[@"http://www.wedoboss.com/uploadfile/adv/2016/09/13/1473758275.jpg",@"http://www.wedoboss.com/uploadfile/adv/2016/09/13/1473755891.jpg",@"http://www.wedoboss.com/uploadfile/adv/2016/10/31/1477910938.jpg",@"http://www.wedoboss.com/uploadfile/adv/2016/10/23/1477200778.jpg",@"http://www.wedoboss.com/uploadfile/adv/2016/09/28/1475032943.jpg"];
    _scrPicArr = [NSMutableArray arrayWithArray:arr];
}
-(void)netConnectionstate{
     _manager = [DataBaseManager shareManager];
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    //开始监听
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==AFNetworkReachabilityStatusNotReachable) {
            //无网络
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络无法连接" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAtion = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAtion];
            [self presentViewController:alertController animated:YES completion:nil];
            /*
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络无法连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
             */
            self.dataArray = [_manager selectDataBase];
        }else{
            [self getData];
        }
    }];
}

-(void)getData{
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"正在加载";
    NetWorkingManager * manager = [NetWorkingManager shareManager];
    [manager getDataWithUrl:@"http://wedoboss.com/appapi/product_all.php" AndSuccess:^(id object) {
        NSMutableArray * mArr =[[NSMutableArray alloc] initWithArray:object];
        for (int i = 0;i<17;i++) {
            [self.dataArray addObject:mArr[i]];
        }
        [_manager deleteData];
        [_manager insertDataWithArray:self.dataArray];
       [_collectionView reloadData];
      // [ProgressHUD hideHUDForView:self.view animated:YES];
    } AndFailure:^(NSError *error) {
        
    }];
}

-(void)creatTableView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5.0f;
    //设置头部视图的大小
    layout.headerReferenceSize = CGSizeMake(WIDTH,30);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,59*_a,WIDTH, HEIGHT-100*_a) collectionViewLayout:layout];
    _collectionView.delegate =self;
    _collectionView.dataSource =self;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    [self.view addSubview:_collectionView];
    //注册cell单元格
    [_collectionView registerNib:[UINib nibWithNibName:@"GoodListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];
//    [_collectionView registerNib:[UINib nibWithNibName:@"GoodsClassifyCell" bundle:nil] forCellWithReuseIdentifier:@"GCcell"];
//    [_collectionView registerNib:[UINib nibWithNibName:@"GoodsClassifyCell1" bundle:nil] forCellWithReuseIdentifier:@"GCcell1"];
//    [_collectionView registerNib:[UINib nibWithNibName:@"GoodsClassifyCell2" bundle:nil] forCellWithReuseIdentifier:@"GCcell2"];
    [_collectionView registerNib:[UINib nibWithNibName:@"GoodsClassifyCell3" bundle:nil] forCellWithReuseIdentifier:@"GCcell3"];
    [_collectionView registerClass:[GoodsClassifyCellOne class] forCellWithReuseIdentifier:@"cellOne"];
    [_collectionView registerClass:[GoodsClassifyCellTwo class] forCellWithReuseIdentifier:@"cellTwo"];
    [_collectionView registerClass:[GoodsClassifyCellThree class] forCellWithReuseIdentifier:@"cellThree"];
    
    //注册组头
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self refresh];
        }];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_collectionView.mj_header endRefreshing];
    }];
}
-(void)refresh{
    [_collectionView.mj_footer endRefreshing];

}
-(void)limitedCollectionView{
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(60);
    }];

}
//搜索栏代码
-(void)search{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,20*_a,WIDTH,40*_a)];
    view.backgroundColor = [UIColor whiteColor];
    UIImage * tfbg=[UIImage imageNamed:@"search4.png"];
    tfbg=[tfbg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 30, 30)];
    textField = [[UITextField alloc] initWithFrame:CGRectMake(60*_a,5*_a  ,WIDTH-120*_a,30*_a)];
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,20,5,0)];
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0,5,30,30)];
    UIImageView * rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,15,15)];
    rightImg.image = [UIImage imageNamed:@"search1.png"];
    [rightView addSubview:rightImg];
    textField.leftView = leftView;
    textField.rightView = rightView;
    textField.placeholder = @"搜索";
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [textField setBackground:tfbg];
    [view addSubview:textField];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
     button.frame = CGRectMake(WIDTH-50*_a,5*_a,30*_a,30*_a);
    [button setBackgroundImage:[UIImage imageNamed:@"search2.png"] forState:UIControlStateNormal];
    [view addSubview:button];
    [self.view addSubview:view];
}
#pragma  -mark textField代理方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    SearchViewController * svc = [[SearchViewController alloc] init];
    svc.flag = 1;
    [self.navigationController pushViewController:svc animated:NO];
    [self.delegate hiddenButton];
    return NO;
}
#pragma  -mark collectionView代理方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
        }
        if (_scrPicArr.count>0) {
            NSLog(@"%@",_scrPicArr);
          [_headerView getScrollDataWithArr:_scrPicArr AndWithStr:nil];
            [cell.contentView addSubview:_headerView];
        }
            return cell;
    }
    else if(indexPath.section==1) {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
            
    }
        [cell.contentView addSubview: _buttonView];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if (indexPath.section==2){
        GoodsClassifyCellOne * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellOne" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
//        GoodsClassifyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GCcell" forIndexPath:indexPath];
    
        return cell;
    }
    else if (indexPath.section==3){
        if (indexPath.row%2==0) {
//            GoodsClassifyCell1 * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"GCcell1" forIndexPath:indexPath];
            GoodsClassifyCellTwo * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTwo" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }else{
//            GoodsClassifyCell2 * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"GCcell2" forIndexPath:indexPath];
            GoodsClassifyCellThree * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellThree" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
                return cell;
        }
    }else if (indexPath.section==4){
        GoodsClassifyCell3 * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GCcell3" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    else if(indexPath.section==6){
    GoodsListModel * model =[_dataArray objectAtIndex:indexPath.row];
    GoodListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.label1.text = model.name;
        cell.lable2.text = [NSString stringWithFormat:@"%@:%@",@"¥",model.price];
        cell.label3.text = [NSString stringWithFormat:@"出售%@件",model.sales];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"zgtj.png"]];
        cell.backgroundColor = [UIColor whiteColor];
            return cell;
    }else{
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        for (UIView *view in [cell.contentView subviews]) {
            [view removeFromSuperview];
    }
        return cell;
    }
}

#pragma -mark 设置组头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
           UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100, 30)];
        if (indexPath.section>4) {
        label.text = [NSString stringWithFormat:@"这是第%ld组",(long)indexPath.section];
    }
            for (UIView * view1 in view.subviews) {
                [view1 removeFromSuperview];
            } // 防止复用分区头
            [view addSubview:label];
            return view;
    }else{
        return nil;
    }
}

#pragma -mark 设置每组的cell的边界, 具体看下图
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==3) {
        return UIEdgeInsetsMake(1, 0, 10, 0);
    }else if(section==2){
        return UIEdgeInsetsMake(0.4, 0,0,0);
    }else{
        return UIEdgeInsetsMake(0,0,0,0);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section<3) {
        return CGSizeMake(WIDTH,0);
    }else{
        return CGSizeMake(WIDTH,50);
    }
}
#pragma -mark 返回cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{
    if (indexPath.section<2) {
      _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0,0, WIDTH,180*_a)];
      _buttonView = [[ButtonView alloc] initWithFrame:CGRectMake(0,0,WIDTH, 180*_a)];
       return CGSizeMake(WIDTH,180*_a);
    }else if (indexPath.section==2){
       return CGSizeMake(WIDTH,450*_a);
    }
    else if (indexPath.section==3) {
       return CGSizeMake(WIDTH,200*_a);
    }else if (indexPath.section==4) {
       return CGSizeMake(WIDTH,370*_a);
    }else{
       return CGSizeMake(WIDTH/2-0.5,180*_a);
    }
    
}
#pragma -mark 返回最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section==3){
        return 5;
    }else{
        return 1;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
#pragma -mark 不同的section返回cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section<3){
        return 1;
    }else if(section==3){
        return 12;
    }else if(section==4){
        return 1;
    }else if(section==5){
        return 4;
    }else{
        return 8;
    }
    
}
#pragma -mark 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 7;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==6) {
        DetailViewController * dvc = [DetailViewController new];
        GoodsListModel * modoel = _dataArray[indexPath.row];
        DetailModel * modoel1 = [DetailModel new];
        modoel1.name = modoel.name;
        modoel1.pic_more = modoel.pic_more;
        modoel1.price = modoel.price;
        dvc.modelArray = [NSMutableArray arrayWithObject:modoel1];
        [self.navigationController pushViewController:dvc animated:NO];
        [self.delegate hiddenButton];
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
