//
//  LoginViewController.m
//  掌柜
//
//  Created by yubing on 2016/11/13.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    UITextField * tf1;
    UITextField * tf2;
    int flag;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    flag = 0;
    if (flag==1) {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}
-(void)initUI{
    CGFloat a = MUT_HEIGHT;
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20,WIDTH,30*a)];
    view.image =[UIImage imageNamed:@"2015002.png"];
    view.userInteractionEnabled =YES;
    [self.view addSubview:view];
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15*a,10*a,15*a,15*a);
    [backBtn setImage:[UIImage imageNamed:@"waimai_add_address_arrow@3x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAtion) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80*a,70*a,WIDTH-160*a,80*a)];
    imageView.image = [UIImage imageNamed:@"login7.png"];
    [self.view addSubview:imageView];
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0,0,40*a,40*a)];
    UIImage * tfbg1 = [UIImage imageNamed:@"login4.png"];
    tf1 = [[UITextField alloc] initWithFrame:CGRectMake(50*a,180*a, WIDTH-100*a, 30*a)];
    tf1.returnKeyType =UIReturnKeyDone;
    UIImageView * leftView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10*a,10*a,20*a,20*a)];
    leftView1.image = [UIImage imageNamed:@"login6.png"];
    tf1.leftView = view1;
    tf1.placeholder = @"会员名";
    tf1.leftViewMode = UITextFieldViewModeAlways;
    tf1.delegate = self;
    [tf1 setBackground:tfbg1];
    [view1 addSubview:leftView1];
    [self.view addSubview:tf1];
    
    
    tf2 = [[UITextField alloc] initWithFrame:CGRectMake(50*a,225*a, WIDTH-100*a, 30*a)];
    tf2.returnKeyType =UIReturnKeyDone;
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(0,0,40*a,40*a)];
    UIImageView * leftView2 = [[UIImageView alloc] initWithFrame:CGRectMake(10*a, 10*a,20*a, 20*a)];
    leftView2.image = [UIImage imageNamed:@"login5.png"];
    tf2.leftView = view2;
    tf2.placeholder = @"密码";
    tf2.leftViewMode = UITextFieldViewModeAlways;
    tf2.delegate = self;
    [tf2 setBackground:tfbg1];
    [view2 addSubview:leftView2];
    [self.view addSubview:tf2];
    
    UIImageView * sliderBg = [[UIImageView alloc] initWithFrame:CGRectMake(50*a,270*a,WIDTH-100*a,30*a)];
    sliderBg.image = [UIImage imageNamed:@"login4.png"];
    sliderBg.userInteractionEnabled = YES;
    [self.view addSubview:sliderBg];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(70*a,5*a,160*a,20*a)];
    label.text = @"拖动滑块验证";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14*a];
    [sliderBg addSubview:label];
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(3*a,3.7*a,WIDTH-104*a,24*a)];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    slider.value = 0;
    UIImage * image = [self OriginImage:[UIImage imageNamed:@"login3.png"] scaleToSize:CGSizeMake(60*a,22.6*a)];
    [slider setThumbImage:image forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor clearColor];
    slider.minimumTrackTintColor = [UIColor clearColor];
    [sliderBg addSubview:slider];
    [slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(50*a,330*a,WIDTH-100*a,35*a);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"登录.png"] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    UIButton * freeRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freeRegBtn.frame = CGRectMake(60*a,375*a,60*a,13*a);
    [freeRegBtn setBackgroundImage:[UIImage imageNamed:@"注册1.png"] forState:UIControlStateNormal];
    [self.view addSubview:freeRegBtn];
    
    UIButton * forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(WIDTH-120*a, 375*a,60*a, 13*a);
    [forgetBtn setBackgroundImage:[UIImage imageNamed:@"注册2.png"] forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];
    
    
    UIImageView * otherLog = [[UIImageView alloc] initWithFrame:CGRectMake(10*a,410*a,WIDTH-20*a,10*a)];
    otherLog.image = [UIImage imageNamed:@"login1.png"];
    [self.view addSubview:otherLog];
    
    for (int i=0;i<3;i++) {
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(WIDTH/4*i+105*a,440*a,WIDTH/3-160*a,40*a) ;
        [loginBtn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"login%d.png",i+8]] forState:UIControlStateNormal];
        [self.view addSubview:loginBtn];
    }
    //添加手势键盘回收
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
    [self.view addGestureRecognizer:tap];
    
}
#pragma -mark 返回首页
-(void)backAtion{
    HomePageViewController * hvc = [HomePageViewController new];
    [self.navigationController pushViewController:hvc animated:YES];
}
#pragma  -mark 设置滑动按钮的图片大小
-(UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
#pragma -mark 滑动条value改变的事件
-(void)sliderChange:(UISlider*)slider{
    if (slider.value>=0.5) {
        NSLog(@"=======");
    }
    slider.value=0;
}
#pragma -mark 键盘回收
-(void)onClick:(UITapGestureRecognizer*)tap{
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
}
#pragma -mark UITextFieldDelegate代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField==tf1){
        [tf1 resignFirstResponder];
        [tf2 becomeFirstResponder];
    }else{
        [tf2 resignFirstResponder];
    }
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
