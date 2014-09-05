//
//  EHNoAnimatePushSegue.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHNoAnimatePushSegue.h"

@implementation EHNoAnimatePushSegue

- (void)perform{
    UIViewController *sourceVC = self.sourceViewController;
    [sourceVC.navigationController pushViewController:self.destinationViewController animated:NO];
}

@end
