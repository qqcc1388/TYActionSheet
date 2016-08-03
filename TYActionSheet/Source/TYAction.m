//
//  TYAction.m
//  TYActionSheet
//
//  Created by tiny on 16/7/12.
//  Copyright © 2016年 tiny. All rights reserved.
//

#import "TYAction.h"

@interface TYAction ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImgView;
@end

@implementation TYAction

-(instancetype)initWithActionTitle:(NSString *)title LeftImage:(NSString *)leftImage RightImage:(NSString *)rightImage {
    
    TYAction *action = [[[NSBundle mainBundle] loadNibNamed:@"TYAction" owner:self options:nil] lastObject];
    action.titleLabel.text = title;
    action.currentTitle = title;
    action.leftImgView.image = [UIImage imageNamed:leftImage];
    action.rightImgView.image = [UIImage imageNamed:rightImage];
    return  action;
}
@end
