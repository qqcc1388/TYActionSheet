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

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end

@implementation TYAction

-(instancetype)initWithActionTitle:(NSString *)title Image:(NSString *)image {
    
    TYAction *action = [[[NSBundle mainBundle] loadNibNamed:@"TYAction" owner:self options:nil] lastObject];
    action.titleLabel.text = title;
    action.currentTitle = title;
    action.imgView.image = [UIImage imageNamed:image];
    return  action;
}
@end
