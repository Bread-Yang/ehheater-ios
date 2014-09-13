//
//  EHLeftRightContainVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHLeftRightContainVC.h"
#import "EHMainControlVC.h"
#import "EHMoreVC.h"

@interface EHLeftRightContainVC ()<IIViewDeckControllerDelegate>

@end

@implementation EHLeftRightContainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EHMainControlVC *center = [self.storyboard instantiateViewControllerWithIdentifier:[EHMainControlVC objClassName]];
    UIViewController *leftVC = [self.storyboard instantiateViewControllerWithIdentifier:[EHMoreVC objClassName]];
    self.deckVC = [[IIViewDeckController alloc] initWithCenterViewController:center leftViewController:leftVC rightViewController:nil];
    self.deckVC.leftSize = 100;
    self.deckVC.view.frame = self.view.bounds;
    center.fatherVC = self;
    [self.deckVC setDelegate:self];
    [self.deckVC setPanningCancelsTouchesInView:YES];
    [self.view addSubview:self.deckVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.deckVC = nil;
}

- (void)dealloc{
    self.deckVC = nil;
    EHLog(@"%s",__FUNCTION__);
}

#pragma mark -- IIViewDeckControllerDelegate

- (BOOL)viewDeckController:(IIViewDeckController *)viewDeckController shouldBeginPanOverView:(UIView *)view{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
