//
//  TYActionSheet.h
//  TYActionSheet
//
//  Created by tiny on 16/7/12.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TYAction;

//提供2中回调方案：1.每个action单独各自点击了各自回调方法
typedef void(^TYActonCallBack)(TYAction *acton,NSString *title);
              //2.不单独处理每个action,只需要实现actionSheet回调方法 会传回Index
typedef void(^TYActionSheetCallBack)(TYAction *action,NSInteger index);

@interface TYActionSheet : UIView

/**
 *  暴露出标题Label和取消Label,以方便自定义颜色字体位置等
 */
@property (nonatomic,strong)UILabel *headLabel;
@property (nonatomic,strong)UILabel *bottomLabel;

/**
 *  初始化actonSheet
 *
 *  @param title title
 *
 *  @return 创建完成的action对象
 */
-(instancetype)initActionSheetWithTitle:(NSString *)title;

/**
 *  actonSheet点击了回调
 *
 *  @param actionSheetcallback actionSheet点击了回调
 */
-(void)actionSheetDidClick:(TYActionSheetCallBack)actionSheetcallback;

/**
 *  添加action
 *
 *  @param action   Action
 *  @param callback action点击后block回调
 */
-(void)addAction:(TYAction *)action handle:(TYActonCallBack)callback;


/**
 *  将actonsheet显示在视图上
 */
-(void)show;

@end
