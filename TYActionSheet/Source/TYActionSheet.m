//
//  TYActionSheet.m
//  TYActionSheet
//
//  Created by tiny on 16/7/12.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "TYActionSheet.h"
#import "TYAction.h"


#define kActionWidth  self.frame.size.width
#define kActionHeight self.frame.size.height

#define kContentViewWidth  self.contentView.frame.size.width
#define kContentViewHeight self.contentView.frame.size.height

#define kMargin   5
#define kCellHeight  45
#define kHeadHeiht  40
#define kBottonHeight 50
#define kRadius    10

@interface TYActionSheet ()<UITableViewDelegate,UITableViewDataSource>
{
    TYActionSheetCallBack _actionSheetCallBack;
}

@property (nonatomic,strong)UIButton *shadowButton;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UITableView *centerView;
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,assign)CGFloat contentHeight;

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *callBackArr;
@property (nonatomic,copy)NSString *title;

@end

@implementation TYActionSheet


-(instancetype)initActionSheetWithTitle:(NSString *)title
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.title = title;
        [self initialize];
    }
    return self;
}


-(void)addAction:(TYAction *)action handle:(TYActonCallBack)callback
{
    //添加action
    [self.dataArr addObject:action];
    if (callback) {
        [self.callBackArr addObject:callback];
    }
}

-(void)actionSheetDidClick:(TYActionSheetCallBack)actionSheetcallback
{
    _actionSheetCallBack = actionSheetcallback;
}

-(void)initialize
{
    
    _dataArr = [NSMutableArray array];
    _callBackArr = [NSMutableArray array];
    //初始化控件
    //1. 底部的阴影背景
    self.shadowButton = [[UIButton alloc] init];
    _shadowButton.backgroundColor = [UIColor blackColor];
    _shadowButton.alpha = 0.;
    [_shadowButton addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shadowButton];
    
    //2. 内容 contentView
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    //3. topView
    self.topView = [[UIView alloc] init];
//    self.topView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.topView];
    
    //4. 标题
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:_headView];
    self.headLabel = [[UILabel alloc] init];
    self.headLabel.textColor = [UIColor blackColor];
    self.headLabel.text = self.title;
    self.headLabel.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:self.headLabel];
    
    //5. 中间部分
    self.centerView = [[UITableView  alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _centerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _centerView.delegate = self;
    _centerView.dataSource = self;
    _centerView.scrollEnabled = NO;
    [self.topView addSubview:_centerView];
    
    //6. 底部
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bottomView];
    self.bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.text = @"取消";
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomView addSubview:self.bottomLabel];
    [self.bottomView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)]];

}

-(void)setUpUI
{
    //初始化UI
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    //设置frame
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    self.shadowButton.frame = self.bounds;
    self.contentView.frame = CGRectMake(kMargin, kActionHeight, kActionWidth - kMargin*2,0);

    //1. 如果没有输入标题 则不显示标题
    if (self.title.length >0) {
        self.headView.frame = CGRectMake(0, 0, kContentViewWidth, kHeadHeiht);
        self.headLabel.frame = self.headView.bounds;
    }
    CGFloat add = self.title.length >0 ? 5: 0;
    //2. 显示中间内容
    self.centerView.frame = CGRectMake(0,CGRectGetMaxY(self.headView.frame)+add, kContentViewWidth, self.dataArr.count*kCellHeight);
    
    //3. 标题+中间内容
    self.topView.frame = CGRectMake(0, 0, kContentViewWidth, CGRectGetMaxY(self.centerView.frame));
    self.topView.layer.cornerRadius = kMargin;
    self.topView.clipsToBounds = YES;
    
    //4. 显示底部标题
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.centerView.frame) + 5, kContentViewWidth, kBottonHeight);
    self.bottomView.layer.cornerRadius = kMargin;
    self.bottomView.clipsToBounds = YES;
    self.bottomLabel.frame = self.bottomView.bounds;

    //5. 计算contentView总高度
    self.contentHeight = CGRectGetMaxY(self.bottomView.frame) +5 ;
    self.contentView.frame = CGRectMake(kMargin, kActionHeight, kActionWidth - kMargin*2,self.contentHeight);
    
}
-(void)show
{

    [self setUpUI];
    self.contentView.frame = CGRectMake(kMargin, kActionHeight, kActionWidth - kMargin*2,self.contentHeight);
    [UIView animateWithDuration:0.25f animations:^{
    
        self.contentView.frame = CGRectMake(kMargin,kActionHeight - self.contentHeight, kContentViewWidth ,self.contentHeight);
        self.shadowButton.alpha = 0.35f;
    }];
}
-(void)disMiss
{
    [UIView animateWithDuration:0.25f animations:^{
       
        self.contentView.frame = CGRectMake(kMargin, kActionHeight, self.contentView.frame.size.width, self.contentView.frame.size.height);
        self.shadowButton.alpha = 0.;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - UITablView代理方法和数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TYAction *action = self.dataArr[indexPath.row];
    
    return action;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //拿到cell
    TYAction *action = self.dataArr[indexPath.row];
    //先判断统一回调block是否有效
    if (_actionSheetCallBack) {
        _actionSheetCallBack(action,indexPath.row);
        [self disMiss];
        return;
    }
    
    //拿到block
    if (indexPath.row +1 <= self.callBackArr.count) {
        TYActonCallBack  callback = self.callBackArr[indexPath.row];
        if (callback) {
            callback(action,action.currentTitle);
            [self disMiss];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

-(void)dealloc
{
    NSLog(@"---%s",__func__);
}
@end
