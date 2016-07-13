//
//  ViewController.m
//  ESActionSheet
//
//  Created by tiny on 16/7/12.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "ViewController.h"
#import "TYActionSheet.h"
#import "TYAction.h"


@interface ViewController ()

@property (nonatomic,strong)TYActionSheet *actionSheet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)itemClick:(UIButton *)sender {
    
    //创建actionSheet
    //    [self addActon1];
    [self addActon2];
}


/**
 *  创建方法1 - acton提供统一回调方法，action headle = nil
 */
-(void)addActon1
{
    TYActionSheet *actionSheet = [[TYActionSheet alloc] initActionSheetWithTitle:@"标题"];
    
    //创建acton
    TYAction *action1 = [[TYAction alloc] initWithActionTitle:@"内容1" Image:nil];
    TYAction *action2 = [[TYAction alloc] initWithActionTitle:@"内容2" Image:@"test"];
    TYAction *action3 = [[TYAction alloc] initWithActionTitle:@"内容3" Image:@"test"];
    //添加action
    [actionSheet addAction:action1 handle:nil];
    [actionSheet addAction:action2 handle:nil];
    [actionSheet addAction:action3 handle:nil];
    //回调
    [actionSheet actionSheetDidClick:^(TYAction *action, NSInteger index) {
        NSLog(@"%@---%zi",action.currentTitle,index);
    }];
    //显示actionSheet
    [actionSheet show];
}

/**
 *  创建方式2  - 每个action提供一个回调方法
 */
-(void)addActon2
{
    TYActionSheet *actionSheet = [[TYActionSheet alloc] initActionSheetWithTitle:@"标题"];
    //创建acton
    TYAction *action1 = [[TYAction alloc] initWithActionTitle:@"内容1" Image:nil];
    TYAction *action2 = [[TYAction alloc] initWithActionTitle:@"内容2" Image:@"test"];
    TYAction *action3 = [[TYAction alloc] initWithActionTitle:@"内容3" Image:@"test"];
    
    //添加action 并提供回调
    [actionSheet addAction:action1 handle:^(TYAction *acton,NSString *title) {
        NSLog(@"%@",title);
    }];
    [actionSheet addAction:action2 handle:^(TYAction *acton, NSString *title) {
        
        NSLog(@"%@",title);
    }];
    [actionSheet addAction:action3 handle:^(TYAction *acton, NSString *title) {
        
        NSLog(@"%@",title);
    }];
    //显示actionSheet
    [actionSheet show];
}



@end
