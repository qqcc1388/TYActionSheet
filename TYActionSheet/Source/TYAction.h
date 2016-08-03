//
//  TYAction.h
//  TYActionSheet
//
//  Created by tiny on 16/7/12.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TYActionStyleDefalut
} TYActionStyle;

@class TYAction;
typedef void(^TYActionCallBack)(TYAction *action,NSString *title);

@interface TYAction : UITableViewCell

-(instancetype)initWithActionTitle:(NSString *)title LeftImage:(NSString *)leftImage RightImage:(NSString *)rightImage;

@property (nonatomic,copy)NSString *currentTitle;

@end
