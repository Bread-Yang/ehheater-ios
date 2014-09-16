//
//  EHNoConectWifiAlert.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHNoConectWifiAlert.h"

@interface EHNoConectWifiAlert()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *heaterImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation EHNoConectWifiAlert

+ (instancetype)loadFromNib{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:[EHNoConectWifiAlert objClassName] owner:nil options:nil];
    EHNoConectWifiAlert *obj = nil;
    if (nibs.count > 0) {
        obj = [nibs objectAtIndex:0];
    }
    return obj;
}

- (void)awakeFromNib{
    [self.tipLabel setText:NSLocalizedString(EH_Init_NotConnect_Tip, nil)];
    [self.cancelButton setAllStatusTitle:NSLocalizedString(EH_Cancel, nil)];
}

- (IBAction)cancelButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(noConnectWifiAlertPressedCancel:)]) {
        [self.delegate noConnectWifiAlertPressedCancel:self];
    }
}

#pragma mark -- Public

- (void)showInAppWindow{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    self.frame = window.bounds;
    if (![self isDescendantOfView:window]) {
        [UIView transitionWithView:window duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.showing = YES;
            [window addSubview:self];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)dismiss{
    self.showing = NO;
    [self removeFromSuperview];
}

@end
