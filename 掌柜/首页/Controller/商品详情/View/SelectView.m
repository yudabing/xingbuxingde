//
//  SelectView.m
//  掌柜
//
//  Created by yubing on 2016/11/25.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "SelectView.h"
@interface SelectView ()<UITextFieldDelegate,TypeSeleteDelegete>{
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;

}
@end
@implementation SelectView
@synthesize whiteView,img,lb_detail,lb_price,lb_stock,mainscrollview,sizeView,colorView,countView,bt_sure,bt_cancle,lb_line,bt_add;
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       // _a = MUT_WIDTH;
        sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",nil];
       colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",@"卡其色",nil];
        NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
        stockarr = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
        NSLog(@"%@",str);
        [self initUI];
    }
    return self;
}
-(void)initUI{
    //装载商品信息的视图
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.frame.size.width, self.frame.size.height-200)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [whiteView addGestureRecognizer:tap];
    
    //商品图片
    img = [[UIImageView alloc] initWithFrame:CGRectMake(10, -20, 100, 100)];
    img.image = [UIImage imageNamed:@"1.jpg"];
    img.backgroundColor = [UIColor yellowColor];
    img.layer.cornerRadius = 4;
    img.layer.borderColor = [UIColor whiteColor].CGColor;
    img.layer.borderWidth = 5;
    [img.layer setMasksToBounds:YES];
    [whiteView addSubview:img];
    
    bt_cancle= [UIButton buttonWithType:UIButtonTypeCustom];
    bt_cancle.frame = CGRectMake(whiteView.frame.size.width-40, 10,30, 30);
    [bt_cancle setBackgroundImage:[UIImage imageNamed:@"close@3x"] forState:0];
    [whiteView addSubview:bt_cancle];
    
    //商品价格
    lb_price = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, 10, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 20)];
    lb_price.textColor = [UIColor redColor];
    lb_price.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:lb_price];
    //商品库存
    lb_stock = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_price.frame.origin.y+lb_price.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40),20)];
    lb_stock.textColor = [UIColor blackColor];
    lb_stock.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:lb_stock];
    //用户所选择商品的尺码和颜色
    lb_detail = [[UILabel alloc] initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+20, lb_stock.frame.origin.y+lb_stock.frame.size.height, whiteView.frame.size.width-(img.frame.origin.x+img.frame.size.width+40+40), 40)];
    lb_detail.numberOfLines = 2;
    lb_detail.textColor = [UIColor blackColor];
    lb_detail.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:lb_detail];
    //分界线
    lb_line = [[UILabel alloc] initWithFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+20, whiteView.frame.size.width, 0.5)];
    lb_line.backgroundColor = [UIColor lightGrayColor];
    [whiteView addSubview:lb_line];
    
    lb_price.text = @"¥100";
    lb_stock.text = @"库存100000件";
    lb_detail.text = @"请选择 尺码 颜色分类";
    
    //加入购物车
    bt_add = [UIButton buttonWithType:UIButtonTypeCustom];
    bt_add.frame = CGRectMake(0, whiteView.frame.size.height-40,whiteView.frame.size.width/2,40);
    [bt_add setBackgroundColor:[UIColor orangeColor]];
    [bt_add setTitleColor:[UIColor whiteColor] forState:0];
    bt_add.titleLabel.font = [UIFont systemFontOfSize:16];
    [bt_add setTitle:@"加入购物车" forState:0];
    [whiteView addSubview:bt_add];
    
    //确定按钮
    bt_sure= [UIButton buttonWithType:UIButtonTypeCustom];
    bt_sure.frame = CGRectMake(bt_add.frame.size.width, whiteView.frame.size.height-40,whiteView.frame.size.width/2, 40);
    [bt_sure setBackgroundColor:[UIColor redColor]];
    [bt_sure setTitleColor:[UIColor whiteColor] forState:0];
    bt_sure.titleLabel.font = [UIFont systemFontOfSize:16];
    [bt_sure setTitle:@"立即购买" forState:0];
    [whiteView addSubview:bt_sure];
    //有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, lb_line.frame.origin.y+lb_line.frame.size.height, whiteView.frame.size.width, bt_sure.frame.origin.y-(lb_line.frame.origin.y+lb_line.frame.size.height))];
    mainscrollview.showsHorizontalScrollIndicator = NO;
    mainscrollview.showsVerticalScrollIndicator = NO;
    [whiteView addSubview:mainscrollview];
    //购买数量的视图
    countView = [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [mainscrollview addSubview:countView];
    [countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    countView.tf_count.delegate = self;
    [countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    
    sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
    sizeView.delegate = self;
    [mainscrollview addSubview:sizeView];
    sizeView.frame = CGRectMake(0, 0, self.frame.size.width,self.sizeView.height);
    //颜色分类
   colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, self.sizeView.frame.size.height, self.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
    if (![colorarr[0] isEqualToString:@"NULL"]) {
        NSLog(@"aaa");
    
        colorView.delegate = self;
        [mainscrollview addSubview:self.colorView];
        colorView.frame = CGRectMake(0, self.sizeView.frame.size.height, self.frame.size.width, self.colorView.height);
    }else{
                colorView.frame = CGRectMake(0,self.sizeView.frame.size.height,self.frame.size.width,0);
    }
    
    //购买数量
    countView.frame = CGRectMake(0, self.colorView.frame.size.height+self.colorView.frame.origin.y, self.frame.size.width, 50);
    mainscrollview.contentSize = CGSizeMake(self.frame.size.width, self.countView.frame.size.height+self.countView.frame.origin.y);
}
-(void)add
{
    int count =[countView.tf_count.text intValue];
    if (count < self.stock) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
    }
}
-(void)reduce
{
    int count =[countView.tf_count.text intValue];
    if (count > 1) {
        countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
    }else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        alert.tag = 100;
        //        [alert show];
    }
}
#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    mainscrollview.contentOffset = CGPointMake(0, countView.frame.origin.y);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int count =[countView.tf_count.text intValue];
    if (count > self.stock) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
        countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];
        [self tap];
    }
}
-(void)tap
{
    mainscrollview.contentOffset = CGPointMake(0, 0);
    [countView.tf_count resignFirstResponder];
}
#pragma mark-typedelegete
-(void)btnindex:(int)tag
{
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (sizeView.seletIndex >=0&&colorView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[sizearr objectAtIndex:sizeView.seletIndex];
        NSString *color =[colorarr objectAtIndex:colorView.seletIndex];
        lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockarr objectForKey: size] objectForKey:color]];
        lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
        _stock =[[[stockarr objectForKey: size] objectForKey:color] intValue];
        
        [self reloadTypeBtn:[stockarr objectForKey:size] :colorarr :colorView];
        [self reloadTypeBtn:[stockarr objectForKey:color] :sizearr :sizeView];
        NSLog(@"%d",colorView.seletIndex);
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",colorView.seletIndex+1]];
    }else if (sizeView.seletIndex ==-1&&colorView.seletIndex == -1)
    {
        //尺码和颜色都没选的时候
        lb_price.text = @"¥100";
        lb_stock.text = @"库存100000件";
        lb_detail.text = @"请选择 尺码 颜色分类";
        _stock = 100000;
        //全部恢复可点击状态
        [self resumeBtn:colorarr :colorView];
        [self resumeBtn:sizearr :sizeView];
        
    }else if (sizeView.seletIndex ==-1&&colorView.seletIndex >= 0)
    {
        //只选了颜色
        NSString *color =[colorarr objectAtIndex:colorView.seletIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSDictionary *dic = [stockarr objectForKey:color];
        [self reloadTypeBtn:dic :sizearr :sizeView];
        [self resumeBtn:colorarr :colorView];
        lb_stock.text = @"库存100000件";
        lb_detail.text = @"请选择 尺码";
        _stock = 100000;
        
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",colorView.seletIndex+1]];
    }else if (sizeView.seletIndex >= 0&&colorView.seletIndex == -1)
    {
        //只选了尺码
        NSString *size =[sizearr objectAtIndex:sizeView.seletIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSDictionary *dic = [stockarr objectForKey:size];
        [self resumeBtn:sizearr :sizeView];
        [self reloadTypeBtn:dic :colorarr :colorView];
        lb_stock.text = @"库存100000件";
        lb_detail.text = @"请选择 颜色分类";
        _stock = 100000;
        
        //        for (int i = 0; i<colorarr.count; i++) {
        //            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
        //            //遍历颜色字典 库存为零则改尺码按钮不能点击
        //            if (count == 0) {
        //                UIButton *btn =(UIButton *) [choseView.colorView viewWithTag:100+i];
        //                btn.enabled = NO;
        //            }
        //        }
        
    }
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
