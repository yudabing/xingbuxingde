//
//  HeaderView.m
//  仿优购
//
//  Created by yubing on 16/10/28.
//  Copyright © 2016年 yubing. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()<UIScrollViewDelegate>{
     BOOL isTimerStart;
}
@property (nonatomic,retain) UIScrollView * scrollView;
@property (nonatomic,retain) UIPageControl * pageControl;
@property (nonatomic,retain) NSMutableArray * picArray;
@property (assign,nonatomic) NSUInteger  currentPageIndex;
@property (assign,nonatomic) int page;
@property (nonatomic,retain) NSTimer * timer;
@property (nonatomic,retain) NSString * str;
@end
@implementation HeaderView

-(NSMutableArray *)picArray{
    if (_picArray==nil) {
        _picArray = [[NSMutableArray alloc] init];
    }
    return _picArray;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
#pragma -mark 获取轮播图数据
-(void)getScrollDataWithArr:(NSArray*)arr AndWithStr:(NSString*)str{
//      AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/html",@"text/plain",@"text/javascript", nil];
//        [manager GET:@"http://news.app.autohome.com.cn/news_v6.0.0/news/shouye-pm1-c0-nt0-p1-s30-l0-sd.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSArray * arr = responseObject[@"result"][@"focusimg"];
//            for (NSDictionary * dict in arr) {
//                [self.picArray addObject:dict[@"imgurl"]];
//            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self initScrollView];
//            });
//        }
//             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             }];
    self.picArray = [NSMutableArray arrayWithArray:arr];
    self.str = str;
    dispatch_async(dispatch_get_main_queue(), ^{
                        [self initScrollView];
                    });
    
}
-(void)initScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,WIDTH,self.frame.size.height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*(_picArray.count+2),_scrollView.bounds.size.height);
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width,0) animated:NO];
    _scrollView.backgroundColor = [UIColor blackColor];
    for (int i =1;i<=self.picArray.count;i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*i,0,_scrollView.bounds.size.width,_scrollView.bounds.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_picArray[i-1]]];
        imageView.userInteractionEnabled=YES;
        [_scrollView addSubview:imageView];
    }
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width*(_picArray.count+1),0,_scrollView.bounds.size.width , _scrollView.bounds.size.height)];
    [imageView1 sd_setImageWithURL:[NSURL URLWithString:_picArray[0]]];
    [_scrollView addSubview:imageView1];
    
    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,_scrollView.bounds.size.width, _scrollView.bounds.size.height)];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString:_picArray[_picArray.count-1]]];
    [_scrollView addSubview:imageView2];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    //添加分页控制器
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,_scrollView.bounds.size.height-30 , _scrollView.bounds.size.width, 30)];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = self.picArray.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    [self reloadInputViews];
    if ([self.str isEqualToString:@"0"]) {
        
    }else{
    [self startTimer];
    }
}
-(void)startTimer{
    //自动滚动
    if (self.timer==nil) {
        isTimerStart = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerAtion) userInfo:nil repeats:YES];
    }
}
-(void)colseTimer{
    if (self.timer) {
        isTimerStart = NO;
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)timerAtion{

    _page ++;
    [_scrollView setContentOffset:CGPointMake((_page)*WIDTH , 0) animated:YES];
    
}
#pragma mack
//滚动完执行
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rect= _scrollView.frame;
    CGSize size1= rect.size;
    CGSize size2= _scrollView.contentSize;
    _page = _scrollView.contentOffset.x/WIDTH;
    [_pageControl setCurrentPage:_page-1];
    if (_page == (size2.width/size1.width)-1) {
        //用语法来设置没有卡顿效果
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
        [_pageControl setCurrentPage:0];
    }
    if (_page == 0) {
        _scrollView.contentOffset = CGPointMake(((size2.width/size1.width)-1.5)*WIDTH, 0);
          [_pageControl setCurrentPage:_picArray.count-1];
    }
   }
// 当手动滚动时，计时器停止。
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self colseTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([self.str isEqualToString:@"0"]) {
        
    }else{
    [self startTimer];
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
